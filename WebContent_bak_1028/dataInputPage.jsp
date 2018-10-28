<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>


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
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Start</a>
				</li>
				<li class="nav-item active"><a
					class="nav-link js-scroll-trigger">Data Input</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Quasi-Identifier</a>
				</li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Taxonomy
						tree</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Example</a>
				</li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Review</a>
				</li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger">Download</a></li>
			</ul>
		</div>
	</nav>

	<hr class="m-0">

	<section class="resume-section p-3 p-lg-5 d-flex flex-column" id="Input">
		
		<div class="my-auto">

			<h1>data input</h1>

			<div class="container">

				<div class="container" style="float: left; width: 100%">
					<h2 class="mb-1">Select your data (*.csv)</h2>
					<form method="POST" action="quasiIdentifierPage.jsp" enctype="multipart/form-data">

						<div class="form-group">
							<input type="file" class="form-control" id="customFile"	name="inputData">
						</div>

						<div class="form-group">
							<button type="submit" class="btn btn-primary pull-right">Next</button>
							<button type="reset" class="btn btn-danger">Reset</button>
						</div>
					</form>
				</div>


				<div class="container" style="float: left; width: 100%">
					<h2 class="mb-1">Data Example</h2>
					<img src="/WebContent/img/dataCapture.PNG" alt="data example" />

				</div>
			</div>
		</div>
	</section>

</body>
</html>