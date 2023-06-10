<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Cart</title>
    <link rel="stylesheet" href="./css/cart.css">
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
	<div class="description-container">
	    <div class="main-container">
	        <table class="cart-table">
	            <tr>
	                <th>Book Cover</th>
	                <th>Title</th>
	                <th>Author</th>
	                <th>Genre</th>
	                <th>Rating</th>
	                <th>Price</th>
	                <th>Action</th>
	            </tr>
	            <%
				Object booksInCartObj = session.getAttribute("booksInCart");
				if (booksInCartObj != null && booksInCartObj instanceof ArrayList) {
				    ArrayList<Book> booksInCart = (ArrayList<Book>) session.getAttribute("booksInCart");
				    if (!booksInCart.isEmpty()) {
				        for (Book book : booksInCart) {
				%>

	                <tr>
	                    <td class="image-cell"><img src="placeholder-image.jpg" alt="Book Cover" class="book-cover"></td>
	                    <td><%= book.getTitle() %></td>
	                    <td><%= book.getAuthor() %></td>
	                    <td>
	                        <%
	                        ArrayList<BookGenre> allGenres = (ArrayList<BookGenre>) session.getAttribute("genres");
						    String[] genres = book.getGenre();
						    for (int k = 0; k < genres.length; k++) {
						    	int genre = Integer.parseInt(genres[k]);
						    	//Convert id to name
						    	for (int x = 0; x < allGenres.size(); x++) {
						    		BookGenre genreCheck = allGenres.get(x);
						    		if (genre == genreCheck.getGenreId()) {
						    			out.print("<span class='genre'>" + genreCheck.getGenreName() + "</span>");
						    			break;
						    		}
						    	}
						        if (k < genres.length - 1) {
						            out.print("<span class='dot'> &bull; </span>");
						        }
						    }
							%>
	                    </td>
	                    <td>
	                        <div class="rating-stars">
	                            <% for (int j = 0; j < book.getRating(); j++) { %>
	                                <i class="fas fa-star"></i>
	                            <% }
	                               for (int j = book.getRating(); j < 5; j++) { %>
	                                <i class="far fa-star"></i>
	                            <% } %>
	                                
	                        </div>
	                    </td>
	                    <td>$<%= book.getPrice() %></td>
	                    <td>
	                        <div class="quantity-controls">
	                            <button class="quantity-btn" onclick="subtractQuantity(this)">-</button>
	                            <input type="number" class="quantity-input" name="quantity" value="1" min="0">
	                            <button class="quantity-btn" onclick="addQuantity(this)">+</button>
	                        </div>
	                    </td>
	                </tr>
	            <%
			            }
			        } 
			    } else {
			    %>
			        <tr>
			            <td class="empty-cart-message" colspan="7">No books in the cart.</td>
			        </tr>
			    <% 
			    }
			    %>
	        </table>
	    </div>
	</div>
	
	<script>
	  function subtractQuantity(btn) {
	    var input = btn.nextElementSibling;
	    var currentValue = parseInt(input.value);
	    if (currentValue > 1) {
	      input.value = currentValue - 1;
	    }
	  }
	
	  function addQuantity(btn) {
	    var input = btn.previousElementSibling;
	    var currentValue = parseInt(input.value);
	    input.value = currentValue + 1;
	  }
	</script>

    
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
</html>
