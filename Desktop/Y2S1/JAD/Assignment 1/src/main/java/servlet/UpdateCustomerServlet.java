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

import org.mindrot.jbcrypt.BCrypt;

import customers.Customer;

/**
 * Servlet implementation class UpdateCustomerServlet
 */
@WebServlet("/UpdateCustomerServlet")
public class UpdateCustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCustomerServlet() {
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
	
	        // Step 5: Execute SQL Command
	 		
	        String name = request.getParameter("name");
	        String email = request.getParameter("email");
	        out.println(name + " " + email);
	        String password = request.getParameter("password");
	        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
	        String address = request.getParameter("address");
	        Integer customerID = Integer.parseInt(request.getParameter("customerId"));
	        String sqlStr = "UPDATE customers SET ";
	        ArrayList<Object> values = new ArrayList<>();
	        
	        if (name != null && !name.isEmpty()) {
	            sqlStr += "name = ?, ";
	            values.add(name);
	        }
	        
	        if (email != null && !email.isEmpty()) {
	            sqlStr += "email = ?, ";
	            values.add(email);
	        }
	        
	        if (password != null && !password.isEmpty()) {
	            sqlStr += "password = ?, ";
	            values.add(hashedPassword);
	        }
	        
	        if (address != null && !address.isEmpty()) {
	            sqlStr += "address = ?, ";
	            values.add(address);
	        }
	        
	        // remove comma and space
	        sqlStr = sqlStr.substring(0, sqlStr.length() - 2);
	        
	        sqlStr += " WHERE `id` = ?";
	        values.add(customerID);

	        PreparedStatement statement = conn.prepareStatement(sqlStr);
	        for (int i = 1; i < values.size(); i++) {
	            statement.setObject(i, values.get(i-1));
	        }
	        
	        statement.setInt(values.size(), customerID);
	        out.println(sqlStr);
	        int rowsUpdated = statement.executeUpdate();
	
	        if (rowsUpdated > 0) {
	            out.println("User information updated successfully.");
	            ArrayList<Customer> customers = (ArrayList<Customer>) session.getAttribute("customers");
		 	    for (Customer customer: customers) {
		 	        if (customer.getID().equals(customerID)) {
						if (name != null && !name.isEmpty()) {
					        customer.setName(name);
					    }
					    if (email != null && !email.isEmpty()) {
					        customer.setEmail(email);
					    }
					    if (password != null && !password.isEmpty()) {
					        customer.setPassword(password);
					    }
					    if (address != null && !address.isEmpty()) {
					        customer.setAddress(address);
					    }
					    break;
		 	        }
		 	    }
		 	   session.setAttribute("customers", customers);
	        } else {
	            out.println("No changes were made.");
	        }
	        
	        conn.close();
	        response.sendRedirect(request.getHeader("referer").split("\\?")[0] + "?statusCode=validCustomerUpdate");
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
