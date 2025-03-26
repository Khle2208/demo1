package fa.mockproject.model;

import java.util.UUID;

public class HasDiscount {
	private UUID userId;
    private UUID discountId;
    
    public HasDiscount() {
    	super();
    }
  
	public HasDiscount(UUID userId, UUID discountId) {
		super();
		this.userId = userId;
		this.discountId = discountId;
	}
	public UUID getUserId() {
		return userId;
	}
	public void setUserId(UUID userId) {
		this.userId = userId;
	}
	public UUID getDiscountId() {
		return discountId;
	}
	public void setDiscountId(UUID discountId) {
		this.discountId = discountId;
	}
    
    
    
}
