<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.util.ArrayList" %>
<%
ArrayList<Integer> cart = new ArrayList<>();
cart.add(1);
cart.add(2);
cart.add(4);
ArrayList<Integer> quantity = new ArrayList<>();
quantity.add(3);
quantity.add(1);
quantity.add(1);
session.setAttribute("cart", cart);
session.setAttribute("quantity", quantity);
session.setAttribute("customer", 3);
response.sendRedirect(request.getContextPath() + "/CheckoutServlet");
%>
</body>
</html>