package com.leaveapp;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String token = request.getParameter("token");
		String newPassword = request.getParameter("newPassword");
		String confirmPassword = request.getParameter("confirmPassword");

		// Validate input
		if (token == null || token.trim().isEmpty()) {
			request.setAttribute("errorMessage", "Invalid reset token.");
			request.getRequestDispatcher("jsp/reset-password-error.jsp").forward(request, response);
			return;
		}

		if (newPassword == null || newPassword.trim().isEmpty()) {
			request.setAttribute("errorMessage", "Please enter a new password.");
			request.getRequestDispatcher("jsp/reset-password.jsp?token=" + token).forward(request, response);
			return;
		}

		if (confirmPassword == null || !newPassword.equals(confirmPassword)) {
			request.setAttribute("errorMessage", "Passwords do not match.");
			request.getRequestDispatcher("jsp/reset-password.jsp?token=" + token).forward(request, response);
			return;
		}

		if (newPassword.length() < 6) {
			request.setAttribute("errorMessage", "Password must be at least 6 characters long.");
			request.getRequestDispatcher("jsp/reset-password.jsp?token=" + token).forward(request, response);
			return;
		}

		Connection conn = null;
		PreparedStatement checkTokenStmt = null;
		PreparedStatement updatePasswordStmt = null;
		PreparedStatement markTokenUsedStmt = null;
		ResultSet rs = null;

		try {
			conn = DBConnection.getConnection();

			// Check if token is valid and not expired
			String checkTokenSql = "SELECT email, expires_at, used FROM password_reset_tokens WHERE token = ?";
			checkTokenStmt = conn.prepareStatement(checkTokenSql);
			checkTokenStmt.setString(1, token);
			rs = checkTokenStmt.executeQuery();

			if (!rs.next()) {
				request.setAttribute("errorMessage", "Invalid or expired reset token.");
				request.getRequestDispatcher("jsp/reset-password-error.jsp").forward(request, response);
				return;
			}

			String email = rs.getString("email");
			Timestamp expiresAt = rs.getTimestamp("expires_at");
			boolean used = rs.getBoolean("used");

			// Check if token is already used
			if (used) {
				request.setAttribute("errorMessage", "This reset token has already been used.");
				request.getRequestDispatcher("jsp/reset-password-error.jsp").forward(request, response);
				return;
			}

			// Check if token is expired
			if (expiresAt.before(new Timestamp(System.currentTimeMillis()))) {
				request.setAttribute("errorMessage", "Reset token has expired. Please request a new one.");
				request.getRequestDispatcher("jsp/reset-password-error.jsp").forward(request, response);
				return;
			}

			rs.close();
			checkTokenStmt.close();

			// Hash the new password
			String hashedPassword = hashPassword(newPassword);

			// Update user's password
			String updatePasswordSql = "UPDATE users SET password = ? WHERE LOWER(email) = ?";
			updatePasswordStmt = conn.prepareStatement(updatePasswordSql);
			updatePasswordStmt.setString(1, hashedPassword);
			updatePasswordStmt.setString(2, email.toLowerCase());

			int rowsUpdated = updatePasswordStmt.executeUpdate();

			if (rowsUpdated > 0) {
				// Mark token as used
				String markTokenUsedSql = "UPDATE password_reset_tokens SET used = ? WHERE token = ?";
				markTokenUsedStmt = conn.prepareStatement(markTokenUsedSql);
				markTokenUsedStmt.setBoolean(1, true);
				markTokenUsedStmt.setString(2, token);
				markTokenUsedStmt.executeUpdate();

				System.out.println("Password successfully reset for email: " + email);

				request.setAttribute("successMessage",
						"Your password has been successfully reset. You can now login with your new password.");
				request.getRequestDispatcher("jsp/reset-password-success.jsp").forward(request, response);

			} else {
				request.setAttribute("errorMessage", "Failed to update password. Please try again.");
				request.getRequestDispatcher("jsp/reset-password.jsp?token=" + token).forward(request, response);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Database error occurred. Please try again later.");
			request.getRequestDispatcher("jsp/reset-password.jsp?token=" + token).forward(request, response);

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "System error occurred. Please try again later.");
			request.getRequestDispatcher("jsp/reset-password.jsp?token=" + token).forward(request, response);

		} finally {
			// Close all resources
			try {
				if (rs != null)
					rs.close();
				if (checkTokenStmt != null)
					checkTokenStmt.close();
				if (updatePasswordStmt != null)
					updatePasswordStmt.close();
				if (markTokenUsedStmt != null)
					markTokenUsedStmt.close();
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
	 * Hash password using SHA-256
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
