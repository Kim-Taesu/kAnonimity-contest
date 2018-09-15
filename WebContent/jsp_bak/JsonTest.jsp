<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
      <title>Home</title>
      <script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
      <script>
        
      $(function() {
          
        $("#checkJson").click(function() {
            
          //사람 정보
          var personArray = new Array();
              
          var personInfo = new Object();
            
          personInfo.name = "송강호";
          personInfo.age = "25";
          personInfo.gender = "남자";
          personInfo.nickname = "남궁민수";
              
          personArray.push(personInfo);
            
            
          personInfo = new Object();
            
          personInfo.name = "전지현";
          personInfo.age = "21";
          personInfo.gender = "여자";
          personInfo.nickname = "예니콜";
            
          personArray.push(personInfo);
            
          //책 정보
          var bookArray = new Array();
            
          bookInfo = new Object();
            
          bookInfo.name = "사람은 무엇으로 사는가?";
          bookInfo.writer = "톨스토이";
          bookInfo.price = "100";
          bookInfo.genre = "소설";
          bookInfo.publisher = "톨스토이 출판사";
            
          bookArray.push(bookInfo);
            
            
          bookInfo = new Object();
            
          bookInfo.name = "홍길동전";
          bookInfo.writer = "허균";
          bookInfo.price = "300";
          bookInfo.genre = "소설";
          bookInfo.publisher = "허균 출판사";
            
          bookArray.push(bookInfo);
            
            
          bookInfo = new Object();
            
          bookInfo.name = "레미제라블";
          bookInfo.writer = "빅토르 위고";
          bookInfo.price = "900";
          bookInfo.genre = "소설";
          bookInfo.publisher = "빅토르 위고 출판사";
            
          bookArray.push(bookInfo);
            
          //사람, 책 정보를 넣음
          var totalInfo = new Object();
            
          totalInfo.persons = personArray;
          totalInfo.books = bookArray;
            
          var jsonInfo = JSON.stringify(totalInfo);
          console.log(jsonInfo); //브라우저 f12개발자 모드에서 confole로 확인 가능
          alert(jsonInfo);
      
        });
          
      });
        
      </script>
    </head>
    <body>
         
 
         
 
        <a id="checkJson" style="cursor:pointer">확인</a>
    </body>
</html>