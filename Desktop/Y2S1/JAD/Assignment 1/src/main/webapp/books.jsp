<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Display all books</title>
</head>
<body>
<%@page import ="java.util.*"%>
<%@page import ="books.Book"%>
<%
ArrayList<Book> books = (ArrayList<Book>) session.getAttribute("books");
for (int i = 0; i < books.size(); i++) {
	out.print(books.get(i).getTitle());
}
%>
</body>
</html>