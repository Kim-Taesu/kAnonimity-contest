<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>

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
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Start</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Data Input</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Quasi-Identifier</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Taxonomy tree</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Example</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Review</a></li>
				<li class="nav-item active"><a class="nav-link js-scroll-trigger">Download</a>
			</ul>
		</div>
	</nav>

	<hr class="m-0">

	<section class="resume-section p-3 p-lg-5 d-flex flex-column"
		id="Review">
		<div class="my-auto">
			<h1 class="mb-5">Finished!</h1>

			
			<h3>Congratulation! Your data has been anonymized using
				k-Anonymization</h3>
		</div>

		<div class="row">

			<div class="col-xs-12 col-md-6">


				<%
					String userID = null;
					if (session.getAttribute("userID") != null) {
						userID = (String) session.getAttribute("userID");
					}

					Date today = new Date();
					SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");

					System.out.println("\n\n!!!delete Page!!!");

					String downloadPathInHdfs = request.getParameter("downloadPathInHdfs");
					String inputDataName = request.getParameter("inputDataName");
					String inputDataPathInHdfs = "/lg_project/data/" + inputDataName;
					String gtreeFilePath = request.getParameter("gtreeFilePath");
					String inputDataRealPath = request.getParameter("inputDataRealPath");

					System.out.println("inputDataPathInHdfs : " + inputDataPathInHdfs);
					System.out.println("gtreeFilePath : " + gtreeFilePath);
					System.out.println("inputDataRealPath : " + inputDataRealPath);

					//delete gTree.txt
					try {
						File file = new File(gtreeFilePath);

						if (file.exists()) {
							if (file.delete()) {
								System.out.println("파일삭제 성공");
							}
						}
					} catch (Exception e) {
						e.printStackTrace();
					}

					Process process = null;
					try {
						long start = System.currentTimeMillis();
						String command = "rm -r " + " " + gtreeFilePath + ";rm -r " + " " + inputDataRealPath;
						process = Runtime.getRuntime().exec(command);

						process.waitFor();
						process.destroy();
					} catch (Exception e) {
						out.println("Error : " + e);
					}

					Process process2 = null;
					try {
						long start = System.currentTimeMillis();
						String command = "/home/hp/hadoop-2.8.4/bin/hadoop fs -rm -r /lg_project/data/*";
						process2 = Runtime.getRuntime().exec(command);
						process2.waitFor();
						process2.destroy();

					} catch (Exception e) {
						out.println("Error : " + e);
					}
					
					Process process3 = null;
					try {
						long start = System.currentTimeMillis();
						String command = "/home/hp/hadoop-2.8.4/bin/hadoop fs -rm -r /lg_project/output/*";
						process3 = Runtime.getRuntime().exec(command);
						process3.waitFor();
						process3.destroy();

					} catch (Exception e) {
						out.println("Error : " + e);
					}
				%>
			
			<form method="post" action="main.jsp">
					<button type="submit" class="btn btn-primary">home</button>
				</form>
			</div>

		</div>
	</section>



</body>
</html>