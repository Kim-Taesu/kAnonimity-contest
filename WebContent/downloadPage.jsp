<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
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
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="reviewPage.jsp">Review</a></li>
				<li class="nav-item active"><a
					class="nav-link js-scroll-trigger" href="downloadPage.jsp">Download</a>
				</li>
			</ul>
		</div>
	</nav>


	<hr class="m-0">

	<section class="resume-section p-3 p-lg-5 d-flex flex-column"
		id="Download">
		<div class="my-auto">
			<h1 class="mb-3">Download Sucess!</h1>
			<div class="container">
				<h2>Result File</h2>

				<br>
				<button type="submit" class="btn btn-primary pull-right">Exit</button>
			</div>
			<%
				String userID = null;
				if (session.getAttribute("userID") != null) {
					userID = (String) session.getAttribute("userID");
				}

				Date today = new Date();
				SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");

				String downloadPathInHdfs = request.getParameter("downloadPathInHdfs");
				String inputDataName = request.getParameter("inputDataName");
				String kValue = request.getParameter("kValue");

				System.out.println("Path in HDFS : " + downloadPathInHdfs);
				Process process = null;
				try {
					long start = System.currentTimeMillis();

					String command = "hadoop fs -getmerge " + downloadPathInHdfs + " " + ". " + "kvalue_" + kValue + "_"
							+ date.format(today) + "_" + inputDataName;
					System.out.println("command : " + command);
					//String command = "hadoop fs -getmerge " + path + "/* /home/hp/eclipse-web/SWDevelopment/spark_output/ " + output;
					process = Runtime.getRuntime().exec(command);
					process.waitFor();
					process.destroy();

					out.println("<br>File Download Ready!<br>");
				} catch (Exception e) {
					out.println("Error : " + e);
				}

				String server_path = "./";

				// a태그의 href로 fileDown1.jsp?file_name="<%=fileName1 을 통해 전달한
				// 중복 방지 처리한 파일명 값을 가져온다.
				String fileName = "kvalue_" + kValue + "_" + date.format(today) + "_" + inputDataName;

				// 업로드한 폴더의 위치와 업로드 폴더의 이름을 알아야 한다.
				String savePath = server_path; // WebContent/uploadFile
				// 위의 폴더는 상대경로이고 절대경로 기준의 진짜 경로를 구해와야한다.
				String sDownPath = request.getRealPath(savePath);

				System.out.println("다운로드 폴더 절대 경로 위치 : " + sDownPath);
				System.out.println("fileName1 : " + fileName);

				// 저장되어 있는 폴더경로/저장된 파일명 으로 풀 path를 만들어준다.
				// 자바에서는 \를 표시하기 위해서는 \를 한번 더 붙여주기 때문에 \\로 해준다.
				String sFilePath = server_path + "kvalue_" + kValue + "_" + date.format(today) + "_" + inputDataName; // ex)c:\\uploadPath\\image.jpg
				System.out.println("Full File Path : " + sFilePath);
				// 풀 path에 대한걸 파일 객체로 인식시킨다.
				File outputFile = new File(sFilePath);
				// 저장된 파일을 읽어와 저장할 버퍼를 임시로 만들고 버퍼의 용량은 이전에 한번에 업로드할 수 있는 파일크기로 지정한다.
				byte[] temp = new byte[1024 * 1024 * 10]; // 10M

				// 파일을 읽어와야 함으로 inputStream을 연다.(풀패스를 가지는 파일 객체를 이용해 input스트림을 형성한다.)
				FileInputStream in = new FileInputStream(outputFile);

				// 유형 확인 : 읽어올 경로의 파일의 유형 -> 페이지 생성할 때 타입을 설정해야 한다.
				String sMimeType = getServletContext().getMimeType(sFilePath);

				System.out.println("유형 : " + sMimeType);

				// 지정되지 않은 유형 예외처리
				if (sMimeType == null) {
					// 관례적인 표현
					sMimeType = "application.octec-stream"; // 일련된 8bit 스트림 형식
					// 유형이 알려지지 않은 파일에 대한 읽기 형식 지정
				}

				// 파일 다운로드 시작
				// 유형을 지정해 준다.
				response.setContentType(sMimeType); // 응답할 페이지가 text/html;charset=utf-8을
				// 파일 mime 타입으로 지정해 준다.

				// 업로드 파일의 제목이 깨질 수 있으므로 인코딩을 해준다.
				String sEncoding = new String(fileName.getBytes("euc-kr"), "8859_1");
				//String B = "utf-8";
				//String sEncoding = URLEncoder.encode(A,B);

				// 기타 내용을 헤더에 올려야 한다.
				// 기타 내용을 보고 브라우저에서 다운로드 시 화면에 출력시켜 준다.
				String AA = "Content-Disposition";
				String BB = "attachment;filename=" + sEncoding;
				response.setHeader(AA, BB);

				// 브라우저에 쓰기
				ServletOutputStream out2 = response.getOutputStream();

				int numRead = 0;

				// 바이트 배열 temp의 0번부터 numRead번까지 브라우저로 출력
				// 파일이 위치한 곳에 연결된 inputStream에서 읽되 끝(-1) 전까지 while을 돈다.
				while ((numRead = in.read(temp, 0, temp.length)) != -1) { // temp 배열에 읽어올건데 0번째 인덱스부터 한번에 최대 temp.length 만큼 읽어온다.
					// 읽어올게 더이상 없으면 -1을 리턴하면서 while문을 빠져나감

					// 브라우저에 출력 : 근대 header 정보를 attachment로 해놓았음으로 다운로드가 된다.
					out2.write(temp, 0, numRead); // temp배열에 있는 데이터의 0번째부터 최대 numRead만큼 출력한다.
				}
				// 자원 해제
				out2.flush();
				out2.close();
				in.close();
			%>
		</div>


	</section>
</body>
</html>