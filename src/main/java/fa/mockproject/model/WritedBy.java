package fa.mockproject.model;

import java.util.UUID;

public class WritedBy {
	private UUID authorId;
    private UUID bookId;
    
    public WritedBy() {
		super();
    }
	public WritedBy(UUID authorId, UUID bookId) {
		super();
		this.authorId = authorId;
		this.bookId = bookId;
	}
	public UUID getAuthorId() {
		return authorId;
	}
	public void setAuthorId(UUID authorId) {
		this.authorId = authorId;
	}
	public UUID getBookId() {
		return bookId;
	}
	public void setBookId(UUID bookId) {
		this.bookId = bookId;
	}
    
    
    
}
