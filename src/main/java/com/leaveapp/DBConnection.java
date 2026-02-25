package com.leaveapp;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	public static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection("jdbc:postgresql://localhost/leave_management", "postgres", "password");

		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}
