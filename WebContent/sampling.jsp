<%@page import="java.util.StringTokenizer"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.*"%>

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
	taxonomy = taxonomy.replace("\r\n", "\n");

	JSONObject Taxonomy = new JSONObject();
	JSONArray taxonomy_range = new JSONArray();

	StringTokenizer temp = new StringTokenizer(taxonomy, "\n");
	StringTokenizer temp2;
	String pre_quasi = "";

	while (temp.hasMoreElements()) {
		String line = temp.nextToken();

		temp2 = new StringTokenizer(line, "|");

		if (temp2.countTokens() != 3) {
			String quasi = "";
			while (temp2.countTokens() == 2) {
				quasi = quasi + temp2.nextToken();
			}
			String quasiLevel = temp2.nextToken();
			String range = temp2.nextToken();
		}

		else {
			String quasi = temp2.nextToken();
			String quasiLevel = temp2.nextToken();
			String range = temp2.nextToken();

			if (pre_quasi.equals("")) {
				pre_quasi = quasi;
			}

			if (quasi.equals(pre_quasi)) {
				taxonomy_range.add(quasi + "|" + quasiLevel + "|" + range);
				pre_quasi = quasi;
			}

			else {
				Taxonomy.put(pre_quasi, taxonomy_range);
				taxonomy_range = new JSONArray();

				taxonomy_range.add(quasi + "|" + quasiLevel + "|" + range);
				pre_quasi = quasi;
			}
		}

	}

	Taxonomy.put(pre_quasi, taxonomy_range);
	System.out.println("Taxonomy: " + Taxonomy + "\n\n");
%>

