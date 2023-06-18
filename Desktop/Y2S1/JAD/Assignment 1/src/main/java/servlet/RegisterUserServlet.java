package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

import customers.Customer;
/**
 * Servlet implementation class RegisterUserServlet
 */
@WebServlet("/RegisterUserServlet")
public class RegisterUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterUserServlet() {
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
		
		String name =  request.getParameter("name");
		String address ="";
		String orders="-";
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String connURL = "jdbc:mysql://localhost/bookstore_db?user=root&password=root&serverTimezone=UTC";
			Connection conn = DriverManager.getConnection(connURL);
			
			String sql = "INSERT INTO customers (name, email, password) VALUES(?, ?, ?)";
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, name);
			statement.setString(2, email);
			statement.setString(3, hashedPassword);
			int rowsAffected = statement.executeUpdate();

		    if (rowsAffected == 1) {
		    	String referer = request.getHeader("referer");
	            if (referer != null && referer.contains("adminCustomer.jsp")) {
	            	response.sendRedirect("/ST0510_JAD_Assignment_1/adminCustomer.jsp?statusCode=validRegistration");
	            } else {
	            	response.sendRedirect("/ST0510_JAD_Assignment_1/index.jsp?statusCode=validRegistration");
	            }
		    } else {
		    	response.sendRedirect("/ST0510_JAD_Assignment_1/index.jsp?statusCode=invalidRegistration");
		    }
			// Step 7: Close connection
		    ArrayList<Customer> customers = (ArrayList<Customer>) session.getAttribute("customers");
 			customers.add(new Customer(customers.size()+1, name, email, address, orders, hashedPassword));
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
