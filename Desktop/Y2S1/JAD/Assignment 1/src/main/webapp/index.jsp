<html>

<head>
    <link rel="stylesheet" href="./css/index.css">
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
    
    <div class="navbar">
        <h2 class="logo"><a href="index.jsp">SP BookStore</a></h2>

        <nav class="navigation">
            <a href="/ST0510_JAD_Assignment_1/GetBooksServlet?next=books.jsp" class="navLink">Books</a>
             <a href="/ST0510_JAD_Assignment_1/GetCartServlet"id="cart" style="cursor: pointer;" class="navLink">Shopping Cart</a>
            <% 
    			Object uIDObj = session.getAttribute("sessUserID");
			    if (uIDObj != null) {
			        if (uIDObj instanceof String) {
			            String uID = (String) uIDObj;
			%>
						<a href="account.jsp" class="navLink">Account</a>
			            <form action='/ST0510_JAD_Assignment_1/LogoutUserServlet' class="logoutForm">
			                <button type="submit" class="btnLogin" id="btnLogin">Logout</button>
			            </form>
			<%
			        } else if (uIDObj instanceof Integer) {
			            Integer uID = (Integer) uIDObj;
			%>
						<a href="account.jsp" class="navLink">Account</a>
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


    <div class="description-container">
        <div class="description">
            Welcome to our Book Store! Our store is dedicated to providing you with a convenient and
            enjoyable experience. Browse our online inventory and purchase any film you like!
        </div>

        <a href="/ST0510_JAD_Assignment_1/GetBooksServlet"><button class="startBrowsing">Start Browsing!</button></a>
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
                    <input type="text" id="name" name="name" required>
                    <label>Name</label>
                </div>
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

                <button type="submit" class="btn">Register</button>

                <div class="login-register">
                    <p>Already have an account? <a href="#" class="login-link"> Login</a></p>
                </div>
            </form>
        </div>
    </div>
    <script src="./js/functions.js"></script>
    <script src="./js/script.js"></script>
</body>

</html>