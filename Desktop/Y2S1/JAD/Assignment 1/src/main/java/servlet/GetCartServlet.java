package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import books.Book;
import books.BookGenre;
import books.CartItems;

/**
 * Servlet implementation class GetCartServlet
 */
@WebServlet("/GetCartServlet")
public class GetCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetCartServlet() {
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
		
		try {
			//Step 1
	 		Class.forName("com.mysql.jdbc.Driver");

	 		String connURL = "jdbc:mysql://localhost/bookstore_db?user=root&password=root&serverTimezone=UTC";

	 		Connection conn = DriverManager.getConnection(connURL);
	 		if (session.getAttribute("cart") != null) {
	 			ArrayList<CartItems> cart = (ArrayList<CartItems>) session.getAttribute("cart");
	 			
				String sqlStr = "SELECT * FROM books WHERE id = ?";
				
		 		ArrayList<Book> booksInCart =  new ArrayList<Book>();
		 		for (int i = 0; i < cart.size(); i++) {
		            PreparedStatement statement = conn.prepareStatement(sqlStr);
		            statement.setInt(1, cart.get(i).getBookID());
		            ResultSet rs = statement.executeQuery();

		            if (rs.next()) {
		            	int id = rs.getInt("id");
			 			String title = rs.getString("title");
			 			String author = rs.getString("author");
			 			double price = rs.getDouble("price");
			 			int quantity = rs.getInt("quantity");
			 			String publisher = rs.getString("publisher");
			 			String date = rs.getString("publication_date");
			 			String isbn = rs.getString("isbn");
			 			String description = rs.getString("description");
			 			String genresString = rs.getString("genre");
			 		    String[] genreIDs = genresString.split(",");
			 		    Blob blob = rs.getBlob("image");
			 			String image = "";
			 			if (blob != null) {
			 				byte[] imageData = blob.getBytes(1, (int) blob.length());
				 		    image = Base64.getEncoder().encodeToString(imageData);
			 			}
			 		    String[] genreNames = new String[genreIDs.length];
			 		    
				 		   for (int x = 0; x < genreIDs.length; x++) {
				 		        try {
				 		            String sql = "SELECT genre_name FROM book_genre WHERE genre_id = ?";
				 		            PreparedStatement statement1 = conn.prepareStatement(sql);
				 		            statement1.setString(1, genreIDs[x]);
				 		            ResultSet resultSet = statement1.executeQuery();
			
				 		            if (resultSet.next()) {
				 		                genreNames[x] = resultSet.getString("genre_name");
				 		            }
			
				 		            resultSet.close();
				 		            statement1.close();
				 		        } catch (Exception e) {
				 		            e.printStackTrace();
				 		            // Handle the exception appropriately
				 		        }
				 		    }
			 		    int rating = rs.getInt("rating");

		                // Create a Book object
			 		   	booksInCart.add(new Book(id,title,author,price,quantity,publisher,date,description,isbn, genreNames, rating, image));
		            }
		            
		            // Close the ResultSet and PreparedStatement
		            rs.close();
		            statement.close();
		        }
		 		session.setAttribute("booksInCart", booksInCart);
		 		response.sendRedirect("/ST0510_JAD_Assignment_1/cart.jsp");
	 		} else {
	 			
	 			response.sendRedirect("/ST0510_JAD_Assignment_1/cart.jsp");
	 		}
	 		
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
