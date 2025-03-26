package fa.mockproject.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.UUID;

import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Digits;
import javax.validation.constraints.Future;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

public class Discount {
	private UUID discountId;
	@NotBlank
	private String nameDiscount;
	@NotNull
	@DecimalMin(value = "0.0", inclusive = false)
	@Digits(integer = 8, fraction = 2)
	private BigDecimal discountPrice;
	private int quantity;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Future()
	@NotNull
	private LocalDate outDate;
	
	public Discount() {
		super();
	}
	
	public Discount(UUID discountId, String nameDiscount, BigDecimal discountPrice, int quantity, LocalDate outDate) {
		super();
		this.discountId = discountId;
		this.nameDiscount = nameDiscount;
		this.discountPrice = discountPrice;
		this.quantity = quantity;
		this.outDate = outDate;
	}

	public UUID getDiscountId() {
		return discountId;
	}

	public void setDiscountId(UUID discountId) {
		this.discountId = discountId;
	}

	public String getNameDiscount() {
		return nameDiscount;
	}

	public void setNameDiscount(String nameDiscount) {
		this.nameDiscount = nameDiscount;
	}

	public BigDecimal getDiscountPrice() {
		return discountPrice;
	}

	public void setDiscountPrice(BigDecimal discountPrice) {
		this.discountPrice = discountPrice;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public LocalDate getOutDate() {
		return outDate;
	}

	public void setOutDate(LocalDate outDate) {
		this.outDate = outDate;
	}

}
