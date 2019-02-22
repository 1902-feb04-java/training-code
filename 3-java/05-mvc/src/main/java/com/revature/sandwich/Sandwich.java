package com.revature.sandwich;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Sandwich {
	List<String> ingredients;
	String prepStyle;
	boolean isWrap;

	public Sandwich(List<String> ingredients, String prepStyle, boolean isWrap) {
		super();
		this.ingredients = ingredients;
		this.prepStyle = prepStyle;
		this.isWrap = isWrap;
	}
	
	public Sandwich(String fileName) {
		try(BufferedReader br = new BufferedReader(new FileReader(fileName))) {
			ingredients = new ArrayList<>();
			while (br.ready()) {
				ingredients.add(br.readLine());
			}
			this.prepStyle = "hot";
			this.isWrap = true;
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public String toString() {
		return "Sandwich [ingredients=" + ingredients + ", prepStyle=" + prepStyle + ", isWrap=" + isWrap + "]";
	}
	
}
