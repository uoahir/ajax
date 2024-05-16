package com.ajax.model.dto;


public class Actor {
	private String name;
	private String phone;
	private String profile;
	private int age;
	private double height;
	private boolean married;
	
	public Actor() {
		// TODO Auto-generated constructor stub
	}
	
	public Actor(String name, String phone, String profile, int age, double height, boolean married) {
		super();
		this.name = name;
		this.phone = phone;
		this.profile = profile;
		this.age = age;
		this.height = height;
		this.married = married;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public double getHeight() {
		return height;
	}

	public void setHeight(double height) {
		this.height = height;
	}

	public boolean isMarried() {
		return married;
	}

	public void setMarried(boolean married) {
		this.married = married;
	}
	
	
	
//	public String toJson() {
//		return "{\"name\":\""+name+""\",\"phone\"}";
//	}
	
	
}
