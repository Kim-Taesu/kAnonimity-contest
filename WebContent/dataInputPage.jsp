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
          <li class="nav-item active">
            <a class="nav-link js-scroll-trigger" href="dataInputPage.jsp">Data Input</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="quasiIdentifierPage.jsp">Quasi-Identifier</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="taxonomyTreePage.jsp">Taxonomy tree</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="examplePage.jsp">Example</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="reviewPage.jsp">Review</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="downloadPage.jsp">Submit &amp; Download</a>
          </li>
        </ul>
      </div>
    </nav>
    
    <hr class="m-0">

    <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="Input">
	      <div class="my-auto">
	      		
	      		<h1>data input</h1>
	      		
	      		<div class="container">
	      		
	      			<div class="container" style="float: left; width: 100%">
	      				<h2 class="mb-1">Data Example</h2>
	      				<div class="subheading mb-1">
          					EX) C:\Users\Name\Descktop\data.csv
          				</div>
						<textarea class="form-control col-sm-15" rows="15"
						placeholder='id,height,weight,email,gender,ip_address
1,9,24,ithirsk0@ucla.edu,1,124.252.31.194
2,200,20,rnoakes1@dmoz.org,2,135.77.181.18
3,99,14,vyashunin2@behance.net,2,99.188.41.99
4,71,65,lcapin3@sun.com,1,38.198.146.8
5,79,36,rjouhning4@constantcontact.com,1,108.190.206.101
6,26,6,mhinsche5@google.co.uk,2,80.0.141.220
7,80,100,glaurenty6@people.com.cn,2,16.119.112.229
8,44,54,gspeaks7@ustream.tv,2,142.4.106.17
9,64,1,nbuckthorp8@goo.ne.jp,2,208.230.198.202
10,28,97,rfortescue9@tripod.com,2,191.30.80.68
11,110,11,sboorda@amazon.co.uk,1,246.18.120.99
12,54,58,cbarhemsb@wiley.com,1,92.187.181.124
13,25,35,qhuberyc@thetimes.co.uk,2,147.3.232.89
14,52,64,csilled@nydailynews.com,2,93.42.81.227
15,90,59,bedwardsone@tiny.cc,2,97.31.141.77
'></textarea><br>
	      			</div>
					
					
					<div class="container" style="float: left; width:100%">
						<h2 class="mb-1">Select your data (*.csv)</h2>
						<form method="POST" action="quasiIdentifierPage.jsp" enctype="multipart/form-data">
							<!-- COMPONENT START -->
							<!-- <div class="form-group">
								<div class="input-group input-file" name="Ficher1">
							   		<input type="file" class="form-control" name="fileName1"/>			
							        <span class="input-group-btn"></span>
								</div>
						   	</div> -->
							<div class="form-group">
								<input type="file" class="form-control" id="customFile" name="inputData"> 
								<label class="custom-file-label"
									for="customFile">Choose file</label>
							</div>
							<!-- COMPONENT END -->
							<div class="form-group">
								<button type="submit" class="btn btn-primary pull-right">Next</button>
								<button type="reset" class="btn btn-danger">Reset</button>
							</div>
						</form>
					</div>
										
				</div>
	      </div>
      </section>

</body>
</html>