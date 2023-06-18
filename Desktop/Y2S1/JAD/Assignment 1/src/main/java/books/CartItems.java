package books;

public class CartItems {
	private int bookID, quantity;
	
	public CartItems(int bookID, int quantity) {
		this.bookID = bookID;
		this.quantity = quantity;
	}

	public int getBookID() {
		return bookID;
	}

	public int getQuantity() {
		return quantity;
	}
	
	public void setQuantity(int quantity) {
		this.quantity=quantity;
	}
}
