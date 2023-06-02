<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
    function goBack() {
        window.history.back()
    }
</script>
</head>
	<body>
		<%@page import="java.util.*"%>
		<%@page import="books.Book"%>
		<%
		int bookID = Integer.parseInt(request.getParameter("bookID"));
		if (session.getAttribute("cart") != null) {
	    	ArrayList<Integer> cart = new ArrayList<Integer>();
	    	cart.add(bookID);
	    } else {
	    	ArrayList<Integer> cart = new ArrayList<Integer>();
	    	cart.add(bookID);
	    	session.setAttribute("cart", cart);
	    }
		out.print("<script>goBack();</script>");
		%>
	</body>
</html>