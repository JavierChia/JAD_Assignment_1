package books;

public class BookGenre {
	private int genre_id;
	private String genre_name;
	
	public BookGenre(int genre_id, String genre_name) {
		super();
		this.genre_id = genre_id;
		this.genre_name = genre_name;
	}

	public int getGenreId() {
		return genre_id;
	}

	public String getGenreName() {
		return genre_name;
	}

}
