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
 * Servlet implementation class NewBookServlet
 */
@WebServlet("/NewBookServlet")
public class NewBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewBookServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
				PrintWriter out = response.getWriter();
				HttpSession session = request.getSession();
				
				if (session.getAttribute("sessUserRole") != null && session.getAttribute("sessUserRole").equals("Admin")) {
					out.println("User Authorized");
				} else {
					response.sendRedirect("error.jsp");
				}

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
			 		String title = request.getParameter("title");
			 		String author = request.getParameter("author");
			 		Double price = Double.parseDouble(request.getParameter("price"));
			 		String publisher = request.getParameter("publisher");
			 		String pdate = request.getParameter("pdate");
			 		String isbn = request.getParameter("isbn");
			 		String[] genres = request.getParameterValues("genre");
			 		int rating = Integer.parseInt(request.getParameter("rating"));
			 		String desc = request.getParameter("desc");
			 		
			 		String genre = "-";
			 		for (int i = 0; i < genres.length; i++) {
			 			genre += genres[i] + "-";
			 		}

			 		String sqlStr = 
			 				"INSERT INTO books"
			 				+ "(title, author, price, quantity, publisher, publication_date, ISBN, genre, rating, description)"
			 				+ "VALUES(?,?,?,0,?,?,?,?,?,?);";
			 		PreparedStatement statement = conn.prepareStatement(sqlStr, Statement.RETURN_GENERATED_KEYS);
			 		statement.setString(1,title);
			 		statement.setString(2,author);
			 		statement.setDouble(3,price);
			 		statement.setString(4,publisher);
			 		statement.setString(5,pdate);
			 		statement.setString(6,isbn);
			 		statement.setString(7,genre);
			 		statement.setInt(8,rating);
			 		statement.setString(9,desc);
			 		statement.executeUpdate();
			 		ResultSet rs = statement.getGeneratedKeys();
			 		int book_id = 0;
			 		if (rs.next()) {
			 		    book_id = rs.getInt(1);
			 		}
			 		ArrayList<Book> books = (ArrayList<Book>) session.getAttribute("books");
		 			books.add(new Book(books.size()+1, title,author,price,0,publisher,pdate,desc,isbn, genres, rating));
			 		conn.close();
			 	} catch (Exception e) {
			 		out.println("Error: " + e);
			 	}
				response.sendRedirect(request.getHeader("referer").split("\\?")[0] + "?statusCode=validCreation");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
