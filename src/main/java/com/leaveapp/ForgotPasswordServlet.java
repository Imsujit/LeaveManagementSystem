package com.leaveapp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("email");

		if (email == null || email.trim().isEmpty()) {
			request.setAttribute("errorMessage", "Please enter your email address.");
			request.getRequestDispatcher("jsp/forgot-password.jsp").forward(request, response);
			return;
		}

		email = email.trim().toLowerCase();

		Connection conn = null;
		PreparedStatement checkUserStmt = null;
		PreparedStatement insertTokenStmt = null;
		PreparedStatement deleteOldTokensStmt = null;
		ResultSet rs = null;

		try {
			conn = DBConnection.getConnection();

			// First, check if user exists with this email
			String checkUserSql = "SELECT username FROM users WHERE LOWER(email) = ?";
			checkUserStmt = conn.prepareStatement(checkUserSql);
			checkUserStmt.setString(1, email);
			rs = checkUserStmt.executeQuery();

			if (!rs.next()) {
				// USER-FRIENDLY: Show clear error message
				request.setAttribute("errorMessage", "❌ No account found with email address: " + email
						+ "\n\nPlease check your email or register for a new account.");
				request.getRequestDispatcher("jsp/forgot-password.jsp").forward(request, response);
				return;
			}

			String username = rs.getString("username");
			rs.close();
			checkUserStmt.close();

			// Delete any existing tokens for this email
			String deleteOldTokensSql = "DELETE FROM password_reset_tokens WHERE email = ?";
			deleteOldTokensStmt = conn.prepareStatement(deleteOldTokensSql);
			deleteOldTokensStmt.setString(1, email);
			deleteOldTokensStmt.executeUpdate();
			deleteOldTokensStmt.close();

			// Generate unique token
			String token = UUID.randomUUID().toString().replace("-", "");

			// Set expiration time (1 hour from now)
			Timestamp expiresAt = new Timestamp(System.currentTimeMillis() + (60 * 60 * 1000)); // 1 hour

			// Insert new token
			String insertTokenSql = "INSERT INTO password_reset_tokens (email, token, expires_at, used) VALUES (?, ?, ?, ?)";
			insertTokenStmt = conn.prepareStatement(insertTokenSql);
			insertTokenStmt.setString(1, email);
			insertTokenStmt.setString(2, token);
			insertTokenStmt.setTimestamp(3, expiresAt);
			insertTokenStmt.setBoolean(4, false);

			int rowsInserted = insertTokenStmt.executeUpdate();

			if (rowsInserted > 0) {
				// Create reset link
				String resetLink = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
						+ request.getContextPath() + "/jsp/reset-password.jsp?token=" + token;

				// Send email
				try {
					EmailUtil.sendPasswordResetEmail(email, username, resetLink);
					System.out.println("Password reset email sent to: " + email);

					request.setAttribute("successMessage", "✅ Password reset link has been sent to " + email
							+ "\n\nPlease check your inbox and spam folder.");
					request.getRequestDispatcher("jsp/forgot-password-success.jsp").forward(request, response);

				} catch (Exception emailException) {
					System.err.println("Failed to send password reset email: " + emailException.getMessage());
					emailException.printStackTrace();

					request.setAttribute("errorMessage",
							"Failed to send reset email. Please try again later or contact support.");
					request.getRequestDispatcher("jsp/forgot-password.jsp").forward(request, response);
				}

			} else {
				request.setAttribute("errorMessage", "Failed to process password reset request. Please try again.");
				request.getRequestDispatcher("jsp/forgot-password.jsp").forward(request, response);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Database error occurred. Please try again later.");
			request.getRequestDispatcher("jsp/forgot-password.jsp").forward(request, response);

		} finally {
			// Close all resources
			try {
				if (rs != null)
					rs.close();
				if (checkUserStmt != null)
					checkUserStmt.close();
				if (insertTokenStmt != null)
					insertTokenStmt.close();
				if (deleteOldTokensStmt != null)
					deleteOldTokensStmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Redirect GET requests to the forgot password form
		response.sendRedirect(request.getContextPath() + "/jsp/forgot-password.jsp");
	}
}
