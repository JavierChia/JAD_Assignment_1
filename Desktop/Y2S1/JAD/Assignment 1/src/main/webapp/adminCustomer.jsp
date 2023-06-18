<!DOCTYPE html>
<html>

<head>
    <title>Administrator Page</title>
    <link rel="stylesheet" href="./css/customer.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>
    function showEditButtons() {
        var addCustomerButton = document.getElementById("add-customer-btn");
        var editButtons = document.getElementById("edit-buttons");

        addCustomerButton.style.display = "none";
        editButtons.classList.add("show");

        var form = document.querySelector(".form-wrapper form");
        form.action = "/ST0510_JAD_Assignment_1/UpdateCustomerServlet";

        // Remove the "readonly" attribute from the customerId input field
        document.getElementById("customerId").removeAttribute("readonly");
    }

    function hideEditButtons() {
        var addCustomerButton = document.getElementById("add-customer-btn");
        var editButtons = document.getElementById("edit-buttons");

        addCustomerButton.style.display = "block";
        editButtons.classList.remove("show");

        var form = document.querySelector(".form-wrapper form");
        form.action = "/ST0510_JAD_Assignment_1/RegisterUserServlet";

        // Add the "readonly" attribute to the customerId input field
        document.getElementById("customerId").setAttribute("readonly", true);
    }



        function cancelEdit() {
            hideEditButtons();

            document.getElementById("name").value = "";
            document.getElementById("email").value = "";
            document.getElementById("address").value = "";
            document.getElementById("password").value = "";
        }


        function populateForm(id, name, email, address, password) {
            document.getElementById("name").value = name;
            document.getElementById("email").value = email;
            document.getElementById("address").value = address;
            document.getElementById("password").value = password;
            document.getElementById("customerId").value = id;
            
            showEditButtons();
        }
      </script>
</head>

<body>
	<%@page import="java.util.*"%>
	<%@page import="customers.Customer" %>
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
        <a href="GetBooksServlet?next=adminInventory.jsp"><div class="nav-item <% if (currentPage.contains("Inventory")) out.print("active"); %>">Inventory</div></a>
       	<a href="adminOrders.jsp"><div class="nav-item <% if (currentPage.contains("Orders")) out.print("active"); %>">Orders</div></a>
    </div>

    <div class="content-wrapper">
        <div class="content">
            <h2 style="margin-bottom: 5px;">Customers</h2>
            <div class="form-wrapper">
            <form action="/ST0510_JAD_Assignment_1/RegisterUserServlet">
            	<input type="hidden" id="customerId" name="customerId" value="">
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name">
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="text" id="email" name="email">
                </div>
                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address">
                </div>
		        <div class="form-group">
		        	<label for="address">Password:</label>
                    <input type="text" id="password" name="password">
		        </div>
                <div class="form-group">
			        <button id="add-customer-btn" type="submit">Add Customer</button>
			        <div id="edit-buttons" class="edit-buttons">
			            <button class="edit" type="submit">Edit Customer</button>
			            <button class="cancel" type="button" onclick="cancelEdit()">Cancel</button>
			        </div>
		    	</div>
		    	</form>
            </div>

            <div class="table-wrapper">
                <table class="table">
                    <thead>
                        <tr>
                        	<th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Address</th>
                            <th>Orders</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="table-body">
	                    <%    
		                    ArrayList<Customer> customers = (ArrayList<Customer>)session.getAttribute("customers");
							for (Customer customer : customers){
						%>
							<tr>
								<td><%= customer.getID() %></td>
			                    <td><%= customer.getName() %></td>
			                    <td><%= customer.getEmail() %></td>
			                    <td><%= customer.getAddress() %></td>
			                    <td><%= customer.getOrders() %></td>
			                    <td class="action-buttons">
			                    	<button class="edit" onclick="populateForm(`<%= customer.getID() %>`,`<%= customer.getName() %>`, `<%= customer.getEmail() %>`, `<%= customer.getAddress() %>`, `<%= customer.getPassword() %>`)">Edit</button>
			                        <form action="/ST0510_JAD_Assignment_1/DeleteCustomerServlet">
									    <input type="hidden" name="id" value="<%= customer.getID() %>">
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

    <script>
        // JavaScript logic goes here
    </script>
</body>

</html>
