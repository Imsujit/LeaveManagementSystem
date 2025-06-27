package com.leaveapp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminActionServlet")
public class AdminActionServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String idParam = request.getParameter("id");
		String action = request.getParameter("action");

		if (idParam == null || action == null) {
			request.setAttribute("errorMessage", "Invalid request: missing ID or action.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
			return;
		}

		int id;
		try {
			id = Integer.parseInt(idParam);
		} catch (NumberFormatException e) {
			request.setAttribute("errorMessage", "Invalid leave request ID format.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
			return;
		}

		String status = action.equals("Approved") ? "Approved" : "Rejected";

		Connection conn = null;
		PreparedStatement updateStmt = null;
		PreparedStatement selectStmt = null;
		ResultSet rs = null;

		try {
			conn = DBConnection.getConnection();

			// First, get employee details before updating
			String selectSql = "SELECT lr.leave_type, lr.reason, lr.from_date, lr.to_date, " + "u.username, u.email "
					+ "FROM leave_requests lr " + "JOIN users u ON lr.username = u.username " + "WHERE lr.id = ?";

			selectStmt = conn.prepareStatement(selectSql);
			selectStmt.setInt(1, id);
			rs = selectStmt.executeQuery();

			String employeeName = null;
			String employeeEmail = null;
			String leaveType = null;
			String reason = null;
			String fromDate = null;
			String toDate = null;

			if (rs.next()) {
				employeeName = rs.getString("username");
				employeeEmail = rs.getString("email");
				leaveType = rs.getString("leave_type");
				reason = rs.getString("reason");
				fromDate = rs.getString("from_date");
				toDate = rs.getString("to_date");
			} else {
				request.setAttribute("errorMessage", "No leave request found with the given ID.");
				request.getRequestDispatcher("error.jsp").forward(request, response);
				return;
			}

			// Now update the leave request status
			String updateSql = "UPDATE leave_requests SET status = ? WHERE id = ?";
			updateStmt = conn.prepareStatement(updateSql);
			updateStmt.setString(1, status);
			updateStmt.setInt(2, id);

			int rowsUpdated = updateStmt.executeUpdate();

			if (rowsUpdated > 0) {
				// Send email notification
				try {
					EmailUtil.sendLeaveStatusEmail(employeeEmail, employeeName, leaveType, status, reason, fromDate,
							toDate);
					System.out.println("Email notification sent to: " + employeeEmail);
				} catch (Exception emailException) {
					// Log email error but don't fail the request
					System.err.println("Failed to send email notification: " + emailException.getMessage());
					emailException.printStackTrace();
				}

				// Redirect to admin page
				response.sendRedirect(request.getContextPath() + "/AdminLeaveRequestsServlet");

			} else {
				request.setAttribute("errorMessage", "Failed to update leave request status.");
				request.getRequestDispatcher("error.jsp").forward(request, response);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Database error occurred: " + e.getMessage());
			request.getRequestDispatcher("error.jsp").forward(request, response);
		} finally {
			// Close all resources
			try {
				if (rs != null)
					rs.close();
				if (selectStmt != null)
					selectStmt.close();
				if (updateStmt != null)
					updateStmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
