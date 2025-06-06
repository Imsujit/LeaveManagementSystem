package com.leaveapp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Reuse the LeaveRequest model
@WebServlet("/AdminLeaveRequestsServlet")
public class AdminLeaveRequestsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<LeaveRequest> leaveRequests = new ArrayList<>();

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(
					"jdbc:mysql://maglev.proxy.rlwy.net:17156/railway?useSSL=false&allowPublicKeyRetrieval=true",
					"root", "XSdfQjSTimyLYTcubhnMWosWDsrkNobr");

			String sql = "SELECT id, username, leave_type, from_date, to_date, reason, status FROM leave_requests";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				LeaveRequest lr = new LeaveRequest();
				lr.setId(rs.getInt("id")); // Add ID field in LeaveRequest model
				lr.setUsername(rs.getString("username")); // Add username field in LeaveRequest model
				lr.setLeaveType(rs.getString("leave_type"));
				lr.setFromDate(rs.getString("from_date"));
				lr.setToDate(rs.getString("to_date"));
				lr.setReason(rs.getString("reason"));
				lr.setStatus(rs.getString("status"));
				leaveRequests.add(lr);
			}

			request.setAttribute("leaveRequests", leaveRequests);
			RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/adminLeaveRequests.jsp");
			dispatcher.forward(request, response);

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Error: " + e.getMessage());
		}
	}
}
