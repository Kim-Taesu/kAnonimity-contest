<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.*"%>

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
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="main.jsp">Start</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="dataInputPage.jsp">Data Input</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="quasiIdentifierPage.jsp">Quasi-Identifier</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="taxonomyTreePage.jsp">Taxonomy tree</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="examplePage.jsp">Example</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="reviewPage.jsp">Review</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="downloadPage.jsp">Download</a></li>
			</ul>
		</div>
	</nav>

	<hr class="m-0">

	<section class="resume-section p-3 p-lg-5 d-flex flex-column"
		id="Review">
		<div class="my-auto">
			<h2 class="mb-5">Submit</h2>
		</div>
		
		<div class="row">

			<div class="col-xs-12 col-md-6">
				<h4>Load data to HDFS</h4>
			<%
			String userID = null;
			if (session.getAttribute("userID") != null) {
				userID = (String) session.getAttribute("userID");
			}

			String taxonomy = request.getParameter("taxonomy");
			String filePath = request.getParameter("originalData");
			System.out.println("filePath : " + filePath);
			String[] originalData_Temp = filePath.split("/");
			String originalData = originalData_Temp[originalData_Temp.length - 1];
			String kValue = request.getParameter("kValue");
			
			//spark-submit --class com.kAnonymity_maven.kAnonymity_spark 
			//--master yarn 
			//--deploy-mode cluster 
			//--driver-memory 10g 
			//--executor-memory 10g 
			//		--executor-cores 4 
			//hdfs:///jars/kAnonymity_maven-0.0.1-SNAPSHOT.jar 100 hdfs:///home/hp/data/inputFile_5G.txt 0 10
			/*
			String cmd = "hadoop fs -put " + filePath + " /lgproject/ ";
			
			String cmd2 = "spark-submit --class com.kAnonymity_maven.kAnonymity_spark --master yarn --deploy-mode cluster --driver-memory 10g --executor-memory 10g --executor-cores 4 "
					+ "hdfs:///jars/kAnonymity_maven-0.0.1-SNAPSHOT.jar 100 hdfs:///home/hp/data/inputFile_5G.txt 0 10";
			*/
			String cmd2 = "spark-submit --class com.kAnonymity_maven.WordCount --master yarn --deploy-mode cluster --driver-memory 10g --executor-memory 10g --executor-cores 4 "
					+ "hdfs:///jars/kAnonymity_maven-0.0.1-SNAPSHOT.jar hdfs:///home/hp/data/inputFile.txt" + " hdfs:///lgoutput";
			
			Runtime rt = Runtime.getRuntime();
			Process ps = null;
			String line = "";

			try {
				ps = rt.exec(cmd2);
				BufferedReader br = new BufferedReader(
						new InputStreamReader(new SequenceInputStream(ps.getInputStream(), ps.getErrorStream())));
				while ((line = br.readLine()) != null) {
		%>
		<%=line%><br>
		<!-- 결과 화면에 뿌리기... -->
		<%
			}
				br.close();

			} catch (IOException ie) {
				ie.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>

			</div>


			<div class="col-xs-6 col-md-6">

				<h4>Taxonomy Tree</h4>


			</div>
		</div>

		
		</div>
	</section>



</body>
</html>