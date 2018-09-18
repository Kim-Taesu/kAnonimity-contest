<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		String[] arr = request.getParameterValues("checked");
		String res = "";
		for(int i=0; i<arr.length; i++){
			res += arr[i];
			if(i < arr.length-1){
				res += "|";	
			}
		}
		String originalData = request.getParameter("originalData");
		String fileName1 = request.getParameter("fileName1");
	%>
	
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top" id="sideNav">
      <a class="navbar-brand js-scroll-trigger" href="#page-top">
        <span class="d-block d-lg-none">Data Privacy Project</span>
        <span class="d-none d-lg-block">
          <!-- <img class="img-fluid img-profile rounded-circle mx-auto mb-2" src="img/profile.jpg" alt=""> -->
        </span>
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="main.jsp">Start</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="dataInputPage.jsp">Data Input</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="quasiIdentifierPage.jsp">Quasi-Identifier</a>
          </li>
          <li class="nav-item active">
            <a class="nav-link js-scroll-trigger" href="taxonomyTreePage.jsp">Taxonomy tree</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="examplePage.jsp">Example</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="reviewPage.jsp">Review</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="downloadPage.jsp">Download</a>
          </li>
        </ul>
      </div>
    </nav>

      <hr class="m-0">

      <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="Taxonomy">
       <div class="my-auto">
			<h1 class="mb-3">taxonomy tree</h1>
			
				<div class="container" style="float: left; width:50%">
					<h2>Tree Example</h2>
					<p>height|0|-1<br>
height|1|0_50_100_150_200<br>
height|2|0_100_200<br>
weight|0|-1<br>
weight|1|0_50_100_150_200<br>
weight|2|0_100_200<br>
gender|0|-1<br>
gender|1|0_2
					</p>
					
				</div>

				<div class="container" style="float: right; width:50%">
					<form method="post" action="examplePage.jsp">
						<h2>Taxonomy Tree</h2>
						<textarea class="form-control col-sm-8" cols="100" rows="15" name="taxonomy"></textarea>
						<input type="hidden" value="<%=res%>" name="res" />
						<input type="hidden" value="<%=originalData%>" name="originalData" />
						<input type="hidden" value="<%=fileName1%>" name="fileName1" />		
						<br>
						<input type="submit" class="btn btn-primary" value="Sampling Start!" />
					</form>
				</div>

			
		</div>
        
        	
      </section>

      
</body>
</html>