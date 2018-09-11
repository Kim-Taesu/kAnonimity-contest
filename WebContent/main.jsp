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
            <a class="nav-link js-scroll-trigger" href="main.jsp">Start</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="dataInput.jsp">Data Input</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="quasiIdentifier.jsp">Quasi-Identifier</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="taxonomyTree.jsp">Taxonomy tree</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="example.jsp">Example</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="review.jsp">Review</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="download.jsp">Download</a>
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

		
		
    </div>
    <script type="text/javascript" src="/js/jquery.form.js"></script>
    
    <script type="text/javascript">
	    function handleFileSelect(evt) {
			var files = evt.target.files; // FileList object
	
			// files is a FileList of File objects. List some properties.
			var output = [];
			for (var i = 0, f; f = files[i]; i++) {
				output.push('<li><strong>', escape(f.name),
						'</strong> (', f.type || 'n/a', ') - ',
						f.size, ' bytes, last modified: ',
						f.lastModifiedDate ? f.lastModifiedDate
								.toLocaleDateString() : 'n/a',
						'</li>');
			}
			document.getElementById('list').innerHTML = '<ul>'
					+ output.join('') + '</ul>';
		}
	
		document.getElementById('files').addEventListener('change',
				handleFileSelect, false);
		function getK() {
			var k = prompt("What's your k-value?", "K");
			location.href = '#Review';
		}
		function submit() {
			alert('Please wait for anonymizing Data...');
			location.href = '#Download';
		}
		function download() {
			location.href = "http://www.test.com/test.zip";
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