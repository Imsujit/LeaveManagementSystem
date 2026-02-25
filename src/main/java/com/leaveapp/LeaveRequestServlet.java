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

		if (session == null || session.getAttribute("username") == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		String username = (String) session.getAttribute("username");

		try {
			Class.forName("org.postgresql.Driver");

			Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/leave_management",
					"postgres", "password");

			String sql = "INSERT INTO leave_requests (username, leave_type, from_date, to_date, reason, status) "
					+ "VALUES (?, ?, ?, ?, ?, ?)";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ps.setString(2, leaveType);
			ps.setDate(3, java.sql.Date.valueOf(fromDate)); // ← fixed
			ps.setDate(4, java.sql.Date.valueOf(toDate)); // ← fixed
			ps.setString(5, reason);
			ps.setString(6, "Pending");

			int rows = ps.executeUpdate();

			ps.close();
			conn.close();

			if (rows > 0) {
				response.sendRedirect(request.getContextPath() + "/jsp/userDashboard.jsp");
			} else {
				response.sendRedirect(request.getContextPath() + "/jsp/leaveRequest.jsp?error=fail");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/jsp/leaveRequest.jsp?error=exception");
		}
	}
}