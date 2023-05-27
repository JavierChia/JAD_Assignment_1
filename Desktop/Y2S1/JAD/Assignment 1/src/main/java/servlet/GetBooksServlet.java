package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import books.Book;

/**
 * Servlet implementation class GetBooksServlet
 */
@WebServlet("/GetBooksServlet")
public class GetBooksServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetBooksServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		String sqlStr = "test";
		try {
			
			//Step 1
	 		Class.forName("com.mysql.jdbc.Driver");
	 		
	 		// Step 2: Define Connection URL
	 		String connURL = "jdbc:mysql://localhost/bookstore_db?user=root&password=root&serverTimezone=UTC";
	 		
	 		// Step 3: Establish connection to URL
	 		Connection conn = DriverManager.getConnection(connURL);
	 		
	 		// Step 4: Create Statement object
	 		Statement stmt = conn.createStatement();
	 		
	 		// Step 5: Execute SQL Command
	 		sqlStr = "SELECT * FROM books";
	 		String[] genres = request.getParameterValues("genres");
	 		String searchTitle = request.getParameter("title");
	 		if (genres != null) {
	 			sqlStr += " WHERE genre LIKE ?";
	 			for (int i = 1; i < genres.length; i++) {
	 				sqlStr += " AND genre LIKE ?";
	 			}
	 		}
	 		if (genres != null && searchTitle != null) {
	 			sqlStr += " AND title LIKE ?";
	 		}
	 		if (genres == null && searchTitle != null) {
	 			sqlStr += " WHERE title LIKE ?";
	 		}
	 		log(sqlStr);
	 		PreparedStatement statement = conn.prepareStatement(sqlStr);
	 		int index = 0;
	 		if (genres != null) {
	 			for (index = 0; index < genres.length; index++) {
	 				statement.setString(index+1, "%"+genres[index]+"%");
	 			}
	 		}
	 		if (genres != null && searchTitle != null) {
	 			statement.setString(index+1, "%"+searchTitle+"%");
	 		}
	 		if (genres == null && searchTitle != null) {
	 			statement.setString(1, "%"+searchTitle+"%");
	 		}
	 		ResultSet rs = statement.executeQuery();
	 		
	 		// Step 6: Process Result
	 		ArrayList<Book> books =  new ArrayList<Book>();
	 		while (rs.next()) {
	 			int id = rs.getInt("id");
	 			String title = rs.getString("title");
	 			String author = rs.getString("author");
	 			double price = rs.getDouble("price");
	 			int quantity = rs.getInt("quantity");
	 			String publisher = rs.getString("publisher");
	 			String date = rs.getString("publication_date");
	 			String isbn = rs.getString("isbn");
	 			String genre = rs.getString("genre");
	 			int rating = rs.getInt("rating");
	 			out.print(title);
	 			books.add(new Book(id,title,author,price,quantity,publisher,date,isbn,genre, rating));
	 		}
	 		HttpSession session = request.getSession();
	 		session.setAttribute("books", books);
	 		// Step 7: Close connection
	 		conn.close();
	 		response.sendRedirect("/ST0510_JAD_Assignment_1/books.jsp");
	 		
	 	} catch (Exception e) {
	 		out.println("Error: " + e);
	 		out.println(sqlStr);
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
