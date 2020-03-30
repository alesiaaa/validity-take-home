package com.validity.monolithstarter.domain;

import com.opencsv.bean.CsvBindByPosition;

public class UserContact {
	
	@CsvBindByPosition(position = 0)
	private String id;
	@CsvBindByPosition(position = 1)
	private String firstName;
	@CsvBindByPosition(position = 2)
	private String lastName;
	@CsvBindByPosition(position = 3)
	private String company;
	@CsvBindByPosition(position = 4)
	private String email;
	@CsvBindByPosition(position = 5)
	private String address1;
	@CsvBindByPosition(position = 6)
	private String address2;
	@CsvBindByPosition(position = 7)
	private String zip;
	@CsvBindByPosition(position = 8)
	private String city;
	@CsvBindByPosition(position = 9)
	private String stateLong;
	@CsvBindByPosition(position = 10)
	private String state;
	@CsvBindByPosition(position = 11)
	private String phone;
	
	public UserContact() {}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getId() {
		return id;
	}
	
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	
	public String getFirstName() {
		return firstName;
	}
	
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	
	public String getLastName() {
		return lastName;
	}
	
	public void setCompany(String company) {
		this.company = company;
	}
	
	public String getCompany() {
		return company;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	
	public String getAddress1() {
		return address1;
	}
	
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	
	public String getAddress2() {
		return address2;
	}
	
	public void setZip(String zip) {
		this.zip = zip;
	}
	
	public String getZip() {
		return zip;
	}
	
	public void setCity(String city) {
		this.city = city;
	}
	
	public String getCity() {
		return city;
	}
	
	public void setStateLong(String stateLong) {
		this.stateLong = stateLong;
	}
	
	public String getStateLong() {
		return stateLong;
	}
	
	public void setState(String state) {
		this.state = state;
	}
	
	public String getState() {
		return state;
	}
	
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getPhone() {
		return phone;
	}
	
	public String getFullName() {
		return (firstName.isEmpty() ? "" : firstName + " ") + lastName;
	}
	
	// Check if address is empty
	protected boolean isAddressEmpty() {
		if (address1.isEmpty() && address2.isEmpty() && zip.isEmpty() && city.isEmpty()
				&& stateLong.isEmpty() && state.isEmpty()) {
			return true;
		}
			
			return false;
	}
	
	// Create an instance of UserContact akin to the original row
	public String getRowAsString() {
		return id + "," + firstName + "," + lastName + "," + company + "," + email + "," + address1 + "," +
				address2 + "," + zip + "," + city + "," + stateLong + "," + state + "," + phone;
	}
	
	@Override
	public boolean equals(Object object) {
		
		// Check if this is the same object
		if (this == object) {
			return true;
		}
		
		// Check if object is null
		if (object == null) {
			return false;
		}
		
		// Check if class does not match
		if (getClass() != object.getClass()) {
			return false;
		}
		
		UserContact uc = (UserContact) object;
		
		if (uc.id.equals(this.id) &&
			uc.firstName.equals(this.firstName) &&
			uc.lastName.equals(this.lastName) &&
			uc.company.equals(this.company) &&
			uc.email.equals(this.email) &&
			uc.address1.equals(this.address1) &&
			uc.address2.equals(this.address2) &&
			uc.zip.equals(this.zip) &&
			uc.city.equals(this.city) &&
			uc.stateLong.equals(this.stateLong) &&
			uc.state.equals(this.state) &&
			uc.phone.equals(this.phone)) {
			
			return true;
		}
		
		return false;
	}
	
	@Override
	public int hashCode() {
		final int prime = 11;
		int result = 1;
		result = prime * result +
				((firstName == null) ? 0 : firstName.hashCode()) +
				((lastName == null) ? 0 : lastName.hashCode()) +
				((company == null) ? 0 : company.hashCode()) +
				((email == null) ? 0 : email.hashCode()) +
				((address1 == null) ? 0 : address1.hashCode()) +
				((address2 == null) ? 0 : address2.hashCode()) +
				((zip == null) ? 0 : zip.hashCode()) +
				((city == null) ? 0 : city.hashCode()) +
				((stateLong == null) ? 0 : stateLong.hashCode()) +
				((state == null) ? 0 : state.hashCode()) +
				((phone == null) ? 0 : phone.hashCode());
		return result;
	}
	
}
