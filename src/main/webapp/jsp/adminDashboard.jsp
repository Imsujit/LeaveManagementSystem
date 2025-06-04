<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Leave Management</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }

        .header {
            background: white;
            border-bottom: 1px solid #e5e7eb;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 70px;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: #111827;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .logo i {
            color: #ef4444;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
            background: #f8f9fa;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            border: 1px solid #e5e7eb;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1rem;
        }

        .user-name {
            font-weight: 600;
            color: #111827;
            font-size: 0.9rem;
        }

        .admin-badge {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
            padding: 0.15rem 0.5rem;
            border-radius: 12px;
            font-size: 0.7rem;
            font-weight: 600;
            text-transform: uppercase;
            margin-left: 0.5rem;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        .welcome-section {
            text-align: center;
            color: white;
            margin-bottom: 3rem;
        }

        .welcome-title {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .welcome-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .manage-requests-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 3rem;
            text-align: center;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            margin-bottom: 3rem;
            transition: all 0.3s ease;
        }

        .manage-requests-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
        }

        .manage-icon {
            font-size: 4rem;
            color: #ef4444;
            margin-bottom: 1.5rem;
        }

        .manage-title {
            font-size: 1.8rem;
            font-weight: bold;
            color: #111827;
            margin-bottom: 1rem;
        }

        .manage-subtitle {
            color: #6b7280;
            font-size: 1rem;
            margin-bottom: 2rem;
        }

        .manage-action {
            padding: 1.2rem 2.5rem;
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1.1rem;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            transition: all 0.3s ease;
        }

        .manage-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(239, 68, 68, 0.4);
        }

        .logout-section {
            text-align: center;
        }

        .logout-btn {
            padding: 0.75rem 2rem;
            background: linear-gradient(135deg, #6b7280 0%, #4b5563 100%);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            border: none;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(107, 114, 128, 0.3);
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(107, 114, 128, 0.4);
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem 0.5rem;
            }

            .welcome-title {
                font-size: 2rem;
            }

            .manage-requests-card {
                padding: 2rem;
            }

            .manage-icon {
                font-size: 3rem;
            }

            .manage-title {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-content">
            <h1 class="logo">
                <i class="fas fa-shield-alt"></i>
                Leave Management
            </h1>
            <div class="user-info">
                <div class="user-avatar">
                    <%= username.substring(0,1).toUpperCase() %>
                </div>
                <div class="user-name"><%= username %><span class="admin-badge">Admin</span></div>
            </div>
        </div>
    </header>

    <div class="container">
        <!-- Welcome Section -->
        <div class="welcome-section">
            <h2 class="welcome-title">Admin Dashboard</h2>
            <p class="welcome-subtitle">Manage team leave requests</p>
        </div>

        <!-- Manage Requests Card -->
        <div class="manage-requests-card">
            <div class="manage-icon">
                <i class="fas fa-tasks"></i>
            </div>
            
            <div class="manage-title">Manage Leave Requests</div>
            <div class="manage-subtitle">Review and approve employee leave applications</div>
            
            <a href="<%= request.getContextPath() %>/AdminLeaveRequestsServlet" class="manage-action">
                <i class="fas fa-arrow-right"></i>
                Go to Requests
            </a>
        </div>

        <!-- Logout Section -->
        <div class="logout-section">
            <a href="<%= request.getContextPath() %>/LogoutServlet" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>
                Logout
            </a>
        </div>
    </div>
</body>
</html>
