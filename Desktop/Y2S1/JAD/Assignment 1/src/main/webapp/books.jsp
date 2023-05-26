<html>

<head>

<meta charset="ISO-8859-1">
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

</body>
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
            <a href="/ST0510_JAD_Assignment_1/GetBooksServlet" class="navLink">Books</a>
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
    
    <div class="description-container">
	    <div class="main-container">
	        <div class="sub-container-1">
	            <div class="title">Search for a DVD!</div>
	
	            <div class="bottom-row">
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
	                 
	                <div class="submit-container" style="display: inline-block;">
	                    <button type="submit" class="submit-button" id="search">Search</button>
	                </div>
	            </div>
			</div>
	        <div class="sub-container-2">
	            <div class ="card-container">
		    	<%	
				    ArrayList<Book> books = (ArrayList<Book>) session.getAttribute("books");
				    for (int i = 0; i < books.size(); i++) {
				        Book book = books.get(i);
				%>
					<div class="card">
					    <img src="placeholder-image.jpg" alt="Book Cover">
					    <h3><%=book.getTitle()%></h3>
					    <p class="author"><%=book.getAuthor()%></p>
					    <div class="rating">
					        <% for (int j = 0; j < book.getRating(); j++) { %>
					            <i class="fas fa-star"></i>
					        <% }
					           for (int j = book.getRating(); j < 5; j++) { %>
					            <i class="far fa-star"></i>
					        <% } %>
					        	
					    </div>
					    <p class="price">Price: $<%=book.getPrice()%></p>
					    <p class="price">Price: $<%=book.getGenre()%></p>
					    <button class="btn">Add to Cart</button>
					</div>
				<% } %>
	   	 		</div>
	    	</div>
		</div>
	</div>
    <!--LOGIN & REGISTER-->
    <div class="wrapper-container">
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
	</div>
	<script src="./js/dropdown.js"></script>
    <script src="./js/functions.js"></script>
    <script src="./js/script.js"></script>
</body>

</body>
</html>