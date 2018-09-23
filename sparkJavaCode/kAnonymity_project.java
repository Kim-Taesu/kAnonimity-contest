package com.kAnonymity_maven;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.StringTokenizer;
import java.text.SimpleDateFormat;

import org.apache.spark.SparkConf;
import org.apache.spark.SparkContext;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.function.Function;
import org.apache.spark.ui.ConsoleProgressBar;

public class kAnonymity_project implements Serializable {

	Date today = new Date();
	SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
	int KValue;
	String joinAttrListStr = "0"; //

	// -------------------------cluster_option----------------------------------
	String genTreeFileName = "";
	int count = 0;
	String tranformedStr2 = new String();
	String filePath = "";
	String output_name = "";

	JavaRDD<String> kts1;
	boolean stopFlag = true;

	HashMap<String, Integer> maxMap = new HashMap<String, Integer>();
	HashMap<String, ArrayList<Integer>> rangeMap = new HashMap<String, ArrayList<Integer>>();
	ArrayList<String> projectionList = new ArrayList<String>();
	ArrayList<ArrayList> tupleList_T1 = new ArrayList<ArrayList>();

	JavaRDD<String> line;
	JavaPairRDD<Integer, String> line2;

	Map<String, Long> output;

	public void loadGenTree() {
		System.out.println("loadGenTree Start!!!!");
		try {
			FileInputStream stream = new FileInputStream(this.genTreeFileName);
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
				Integer curMax = this.maxMap.get(attrName);
				if (curMax == null)
					this.maxMap.put(attrName, treeLevel);
				else if (curMax.intValue() < treeLevel.intValue())
					this.maxMap.put(attrName, treeLevel);

				// insert range list
				ArrayList<Integer> tempArr = new ArrayList<Integer>();
				StringTokenizer valueStr_st = new StringTokenizer(valueStr, "_");
				while (valueStr_st.hasMoreTokens()) {
					tempArr.add(new Integer(valueStr_st.nextToken()));
				}

				this.rangeMap.put(attrName + "-" + treeLevel, tempArr);

			}

			// System.out.println(this.maxMap);
			// System.out.println(this.rangeMap);
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println("maxMap : " + maxMap);
		System.out.println("rangeMap : " + rangeMap);
		System.out.println("loadGenTree Finish!!\n\n");
	}

	public kAnonymity_project(int k, String header, String file, String taxonomy, String output) {

		KValue = k;
		StringTokenizer head = new StringTokenizer(header, ",");
		filePath = file;
		genTreeFileName = taxonomy;
		output_name = output;
		while (head.hasMoreTokens())
			projectionList.add(head.nextToken());
	}

	public boolean performGeneralization(final ArrayList<Integer> curNode, JavaRDD<String> info2,
			final ArrayList<Integer> header_num) {
		System.out.println("performGeneralization start!");
		final int attrNumber = projectionList.size();
		stopFlag = true;
		String line = ",";
		for (int i = 0; i < header_num.size(); i++) {
			line = line + header_num.get(i) + ",";
		}

		Iterator<Long> kts2;

		kts1 = info2.map(new Function<String, String>() {
			public String call(String v1) throws Exception {
				System.out.println("line : " + v1);
				String tranformedStr = new String();
				String[] token = v1.split(",");

				for (int k = 0; k < attrNumber; k++) {
					try {
						String attrName = projectionList.get(k);
						int treeLevel = curNode.get(k).intValue();
						int curAttrValue = Integer.parseInt(token[header_num.get(k)]);

						if (treeLevel > 0) {
							ArrayList<Integer> curRangeList = rangeMap.get(attrName + "-" + treeLevel);
							if (curRangeList.size() == 2) {
								tranformedStr = tranformedStr + "," + curRangeList.get(0) + "_" + curRangeList.get(1);
								// nodeIR += 1.0;
							} else {
								for (int m = 0; m < curRangeList.size() - 1; ++m) {
									int curMin = curRangeList.get(m);
									int curMax = curRangeList.get(m + 1);

									if ((curMin <= curAttrValue) && (curAttrValue <= curMax)) {
										tranformedStr = tranformedStr + "," + curMin + "_" + curMax;
										break;
									}
								}
							}
						}

						else {
							tranformedStr = tranformedStr + "," + curAttrValue;
						}

					} catch (NumberFormatException e) {
						String line = ",";
						for (int i = 0; i < header_num.size(); i++) {
							line = line + token[header_num.get(i)] + ",";
						}
						return line;
					}
				}
				return tranformedStr;
			}
		});

		kts2 = kts1.countByValue().values().iterator();

		int header_count = 0;
		while (kts2.hasNext()) {
			Long check_num = kts2.next();
			if (check_num.intValue() < KValue) {
				if (check_num == 1 && header_count == 0) {
					header_count++;
					System.out.println("header!");
					continue;
				}

				System.out.println(curNode + " is fail!! \n");
				return false;
			}
		}
		kts1.saveAsTextFile(
				"hdfs:///lg_project/output/" + "kvalue_" + KValue + "_" + date.format(today) + "_" + output_name);

		return stopFlag;

	}

	public void performAnonymity() {
		System.out.println("performAnonymity start!!");
		SparkConf conf = new SparkConf().setMaster("yarn-cluster").setAppName("kAnonymity_spark");
		JavaSparkContext sc = new JavaSparkContext(conf);
		JavaRDD<String> info2 = sc.textFile(filePath).coalesce(12).cache();

		
		ConsoleProgressBar progressBar = new ConsoleProgressBar(JavaSparkContext.toSparkContext(sc));
		System.out.println(progressBar.log().toString());

		ArrayList<ArrayList<Integer>> nodeQueue = new ArrayList<ArrayList<Integer>>();
		HashMap<String, Integer> duplicateList = new HashMap<String, Integer>();
		ArrayList<Integer> initNode = new ArrayList<Integer>();

		ArrayList<Integer> header_num = new ArrayList<Integer>();
		String[] full_header = info2.first().split(",");

		for (int i = 0, j = 0; i < full_header.length; i++) {
			if (j == projectionList.size())
				break;
			if (full_header[i].equals(projectionList.get(j))) {
				header_num.add(i);
				j++;
			}
		}

		for (int i = 0; i < projectionList.size(); ++i)
			initNode.add(new Integer(0));

		// initialize
		nodeQueue.add(initNode);

		int curCount = 0;
		while (nodeQueue.size() > 0) {
			ArrayList<Integer> curNode = nodeQueue.remove(0);

			// Perform anonymization
			if (curCount > 0) {
				if ((performGeneralization(curNode, info2, header_num))) {
					System.out.println("Success node : " + curNode);
					return;
				} // if end
			} // if end

			// add next nodes
			for (int i = 0; i < projectionList.size(); ++i) {
				ArrayList<Integer> tempNode = (ArrayList<Integer>) (curNode.clone());
				Integer attrMaxValue = maxMap.get(projectionList.get(i));
				// System.out.println("tempNode : " + tempNode);
				// System.out.println("attrMaxValue : " + attrMaxValue + "\n\n");
				if (attrMaxValue >= (tempNode.get(i).intValue() + 1)) {

					tempNode.set(i, new Integer(tempNode.get(i).intValue() + 1));

					String tempStr = new String();

					for (int j = 0; j < projectionList.size(); ++j)
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

	public String run() {

		loadGenTree();
		performAnonymity();
		System.out.println("all jobs finished");

		System.out.println("============================================================");
		System.out.println("k    : " + KValue);
		System.out.println("============================================================");

		return KValue + "\t";
	}

	public static void main(String[] args) {

		// args[0] is kvalue
		// args[1] is input file name
		// args[2] is header list
		// args[3] is taxonomy

		int kvalue = Integer.parseInt(args[0]);
		String file_name = args[1];
		String header = args[2];
		String taxonomy = args[3];
		String output = args[4];

		System.out.println("kvalue : " + kvalue);
		System.out.println("file_name : " + file_name);
		System.out.println("header : " + header);
		System.out.println("taxonomy : " + taxonomy);

		long start = System.currentTimeMillis();
		kAnonymity_project mykAnonymity = new kAnonymity_project(kvalue, header, file_name, taxonomy, output);
		mykAnonymity.run();
		System.out.println("***** Done ***** ");
		System.out.println("KValue is : " + kvalue);
		System.out.println("Input File is : " + file_name);
		long end = System.currentTimeMillis();

		System.out.println("running time : " + (end - start) / 1000.0);
	}

}
