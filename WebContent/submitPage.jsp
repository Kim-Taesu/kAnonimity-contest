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
				<li class="nav-item active"><a
					class="nav-link js-scroll-trigger" href="reviewPage.jsp">Review</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="downloadPage.jsp">Download</a></li>
			</ul>
		</div>
	</nav>

	<hr class="m-0">

	<section class="resume-section p-3 p-lg-5 d-flex flex-column"
		id="Review">
		<div class="my-auto">
			<h1 class="mb-5">Submit</h1>
		</div>

		<div class="row">

			<div class="col-xs-12 col-md-6">
				<h2>Load data to HDFS</h2>
				<script>
					alert("Anonymizing...");
				</script>

				<%
					String userID = null;
					if (session.getAttribute("userID") != null) {
						userID = (String) session.getAttribute("userID");
					}
					String kValue = request.getParameter("kValue");
					String header = request.getParameter("header");
					String taxonomy = request.getParameter("taxonomy");
					String filePath = request.getParameter("originalData");
					String output = request.getParameter("filename");

					String fileName = "/home/hp/eclipse-web/SWDevelopment/taxonomy/gtree.txt";

					try {
						// 파일 객체 생성
						File file = new File(fileName);

						if (file.exists()) {
							if (file.delete()) {
								System.out.println("파일삭제 성공");
							} else {
								System.out.println("파일삭제 실패");
							}
						} else {
							System.out.println("파일이 존재하지 않습니다.");
						}
						FileWriter fw = new FileWriter(file, true);
						fw.write(taxonomy);
						fw.flush();
						fw.close();

					} catch (Exception e) {
						e.printStackTrace();
					}

					String[] originalData_Temp = filePath.split("/");
					String originalData = originalData_Temp[originalData_Temp.length - 1];

					Process process = null;
					try {
						long start = System.currentTimeMillis();
						String command = "time spark-submit --class com.kAnonymity_maven.kAnonymity_project --master yarn --deploy-mode cluster --driver-memory 10g --executor-memory 10g --executor-cores 4 "
								+ "hdfs:///jars/kAnonymity_maven-0.0.1-SNAPSHOT.jar " + kValue + "  /lg_project/data/"
								+ originalData + " " + header + " " + fileName + " " + output + " 10";
						process = Runtime.getRuntime().exec(command);

						process.waitFor();
						process.destroy();
						long end = System.currentTimeMillis();

						double running_time = (end - start) / 1000.0;

						out.println("running time : " + running_time);
						out.println(" ");
						out.println("Your Anonymized Data Sample..!");
					} catch (Exception e) {
						out.println("Error : " + e);
					}

					int lineCount = 0;
					String line = "";
					
					String downloadPath = "/lg_project/output/" + output;

					Process ps = null;
					try {
						String command = "hadoop fs -cat /lg_project/output/" + output + "/*";
						ps = Runtime.getRuntime().exec(command);
						BufferedReader br = new BufferedReader(
								new InputStreamReader(new SequenceInputStream(ps.getInputStream(), ps.getErrorStream())));
						while ((line = br.readLine()) != null) {
							lineCount++;
							if (lineCount > 100)
								break;
				%>
				<%=line%><br>
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

				<h2>Taxonomy Tree</h2>

				<textarea class="form-control col-sm-6" cols="70" rows="20"
					name="taxonomy"><%=taxonomy%></textarea>
				<br>

				<form>
					<button type="submit" class="btn btn-primary pull-right"
						onclick="location.href='downloadPage.jsp'">Next</button>
				</form>
			</div>


		</div>


		</div>
	</section>



</body>
</html>