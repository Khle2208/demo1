package fa.mockproject.model;

import java.util.UUID;

public class Address {
	private String province;
    private String district;
    private String ward;
    private String street;
    private UUID deliveredInformationId;
    
    
    
    
	public Address() {
		super();
	}
	public Address(String province, String district, String ward, String street, UUID deliveredInformationId) {
		super();
		this.province = province;
		this.district = district;
		this.ward = ward;
		this.street = street;
		this.deliveredInformationId = deliveredInformationId;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public String getWard() {
		return ward;
	}
	public void setWard(String ward) {
		this.ward = ward;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public UUID getDeliveredInformationId() {
		return deliveredInformationId;
	}
	public void setDeliveredInformationId(UUID deliveredInformationId) {
		this.deliveredInformationId = deliveredInformationId;
	}
    
    
    
}
