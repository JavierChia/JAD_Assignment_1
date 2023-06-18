<!DOCTYPE html>
<html>

<head>
    <title>Administrator Page</title>
	<link rel="stylesheet" href="./css/inventory.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <%
    if (session.getAttribute("sessUserRole") != null && session.getAttribute("sessUserRole").equals("Admin")) {
		
	} else {
		response.sendRedirect("error.jsp");
	}
    %>
    <script>
	    function showEditButtons() {
	        var addBookButton = document.getElementById("add-book-btn");
	        var editButtons = document.getElementById("edit-buttons");
	        var quantityGroup = document.getElementById("quantity-group");
	
	        addBookButton.style.display = "none";
	        editButtons.classList.add("show");
	        quantityGroup.style.display = "block";
	
	        var form = document.querySelector(".form-wrapper form");
	        form.action = "/ST0510_JAD_Assignment_1/UpdateBookServlet";
	    }
	
	    function hideEditButtons() {
	        var addBookButton = document.getElementById("add-book-btn");
	        var editButtons = document.getElementById("edit-buttons");
	        var quantityGroup = document.getElementById("quantity-group");
	
	        addBookButton.style.display = "block";
	        editButtons.classList.remove("show");
	        quantityGroup.style.display = "none";
	
	        var form = document.querySelector(".form-wrapper form");
	        form.action = "/ST0510_JAD_Assignment_1/NewBookServlet";
	    }



        function cancelEdit() {
            hideEditButtons();

            // Clear the form values
            document.getElementById("isbn").value = "";
            document.getElementById("title").value = "";
            document.getElementById("author").value = "";
            document.getElementById("price").value = "";
            document.getElementById("quantity").value = "";
            document.getElementById("publisher").value = "";
            document.getElementById("pdate").value = "";
            document.getElementById("image").value="";

            var genreCheckboxes = document.querySelectorAll("#genre-names input[type='checkbox']");
            genreCheckboxes.forEach(function (checkbox) {
                checkbox.checked = false;
                checkbox.parentElement.classList.remove("active2");
            });

            var selected = document.querySelector(".selected");
            selected.innerText = "Genre";

            document.getElementById("rating").value = "";
            document.getElementById("desc").value = "";
        }


        function populateForm(isbn, title, author, price, quantity, publisher, publicationDate, genres, rating, description, image) {
            document.getElementById("isbn").value = isbn;
            document.getElementById("title").value = title;
            document.getElementById("author").value = author;
            document.getElementById("price").value = price;
            document.getElementById("quantity").value = quantity;
            document.getElementById("publisher").value = publisher;
            document.getElementById("pdate").value = publicationDate;

            var genreCheckboxes = document.querySelectorAll("#genre-names input[type='checkbox']");
            var selectedGenres = genres.substring(1, genres.length - 1).split(", ").map(Number);
            var genreNames = [];

            genreCheckboxes.forEach(function (checkbox) {
                var genreId = parseInt(checkbox.value);
                var genreName = checkbox.parentElement.innerText.trim();

                if (selectedGenres.includes(genreId)) {
                    checkbox.checked = true;
                    checkbox.parentElement.classList.add("active2");
                    genreNames.push(genreName);
                } else {
                    checkbox.checked = false;
                    checkbox.parentElement.classList.remove("active2");
                }
            });

            var selected = document.querySelector(".selected");
            if (genreNames.length > 0) {
                selected.innerText = genreNames.join(", ");
            } else {
                selected.innerText = "Genre";
            }

            document.getElementById("rating").value = rating;
            document.getElementById("desc").value = description;
            
            var imageElement = document.querySelector(".book-cover");
            imageElement.src = "data:image/jpeg;base64," + image;
			
            var imageInput = document.getElementById("image");
            imageInput.value = image; 
            
            showEditButtons();
        }
    </script>
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
            <form action='/ST0510_JAD_Assignment_1/LogoutUserServlet' class=logoutForm>
            		<button type="submit" class="logout-button">Logout</button>
            </form>
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
        <form action="/ST0510_JAD_Assignment_1/NewBookServlet" method="POST" enctype="multipart/form-data">
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
            <div class="form-group" id="quantity-group">
			    <label>Quantity:</label>
			    <input type="number" id="quantity" name="quantity">
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
                <label>Image:</label>
                <img src="" alt="Book Cover" class="book-cover">
                <input type="file" id="image" name="image" accept="image/png, image/jpeg image/jpg">
            </div>
		    <div class="form-group">
		        <button id="add-book-btn" type="submit">Add Book</button>
		        <div id="edit-buttons" class="edit-buttons">
		            <button class="edit" type="submit">Edit Book</button>
		            <button class="cancel" type="button" onclick="cancelEdit()">Cancel</button>
		        </div>
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
			                <th>Quantity</th>
			                <th>Edit</th>
			                <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody id="table-body">
                        <%    
				            ArrayList<Book> books = (ArrayList<Book>) session.getAttribute("books");
							for (Book book : books){
						%>
							<tr>
			                    <td class="image-cell"><img src=<%="data:image/jpeg;base64," + book.getImage()%> alt="Book Cover" class="book-cover"></td>
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
			                    <td><%= book.getQuantity() %></td>

			                    <td class="action-buttons">
			                    	<button class="edit" onclick="populateForm(`<%= book.getIsbn() %>`, `<%= book.getTitle() %>`, `<%= book.getAuthor() %>`, `<%= book.getPrice() %>`, `<%= book.getQuantity() %>`, `<%= book.getPublisher() %>`, `<%= book.getDate() %>`, `<%= Arrays.toString(book.getGenre()) %>`, `<%= book.getRating() %>`, `<%= book.getDescription() %>`, `<%= book.getImage() %>`)">Edit</button>
			                    </td>
			                    <td class="action-buttons">
			                        <form action="/ST0510_JAD_Assignment_1/DeleteBookServlet">
									    <input type="hidden" name="isbn" value="<%= book.getIsbn() %>">
									    <button class="delete" type="submit">Delete</button>
									</form>                  
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
    <script>
    	hideEditButtons();
    </script>
    
</body>

</html>
