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
import jakarta.servlet.http.HttpSession;

@WebServlet("/LeaveStatusServlet")
public class LeaveStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		String username = (String) session.getAttribute("username");

		List<LeaveRequest> leaveList = new ArrayList<>();

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/leave_management", "root", "root");

			String sql = "SELECT leave_type, from_date, to_date, reason, status FROM leave_requests WHERE username = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				LeaveRequest lr = new LeaveRequest();
				lr.setLeaveType(rs.getString("leave_type"));
				lr.setFromDate(rs.getString("from_date"));
				lr.setToDate(rs.getString("to_date"));
				lr.setReason(rs.getString("reason"));
				lr.setStatus(rs.getString("status"));
				leaveList.add(lr);
			}

			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("leaveList", leaveList);
		RequestDispatcher rd = request.getRequestDispatcher("/jsp/leaveStatus.jsp");
		rd.forward(request, response);
	}
}
