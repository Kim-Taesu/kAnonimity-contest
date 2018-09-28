<%@page import="java.util.StringTokenizer"%>
<%@page
	import="com.sun.org.apache.xml.internal.serializer.utils.StringToIntTable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="anonymity.*"%>
<%@ page import="java.util.HashMap"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Resume - Start Bootstrap Theme</title>

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom fonts for this template -->
<link
	href="https://fonts.googleapis.com/css?family=Saira+Extra+Condensed:500,700"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Muli:400,400i,800,800i"
	rel="stylesheet">
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/resume.min.css" rel="stylesheet">
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}

		System.out.println("!!!Example Page!!!");

		String taxonomy = request.getParameter("taxonomy");
		String selectHeader = request.getParameter("selectHeader");
		String inputDataRealPath = request.getParameter("inputDataRealPath");
		String inputDataName = request.getParameter("inputDataName");

		long start = System.currentTimeMillis();

		//kAnonymity(String Taxonomy, String header, int Kvalue, String dataFilePath)
		kAnonymity2 mykAnonymity = new kAnonymity2(taxonomy, selectHeader, inputDataRealPath);
		String result = mykAnonymity.run();

		result.replaceAll(", ", "\n");
		System.out.println("!!!" + result);
		//HashMap<String, Integer> equivalent = new HashMap<String, Integer>();

		HashMap<String, Integer> equivalent = mykAnonymity.equivalent();
		long end = System.currentTimeMillis();
	%>

	<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top"
		id="sideNav">
		<a class="navbar-brand js-scroll-trigger" href="#page-top"> <span
			class="d-block d-lg-none">Data Privacy Project</span> <span
			class="d-none d-lg-block"> <!-- <img class="img-fluid img-profile rounded-circle mx-auto mb-2" src="img/profile.jpg" alt=""> -->
		</span>
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Start</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Data
						Input</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Quasi-Identifier</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Taxonomy
						tree</a></li>
				<li class="nav-item active"><a
					class="nav-link js-scroll-trigger">Example</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Review</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Submit
						&amp; Download</a>
			</ul>
		</div>
	</nav>

	<hr class="m-0">

	<section class="resume-section p-3 p-lg-5 d-flex flex-column"
		id="Example">
		<div class="my-auto">
			<h1>Example</h1>
			<div class="subheading mb-1">
				Time to Anonymize Sample data (1000 line)<br>
				<%=(end - start) / 1000.0 + " sec"%>
			</div>
			<div class="row">
				<div class="col-xs-12 col-md-6">
					<h2>Enter the value of k.</h2>
					<h3>(Equivalent Class's num)</h3>
					<div class="row-xs-12 row-md-8">

						<form method="post" action="reviewPage.jsp">
							<label for="name">k Value :</label> <input type="text"
								id="kValue" name="kValue" /> <input type="hidden"
								value="<%=taxonomy%>" name="taxonomy" /> <input type="hidden"
								value="<%=inputDataRealPath%>" name="inputDataRealPath" /> <input
								type="hidden" value="<%=inputDataName%>" name="inputDataName" />
							<input type="hidden" value="<%=selectHeader%>"
								name="selectHeader" />
							<button type="submit" class="btn btn-primary pull-right">Next</button>
						</form>
					</div>
					<br> <br> <br>
					<h2>What is Equivalent Class?</h2>
					<div class="row-xs-6 row-md-6">
						<img src="/WebContent/img/equivalent.png" width="700" alt="data example" />
					</div>
				</div>

				<div class="col-xs-12 col-md-6">
					<h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sample Equivalent Class</h2>
					<div class="col-xs-12 col-md-2">
						<table border="1"	style="margin-left: 200px; margin-right: auto; text-align: center;">
							<tr>
								<th>Equivalent Class</th>
								<th>Num</th>
							</tr>

							<%
								StringTokenizer key_token = new StringTokenizer(equivalent.keySet().toString(), ",");
								StringTokenizer value_token = new StringTokenizer(equivalent.values().toString(), ",");

								while (key_token.hasMoreElements()) {
									String key = key_token.nextToken().substring(2);
									String value = value_token.nextToken().substring(1);

									if (!key_token.hasMoreElements()) {
										key = key.substring(0, key.length() - 1);
										value = value.substring(0, value.length() - 1);
									}

									out.println("<tr><th> " + key + " </th><th> " + value + " </th></tr>");
								}
							%>

						</table>
					</div>
				</div>
			</div>
		</div>



	</section>


</body>
</html>