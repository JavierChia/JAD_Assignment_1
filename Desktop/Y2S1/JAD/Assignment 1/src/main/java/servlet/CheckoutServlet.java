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
import books.BookGenre;

/**
 * Servlet implementation class CheckoutServlet
 */
@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
//		ArrayList<Integer> cart1 = new ArrayList<>();
//		cart1.add(1);
//		cart1.add(2);
//		cart1.add(4);
//		ArrayList<Integer> quantity1 = new ArrayList<>();
//		quantity1.add(3);
//		quantity1.add(1);
//		quantity1.add(1);
//		session.setAttribute("cart", cart1);
//		session.setAttribute("quantity", quantity1);
//		session.setAttribute("customer", 3);
//		response.sendRedirect("CheckoutServlet.java");
		PrintWriter out = response.getWriter();
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
	 		int customer = (int) session.getAttribute("customer");
	 		ArrayList<Integer> cart = (ArrayList<Integer>) session.getAttribute("cart");
	 		ArrayList<Integer> quantity = (ArrayList<Integer>) session.getAttribute("quantity");
	 		String sqlStr1 = "INSERT INTO orders (customer_id, order_date) VALUES(?, NOW());";
	 		PreparedStatement statement1 = conn.prepareStatement(sqlStr1, Statement.RETURN_GENERATED_KEYS);
	 		statement1.setInt(1,customer);
	 		statement1.executeUpdate();
	 		ResultSet rs1 = statement1.getGeneratedKeys();
	 		int order_id = 0;
	 		if (rs1.next()) {
	 		    order_id = rs1.getInt(1);
	 		}
	 		
	 		String sqlStr2 = "INSERT INTO order_items (order_id, book_id, quantity) VALUES (" + order_id + ",?,?);";
	 		for (int i = 0; i < cart.size(); i++) {
	 			PreparedStatement statement2 = conn.prepareStatement(sqlStr2);
		 		statement2.setInt(1,cart.get(i));
		 		statement2.setInt(2,quantity.get(i));
		 		statement2.executeUpdate();
	 		}
	 		
	 		// Step 6: Process Result
	 		
	 		
	 		// Step 7: Close connection
	 		response.sendRedirect("/ST0510_JAD_Assignment_1/books.jsp");
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
