<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.User" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %> 
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPW"/>


<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
		}
	if(userID != null){
		 PrintWriter script = response.getWriter();
	     script.println("<script>");
	     script.println("alert('이미 로그인 되어있습니다')");
	     script.println("location.href = 'main.jsp'");
	     script.println("</script>");
	}
	if(user.getUserID()==null || user.getUserPW()==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}else{
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(user);
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.');");
			script.println("history.back()");
			script.println("</script>");
			script.close();
			return;
		}
		else{
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('회원가입에 성공하였습니다.')");
	        script.println("location.href='login.jsp'");    // 이전 페이지로 사용자를 보냄
	        script.println("</script>");
		}
	}
%>
