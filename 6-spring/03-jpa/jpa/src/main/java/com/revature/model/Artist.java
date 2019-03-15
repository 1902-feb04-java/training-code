package com.revature.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name="artists")
public class Artist {
	@Id
	@SequenceGenerator(name="artists_seq", sequenceName="artists_id_seq", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="artists_seq")
	private long id;
	private String name;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Artist(long id, String name) {
		super();
		this.id = id;
		this.name = name;
	}

	public Artist() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "Artist [id=" + id + ", name=" + name + "]";
	}

}
