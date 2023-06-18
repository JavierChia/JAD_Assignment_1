<!DOCTYPE html>
<html>
<head>
    <title>Insert title here</title>
    <script>
        function goBack() {
            window.history.back();
        }
    </script>
</head>
<body>
    <%@ page import="java.util.*" %>
	<%@ page import="books.CartItems" %>
    <%
    int bookID = Integer.parseInt(request.getParameter("bookID"));
    int quantity = 1;

    if (session.getAttribute("cart") != null) {
    	ArrayList<CartItems> cart = (ArrayList<CartItems>) session.getAttribute("cart");
        boolean found = false;
        
        
        // Check if the book already exists in the cart
        for (int i = 0; i < cart.size(); i++) {
	        CartItems item = cart.get(i);
	        if (item.getBookID() == bookID) {
	            // If it exists, update the quantity
	            if (request.getParameter("action").equals("subtract")) {
	                item.setQuantity(item.getQuantity() - quantity);
	                if (item.getQuantity() == 0) {
	                    cart.remove(i); // Remove item from cart if quantity is 0
	                }
	            } else {
	                item.setQuantity(item.getQuantity() + quantity);
	            }
	            found = true;
	            break;
	        }
	    }

        
        // If the book does not exist in the cart, add it
        if (!found) {
            cart.add(new CartItems(bookID, quantity));
        }
    } else {
    	ArrayList<CartItems> cart = new ArrayList<CartItems>();
        cart.add(new CartItems(bookID, quantity));
        session.setAttribute("cart", cart);
    }
    
    // Redirect back to the previous page
    
    response.sendRedirect(request.getHeader("referer").split("\\?")[0]);
    %>
</body>
</html>
