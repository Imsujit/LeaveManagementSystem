package com.leaveapp;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	public static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/leave_management", "root", "root");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}
