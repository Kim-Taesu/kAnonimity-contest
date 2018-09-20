<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.*"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.util.*"%>
<%@ page import="java.nio.*"%>
<%@ page import="java.nio.file.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Resume - Start Bootstrap Theme</title>

<%
		String inputDataName = request.getParameter("fileName1");
		String uploadPath = request.getRealPath("/uploadFile");
		//out.println("서버 내 저장 위치 : " + uploadPath + "<br/>");

		int maxSize = 1024 * 1024 * 10; // 한번에 올릴 수 있는 파일 용량 : 10M로 제한

		String name = "";
		String subject = "";

		//String fileName1 = ""; // 중복처리된 이름
		String originalName = ""; // 중복 처리전 실제 원본 이름
		long fileSize = 0; // 파일 사이즈
		String fileType = ""; // 파일 타입

		MultipartRequest multi = null;

		String inputDataHeader = null; //header

		try {
			// request,파일저장경로,용량,인코딩타입,중복파일명에 대한 기본 정책
			multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

			// form내의 input name="name" 인 녀석 value를 가져옴
			name = multi.getParameter("name");
			// name="subject" 인 녀석 value를 가져옴
			subject = multi.getParameter("subject");

			// 전송한 전체 파일이름들을 가져옴
			Enumeration files = multi.getFileNames();

			while (files.hasMoreElements()) {
				// form 태그에서 <input type="file" name="여기에 지정한 이름" />을 가져온다.
				String file1 = (String) files.nextElement(); // 파일 input에 지정한 이름을 가져옴
				// 그에 해당하는 실재 파일 이름을 가져옴
				originalName = multi.getOriginalFileName(file1);
				// 파일명이 중복될 경우 중복 정책에 의해 뒤에 1,2,3 처럼 붙어 unique하게 파일명을 생성하는데
				// 이때 생성된 이름을 filesystemName이라 하여 그 이름 정보를 가져온다.(중복에 대한 처리)
				inputDataName = multi.getFilesystemName(file1);
				// 파일 타입 정보를 가져옴
				fileType = multi.getContentType(file1);
				// input file name에 해당하는 실재 파일을 가져옴
				File file = multi.getFile(file1);
				// 그 파일 객체의 크기를 알아냄
				fileSize = file.length();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<String> lines = Files.readAllLines(Paths.get(uploadPath.concat("/").concat(inputDataName)));

		//파일 읽기
		try {
			for (String line : lines) {
				line = line.replace(",", "|");
				//String result = line.split(",");
				//for(String s : result) {
			}
			//System.out.println(lines.get(0).toString());
			inputDataHeader = lines.get(0).toString();

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		String inputDataRealPath = uploadPath;
		inputDataRealPath += "/";
		inputDataRealPath += inputDataName;

		System.out.println("!!!File Upload Page!!!");
		System.out.println("inputDataName = " + inputDataName);
		System.out.println("inputDataHeader = " + inputDataHeader);
		System.out.println("inputDataRealPath = " + inputDataRealPath);
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

		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>

	<script type="text/javascript">
	
	window.onload = function add_item(){
        // pre_set 에 있는 내용을 읽어와서 처리..
        
        
        <%request.setCharacterEncoding("UTF-8");

			System.out.println("!!!quasi Identifier Page!!!");
			
			System.out.println("inputDataRealPath : " + inputDataRealPath);
			System.out.println("inputDataName : " + inputDataName);
			System.out.println("inputDataHeader : " + inputDataHeader);

			StringTokenizer st = new StringTokenizer(inputDataHeader, ",");
			int cnt = st.countTokens();
			String[] hArr = new String[cnt];
			int i = 0;
			while (st.hasMoreElements()) {
				hArr[i++] = st.nextToken();
			}
			StringBuffer sb = new StringBuffer();
			for (int j = 0; j < hArr.length; j++) {
				sb.append(hArr[j]);
				if (j < hArr.length - 1) {
					sb.append(",");
				}
			}%>
        
        var str = "<%=sb.toString()%>";
			var strArr = str.split(",");

			for (var i = 0; i < strArr.length; i++) {

				var div = document.createElement('div');

				document.getElementById('field').appendChild(div);

				div.setAttribute("value", strArr[i]);
				div.setAttribute("name", strArr[i]);

				document.getElementById('cb').setAttribute("value", strArr[i]);
				document.getElementById('cb').setAttribute("name", "checked");
				document.getElementById('label').innerHTML = strArr[i];

				div.innerHTML = document.getElementById('dest').innerHTML;
			}

		}
	</script>

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
				<li class="nav-item active"><a
					class="nav-link js-scroll-trigger" href="quasiIdentifierPage.jsp">Quasi-Identifier</a>
				</li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="taxonomyTreePage.jsp">Taxonomy tree</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="examplePage.jsp">Example</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="reviewPage.jsp">Review</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="downloadPage.jsp">Download</a></li>
			</ul>
		</div>
	</nav>

	<hr class="m-0">
	<section class="resume-section p-3 p-lg-5 d-flex flex-column"
		id="SelectQI">

		<div class="my-auto">

			<h1 class="mb-3">Select Quasi-Identifier</h1>

			<div class="container">

				<div class="resume-item d-flex flex-column flex-md-row mb-5"
					style="width: 100%; height: 50%">
					<div class="resume-content my-auto">
						<h2>What is quasi-identifier?</h2>
						<iframe
							src="http://www.ehealthinformation.ca/faq/quasi-identifier/"
							width=1000 height=500></iframe>
					</div>
				</div>

				<div class="resume-item d-flex flex-column flex-md-row mb-5"
					style="width: 100%; height: 50%">
					<div class="resume-content" style="width: 1000px; height: 200px">
						<h2 class="mb-2">Attribute Header</h2>
						<div class="subheading mb-1">Select your header as a
							quasi-identifier</div>
						<div class="container" id="dest" style="display: none;">
							<p style="float: left; margin: 10px;">
								<input type="checkbox" name="" value="" id="cb"><label
									id="label" style="padding: 5px; vertical-align: middle;">
								</label>
							</p>
						</div>
						<form method="post" action="taxonomyTreePage.jsp"
							style="vertical-align: middle;">
							<div id="field">
								<!-- 동적 생성 위치 -->
							</div>
							<button type="submit" class="btn btn-primary pull-right">Next</button>
							<input type="hidden" value="<%=inputDataRealPath%>"
								name="inputDataRealPath" /> <input type="hidden"
								value="<%=inputDataName%>" name="inputDataName" />
						</form>

					</div>

				</div>

			</div>

		</div>

	</section>
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