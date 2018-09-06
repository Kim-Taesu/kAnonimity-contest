import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.StringTokenizer;

import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.function.Function;

class model extends kAnonymitySpark{

    int kValue;
    String originalDataPath;
    int partitionNumber;

    HashMap<String, Integer> maxMap = new HashMap<String, Integer>();
    HashMap<String, ArrayList<Integer>> rangeMap = new HashMap<String, ArrayList<Integer>>();

    ArrayList<String> QuasiIdentifier = new ArrayList<String>();
    String genTreeFilePath;


    void setting(int kValue, String originalDataPath, int partitionNumber, String QuasiIdentifier, String genTreeFilePath) {
        this.kValue = kValue;
        this.originalDataPath = originalDataPath;
        this.partitionNumber = partitionNumber;
        this.genTreeFilePath = genTreeFilePath;


        StringTokenizer token = new StringTokenizer(QuasiIdentifier, ",");
        while (token.hasMoreElements()) {
            this.QuasiIdentifier.add(token.nextToken());
        }
    }




}


public class kAnonymitySpark implements Serializable {

    model model = new model();

    public void loadGenTree() {
        System.out.println("loadGenTree Start!!");
        try {
            FileInputStream stream = new FileInputStream(model.genTreeFilePath);
            InputStreamReader reader = new InputStreamReader(stream);
            BufferedReader buffer = new BufferedReader(reader);

            while (true) {
                String label = buffer.readLine();
                if (label == null)
                    break;

                StringTokenizer st = new StringTokenizer(label, "|");
                String attrName = st.nextElement().toString();

                Integer treeLevel = new Integer(st.nextElement().toString());
                String valueStr = st.nextElement().toString();

                // update min and max
                Integer curMax = model.maxMap.get(attrName);
                if (curMax == null)
                    model.maxMap.put(attrName, treeLevel);
                else if (curMax.intValue() < treeLevel.intValue())
                    model.maxMap.put(attrName, treeLevel);

                // insert range list
                ArrayList<Integer> tempArr = new ArrayList<Integer>();
                StringTokenizer valueStr_st = new StringTokenizer(valueStr, "_");
                while (valueStr_st.hasMoreTokens()) {
                    tempArr.add(new Integer(valueStr_st.nextToken()));
                }

                model.rangeMap.put(attrName + "-" + treeLevel, tempArr);
                break;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            System.out.println("loadGenTree Finish!!");
        }

    }


    public String run() {
        loadGenTree();
        performAnonymity();
        System.out.println("all jobs finished");

        System.out.println("============================================================");
        System.out.println("k    : " + model.kValue);
        System.out.println("============================================================");
        return model.kValue + "\t";
    }


    public boolean performGeneralization(final ArrayList<Integer> curNode, JavaRDD<String> dataRDD) {
        System.out.println("performGeneralization start!");
        final int attrNumber = model.QuasiIdentifier.size();
        boolean stopFlag = true;

        Iterator<Long> mapReduce;

        mapReduce = dataRDD.map(new Function<String, String>() {
            public String call(String v1) throws Exception {
                String tranformedStr = new String();

                StringTokenizer token = new StringTokenizer(v1, "|");

                for (int k = 0; k < attrNumber - 1; k++) {
                    String attrName = model.QuasiIdentifier.get(k);
                    int treeLevel = curNode.get(k).intValue();
                    int curAttrValue = Integer.parseInt(token.nextToken());

                    if (treeLevel > 0) {
                        ArrayList<Integer> curRangeList = model.rangeMap.get(attrName + "-" + treeLevel);
                        if (curRangeList.size() == 2) {
                            tranformedStr = tranformedStr + "|" + curRangeList.get(0) + "_" + curRangeList.get(1);
                            // nodeIR += 1.0;
                        } else {
                            for (int m = 0; m < curRangeList.size() - 1; ++m) {
                                int curMin = curRangeList.get(m);
                                int curMax = curRangeList.get(m + 1);

                                if ((curMin <= curAttrValue) && (curAttrValue <= curMax)) {
                                    tranformedStr = tranformedStr + "|" + curMin + "_" + curMax;
                                    break;
                                }
                            }
                        }
                    } else {
                        tranformedStr = tranformedStr + "|" + curAttrValue;
                    }
                }
                return tranformedStr;
            }
        }).countByValue().values().iterator();

        while (mapReduce.hasNext()) {
            Long equivalentClassNum = mapReduce.next();
            if (equivalentClassNum.intValue() < model.kValue) {
                System.out.println(curNode + " is fail!! \n");
                return false;
            }
        }

        return stopFlag;

    }

    public void performAnonymity() {
        System.out.println("performAnonymity start!!");
        SparkConf conf = new SparkConf().setMaster("yarn-cluster").setAppName("kAnonymitySpark");
        JavaSparkContext sc = new JavaSparkContext(conf);
        JavaRDD<String> dataRDD;

        if (model.partitionNumber == 0) {
            dataRDD = sc.textFile(model.originalDataPath).cache();
        } else {
            dataRDD = sc.textFile(model.originalDataPath).coalesce(model.partitionNumber).cache();
        }

        ArrayList<ArrayList<Integer>> nodeQueue = new ArrayList<ArrayList<Integer>>();
        HashMap<String, Integer> duplicateList = new HashMap<String, Integer>();
        ArrayList<Integer> initNode = new ArrayList<Integer>();

        for (int i = 0; i < model.QuasiIdentifier.size() - 1; ++i)
            initNode.add(new Integer(0));

        // initialize
        nodeQueue.add(initNode);

        int curCount = 0;
        while (nodeQueue.size() > 0) {
            ArrayList<Integer> curNode = nodeQueue.remove(0);

            // Perform anonymization
            if (curCount > 0) {
                if ((performGeneralization(curNode, dataRDD))) {
                    System.out.println("Success node : " + curNode);

                    sc.close();
                    return;
                } // if end
            } // if end

            // add next nodes
            for (int i = 0; i < model.QuasiIdentifier.size() - 1; ++i) {
                ArrayList<Integer> tempNode = (ArrayList<Integer>) (curNode.clone());
                Integer attrMaxValue = model.maxMap.get(model.QuasiIdentifier.get(i));
                if (attrMaxValue >= (tempNode.get(i).intValue() + 1)) {

                    tempNode.set(i, new Integer(tempNode.get(i).intValue() + 1));

                    String tempStr = new String();

                    for (int j = 0; j < model.QuasiIdentifier.size() - 1; ++j)
                        tempStr = tempStr + "_" + tempNode.get(j);
                    Object tempObj = duplicateList.get(tempStr);
                    if (tempObj == null) {
                        nodeQueue.add(tempNode);
                        duplicateList.put(tempStr, new Integer(0));
                    }
                }
            }
            ++curCount;
        }
        System.out.println("performAnonymity Finish!!");
    }


    void setting(int kValue, String originalDataPath, int partitionNumber, String QuasiIdentifier, String genTreeFilePath) {
        model.setting(kValue, originalDataPath, partitionNumber, QuasiIdentifier, genTreeFilePath);
    }

    public static void main(String[] args) {

        //args0 : kValue
        //args1 : original Data Path
        //args2 : RDD Data Partition Number
        //args3 : Selected QuasiIdentifier Data
        //args4 : genTree File Path

        int kValue = Integer.parseInt(args[0]);
        String originalDataPath = args[1];
        int partitionNumber = Integer.parseInt(args[2]);
        String QuasiIdentifier = args[3];
        String genTreeFilePath = args[4];


        long startTime = System.currentTimeMillis();

        kAnonymitySpark mykAnonymity = new kAnonymitySpark();
        mykAnonymity.setting(kValue, originalDataPath, partitionNumber, QuasiIdentifier, genTreeFilePath);
        mykAnonymity.run();


        System.out.println("***** Done ***** ");
        System.out.println("KValue is : " + kValue);
        System.out.println("Input File is : " + originalDataPath);
        long endTime = System.currentTimeMillis();

        System.out.println("Running time : " + (endTime - startTime) / 1000.0);
    }

}