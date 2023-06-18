package books;

public class Book {
	private int id;
	private String title;
	private String author;
	private double price;
	private int quantity;
	private String publisher;
	private String date;
	private String isbn;
	private String[] genre;
	private int rating;
	private String description;
	private String image;
	public Book(int id, String title, String author, double price, int quantity, String publisher, String date, String description,
			String isbn, String[] genre, int rating, String image) {
		super();
		this.id = id;
		this.title = title;
		this.author = author;
		this.price = price;
		this.quantity = quantity;
		this.publisher = publisher;
		this.description = description;
		this.date = date;
		this.isbn = isbn;
		this.genre = genre;
		this.rating = rating;
		this.image = image;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public String getDescription() {
		return description;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getPublisher() {
		return publisher;
	}
	
	public int getRating() {
		return rating;
	}
	
	public void setRating (int rating) {
		this.rating=rating;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getIsbn() {
		return isbn;
	}
	
	public void setDescription (String description) {
		this.description = description;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public String[] getGenre() {
		return genre;
	}

	public void setGenre(String[] genre) {
		this.genre = genre;
	}
}
