<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script>
        function goBack() {
            window.history.back();
        }
    </script>
</head>
<body>
    <%@ page import="java.util.*" %>
    <%@ page import="books.Book" %>
    <%
    int bookID = Integer.parseInt(request.getParameter("bookID"));
    ArrayList<Integer> cart;
    
    if (session.getAttribute("cart") != null) {
        cart = (ArrayList<Integer>) session.getAttribute("cart");
    } else {
        cart = new ArrayList<Integer>();
        session.setAttribute("cart", cart);
    }
    
    cart.add(bookID);
    System.out.println("Cart Contents: " + cart);
    
    // Redirect back to the previous page
    out.print("<script>goBack();</script>");
    %>
</body>
</html>
