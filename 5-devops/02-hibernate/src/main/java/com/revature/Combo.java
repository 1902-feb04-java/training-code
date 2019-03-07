package com.revature;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="combo")
public class Combo {
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE)
	private int id;
	
	@Column(name="price")
	private double price;
	
	@ManyToOne(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	@JoinColumn(name="sandwich_id")
	private Sandwich sandwich;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public Sandwich getSandwich() {
		return sandwich;
	}

	public void setSandwich(Sandwich sandwich) {
		this.sandwich = sandwich;
	}

	public Combo(int id, double price, Sandwich sandwich) {
		super();
		this.id = id;
		this.price = price;
		this.sandwich = sandwich;
	}

	public Combo() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "Combo [id=" + id + ", price=" + price + ", sandwich=" + sandwich + "]";
	}

}
