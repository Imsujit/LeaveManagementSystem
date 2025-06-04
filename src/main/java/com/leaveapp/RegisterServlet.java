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

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, role);

            int row = stmt.executeUpdate();
            if (row > 0) {
                request.getRequestDispatcher("jsp/login.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Registration failed.");
                request.getRequestDispatcher("jsp/register.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) { // MySQL duplicate entry error code
                request.getSession().setAttribute("errorMessage", "User already exists.");
                response.sendRedirect("jsp/register.jsp");
            } else {
                e.printStackTrace();
                request.getSession().setAttribute("errorMessage", "Registration failed: " + e.getMessage());
                response.sendRedirect("jsp/register.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            request.getRequestDispatcher("jsp/register.jsp").forward(request, response);
        }
    }
}
