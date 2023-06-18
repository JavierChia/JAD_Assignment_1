<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
	<title>Display all books</title>
    <link rel="stylesheet" href="./css/addBook.css">
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
            } else if (message !=null && message.equals("validCreation")){
            	out.print("addedBook();");
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
	    
	    <div class='addedBook hide'>
	        <span class="fa-solid fa-circle-check"></span>
	        <span class="msg">Successfully Added a New Book!</span>
	    </div>
	</div>
    
    <div class="navbar">
        <h2 class="logo"><a href="index.jsp">SP BookStore</a></h2>

        <nav class="navigation">
            <a href="/ST0510_JAD_Assignment_1/GetBooksServlet" class="navLink">Books</a>
            <a href="/ST0510_JAD_Assignment_1/GetCartServlet"id="cart" style="cursor: pointer;" class="navLink">Shopping Cart</a>
            <div class="dropdown2">
			    <a id="admin" class="navLink">Admin</a>
			    <ul class="dropdown2-menu">
			        <li><a href="#">Add Book</a></li>
			        <li><a href="#">Update Book</a></li>
			        <li><a href="#">Delete Book</a></li>
			        <li><a href="#">Add Member</a></li>
			        <li><a href="#">Find Member</a></li>
			        <li><a href="#">Update Member</a></li>
			        <li><a href="#">Delete Member</a></li>
			    </ul>
			</div>

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
    <div class="form-container">
        <h2>Add Book</h2>
        <form action="/ST0510_JAD_Assignment_1/NewBookServlet">
            <div class="form-group">
                <label>Title:</label>
                <input type="text" id="title" name="title" required>
            </div>
            <div class="form-group">
			    <label>ISBN:</label>
			    <input type="text" id="isbn" name="isbn" required>
			</div>
            <div class="form-group">
                <label>Author:</label>
                <input type="text" id="author" name="author" required>
            </div>
            <div class="form-group">
                <label>Price:</label>
                <input type="number" id="price" name="price" step="0.01" required>
            </div>
            <div class="form-group">
                <label>Publisher:</label>
                <input type="text" id="publisher" name="publisher" required>
            </div>
            <div class="form-group">
                <label>Publication Date:</label>
                <input type="date" id="pdate" name="pdate" required>
            </div>
            <div class="form-group">
                <label>Genre:</label>
                <div class="genre-container" style="display: inline-block;">
					        <% 
					        String[] selectedGenres = request.getParameterValues("genre");
					        if (selectedGenres == null) {
					            selectedGenres = new String[0]; // Set an empty array if no genres are selected
					        }
					        %>
					        
					        <div class="dropdown">
					            <div class="select">
					                <span class="selected">
					                    Genre
					                </span>
					                <div class="caret"></div>
					            </div>
					            <ul class="menu" id="genre-names">
					                <% 
					                ArrayList<BookGenre> allGenres = (ArrayList<BookGenre>) session.getAttribute("genres");
					                for (int i = 0; i < allGenres.size(); i++) { 
					                    BookGenre genre = allGenres.get(i);
					                    boolean isSelected = Arrays.asList(selectedGenres).contains(String.valueOf(genre.getGenreId()));
					                %>
					                <li value="<%= genre.getGenreId() %>" class="<%= isSelected ? "active2" : "" %>">
					                    <%= genre.getGenreName() %>
					                    <input type="checkbox" name="genre" value="<%= genre.getGenreId() %>" class="hidden-checkbox" <%= isSelected ? "checked" : "" %>>
					                </li>
					                <% } %>
					            </ul>
					        </div>
					    </div>
            </div>
            <div class="form-group">
                <label>Rating:</label>
                <input type="number" id="rating" name="rating" min="0" max="5" step="0.1" required>
            </div>
            <div class="form-group">
                <label>Description:</label>
                <textarea id="desc" name="desc" required></textarea>
            </div>
            <div class="form-group">
                <button type="submit">Add Book</button>
            </div>
        </form>
        <script>
		    // Add click event listener to the list items
		    var listItems = document.querySelectorAll("#genre-names li");
		    listItems.forEach(function(item) {
		        item.addEventListener("click", function() {
		            var checkbox = this.querySelector("input[type='checkbox']");
		            checkbox.checked = !checkbox.checked;
		        });
		    });
		</script>
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
	                    <input type="text" id="name" name="name" required>
	                    <label>Name</label>
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
</html>
