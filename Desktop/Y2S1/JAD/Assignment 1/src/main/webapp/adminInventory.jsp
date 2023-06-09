<!DOCTYPE html>
<html>

<head>
    <title>Administrator Page</title>
	<link rel="stylesheet" href="./css/inventory.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>

<body>
	<%@page import="java.util.*"%>
	<%@page import="books.Book"%>
	<%@page import="books.BookGenre" %>
	<div class="blocker">
	</div>
    <div class="header">
        <div class="search-bar">
            <input type="text" placeholder="Search">
            <button class="logout-button">Logout</button>
        </div>
    </div>

  	<div class="side-navigation">
        <div class="logo">SP BookStore</div>
       	<a href="adminCustomer.jsp"><div class="nav-item <% String currentPage = request.getRequestURI(); if (currentPage.contains("Customer")) out.print("active"); %>">Customers</div></a>
        <a href="adminInventory.jsp"><div class="nav-item <% if (currentPage.contains("Inventory")) out.print("active"); %>">Inventory</div></a>
       	<a href="adminOrders.jsp"><div class="nav-item <% if (currentPage.contains("Orders")) out.print("active"); %>">Orders</div></a>
    </div>

    <div class="content-wrapper">
        <div class="content">
            <h2 style="margin-bottom: 5px;">Inventory</h2>
            <div class="form-wrapper">
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

            <div class="table-wrapper">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Book Cover</th>
			                <th>Title</th>
			                <th>Author</th>
			                <th>Genre</th>
			                <th>Rating</th>
			                <th>Price</th>
			                <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="table-body">
                        <!-- Placeholder customers -->
                        <%    
				            ArrayList<Book> books = (ArrayList<Book>) session.getAttribute("books");
							for (Book book : books){
						%>
							<tr>
			                    <td class="image-cell"><img src="placeholder-image.jpg" alt="Book Cover" class="book-cover"></td>
			                    <td><%= truncateTitle(book.getTitle(), 20) %></td>
			                    <%!
								    public String truncateTitle(String title, int maxLength) {
								        if (title.length() <= maxLength) {
								            return title;
								        } else {
								            return title.substring(0, maxLength) + "...";
								        }
								    }
								%>
			                    <td><%= book.getAuthor() %></td>
			                    <td>
			                        <%
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
			                    <td class="action-buttons">
			                        <button class="edit">Edit</button>
			                        <button class="delete">Delete</button>
			                        
			                    </td>
			                </tr>
		                <%
						}
		                %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <script src="./js/dropdown.js"></script>
    <script src="./js/functions.js"></script>
    <script src="./js/script.js"></script>
</body>

</html>
