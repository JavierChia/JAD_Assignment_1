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
 * Servlet implementation class DeleteBookServlet
 */
@WebServlet("/DeleteBookServlet")
public class DeleteBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteBookServlet() {
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
	 		String isbn = request.getParameter("isbn");
	 		

	 		String sqlStr = "DELETE FROM books WHERE ISBN = ?";
	 		PreparedStatement statement = conn.prepareStatement(sqlStr, Statement.RETURN_GENERATED_KEYS);
	 		statement.setString(1,isbn);
	 		statement.executeUpdate();
	 		ResultSet rs = statement.getGeneratedKeys();
	 		int book_id = 0;
	 		if (rs.next()) {
	 		    book_id = rs.getInt(1);
	 		}
	 		conn.close();
	 		ArrayList<Book> books = (ArrayList<Book>) session.getAttribute("books");
	 	    for (int i = 0; i < books.size(); i++) {
	 	        Book book = books.get(i);
	 	        if (book.getIsbn().equals(isbn)) {
	 	            books.remove(i);
	 	            break; // Exit the loop once the book is removed
	 	        }
	 	    }
	 		response.sendRedirect(request.getHeader("referer").split("\\?")[0] + "?statusCode=validDeletion");
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
