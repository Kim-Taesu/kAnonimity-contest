<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.nio.*"%>
<%@ page import="java.nio.file.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


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
		// request.getRealPath("상대경로") 를 통해 파일을 저장할 절대 경로를 구해온다.
		// 운영체제 및 프로젝트가 위치할 환경에 따라 경로가 다르기 때문에 아래처럼 구해오는게 좋음
		String uploadPath = request.getRealPath("/uploadFile");
		out.println("서버 내 저장 위치 : " + uploadPath + "<br/>");

		int maxSize = 1024 * 1024 * 10; // 한번에 올릴 수 있는 파일 용량 : 10M로 제한

		String name = "";
		String subject = "";

		String fileName1 = ""; // 중복처리된 이름
		String originalName1 = ""; // 중복 처리전 실제 원본 이름
		long fileSize = 0; // 파일 사이즈
		String fileType = ""; // 파일 타입

		MultipartRequest multi = null;

		String header = null; //header

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
				originalName1 = multi.getOriginalFileName(file1);
				// 파일명이 중복될 경우 중복 정책에 의해 뒤에 1,2,3 처럼 붙어 unique하게 파일명을 생성하는데
				// 이때 생성된 이름을 filesystemName이라 하여 그 이름 정보를 가져온다.(중복에 대한 처리)
				fileName1 = multi.getFilesystemName(file1);
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
		List<String> lines = Files.readAllLines(Paths.get(uploadPath.concat("/").concat(fileName1)));

		//파일 읽기
		try {
			for (String line : lines) {
				line = line.replace(",", "|");
				//String result = line.split(",");
				//for(String s : result) {
	%>

	<%
		}
			//System.out.println(lines.get(0).toString());
			header = lines.get(0).toString();

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		String originalData = uploadPath;
		originalData += "/";
		originalData += fileName1;
		System.out.println("originalData = " + originalData);
	%><br>
</body>
<!-- 
    해당 페이지는 사용자에게 보여줄 필요가 없고 해당 정보를 전달만 해주면 되기 때문에 hidden으로 했다.
 -->
<form action="fileCheck.jsp" method="post" name="fileCheckFormName">

	<input type="hidden" value="<%=fileName1%>" name="fileName1" /> <input
		type="hidden" value="<%=originalName1%>" name="originalName1" /> <input
		type="hidden" value="<%=header%>" name="header" /> <input
		type="hidden" value="<%=originalData%>" name="originalData" />
</form>

<form action="taxonomyTreePage.jsp" method="post"
	name="taxonomyTreePage">
	<input type="hidden" value="<%=originalData%>" name="originalData" />
</form>


<!-- 
    a태그로 클릭시 파일체크하는 jsp페이지로 이동하도록 함
    javascript를 이용해서 onclick시 폼태그를 잡아와 submit()을 호출해 폼태그를 전송
 -->

<a href="#" class="btn btn-primary pull-right"
	onclick="javascript:document.fileCheckFormName.submit()">업로드 파일
	확인하기 :<%=fileName1%></a>

