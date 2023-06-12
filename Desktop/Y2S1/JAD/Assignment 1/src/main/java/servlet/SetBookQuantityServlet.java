package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class SetBookQuantityServlet
 */
@WebServlet("/SetBookQuantityServlet")
public class SetBookQuantityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SetBookQuantityServlet() {
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
	 		int bookQuantity = Integer.parseInt(request.getParameter("quantity"));
	 		String action = request.getParameter("action");
	 		String isbn = request.getParameter("isbn");
	 		out.print(isbn);
	 		out.print(action);
	 		
	 		String sqlStr = "";
	 		if (action.equals("remove")) {
	 			sqlStr = "UPDATE books SET quantity = quantity - ? WHERE ISBN = ?";
	 		} else if (action.equals("add")) {
	 			sqlStr = "UPDATE books SET quantity = quantity + ? WHERE ISBN = ?";
	 		} else {
	 			sqlStr = "UPDATE books SET quantity = ? WHERE ISBN = ?";
	 		}
	 		
	 		PreparedStatement statement = conn.prepareStatement(sqlStr, Statement.RETURN_GENERATED_KEYS);
	 		statement.setInt(1,bookQuantity);
	 		statement.setString(2,isbn);
	 		statement.executeUpdate();
	 		// Step 6: Process Result

	 		// Step 7: Close connection
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
