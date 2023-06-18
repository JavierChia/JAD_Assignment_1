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

import java.sql.Blob;
import java.util.Base64;

import books.Book;
import books.BookGenre;

/**
 * Servlet implementation class GetBooksServlet
 */
@WebServlet("/GetBooksServlet")
public class GetBooksServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetBooksServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		String sqlStr = "SELECT * FROM books";
		String sqlStr1 = "SELECT * FROM book_genre";
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
	 		String[] searchedGenres = request.getParameterValues("genre");
	 		System.out.println("Selected Genres: " + searchedGenres);
	 		String searchTitle = request.getParameter("title");
	 		if (searchedGenres != null) {
	 			sqlStr += " WHERE genre LIKE ?";
	 			for (int i = 1; i < searchedGenres.length; i++) {
	 			sqlStr += " AND genre LIKE ?";
	 			}
	 		}
	 		if (searchedGenres != null && searchTitle != null) {
	 			sqlStr += " AND title LIKE ?";
	 		}
	 		if (searchedGenres == null && searchTitle != null) {
	 			sqlStr += " WHERE title LIKE ?";
	 		}
	 		log(sqlStr);
	 		
	 		PreparedStatement statement = conn.prepareStatement(sqlStr);
	 		
	 		int index = 0;
	 		if (searchedGenres != null) {
	 			for (index = 0; index < searchedGenres.length; index++) {
	 				statement.setString(index+1, "%-"+searchedGenres[index]+"-%");
	 			}
	 		}
	 		if (searchedGenres != null && searchTitle != null) {
	 			statement.setString(index+1, "%"+searchTitle+"%");
	 		}
	 		if (searchedGenres == null && searchTitle != null) {
	 			statement.setString(1, "%"+searchTitle+"%");
	 		}
	 		
	 		ResultSet rs = statement.executeQuery();
	 		
	 		// Step 6: Process Result
	 		ArrayList<Book> books =  new ArrayList<Book>();
	 		while (rs.next()) {
	 			int id = rs.getInt("id");
	 			String title = rs.getString("title");
	 			String author = rs.getString("author");
	 			double price = rs.getDouble("price");
	 			int quantity = rs.getInt("quantity");
	 			String publisher = rs.getString("publisher");
	 			String description = rs.getString("description");
	 			String date = rs.getString("publication_date");
	 			String isbn = rs.getString("isbn");
	 			int rating = rs.getInt("rating");
	 			String[] genre = rs.getString("genre").substring(1).split("-");
	 			Blob blob = rs.getBlob("image");
	 			String image = "";
	 			if (blob != null) {
	 				byte[] imageData = blob.getBytes(1, (int) blob.length());
		 		    image = Base64.getEncoder().encodeToString(imageData);
	 			}
	 			Book book = new Book(id,title,author,price,quantity,publisher,date,description,isbn, genre, rating, image);
	 			try {
	 				out.println(book.getImage().length());
	 			} catch (Exception e) {
	 				
	 			}
	 			books.add(book);
	 			
	 		}
	 		
	 		ArrayList<BookGenre> genres = new ArrayList<BookGenre>();
            ResultSet rs2 = stmt.executeQuery(sqlStr1);
            while (rs2.next()) {
            	int genre_id = rs2.getInt("genre_id");
                String genre_name = rs2.getString("genre_name");
                genres.add(new BookGenre(genre_id, genre_name));
            }
	 		
	 		HttpSession session = request.getSession();
	 		session.setAttribute("books", books);
	 		session.setAttribute("genres", genres);
	 		// Step 7: Close connection
	 		response.sendRedirect("/ST0510_JAD_Assignment_1/" + request.getParameter("next"));
	 		conn.close();
	 	} catch (Exception e) {
	 		out.println("Error: " + e);
	 		out.println(sqlStr);
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
