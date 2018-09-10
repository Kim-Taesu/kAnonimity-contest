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
<body id="page-top">
	
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
            <a class="nav-link js-scroll-trigger" href="#Start">Start</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#Input">Data Input</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#SelectQI">Quasi-Identifier</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#Taxonomy">Taxonomy tree</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#Example">Example</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#Review">Review</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#Download">Download</a>
          </li>
        </ul>
      </div>
    </nav>

    <div class="container-fluid p-0">

      <section class="resume-section p-3 p-lg-5 d-flex d-column" id="Start">
        <div class="my-auto">
          <h1 class="mb-0"><br><br>Data Privacy
            <span class="text-primary">Project</span>
          </h1>
          <div class="subheading mb-5">Anonymize your data. Then publish safely!
          </div>
	      <%
			  if(userID == null){
					
		  %>
	          <p class="lead mb-5">Please sign in or up to start this project.</p>
			  <form>
			  		<button type="button"  onclick="location.href='login.jsp'">Sign in</button>
			  		<button type="button"  onclick="location.href='join.jsp'">Sign up</button>
			  </form>  
		  <%
			  }else{
		  %>
				<p class="lead mb-5">Start this project!</p>
				<form>
					<button type="button" onclick="location.href='#Input'">Start</button>
					<button type="button"  onclick="location.href='logoutAction.jsp'">Sign out</button>
				</form>
		  <%
			  }
		  %>
			</div>
      </section>

      <hr class="m-0">

      <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="Input">
	      <div class="container">
	      		<h2>Select your data</h2>
		      	<form method="POST" action="#" enctype="multipart/form-data">
					<!-- COMPONENT START -->
					<div class="form-group">
						<div class="input-group input-file" name="Fichier1">
					   		<input type="text" class="form-control" placeholder='Choose a file...' />			
					        <span class="input-group-btn">
					       	<button class="btn btn-default btn-choose" type="button" onclick="upload()">Choose</button>
					   		</span>
						</div>
				   	</div>
					<!-- COMPONENT END -->
					<div class="form-group">
						<button type="submit" class="btn btn-primary pull-right">Submit</button>
						<button type="reset" class="btn btn-danger">Reset</button>
					</div>
				</form>
				<h2>Data Example</h2>
				<textarea class="form-control col-sm-7" rows="2" placeholder='C:\Users\Name\Descktop\File\data.csv'></textarea>
				<img src="C:\Users\dlsrk\eclipse-workspace\bootstrapEX\WebContent\img\img01.png" class="img-responsive" style="margin:0 auto; object-fit:container">
	      </div>
      </section>

      <hr class="m-0">

      <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="SelectQI">
        <div class="my-auto">
          <br><br><br><br><br><br><br><br><h2 class="mb-5">Select Quasi-Identifier</h2>

          <div class="resume-item d-flex flex-column flex-md-row mb-5">
            <div class="resume-content mr-auto">
              <a href="http://www.ehealthinformation.ca/faq/quasi-identifier/">What is quasi-identifier?</a><br><br>
              <h3 class="mb-0">Attribute Header</h3>
   	          
	          <div class="checks">
	          	<input type="checkbox" name="chk_info" value="HeaderA">DataA  
			  	<input type="checkbox" name="chk_info" value="HeaderB">DataB 
			  	<input type="checkbox" name="chk_info" value="HeaderC">DataC<br><br>
	          </div>
	          
			  <button type="submit" class="btn btn-primary pull-right">Submit</button>
            </div>
          </div>
        </div>
      </section>

      <hr class="m-0">

      <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="Taxonomy">
        <div class="container">
			<h2>Taxonomy Tree</h2>
			<textarea class="form-control col-sm-6" rows="5"></textarea><br>
			<textarea class="form-control col-sm-6" rows="5"></textarea><br>
			<p></p>
			<button type="submit" class="btn btn-primary pull-right" onclick="location.href='#Example'">Submit</button>
		</div>
		<div class="container">
			<h2>Data Example</h2>
			<img src="C:\Users\dlsrk\eclipse-workspace\bootstrapEX\WebContent\img\img02.png" class="img-responsive" style="margin:0 auto; object-fit:container">
		</div>
      </section>

      <hr class="m-0">

      <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="Example">
        <div class="my-auto">
          <h2 class="mb-5">Example</h2>
          <p>Result from example data.<br>Then choose your K value.</p>
        </div> 
     	<div class="row">
     		<div class="col-xs-12 col-md-6">
     			<img src="C:\Users\dlsrk\eclipse-workspace\bootstrapEX\WebContent\img\img03.png" class="img-responsive" style="margin:0 auto; object-fit:container">
     		</div>
  			<div class="col-xs-6 col-md-6">
  				<img src="C:\Users\dlsrk\eclipse-workspace\bootstrapEX\WebContent\img\img04.png" class="img-responsive" style="margin:0 auto; object-fit:container">
  			</div>
  			<div class="form-group">
  					<p><br></p>
					<button type="submit" class="btn btn-primary pull-right" onclick="getK()">Submit</button>
			</div>
     	</div>  
      </section>
	 
      <hr class="m-0">

      <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="Review">
        <div class="my-auto">
          <h2 class="mb-5">Reivew &amp; Submit</h2>       	 
       	 </div>
       	 <div class="container">
	       		<h2>Input File</h2>
	       		<textarea class="form-control col-sm-7" rows="2" placeholder='C:\Users\Name\Descktop\File\data.csv'></textarea>
	     </div>
	          
	     <div class="container">
	       		<h2>Generalization Lattice</h2>
	       		<table style="width:70%;  text-align:center">
					<tr style="background-color:lightgrey;">
						<th>AGE</th>
						<th>LENGTH</th>
						<th>SURGERY</th>
						<th>POST</th>
						<th>GENDER</th>
					</tr>
					<tr>
						<td>3</td>
						<td>2</td>
						<td>3</td>
						<td>2</td>
						<td>1</td>
					</tr>
				</table>
	     </div>
	          
	     <div class="container">
	       		<h2>k-Value</h2>
	       		<table style="width:20%;  text-align:center">
					<tr style="background-color:lightgrey;">
						<th>K-Value</th>
					</tr>
					<tr>
						<td>3</td>
					</tr>
				</table>
	    </div>
	    
       	<div class="container">
       			<p><br></p>
				<button type="submit" class="btn btn-primary pull-right" onclick="submit()">Submit</button>
		</div>
		
      </section>
	
	
	  <hr class="m-0">

      <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="Download">
        <div class="my-auto">
         	 <h2 class="mb-5">Download</h2>       	 
       	 </div>
      		
		<div class="container">
	       		<h2>Result File</h2>
	       		<textarea class="form-control col-sm-7" rows="2" placeholder='C:\Users\Name\Descktop\File\data.csv'></textarea>
	       		<p><br></p>
	       		<button type="submit" class="btn btn-primary pull-right" onclick="download()">Download</button>
	     </div>
      </section>	
		
		
    </div>
    
    <script type="text/javascript">
    	function upload(){
    		
    	}
    	function getK(){
    		var k=prompt("What's your k-value?", "K");
    		location.href='#Review';
    	}
    	function submit(){
    		alert('Please wait for anonymizing Data...');
    		location.href='#Download';
    	}
    	function download(){
    		location.href="http://www.test.com/test.zip";
    	}
    </script>

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for this template -->
    <script src="js/resume.min.js"></script>
    
    <script src="path/to/poly-checked.min.js"></script>


  </body>
</html>