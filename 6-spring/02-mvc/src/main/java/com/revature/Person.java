package com.revature;

public class Person {
	private int id;
	private String firstName;
	private String lastName;

	public Person(int i, String f, String l) {
		id = i;
		firstName = f;
		lastName = l;
	}

	public Person() {
	};

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String toString() {
		return firstName + lastName;
	}
}