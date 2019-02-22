package com.revature;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.revature.sandwich.Sandwich;
import com.revature.sandwich.SandwichFactory;

public class App {

	public static void main(String[] args) {
		Sandwich sandwich = SandwichFactory.getInstance().build("ingredients.txt");
		System.out.println(sandwich.toString());
		
		String url = "jdbc:postgresql://postgres.cvoui7q38caj.us-east-2.rds.amazonaws.com:5432/postgres";
		String username = "postgres";
		String password = "postgres";
		
		try (Connection connection = DriverManager.getConnection(url, username, password)) {
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("select * from sandwich");
			while (rs.next()) {
				System.out.println(rs.getString("id"));
				System.out.println(rs.getString("name"));
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
