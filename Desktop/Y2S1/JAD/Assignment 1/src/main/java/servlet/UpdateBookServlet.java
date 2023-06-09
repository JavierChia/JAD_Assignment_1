package servlet;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import books.Book;
import customers.Customer;

/**
 * Servlet implementation class NewBookServlet
 */
@WebServlet("/UpdateBookServlet")
@MultipartConfig
public class UpdateBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateBookServlet() {
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
			 		int quantity = Integer.parseInt(request.getParameter("quantity"));
			 		String publisher = request.getParameter("publisher");
			 		String pdate = request.getParameter("pdate");
			 		String isbn = request.getParameter("isbn");
			 		String[] genres = request.getParameterValues("genre");
			 		int rating = Integer.parseInt(request.getParameter("rating"));
			 		String desc = request.getParameter("desc");
			 		Part filePart = request.getPart("image");
			 		
			 		String genre = "-";
			 		for (int i = 0; i < genres.length; i++) {
			 			genre += genres[i] + "-";
			 		}
			 		
			 		// Convert the image to bytes
			 		InputStream fileInputStream = filePart.getInputStream();
			        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
			        int bytesRead;
			        byte[] data = new byte[1024];
			        while ((bytesRead = fileInputStream.read(data, 0, data.length)) != -1) {
			            buffer.write(data, 0, bytesRead);
			        }
			        byte[] imageBytes = buffer.toByteArray();
			        String image = Base64.getEncoder().encodeToString(imageBytes);

			 		String sqlStr = 
			 				"UPDATE books "
			 				+ "SET title = ?, author = ?, price = ?, quantity = ?, publisher = ?, publication_date = ?, ISBN = ?, genre = ?, rating = ?, description = ?, image = ?  "
			 				+ "WHERE ISBN = ?";
			 		PreparedStatement statement = conn.prepareStatement(sqlStr, Statement.RETURN_GENERATED_KEYS);
			 		statement.setString(1,title);
			 		statement.setString(2,author);
			 		statement.setDouble(3,price);
			 		statement.setInt(4,quantity);
			 		statement.setString(5,publisher);
			 		statement.setString(6,pdate);
			 		statement.setString(7,isbn);
			 		statement.setString(8,genre);
			 		statement.setInt(9,rating);
			 		statement.setString(10,desc);
			 		statement.setBytes(11,imageBytes);
			 		statement.setString(12,isbn);
			 		
			 		int rowsUpdated = statement.executeUpdate();
			 		ResultSet rs = statement.getGeneratedKeys();
			 		ArrayList<Book> books = (ArrayList<Book>) session.getAttribute("books");
			 	    for (Book book : books) {
			 	        if (book.getIsbn().equals(isbn)) {
			 	            book.setTitle(title);
			 	            book.setAuthor(author);
			 	            book.setPrice(price);
			 	            book.setQuantity(quantity);
			 	            book.setPublisher(publisher);
			 	            book.setDate(pdate);
			 	            book.setDescription(desc);
			 	            book.setGenre(genres);
			 	            book.setRating(rating);
			 	            book.setImage(image);
			 	            break;
			 	        }
			 	    }
			 		conn.close();
			 	} catch (Exception e) {
			 		out.println("Error: " + e);
			 	}
				response.sendRedirect(request.getHeader("referer").split("\\?")[0] + "?statusCode=validUpdate");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
