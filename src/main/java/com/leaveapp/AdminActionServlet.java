package com.leaveapp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
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

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement("UPDATE leave_requests SET status = ? WHERE id = ?")) {

			stmt.setString(1, status);
			stmt.setInt(2, id);

			int rowsUpdated = stmt.executeUpdate();

			if (rowsUpdated > 0) {
				response.sendRedirect(request.getContextPath() + "/AdminLeaveRequestsServlet");

			} else {
				request.setAttribute("errorMessage", "No leave request found with the given ID.");
				request.getRequestDispatcher("error.jsp").forward(request, response);
			}

		} catch (SQLException e) {
			e.printStackTrace(); // Log the full error
			request.setAttribute("errorMessage", "Database error occurred: " + e.getMessage());
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}
}
