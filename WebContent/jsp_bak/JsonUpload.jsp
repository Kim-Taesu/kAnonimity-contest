<%@page import="java.util.StringTokenizer"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<%
	// request.getRealPath("상대경로") 를 통해 파일을 저장할 절대 경로를 구해온다.
	// 운영체제 및 프로젝트가 위치할 환경에 따라 경로가 다르기 때문에 아래처럼 구해오는게 좋
	String taxonomy = request.getParameter("taxonomy");
	String kValue = request.getParameter("kValue");
	String header = request.getParameter("header");
	
	StringTokenizer headerToken = new StringTokenizer(header, "\t");
	
	
	
	

	out.println(taxonomy);
	out.println(kValue);
	out.println(header);


	JSONObject tempJson = new JSONObject();
	tempJson.put("taxonomy", taxonomy);
	tempJson.put("kValue", kValue);
	tempJson.put("header", header);

	System.out.println(tempJson);
%>
</head>
</html>