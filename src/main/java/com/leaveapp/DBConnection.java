package com.leaveapp;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	public static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mysql://maglev.proxy.rlwy.net:17156/railway?useSSL=false&allowPublicKeyRetrieval=true",
					"root", "XSdfQjSTimyLYTcubhnMWosWDsrkNobr");

		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}
