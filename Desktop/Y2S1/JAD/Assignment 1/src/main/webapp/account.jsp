<html>

<head>
	<link rel="stylesheet" href="./css/account.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <%
	    if (session.getAttribute("sessUserRole") != null && session.getAttribute("sessUserRole").equals("Member")) {
			
		} else {
			response.sendRedirect("index.jsp");
		}
    %>
</head>

<body>
    <div class='loggedIn hide'>
        <span class="fa-solid fa-circle-check"></span>
        <span class="msg">Successfully logged in!</span>
    </div>

    <div class="navbar">
        <h2 class="logo"><a href="index.jsp">SP BookStore</a></h2>

        <nav class="navigation">
            <a href="/ST0510_JAD_Assignment_1/GetBooksServlet" class="navLink">Books</a>
            <a href="/ST0510_JAD_Assignment_1/GetCartServlet" id="cart" style="cursor: pointer;"
                class="navLink">Shopping Cart</a>
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

    <div class="user-info">
       	<form action="/ST0510_JAD_Assignment_1/UpdateCustomerServlet" method="post">
       		<input type="hidden" id="customerId" name="customerId" value="<%= session.getAttribute("sessUserID") %>">
		    <div>
		        <label for="name">Name:</label>
		        <input type="text" id="name" name="name" value="<%=session.getAttribute("sessUserName") %>" readonly>
		        <i class="fas fa-edit edit-icon" id="name-edit-icon"></i>
		        <i class="fas fa-times cross-icon" id="name-cross-icon"></i>
		    </div>
		
		    <div>
		        <label for="email">Email:</label>
		        <input type="email" id="email" name="email" value="<%=session.getAttribute("sessUserEmail") %>" readonly>
		        <i class="fas fa-edit edit-icon" id="email-edit-icon"></i>
		        <i class="fas fa-times cross-icon" id="email-cross-icon"></i>
		    </div>
		
		    <div>
		        <label for="password">Password:</label>
		        <input type="password" id="password" name="password" value="<%=session.getAttribute("sessUserPassword") %>" readonly>
		        <i class="fas fa-edit edit-icon" id="password-edit-icon"></i>
		        <i class="fas fa-times cross-icon" id="password-cross-icon"></i>
		    </div>
		
		    <div>
		        <label for="address">Address:</label>
		        <input type="text" id="address" name="address" value="<%=session.getAttribute("sessUserAddress") %>" readonly>
		        <i class="fas fa-edit edit-icon" id="address-edit-icon"></i>
		        <i class="fas fa-times cross-icon" id="address-cross-icon"></i>
		    </div>
		    
		    <button type="submit" class="confirm-btn" id="confirm-btn">Confirm</button>
		</form>
    </div>
    
    <script>
	    var crossIcons = document.querySelectorAll(".cross-icon");
	    for (var i = 0; i < crossIcons.length; i++) {
	        crossIcons[i].style.display = "none";
	    }
	</script>

    <script>
    $(document).ready(function () {
        var clickedEditIcons = new Set();

        $(".edit-icon").click(function () {
            var fieldId = $(this).attr("id").split("-")[0];
            enableEditMode(fieldId);
            clickedEditIcons.add(fieldId);
            showConfirmButton();
        });

        $(".cross-icon").click(function () {
            var fieldId = $(this).attr("id").split("-")[0];
            discardChanges(fieldId);
            clickedEditIcons.delete(fieldId);
            showConfirmButton();
        });

        function enableEditMode(fieldId) {
            $("#" + fieldId).removeAttr("readonly").focus();
            $("#" + fieldId + "-edit-icon").hide();
            $("#" + fieldId + "-cross-icon").show();
        }

        function disableEditMode(fieldId) {
            $("#" + fieldId).attr("readonly", "readonly");
            $("#" + fieldId + "-edit-icon").show();
            $("#" + fieldId + "-cross-icon").hide();
        }

        function discardChanges(fieldId) {
            $("#" + fieldId).val($("#" + fieldId).attr("value"));
            disableEditMode(fieldId);
        }

        function showConfirmButton() {
            if (clickedEditIcons.size > 0) {
                $("#confirm-btn").show();
            } else {
                $("#confirm-btn").hide();
            }
        }

        $("#confirm-btn").click(function () {
            // Handle saving the changes here
            // This code will execute when the confirm button is clicked
            clickedEditIcons.forEach(function (fieldId) {
                disableEditMode(fieldId);
            });
            clickedEditIcons.clear();
            showConfirmButton();
        });
    });
</script>

</body>

</html>
