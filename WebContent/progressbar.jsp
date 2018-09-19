<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script>
	function go(ing, end) {
		document.all.div1.style.width = (ing + 1) / end * 100 + "%";
		document.all.div11.style.width = (ing + 1) / end * 100 + "%";
		document.all.div2.innerHTML = parseInt((ing + 1) / end * 100, 10) + "%";
		document.all.div22.innerHTML = parseInt((ing + 1) / end * 100, 10)
				+ "%";
		//ing+1 하는이유는 (ing+1)/end*100  =0 이되면 에러가 나기 때문
	}
</script>
</head>
<!-- 상태진행바가 위치할 HTMl소스 -->
<body>
	<br>
	<br>

	<table width="445" border="0" cellpadding="2" cellspacing="1"
		bgcolor="#CCCCCC" style="font-size: 11px;">
		<tr>
			<td align="center" bgcolor="#EEEEEE" width="50">진행율</td>
			<td bgcolor="#ffffff"><table id="div1" width="50%" height="10"
					border="0" cellpadding="0" cellspacing="0" bgcolor="#428EA1">
					<tr>
						<td width="60%"
							style="filter: progid:DXImageTransform.Microsoft.Gradient(startColorStr='#32788A', endColorStr='#5DB4CA', gradientType='1')"></td>
						<td width="40%"
							style="filter: progid:DXImageTransform.Microsoft.Gradient(startColorStr='#5DB4CA', endColorStr='#32788A', gradientType='1')"></td>
					</tr>
				</table></td>
			<td id="div2" align="center" bgcolor="#ffffff" width="50">0</td>
		</tr>
		<tr>
			<td align="center" bgcolor="#EEEEEE">진행율</td>
			<td bgcolor="#ffffff"><table id="div11" width="50%" height="10"
					border="0" cellpadding="0" cellspacing="0" bgcolor="#CC3333">
					<tr>
						<td width="80%"
							style="filter: progid:DXImageTransform.Microsoft.Gradient(startColorStr='#CC2A2C', endColorStr='#FA8A8B', gradientType='1')"></td>
						<td width="20%"
							style="filter: progid:DXImageTransform.Microsoft.Gradient(startColorStr='#FA8A8B', endColorStr='#CC2A2C', gradientType='1')"></td>
					</tr>
				</table></td>
			<td id="div22" align="center" bgcolor="#ffffff" class="org">0</td>
		</tr>
	</table>
	<%
		int start = 0;
		int end = 100;
		for (int i = start; i < end; i++) {
			out.println("<script>go(" + i + "," + end + ")</script>");

			//상태진행바의 진행 로직을 실행하는부분
			Thread.sleep(20);
			//로직 끝

			out.flush();
		}
	%>
</body>
</html>