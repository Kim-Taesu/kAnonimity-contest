<%@page language="java" contentType="application/json; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%
	Object[][] sampleArr = { { "박초아", "AOA", "걸그룹", 25 }, { "전효성", "시크릿", "가수", 26 },
			{ "정은지", "에이핑크", "텔런트", 22 }, { "배수지", "미스에이", "영화배우", 21 } };

	JSONObject jsonList = new JSONObject();
	JSONArray itemList = new JSONArray();

	for (int i = 0; i < sampleArr.length; i++) {
		JSONObject tempJson = new JSONObject();
		tempJson.put("name", sampleArr[i][0]);
		tempJson.put("group", sampleArr[i][1]);
		tempJson.put("job", sampleArr[i][2]);
		tempJson.put("age", sampleArr[i][3]);
		itemList.add(tempJson);
	}
	jsonList.put("TOTAL", sampleArr.length);
	jsonList.put("ITEMS", itemList);

	System.out.println(jsonList);
	out.print(jsonList);
%>