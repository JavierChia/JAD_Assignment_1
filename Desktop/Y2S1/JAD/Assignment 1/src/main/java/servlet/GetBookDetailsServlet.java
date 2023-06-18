package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import books.Book;
import books.BookGenre;

/**
 * Servlet implementation class GetBookDetailsServlet
 */
@WebServlet("/GetBookDetailsServlet")
public class GetBookDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetBookDetailsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String sqlStr = "SELECT * FROM books where id = ?";

		try {
	 		Class.forName("com.mysql.jdbc.Driver");
	 		
	 		String connURL = "jdbc:mysql://localhost/bookstore_db?user=root&password=root&serverTimezone=UTC";
	 		
	 		Connection conn = DriverManager.getConnection(connURL);
	 		
	 		PreparedStatement statement = conn.prepareStatement(sqlStr);
	 		
	 		String bookID = request.getParameter("bookID");
	 		
	 		statement.setString(1, bookID);
	 		
	 		ResultSet rs = statement.executeQuery();
	 		
	 		
	 		ArrayList<Book> books =  new ArrayList<Book>();
	 		while (rs.next()) {
	 			int id = rs.getInt("id");
	 			String title = rs.getString("title");
	 			String author = rs.getString("author");
	 			double price = rs.getDouble("price");
	 			int quantity = rs.getInt("quantity");
	 			String publisher = rs.getString("publisher");
	 			String description = rs.getString("description");
	 			String date = rs.getString("publication_date");
	 			String isbn = rs.getString("isbn");
	 			int rating = rs.getInt("rating");
	 			String[] genre = rs.getString("genre").substring(1).split("-");
	 			Blob blob = rs.getBlob("image");
	 			String image = "";
	 			if (blob != null) {
	 				byte[] imageData = blob.getBytes(1, (int) blob.length());
		 		    image = Base64.getEncoder().encodeToString(imageData);
	 			}
	 			books.add(new Book(id,title,author,price,quantity,publisher,date,description,isbn, genre, rating, image));
	 		}
	 		
	 		HttpSession session = request.getSession();
	 		session.setAttribute("books", books);
	 		
	 		response.sendRedirect("/ST0510_JAD_Assignment_1/bookDetails.jsp");
	 		conn.close();
	 	} catch (Exception e) {
	 		out.println("Error: " + e);
	 	}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
