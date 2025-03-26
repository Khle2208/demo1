package fa.mockproject.model;

import java.util.Date;
import java.util.UUID;

public class Ratings {
	private UUID ratingsId;
	private String content;
	private int starNumber;
	private Date createdAt;
	private UUID userId;
	private UUID bookId;
	
	
	public Ratings() {
		super();
	}
	
	public Ratings(UUID ratingsId, String content, int starNumber, Date createdAt, UUID userId, UUID bookId) {
		super();
		this.ratingsId = ratingsId;
		this.content = content;
		this.starNumber = starNumber;
		this.createdAt = createdAt;
		this.userId = userId;
		this.bookId = bookId;
	}
	public UUID getRatingsId() {
		return ratingsId;
	}
	public void setRatingsId(UUID ratingsId) {
		this.ratingsId = ratingsId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getStarNumber() {
		return starNumber;
	}
	public void setStarNumber(int starNumber) {
		this.starNumber = starNumber;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public UUID getUserId() {
		return userId;
	}
	public void setUserId(UUID userId) {
		this.userId = userId;
	}
	public UUID getBookId() {
		return bookId;
	}
	public void setBookId(UUID bookId) {
		this.bookId = bookId;
	}
	
	
	
	
	
}
