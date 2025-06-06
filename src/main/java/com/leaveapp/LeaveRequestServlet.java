package com.leaveapp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LeaveRequestServlet")
public class LeaveRequestServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		String reason = request.getParameter("reason");
		String leaveType = request.getParameter("leaveType");

		HttpSession session = request.getSession(false);
		String username = (String) session.getAttribute("username"); // Assumes username is stored in session after
																		// login

		try {
			// Load JDBC driver (if required for your DB)
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Replace with your actual DB details
			Connection conn = DriverManager.getConnection("jdbc:mysql://mysql.railway.internal:3306/railway", "root",
					"oKVhNnwRVtOezbUSzvolAYhLcsFuMsGs");

			String sql = "INSERT INTO leave_requests (username, leave_type, from_date, to_date, reason, status) VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ps.setString(2, leaveType);
			ps.setString(3, fromDate);
			ps.setString(4, toDate);
			ps.setString(5, reason);
			ps.setString(6, "Pending");

			int rows = ps.executeUpdate();

			if (rows > 0) {
				request.getRequestDispatcher("jsp/userDashboard.jsp").forward(request, response);
			} else {
				response.sendRedirect("/jsp/leaveRequest.jsp?error=fail");
			}

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("leaveRequest.jsp?error=exception");
		}
	}
}
