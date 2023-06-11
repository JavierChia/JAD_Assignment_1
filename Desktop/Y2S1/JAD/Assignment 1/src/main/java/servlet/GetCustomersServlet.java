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

import customers.Customer;

/**
 * Servlet implementation class GetCustomersServlet
 */
@WebServlet("/GetCustomersServlet")
public class GetCustomersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetCustomersServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String sqlStr = "SELECT c.first_name, c.last_name, c.email, c.address, IFNULL(o.id, '-') AS order_id FROM customers c LEFT JOIN orders o ON c.id = o.customer_id";
		try {
	 		Class.forName("com.mysql.jdbc.Driver");
	 		
	 		String connURL = "jdbc:mysql://localhost/bookstore_db?user=root&password=root&serverTimezone=UTC";
	 		
	 		Connection conn = DriverManager.getConnection(connURL);
	 		
	 		PreparedStatement statement = conn.prepareStatement(sqlStr);
	 		
	 		ResultSet rs = statement.executeQuery();
	 		
	 		// Step 6: Process Result
	 		ArrayList<Customer> customers =  new ArrayList<Customer>();
	 		while (rs.next()) {
	 			String first_name = rs.getString("first_name");
	 			String last_name = rs.getString("last_name");
	 			String email = rs.getString("email");
	 			String address = rs.getString("address");
	 			String orders = rs.getString("order_id");
	 			
	 			customers.add(new Customer(first_name, last_name, email, address, orders));
	 		}
	 		
	 		HttpSession session = request.getSession();
	 		session.setAttribute("customers", customers);
	 		
	 		response.sendRedirect("/ST0510_JAD_Assignment_1/adminCustomer.jsp");
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