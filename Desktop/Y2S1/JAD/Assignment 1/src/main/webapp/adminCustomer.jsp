<!DOCTYPE html>
<html>

<head>
    <title>Administrator Page</title>
    <link rel="stylesheet" href="./css/customer.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
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
        <a href="adminInventory.jsp"><div class="nav-item <% if (currentPage.contains("Inventory")) out.print("active"); %>">Inventory</div></a>
       	<a href="adminOrders.jsp"><div class="nav-item <% if (currentPage.contains("Orders")) out.print("active"); %>">Orders</div></a>
    </div>

    <div class="content-wrapper">
        <div class="content">
            <h2 style="margin-bottom: 5px;">Customers</h2>
            <div class="form-wrapper">
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" id="name" placeholder="Enter name">
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="text" id="email" placeholder="Enter email">
                </div>
                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" id="address" placeholder="Enter address">
                </div>
                <div class="form-group">
                    <label for="phone">Phone:</label>
                    <input type="text" id="phone" placeholder="Enter phone">
                </div>
                <div class="form-group">
                    <label for="orders">Orders:</label>
                    <input type="text" id="orders" placeholder="Enter orders">
                </div>
                <div class="form-group">
                    <button id="create">Add Customer</button>
                </div>
            </div>

            <div class="table-wrapper">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Address</th>
                            <th>Orders</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="table-body">
                        <!-- Placeholder customers -->
                        
	                        <%
								ArrayList<Customer> customers = (ArrayList<Customer>)session.getAttribute("customers");
								for (Customer customer : customers){
									out.print("<tr><td>" + customer.getName() + "</td>");
									out.print("<td>" + customer.getEmail() + "</td>");
									out.print("<td>" + customer.getAddress() + "</td>");
									out.print("<td>" + customer.getOrders() + "</td>");
									out.print("<td class=\"action-buttons\"><button class=\"edit\">Edit</button><button class=\"delete\">Delete</button></td></tr>");
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
