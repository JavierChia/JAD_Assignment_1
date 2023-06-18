package customers;

public class Customer {
	private String name, email, address, orders, password;
	private int id;
	
	public Customer(int id, String name, String email, String address, String orders, String password) {
		this.id = id;
		this.name = name;
		this.email = email;
		this.address = address;
		this.orders = orders;
		this.password = password;
	}
	public Integer getID() {
		return id;
	}
	public String getName() {
		return name;
	}
	public String getPassword() {
		return password;
	}
	public String getEmail() {
		return email;
	}
	public String getAddress() {
		return address;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getOrders() {
		return orders;
	}
}
