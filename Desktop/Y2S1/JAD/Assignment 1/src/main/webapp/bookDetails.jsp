<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Display all books</title>
    <link rel="stylesheet" href="./css/bookDetails.css">
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
    <div class="main-container">
	    <%@ page import="books.Book" %>
	    <%@ page import="java.util.ArrayList" %>
	    <%@ page import="javax.servlet.http.HttpSession" %>
	    <%
	        ArrayList<Book> books = (ArrayList<Book>) session.getAttribute("books");
	        
	        if (books != null && !books.isEmpty()) {
	            for (Book book : books) {
	                String id = String.valueOf(book.getId());
	                String title = book.getTitle();
	                String author = book.getAuthor();
	                String price = String.format("%.2f", book.getPrice());
	                String quantity = String.valueOf(book.getQuantity());
	                String publisher = book.getPublisher();
	                String publicationDate = book.getDate();
	                String isbn = book.getIsbn();
	                String rating = String.valueOf(book.getRating());
	                String description = book.getDescription();
	                String[] genres = book.getGenre();
	    %>
	    <div class="card">
	        <div class="cover">
	            <img src="placeholder.jpg" alt="Book Cover">
	        </div>
	        <div class="details">
	            <h3><%= title %></h3>
	            <p><strong>Author:</strong> <%= author %></p>
	            <div class="rating">
	                <strong>Rating:</strong>
	                <%-- Display rating as stars (using Font Awesome) --%>
	                <% for (int i = 0; i < Integer.parseInt(rating); i++) { %>
	                    <span class="fa fa-star"></span>
	                <% } %>
	            </div>
	            <p class="description"><strong>Description:</strong> <%= description %></p>
	            <div class="genres">
	                <strong>Genres:</strong>
	                <%-- Display genres --%>
	                <% 
                    ArrayList<BookGenre> allGenres = (ArrayList<BookGenre>) session.getAttribute("genres");
		                for (int k = 0; k < genres.length; k++) {
		                    int genre = Integer.parseInt(genres[k]);
		                    // Convert id to name
		                    for (int x = 0; x < allGenres.size(); x++) {
		                        BookGenre genreCheck = allGenres.get(x);
		                        if (genre == genreCheck.getGenreId()) {
		                            out.print("<span class='genre'>" + genreCheck.getGenreName() + "</span>");
		                            break;
		                        }
		                    }
		                }
		                %>
	            </div>
	            <p class="publication-date"><strong>Publication Date:</strong> <%= publicationDate %></p>
	            <p class="price"><strong>Price:</strong> $<%= price %></p>
	            <div class="add-to-cart">
	                <button>Add to Cart</button>
	            </div>
	        </div>
	    </div>
	    <% 
	            }
	        } else {
	    %>
	    <p>No book details available.</p>
	    <% 
	        }
	    %>
    </div>
</body>

</html>