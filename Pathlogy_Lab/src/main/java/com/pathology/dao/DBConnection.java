package com.pathology.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class DBConnection {

	private static final ResourceBundle bundle = ResourceBundle.getBundle("config");
	
	private static final String URL = System.getenv("DB_URL") != null ? System.getenv("DB_URL") : bundle.getString("db.url");
	private static final String DRIVER = bundle.getString("db.driver");
	private static final String USERNAME = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : bundle.getString("db.username");
	private static final String PASSWORD = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : bundle.getString("db.password");

	public static Connection getConnection() {
		Connection con = null;

		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
		} catch (ClassNotFoundException | SQLException e) {
			System.err.println("Database Connection Error: " + e.getMessage());
			e.printStackTrace();
		}

		return con;
	}
}
