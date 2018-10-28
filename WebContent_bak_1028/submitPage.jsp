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

<title>D2P project</title>

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
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Data
						Input</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Quasi-Identifier</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Taxonomy
						tree</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Example</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Review</a></li>
				<li class="nav-item active"><a
					class="nav-link js-scroll-trigger">Download</a>
			</ul>
		</div>
	</nav>

	<script>
		alert("complete!!!");
	</script>


	<hr class="m-0">

	<section class="resume-section p-3 p-lg-5 d-flex flex-column"
		id="Review">
		<div class="my-auto">
			<h1 class="mb-5">Download</h1>
			<div class="row">

				<div class="col-xs-12 col-md-6">
					<h2>Anonymized Data Sample</h2>
					<table border="1"
						style="text-align: center; text-transform: uppercase">
						<%
							String userID = null;
							if (session.getAttribute("userID") != null) {
								userID = (String) session.getAttribute("userID");
							}

							Date today = new Date();
							SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");

							System.out.println("\n\n!!!submit Page!!!");

							String kValue = request.getParameter("kValue");
							String selectHeader = request.getParameter("selectHeader");
							String taxonomy = request.getParameter("taxonomy");
							String inputDataRealPath = request.getParameter("inputDataRealPath");
							String inputDataName = request.getParameter("inputDataName");
							String downloadPathInHdfs = "/lg_project/output/" + "kvalue_" + kValue + "_" + date.format(today) + "_"
									+ inputDataName;
							String gtreeFilePath = "/home/hp/eclipse-web/SWDevelopment/taxonomy/"
									+ (String) session.getAttribute("userID") + "_" + "gtree.txt";

							//make gTree.txt
							try {
								File file = new File(gtreeFilePath);

								FileWriter fw = new FileWriter(file, true);
								fw.write(taxonomy);
								fw.flush();
								fw.close();

								Process process1 = null;
								long start1 = System.currentTimeMillis();
								String command1 = "hadoop fs -rm -r" + " /lg_project/data/" + gtreeFilePath;
								process1 = Runtime.getRuntime().exec(command1);
								process1.waitFor();
								process1.destroy();

								Process process = null;
								long start = System.currentTimeMillis();
								String command = "hadoop fs -put " + gtreeFilePath + " /lg_project/data/";

								process = Runtime.getRuntime().exec(command);

								process.waitFor();
								process.destroy();

							} catch (Exception e) {
								e.printStackTrace();
							}
							int lineCount = 0;
							Process process = null;
							String line = "";
							try {
								long start = System.currentTimeMillis();
								String command = "time /home/hp/spark-2.3.0-bin-hadoop2.7/bin/spark-submit --class com.kAnonymity_maven.kAnonymity_project --master yarn --deploy-mode cluster --driver-memory 10g --executor-memory 10g --executor-cores 4 "
										+ "hdfs:///jars/kAnonymity_maven-0.0.1-SNAPSHOT.jar " + kValue + "  /lg_project/data/"
										+ inputDataName + " " + selectHeader + " " + "hdfs:///lg_project/data/"
										+ (String) session.getAttribute("userID") + "_" + "gtree.txt" + " " + inputDataName + " 10";
								//String command = "pwd";

								System.out.println("Spark command : " + command);
								process = Runtime.getRuntime().exec(command);

								process.waitFor();
								process.destroy();
								System.out.println("spark submit finish!!");
								long end = System.currentTimeMillis();

								double running_time = (end - start) / 1000.0;
								out.println("RUNNING TIME : " + running_time);
								out.println("<br>");
							} catch (Exception e) {
								out.println("Error : " + e);
							}

							Process ps = null;
							try {
								String command = "hadoop fs -cat /lg_project/output/" + "kvalue_" + kValue + "_" + date.format(today)
										+ "_" + inputDataName + "/*";

								ps = Runtime.getRuntime().exec(command);
								System.out.println("upload data to HDFS finish!!");
								BufferedReader br = new BufferedReader(
										new InputStreamReader(new SequenceInputStream(ps.getInputStream(), ps.getErrorStream())));
								while ((line = br.readLine()) != null) {
									lineCount++;
									if (lineCount > 15)
										break;
									StringTokenizer token = new StringTokenizer(line, ",");
									String tmp = "";

									out.println("<tr>");
									while (token.hasMoreElements()) {
										out.println("<th>" + token.nextToken() + "</th>");
									}
									out.println("</tr>");
									ps.destroy();
								}
								br.close();
							} catch (IOException ie) {
								ie.printStackTrace();
							} catch (Exception e) {
								e.printStackTrace();
							}
						%>
					</table>
					<br>
					<h2>Download Anonymized Data</h2>
					<form method="post" action="downloadPage.jsp">
						<button type="submit" class="btn btn-danger">Download</button>
						<input type="hidden" value="<%=downloadPathInHdfs%>"
							name="downloadPathInHdfs" /> <input type="hidden"
							value="<%=inputDataName%>" name="inputDataName" /> <input
							type="hidden" value="<%=kValue%>" name="kValue" />

					</form>
					<br> <br>
					<form method="post" action="deletePage.jsp">
						<button type="submit" class="btn btn-primary">Next</button>
						<input type="hidden" value="<%=downloadPathInHdfs%>"
							name="downloadPathInHdfs" /> <input type="hidden"
							value="<%=inputDataName%>" name="inputDataName" /><input
							type="hidden" value="<%=gtreeFilePath%>" name="gtreeFilePath" />
						<input type="hidden" value="<%=inputDataRealPath%>"
							name="inputDataRealPath" />
					</form>
				</div>


			</div>
		</div>
	</section>



</body>
</html>