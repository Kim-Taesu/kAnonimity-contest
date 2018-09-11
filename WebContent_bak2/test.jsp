<%-- 
<%@ page contentType="text/html;charset=euc-kr" import="itexpert.chap04.*"%>
<jsp:useBean id="myInfo" class="itexpert.chap04.MyInfo" scope="page">
 <jsp:setProperty name="myInfo" property="name"/>
 <jsp:setProperty name="myInfo" property="age"/>
</jsp:useBean>



--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %> 
<% request.setCharacterEncoding("UTF-8"); %>
 
<jsp:useBean id="user" class="user.User" scope="application"></jsp:useBean>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPW"/>
<html>
<head>
<title>Hello World</title> 
</head>
<body>
 <%
  out.print("ID : " + user.getUserID()+"</br>");
  out.print("PW : " + user.getUserPW());
 %>
</body>
</html>

