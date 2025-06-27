// OLD CODE WHICH IS WORKING FINE

//package com.leaveapp;
//
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.SQLException;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//@WebServlet("/RegisterServlet")
//public class RegisterServlet extends HttpServlet {
//	protected void doPost(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
//
//		String username = request.getParameter("username");
//		String email = request.getParameter("email");
//		String password = request.getParameter("password");
//		String role = request.getParameter("role");
//
//		try {
//			Connection conn = DBConnection.getConnection();
//			String sql = "INSERT INTO users (username, password, role, email) VALUES (?, ?, ?, ?)";
//			PreparedStatement stmt = conn.prepareStatement(sql);
//			stmt.setString(1, username);
//			stmt.setString(2, password);
//			stmt.setString(3, role);
//			stmt.setString(4, email);
//
//			int row = stmt.executeUpdate();
//			if (row > 0) {
//				request.getRequestDispatcher("jsp/login.jsp").forward(request, response);
//			} else {
//				request.setAttribute("errorMessage", "Registration failed.");
//				request.getRequestDispatcher("jsp/register.jsp").forward(request, response);
//			}
//		} catch (SQLException e) {
//			if (e.getErrorCode() == 1062) { // MySQL duplicate entry error code
//				request.getSession().setAttribute("errorMessage", "User already exists.");
//				response.sendRedirect("jsp/register.jsp");
//			} else {
//				e.printStackTrace();
//				request.getSession().setAttribute("errorMessage", "Registration failed: " + e.getMessage());
//				response.sendRedirect("jsp/register.jsp");
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			request.setAttribute("errorMessage", "Error: " + e.getMessage());
//			request.getRequestDispatcher("jsp/register.jsp").forward(request, response);
//		}
//	}
//}
package com.leaveapp;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String role = request.getParameter("role");

		// Validate input
		if (username == null || username.trim().isEmpty()) {
			request.setAttribute("errorMessage", "Please enter a username.");
			request.getRequestDispatcher("jsp/register.jsp").forward(request, response);
			return;
		}

		if (email == null || email.trim().isEmpty()) {
			request.setAttribute("errorMessage", "Please enter an email address.");
			request.getRequestDispatcher("jsp/register.jsp").forward(request, response);
			return;
		}

		if (password == null || password.trim().isEmpty()) {
			request.setAttribute("errorMessage", "Please enter a password.");
			request.getRequestDispatcher("jsp/register.jsp").forward(request, response);
			return;
		}

		if (role == null || role.trim().isEmpty()) {
			request.setAttribute("errorMessage", "Please select a role.");
			request.getRequestDispatcher("jsp/register.jsp").forward(request, response);
			return;
		}

		username = username.trim();
		email = email.trim().toLowerCase();

		Connection conn = null;
		PreparedStatement checkStmt = null;
		PreparedStatement insertStmt = null;
		ResultSet rs = null;

		try {
			conn = DBConnection.getConnection();

			// Check if username or email already exists
			String checkSql = "SELECT username, email FROM users WHERE username = ? OR email = ?";
			checkStmt = conn.prepareStatement(checkSql);
			checkStmt.setString(1, username);
			checkStmt.setString(2, email);
			rs = checkStmt.executeQuery();

			if (rs.next()) {
				String existingUsername = rs.getString("username");
				String existingEmail = rs.getString("email");

				if (username.equals(existingUsername)) {
					request.setAttribute("errorMessage",
							"Username already exists. Please choose a different username.");
				} else if (email.equals(existingEmail)) {
					request.setAttribute("errorMessage", "Email already registered. Please use a different email.");
				}

				request.getRequestDispatcher("jsp/register.jsp").forward(request, response);
				return;
			}

			rs.close();
			checkStmt.close();

			// Hash password using SHA-256
			String hashedPassword = hashPassword(password);

			// Insert new user
			String insertSql = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)";
			insertStmt = conn.prepareStatement(insertSql);
			insertStmt.setString(1, username);
			insertStmt.setString(2, email);
			insertStmt.setString(3, hashedPassword);
			insertStmt.setString(4, role);

			int rowsInserted = insertStmt.executeUpdate();

			if (rowsInserted > 0) {
				System.out.println("User registered successfully: " + username);

				// Send welcome email
				try {
					EmailUtil.sendWelcomeEmail(email, username);
					System.out.println("Welcome email sent to: " + email);
				} catch (Exception emailException) {
					System.err.println("Failed to send welcome email: " + emailException.getMessage());
					// Don't fail registration if email fails
				}

				// Redirect to login page with success message
				request.setAttribute("successMessage", "Registration successful! Please login with your credentials.");
				request.getRequestDispatcher("jsp/login.jsp").forward(request, response);

			} else {
				request.setAttribute("errorMessage", "Registration failed. Please try again.");
				request.getRequestDispatcher("jsp/register.jsp").forward(request, response);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Database error occurred. Please try again later.");
			request.getRequestDispatcher("jsp/register.jsp").forward(request, response);

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "System error occurred. Please try again later.");
			request.getRequestDispatcher("jsp/register.jsp").forward(request, response);

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (checkStmt != null)
					checkStmt.close();
				if (insertStmt != null)
					insertStmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect(request.getContextPath() + "/jsp/register.jsp");
	}

	/**
	 * Hash password using SHA-256 (same method used in login and reset)
	 */
	private String hashPassword(String password) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		byte[] hashedBytes = md.digest(password.getBytes());

		StringBuilder sb = new StringBuilder();
		for (byte b : hashedBytes) {
			sb.append(String.format("%02x", b));
		}
		return sb.toString();
	}
}
