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
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}

		System.out.println("!!!review page!!!");

		String taxonomy = request.getParameter("taxonomy");
		String inputDataRealPath = request.getParameter("inputDataRealPath");
		String inputDataName = request.getParameter("inputDataName");
		String kValue = request.getParameter("kValue");
		String selectHeader = request.getParameter("selectHeader");

		Process process = null;
		BufferedReader in = null;
		BufferedReader err = null;

		System.out.println("taxonomy : " + taxonomy);
		System.out.println("inputDataRealPath : " + inputDataRealPath);
		System.out.println("inputDataName : " + inputDataName);
		System.out.println("kValue : " + kValue);
		System.out.println("selectHeader : " + selectHeader);

		String line = "";
		try {

			String command = "hadoop fs -put " + inputDataRealPath + " /lg_project/data/";
			//String command = "/home/hp/eclipse-web/SWDevelopment/sparkCommand/test";
			process = Runtime.getRuntime().exec(command);
			System.out.println(process);

			BufferedReader br = new BufferedReader(

					new InputStreamReader(

							new SequenceInputStream(process.getInputStream(), process.getErrorStream())));

			while ((line = br.readLine()) != null) {
	%>
	<%=line%><br>
	<!-- 결과 화면에 뿌리기... -->
	<%
		}
			br.close();
		} catch (Exception e) {
			out.println("Error : " + e);
		} 
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
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Data Input</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Quasi-Identifier</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Taxonomy tree</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Example</a></li>
				<li class="nav-item active"><a class="nav-link js-scroll-trigger">Review</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Submit &amp; Download</a></li>
			</ul>
		</div>
	</nav>

	<hr class="m-0">
	<section class="resume-section p-3 p-lg-5 d-flex flex-column"
		id="Review">
		<div class="my-auto">
			<h1 class="mb-5">Review Your Setting</h1>



			<div class="row">

				<div class="col-xs-12 col-md-4">
					<h2 class="mb-3">Data Input</h2>
					<div class="row-xs-12 row-md-4">
						<div class="subheading mb-1">
							<%=inputDataName%>
						</div>
						<br> <br>
					</div>

					<h2 class="mb-3">Quasi Identifier</h2>
					<div class="row-xs-6 row-md-4">
						<div class="subheading mb-1">
							<%=selectHeader.replaceAll(",", ",   ")%>
						</div>
						<br> <br>
					</div>

					<h2 class="mb-3">
						K Value
					</h2>
					<div class="row-xs-6 row-md-4">
						<div class="subheading mb-0">
							<%=kValue%>
						</div>
						<br> <br>
					</div>
					<br> <br> <br>
					<form method="post" action="submitPage.jsp">
						<input type="hidden" value="<%=kValue%>" name="kValue" /> <input
							type="hidden" value="<%=taxonomy%>" name="taxonomy" /> <input
							type="hidden" value="<%=inputDataRealPath%>"
							name="inputDataRealPath" /> <input type="hidden"
							value="<%=selectHeader%>" name="selectHeader" /><input
							type="hidden" value="<%=inputDataName%>" name="inputDataName" />
						<button type="submit" class="btn btn-danger">Submit! <br>(Press button and wait for completion alarm)</button>
					</form>

				</div>


				<div class="container" style="float: right; width: 40%">

					<h2>Taxonomy Tree</h2>
					<textarea class="form-control" cols="100" rows="20"
						name="taxonomy"><%=taxonomy%></textarea>


				</div>
			</div>
		</div>
	</section>
</body>
</html>