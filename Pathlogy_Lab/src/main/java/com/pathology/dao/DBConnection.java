package com.pathology.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class DBConnection {

	private static final ResourceBundle bundle = ResourceBundle.getBundle("config");
	
	private static final String URL = bundle.getString("db.url");
	private static final String DRIVER = bundle.getString("db.driver");
	private static final String USERNAME = bundle.getString("db.username");
	private static final String PASSWORD = bundle.getString("db.password");

	public static Connection getConnection() {
		Connection con = null;

		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

		return con;
	}
}
