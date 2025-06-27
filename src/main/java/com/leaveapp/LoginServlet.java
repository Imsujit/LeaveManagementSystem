// OLD CODE WHICH IS WORKING FINE

//package com.leaveapp;
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;

//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//@WebServlet("/LoginServlet")
//public class LoginServlet extends HttpServlet {
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//
//        String sql = "SELECT role, password FROM users WHERE BINARY username = ? AND BINARY password = ?";
//        try (
//            Connection conn = DBConnection.getConnection();
//            PreparedStatement stmt = conn.prepareStatement(sql)
//        ) {
//            stmt.setString(1, username);
//            stmt.setString(2, password);
//            try (ResultSet rs = stmt.executeQuery()) {
//                if (rs.next()) {
//                    String role = rs.getString("role");
//                    HttpSession session = request.getSession();
//                    session.setAttribute("username", username);
//                    session.setAttribute("role", role);
//
//                    if ("admin".equals(role)) {
//                        request.getRequestDispatcher("jsp/adminDashboard.jsp").forward(request, response);
//                    } else {
//                        request.getRequestDispatcher("jsp/userDashboard.jsp").forward(request, response);
//                    }
//                } else {
//                    request.getSession().setAttribute("errorMessage", "Invalid username or password");
//                    response.sendRedirect("jsp/login.jsp");
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            request.getSession().setAttribute("errorMessage", "An internal error occurred. Please try again later.");
//            response.sendRedirect("jsp/login.jsp");
//        }
//    }
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
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		// Validate input
		if (username == null || username.trim().isEmpty()) {
			request.setAttribute("errorMessage", "Please enter your username.");
			request.getRequestDispatcher("jsp/login.jsp").forward(request, response);
			return;
		}

		if (password == null || password.trim().isEmpty()) {
			request.setAttribute("errorMessage", "Please enter your password.");
			request.getRequestDispatcher("jsp/login.jsp").forward(request, response);
			return;
		}

		username = username.trim();

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			conn = DBConnection.getConnection();

			// Hash the entered password
			String hashedPassword = hashPassword(password);

			String sql = "SELECT username, role FROM users WHERE username = ? AND password = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, username);
			stmt.setString(2, hashedPassword);

			rs = stmt.executeQuery();

			if (rs.next()) {
				// Login successful
				String role = rs.getString("role");

				HttpSession session = request.getSession();
				session.setAttribute("username", username);
				session.setAttribute("role", role);

				System.out.println("Login successful for user: " + username + " with role: " + role);

				// Redirect based on role
				if ("admin".equalsIgnoreCase(role)) {
					response.sendRedirect(request.getContextPath() + "/jsp/adminDashboard.jsp");
				} else {
					response.sendRedirect(request.getContextPath() + "/jsp/userDashboard.jsp");
				}

			} else {
				// Login failed - check if username exists
				String checkUserSql = "SELECT username FROM users WHERE username = ?";
				PreparedStatement checkStmt = conn.prepareStatement(checkUserSql);
				checkStmt.setString(1, username);
				ResultSet checkRs = checkStmt.executeQuery();

				if (checkRs.next()) {
					// Username exists, wrong password
					request.setAttribute("errorMessage", "❌ Incorrect password. Please try again.");
					request.setAttribute("username", username); // Keep username in form
				} else {
					// Username doesn't exist
					request.setAttribute("errorMessage",
							"❌ Username not found. Please check your username or register.");
				}

				checkRs.close();
				checkStmt.close();

				System.out.println("Login failed for username: " + username);
				request.getRequestDispatcher("jsp/login.jsp").forward(request, response);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "⚠️ Database connection error. Please try again later.");
			request.getRequestDispatcher("jsp/login.jsp").forward(request, response);

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "⚠️ System error occurred. Please contact support.");
			request.getRequestDispatcher("jsp/login.jsp").forward(request, response);

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Redirect GET requests to login page
		response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
	}

	/**
	 * Hash password using SHA-256 (same method used in registration and reset)
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
