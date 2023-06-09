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
import org.mindrot.jbcrypt.BCrypt;

/**
 * Servlet implementation class VerifyUserServlet
 */
@WebServlet("/VerifyUserServlet")
public class VerifyUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VerifyUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		
		String name, role, address;
		int id;
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String referer = request.getHeader("referer");
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String connURL = "jdbc:mysql://localhost/bookstore_db?user=root&password=root&serverTimezone=UTC";
			Connection conn = DriverManager.getConnection(connURL);
			
			String sql = "SELECT * FROM customers WHERE email=?";
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, email);
			ResultSet rs = statement.executeQuery();
			
			while (rs.next()) {
				name = rs.getString("name");
				role = rs.getString("role");
				id = rs.getInt("id");
				email = rs.getString("email");
				address = rs.getString("address");
				if(BCrypt.checkpw(password,rs.getString("password"))){
					session.setAttribute("sessUserID", id);
					session.setAttribute("sessUserRole", role);
					session.setAttribute("sessUserName", name);
					session.setAttribute("sessUserPassword", password);
					session.setAttribute("sessUserEmail", email);
					session.setAttribute("sessUserAddress", address);
					if (role.equals("Admin")) {
						response.sendRedirect("/ST0510_JAD_Assignment_1/GetCustomersServlet");
					} else {
						response.sendRedirect(request.getHeader("referer").split("\\?")[0] + "?statusCode=validLogin");
					}
		        } else {
		            response.sendRedirect(request.getHeader("referer").split("\\?")[0] + "?statusCode=invalidLogin");
		        }
			}
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
