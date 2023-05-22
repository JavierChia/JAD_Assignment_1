<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Books</title>
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
    
    <div class='enter hide'>
        <span class="fa-solid fa-circle-exclamation"></span>
        <span class="msg">Please enter a category or title to search!</span>
    </div>
    
    <div class="navbar">
        <h2 class="logo"><a href="home.html">SP BookStore</a></h2>

        <nav class="navigation">
            <a href="home.jsp" class="navLink">Home</a>
            <a id="cart" style="cursor: pointer;" class="navLink">Shopping Cart</a>
            <a id="admin" class="navLink">Admin</a>
            <% if (message != null && message.equals("validLogin")) { %>
            	<form action='/ST0510_JAD_Assignment_1/LogoutUserServlet' class=logoutForm>
            		<button type="submit" class="btnLogin" id="btnLogin">Logout</button>
            	</form>
    		<% } else { %>
       		 	<button class="btnLogin" id="btnLogin">Login</button>
    		<% } %>
        </nav>
    </div>

	<div class="container">
        <div class="title">Search for a Book!</div>

        <div class="top-row">
            <div class="genre-container" style="display: inline-block;">
                <div class="dropdown">
                    <div class="select">
                        <span class="selected">Genre</span>
                        <div class="caret"></div>
                    </div>
                    <ul class="menu" id="genre-names">
                    </ul>
                </div>
            </div>

            <div class="title-bar-container" style="display: inline-block;">
                <input type="text" class="title-bar" placeholder="Enter a title!" id="title">
            </div>
            
			<div class="bottom-row">
            <div class="submit-container">
                <button type="submit" class="submit-button" id="search">Search
                </button>
            </div>
        </div>
        </div>

        
    </div>
	
    <!--LOGIN & REGISTER-->
    <div class="wrapper">
        <span class="icon-close">
            <i class="fa-solid fa-xmark"></i>
        </span>

        <div class="form-box login">
            <h2>Login</h2>
            <form action="/ST0510_JAD_Assignment_1/VerifyUserServlet">
                <div class="input-box">
                    <span class="icon">
                        <i class="fa-solid fa-envelope"></i>
                    </span>
                    <input type="email" id="email" name="email" required>
                    <label>Email</label>
                </div>

                <div class="input-box">
                    <span class="icon">
                        <i class="fa-solid fa-lock"></i>
                    </span>
                    <input type="password" id="password" name="password" required>
                    <label>Password</label>
                </div>

                <div class="remember-forgot">
                    <label><input type="checkbox">Remember me</label>
                    <a href="#">Forgot Password?</a>
                </div>
				<input type="submit" class="btn" id="login" name="btnSubmit" value="Login">

                <div class="login-register">
                    <p>Don't have an account? <a href="#" class="register-link"> Register</a></p>
                </div>
            </form>
        </div>

        <div class="form-box register">
            <h2>Registration</h2>
            <form action="/ST0510_JAD_Assignment_1/RegisterUserServlet">
                <div class="input-box">
                    <span class="icon">
                        <i class="fa-solid fa-user"></i>
                    </span>
                    <input type="text" id="firstName" name="firstName" required>
                    <label>First Name</label>
                </div>
                <div class="input-box">
                    <span class="icon">
                        <i class="fa-solid fa-user"></i>
                    </span>
                    <input type="text" id="lastName" name="lastName" required>
                    <label>Last Name</label>
                </div>
                <div class="input-box">
                    <span class="icon">
                        <i class="fa-solid fa-envelope"></i>
                    </span>
                    <input type="email" id="email" name="registerEmail" required>
                    <label>Email</label>
                </div>

                <div class="input-box">
                    <span class="icon">
                        <i class="fa-solid fa-lock"></i>
                    </span>
                    <input type="password" id="password" name="registerPassword" required>
                    <label>Password</label>
                </div>

                <button type="submit" class="btn">Register</button>

                <div class="login-register">
                    <p>Already have an account? <a href="#" class="login-link"> Login</a></p>
                </div>
            </form>
        </div>


    </div>
    <script src="functions.js"></script>
    <script src="script.js"></script>
</body>

</html>