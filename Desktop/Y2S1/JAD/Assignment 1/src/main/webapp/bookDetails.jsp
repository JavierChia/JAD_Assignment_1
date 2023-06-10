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
	<%@page import="java.util.*"%>
	<%@page import="books.Book"%>
	<%@page import="books.BookGenre" %>
	<div class="alerts">
		<div class='loginAlert hide'>
	        <span class="fa-solid fa-circle-exclamation"></span>
	        <span class="msg">Incorrect email or password!</span>
	    </div>
	    
	    <div class='loggedIn hide'>
	        <span class="fa-solid fa-circle-check"></span>
	        <span class="msg">Successfully logged in!</span>
	    </div>
	    
	    <div class='loggedOut hide'>
	        <span class="fa-solid fa-arrow-right-from-bracket"></span>
	        <span class="msg">Successfully logged out!</span>
	    </div>
	    
	    <div class='registered hide'>
	        <span class="fa-solid fa-circle-check"></span>
	        <span class="msg">Successfully registered!</span>
	    </div>
	</div>
	
	<div class="navbar">
        <h2 class="logo"><a href="index.jsp">SP BookStore</a></h2>

        <nav class="navigation">
            <a href="/ST0510_JAD_Assignment_1/GetBooksServlet" class="navLink">Books</a>
            <a href="/ST0510_JAD_Assignment_1/GetCartServlet"id="cart" style="cursor: pointer;" class="navLink">Shopping Cart</a>
            <% 
			    Object uIDObj = session.getAttribute("sessUserID");
			    if (uIDObj != null) {
			        if (uIDObj instanceof String) {
			            String uID = (String) uIDObj;
			%>
			            <form action='/ST0510_JAD_Assignment_1/LogoutUserServlet' class="logoutForm">
			                <button type="submit" class="btnLogin" id="btnLogin">Logout</button>
			            </form>
			<%
			        } else if (uIDObj instanceof Integer) {
			            Integer uID = (Integer) uIDObj;
			%>
			            <form action='/ST0510_JAD_Assignment_1/LogoutUserServlet' class="logoutForm">
			                <button type="submit" class="btnLogin" id="btnLogin">Logout</button>
			            </form>
			<%
			        }
			    } else {
			%>
			    <button class="btnLogin" id="btnLogin">Login</button>
			<% } %>
        </nav>
    </div>
</body>

</html>