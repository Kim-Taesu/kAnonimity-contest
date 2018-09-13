<%@page import="java.util.StringTokenizer"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.*"%>
<%@ page import="anonymity.kAnonymity"%>


<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
</head>

<body>
	
</body>
</html>
<%
	String taxonomy = request.getParameter("taxonomy");
	
	//String header = request.getParameter("header");
	String header = "age|sex|surgery|length|temp|location";
	
	
	//	String originalData = request.getParameter("originalData");
	String originalData = "C:\\Users\\Taesu Kim\\eclipse-workspace\\web_test\\data\\t1_resizingBy_100.txt";

	long start = System.currentTimeMillis();

	//kAnonymity(String Taxonomy, String header, int Kvalue, String dataFilePath)
	kAnonymity mykAnonymity = new kAnonymity(taxonomy, header, originalData);
	mykAnonymity.run();
	System.out.println("***** Done ***** ");
	long end = System.currentTimeMillis();

	System.out.println("runtime : " + (end - start) / 1000.0);
%>

