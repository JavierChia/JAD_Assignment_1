package customers;

public class Customer {
	private String first_name, last_name, email, address, orders;
	
	public Customer(String first_name, String last_name, String email, String address, String orders) {
		this.first_name = first_name;
		this.last_name = last_name;
		this.email = email;
		this.address = address;
		this.orders = orders;
	}
	
	public String getName() {
		return first_name + " " + last_name;
	}
	public String getEmail() {
		return email;
	}
	public String getAddress() {
		return address;
	}
	public String getOrders() {
		return orders;
	}
}
