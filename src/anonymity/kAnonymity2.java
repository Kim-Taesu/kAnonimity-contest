package anonymity;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.Writer;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

public class kAnonymity2 {

	// kValue
	private int KValue = 0;

	// header value num
	private int totalAttrSize = 0;

	// Taxonomy data
	private String genTreeFileName = "";

	// Original data
	private String inputFile_T1 = "";
	private String delim="";
	private HashMap<String, Integer> maxMap = new HashMap<String, Integer>();
	private HashMap<String, ArrayList<Integer>> rangeMap = new HashMap<String, ArrayList<Integer>>();
	private ArrayList<String> projectionList = new ArrayList<String>();
	private ArrayList<ArrayList> tupleList_T1 = new ArrayList<ArrayList>();
	private ArrayList<String> transfromed_tupleList_T1 = new ArrayList<String>();

	HashMap<String, Integer> equivalentClass = new HashMap<String, Integer>();

	public void loadGenTree() {
		System.out.println("loadGenTree Start!!!!");
		StringTokenizer lineToken = new StringTokenizer(this.genTreeFileName, "\n");
		while (lineToken.hasMoreTokens()) {
			String label = lineToken.nextToken();
			StringTokenizer st = new StringTokenizer(label, "|");
			String attrName = st.nextElement().toString();
			Integer treeLevel = new Integer(st.nextElement().toString());
			String valueStr = st.nextElement().toString();
			valueStr.substring(0, valueStr.length() - 1);

			// update min and max
			Integer curMax = this.maxMap.get(attrName);
			if (curMax == null)
				this.maxMap.put(attrName, treeLevel);
			else if (curMax.intValue() < treeLevel.intValue())
				this.maxMap.put(attrName, treeLevel);

			// insert range list
			ArrayList<Integer> tempArr = new ArrayList<Integer>();

			// if(!lineToken.hasMoreElements()) valueStr.substring(0, valueStr.length()-1);

			StringTokenizer valueStr_st = new StringTokenizer(valueStr, "_");

			// System.out.println("label : " + label);
			// System.out.println("valueStr : " + valueStr + "\n" + "valueStr length : " +
			// valueStr.length());

			while (valueStr_st.hasMoreTokens()) {
				String line = valueStr_st.nextToken();
				if (!valueStr_st.hasMoreElements() && lineToken.hasMoreElements()) {
					// System.out.println("!!");
					int lineEnd = line.length();
					line = line.substring(0, lineEnd - 1);
				}

				// System.out.println("line : " + line + ", length : " + line.length());
				tempArr.add(Integer.parseInt(line));
				// System.out.println("tempArr : " + tempArr);

			}

			this.rangeMap.put(attrName + "-" + treeLevel, tempArr);
			// System.out.println("!!rangeMap : " + rangeMap + "\n");
		}

		System.out.println("maxMap : " + maxMap);
		System.out.println("rangeMap : " + rangeMap);
		System.out.println("loadGenTree Finish!!\n\n");

	}

	private ArrayList<Integer> fitNode;

	public kAnonymity2(String Taxonomy, String header, String dataFilePath, String delim) {
		this.delim = delim;
		StringTokenizer headerToken = new StringTokenizer(header, delim);
		while (headerToken.hasMoreElements()) {
			this.projectionList.add(headerToken.nextToken());
		}

		this.genTreeFileName = Taxonomy;
		this.inputFile_T1 = dataFilePath;

//		System.out.println(this.inputFile_T1);
	}

	public void loadData(String inputFileName, ArrayList<ArrayList> curTupleList) {
		System.out.println("loadData Start!!");
		int line_count = 0;
		try {
			FileInputStream stream = new FileInputStream(inputFileName);
			InputStreamReader reader = new InputStreamReader(stream);
			BufferedReader buffer = new BufferedReader(reader);

			// pass header
			String[] temp = buffer.readLine().split("\\"+delim);
			ArrayList<Integer> headerInt = new ArrayList<Integer>();
			System.out.println("delim : " + delim);
			System.out.println("projectionList : " + projectionList);
			for(String s : temp) System.out.println(s);

			for (int i = 0; i < this.projectionList.size(); i++) {
				for (int j = 0; i < temp.length; j++) {
					if (this.projectionList.get(i).equals(temp[j])) {
						headerInt.add(j);
						break;
					}
				}
			}

			int curCount = 0;
			while (true) {
				String[] label = buffer.readLine().split("\\"+delim);
				line_count++;
				if (line_count > 1000)
					break;
				if (label == null)
					break;

				ArrayList curTuple = new ArrayList();

				for (int i = 0; i < headerInt.size(); i++) {
					curTuple.add(new Integer(label[headerInt.get(i)]));
				}
				curTupleList.add(curTuple);

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println("curTupleList : " + curTupleList);
		System.out.println("loadData Finish!!");
	}

	public void performGeneralization(ArrayList<Integer> curNode, ArrayList<ArrayList> curTupleList,
			ArrayList<String> transfromed_curTupleList) {
		System.out.println("performGeneralization Start!!");
		int attrNumber = this.projectionList.size();
		HashMap<String, ArrayList<String>> anonymizedResult = new HashMap<String, ArrayList<String>>();

		for (int i = 0; i < curTupleList.size(); ++i) {
			ArrayList curTuple = curTupleList.get(i);

			String tranformedStr = new String();
			for (int k = 0; k < attrNumber; ++k) {

				String attrName = this.projectionList.get(k);
				int treeLevel = curNode.get(k).intValue();
				int curAttrValue = ((Integer) curTuple.get(k)).intValue();

				if (treeLevel > 0) {
					ArrayList<Integer> curRangeList = this.rangeMap.get(attrName + "-" + treeLevel);

					if (curRangeList.size() == 2) {
						tranformedStr = tranformedStr + "|" + curRangeList.get(0) + "_" + curRangeList.get(1);
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
			if (!equivalentClass.containsKey(tranformedStr)) {
				equivalentClass.put(tranformedStr, 1);
			} else {
				equivalentClass.put(tranformedStr, equivalentClass.get(tranformedStr) + 1);
			}
			transfromed_curTupleList.add(tranformedStr);

		}
		System.out.println("performGeneralization Finish!!");
	}

	//
	public void performAnonymity() {
		System.out.println("performAnonymity Start!!");
		ArrayList<Integer> middleGL = new ArrayList<Integer>();
		for (int i = 0; i < maxMap.keySet().size(); i++) {
			int middleLevel = maxMap.get(projectionList.get(i)) / 2;
			middleGL.add(middleLevel);
		}

		System.out.println("middleGL : " + middleGL);
		performGeneralization(middleGL, this.tupleList_T1, this.transfromed_tupleList_T1);
		System.out.println("performAnonymity Finish!!");

	}

	public HashMap<String, Integer> equivalent() {
		return equivalentClass;
	}

	public String run() {
		loadGenTree();
		loadData(this.inputFile_T1, this.tupleList_T1);
		performAnonymity();
		System.out.println(equivalentClass);
		return transfromed_tupleList_T1.toString() + "\n";
	}

	// main part
	public static void main(String[] args) {
	}

}
