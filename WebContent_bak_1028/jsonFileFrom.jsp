<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
    </head>
    <body>
        <form action="JsonUpload.jsp" method="post">
            <label>taxonomy: </label>
            <input name="taxonomy" type="text" style="text-align:center; width:200px; height:50px;"><br>
            
            
            
            <label>kValue: </label>
            <input name="kValue" type="text"><br>
            <label>header: </label>
            <input name="header" type="text"><br>
            <input type="submit" value="전송">
        </form>
    </body>
</html>