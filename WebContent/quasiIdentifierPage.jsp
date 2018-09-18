<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Resume - Start Bootstrap Theme</title>

<%
	
%>

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
		// post방식에 대한 한글 인코딩 방식 지정 get방식은 서버의 server.xml에서 Connector태그에 URIEncoding="UTF-8" 추가
		request.setCharacterEncoding("UTF-8");

		//String header = request.getParameter("header");
		//StringTokenizer st = new StringTokenizer(header, ",");
		//int cnt = st.countTokens();
		//String[] hArr = new String[cnt];
		//int i = 0; 
		//while(st.hasMoreElements()){
		//	hArr[i++] = st.nextToken();
		//}
		
		//for(i=0; i<hArr.length; i++){
		//	System.out.print(hArr[i]);
		//}
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
	%>
	
	<script type="text/javascript">
	
	window.onload = function add_item(){
        // pre_set 에 있는 내용을 읽어와서 처리..
        
        
        <%
	        request.setCharacterEncoding("UTF-8");
		
        	String originalData = request.getParameter("originalData");
        	String fileName1 = request.getParameter("fileName1");
			String header = request.getParameter("header");
			System.out.println(header);
			StringTokenizer st = new StringTokenizer(header, ",");
			int cnt = st.countTokens();
			String[] hArr = new String[cnt];
			int i = 0; 
			while(st.hasMoreElements()){
				hArr[i++] = st.nextToken();
			}
			StringBuffer sb = new StringBuffer();
			for(int j=0; j<hArr.length; j++){
				sb.append(hArr[j]);
				if(j<hArr.length-1){
					sb.append(",");
				}
			}
        %>
        
        var str = "<%=sb.toString()%>";
        var strArr = str.split(",");
        
       
        
        
        for(var i=0; i<strArr.length; i++){
        	
        	var div = document.createElement('div');

            document.getElementById('field').appendChild(div);
        	
            div.setAttribute("value",strArr[i]);
            div.setAttribute("name", strArr[i]);
            
            document.getElementById('cb').setAttribute("value", strArr[i]);
            document.getElementById('cb').setAttribute("name", "checked");
            document.getElementById('label').innerHTML = strArr[i];
            
            div.innerHTML = document.getElementById('dest').innerHTML;
        }
        
	}
	
	</script>
	
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
          <li class="nav-item active">
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
            <a class="nav-link js-scroll-trigger" href="downloadPage.jsp">Download</a>
          </li>
        </ul>
      </div>
    </nav>
    
       <hr class="m-0">
        <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="SelectQI">
        
        	<div class="my-auto">
        		
        		<h1 class="mb-3">Select Quasi-Identifier</h1>
        		
        		<div class="container">
        		
        			<div class="resume-item d-flex flex-column flex-md-row mb-5" style="width: 100%; height:50%">
						<div class="resume-content my-auto">
							<h2>What is quasi-identifier?</h2>
							<iframe src="http://www.ehealthinformation.ca/faq/quasi-identifier/" width=1000 height=500></iframe>
						</div>
        			</div>
        			        		
        			<div class="resume-item d-flex flex-column flex-md-row mb-5" style="width: 100%; height:50%">
        				<div class="resume-content" style="width:1000px; height:200px">
        					<h2 class="mb-2">Attribute Header</h2>
        					<div class="subheading mb-1">
	          					Select your header as a quasi-identifier
	          				</div>
							<div class="container" id="dest" style="display: none;">
									<p style="float:left; margin:10px;">
										<input type="checkbox" name="" value="" id="cb"><label id="label" style="padding:5px; vertical-align:middle;"> </label>
									</p>
							</div>		
							<form method="post" action="taxonomyTreePage.jsp" style="vertical-align:middle;">
								<div id="field">
								<!-- 동적 생성 위치 -->
								</div>
								<button type="submit" class="btn btn-primary pull-right">Next</button>
								<input type="hidden" value="<%=originalData %>" name="originalData" />
								<input type="hidden" value="<%=fileName1 %>" name="fileName1"/>
							</form>
							
        				</div>
						
					</div>
        		
        		</div>
        		
        	</div>
        	
        </section>
        
      <!-- <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="SelectQI">
        <div class="my-auto">
          <h1 class="mb-3">Select Quasi-Identifier</h1>

          <div class="resume-item d-flex flex-column flex-md-row mb-2">

				<div class="resume-content mr-auto">

					<a href="http://www.ehealthinformation.ca/faq/quasi-identifier/"><font size="30px">What is quasi-identifier?</font></a><br>
					<br> 

					<h2 class="mb-2">Attribute Header</h2>
					
					<div id="dest" style="display: none">

						<input type="checkbox" name="" value="" id="cb">
						<textarea placeholder="" id="ta"></textarea>

					</div>

					<form method="post" action="taxonomyTreePage.jsp" id="field">
						<button type="submit" class="btn btn-primary pull-right">Submit</button>
						<input type="hidden" value="<%=originalData %>" name="originalData" />
						<input type="hidden" value="<%=fileName1 %>" name="fileName1"/>
					</form>

				</div>
			</div>
        </div>
      </section> -->
	<script type="text/javascript" src="/js/jquery.form.js"></script>
	
	


	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Plugin JavaScript -->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for this template -->
	<script src="js/resume.min.js"></script>

	<script src="path/to/poly-checked.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>


</body>
</html>