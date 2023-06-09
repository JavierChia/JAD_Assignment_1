<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Display all books</title>
    <link rel="stylesheet" href="./css/books.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>
        $(document).ready(function () { //This is to prevent any jQuery code from running before the document is finished loading (is ready). alternative: $(document).ready(function()
            <%
    	    String message = request.getParameter("statusCode");
            if(message !=null && message.equals("invalidLogin")) {
            	out.print("login2Alert();");
            } else if (message !=null && message.equals("validLogin")){
            	out.print("loginAlert();");
            } else if (message !=null && message.equals("loggedOut")){
            	out.print("logoutAlert();");
            } else if (message !=null && message.equals("validRegistration")){
            	out.print("registerAlert();");
            }
       		 %>
        })
    </script>
</head>

<body>
	<h1>HELLO!!!</h1>
</body>

</html>