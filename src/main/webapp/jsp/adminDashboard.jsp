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
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            color: #1a202c;
            min-height: 100vh;
        }

        .header {
            background: linear-gradient(135deg, #e53e3e 0%, #c53030 100%);
            color: white;
            padding: 1.2rem 0;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.4rem;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            background: rgba(255, 255, 255, 0.1);
            padding: 0.5rem 1rem;
            border-radius: 25px;
            backdrop-filter: blur(10px);
        }

        .user-avatar {
            width: 38px;
            height: 38px;
            background: linear-gradient(135deg, #c53030 0%, #9c1c1c 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 1rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }

        .admin-badge {
            background: linear-gradient(135deg, #c53030 0%, #9c1c1c 100%);
            color: white;
            padding: 0.25rem 0.6rem;
            border-radius: 12px;
            font-size: 0.7rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-left: 0.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 3rem 1rem;
        }

        .welcome-section {
            text-align: center;
            margin-bottom: 3rem;
        }

        .welcome-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: #1a202c;
            margin-bottom: 0.5rem;
            letter-spacing: -1px;
        }

        .welcome-subtitle {
            color: #64748b;
            font-size: 1.1rem;
            font-weight: 400;
        }

        .admin-card {
            background: white;
            padding: 3rem;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            text-align: center;
            margin-bottom: 3rem;
            border: 1px solid #e2e8f0;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .admin-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.12);
        }

        .admin-icon {
            font-size: 4rem;
            color: #e53e3e;
            margin-bottom: 1.5rem;
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            width: 100px;
            height: 100px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            box-shadow: 0 8px 16px rgba(229, 62, 62, 0.2);
        }

        .admin-title {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.8rem;
            color: #1a202c;
            letter-spacing: -0.5px;
        }

        .admin-description {
            color: #64748b;
            margin-bottom: 2rem;
            font-size: 1rem;
            line-height: 1.6;
        }

        .admin-button {
            background: linear-gradient(135deg, #e53e3e 0%, #c53030 100%);
            color: white;
            padding: 1rem 2.5rem;
            border: none;
            border-radius: 12px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(229, 62, 62, 0.3);
        }

        .admin-button:hover {
            background: linear-gradient(135deg, #c53030 0%, #9c1c1c 100%);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(229, 62, 62, 0.4);
        }

        .logout-section {
            text-align: center;
        }

        .logout-btn {
            background: linear-gradient(135deg, #64748b 0%, #475569 100%);
            color: white;
            padding: 0.8rem 2rem;
            border: none;
            border-radius: 10px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(100, 116, 139, 0.3);
        }

        .logout-btn:hover {
            background: linear-gradient(135deg, #475569 0%, #334155 100%);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(100, 116, 139, 0.4);
        }

        @media (max-width: 768px) {
            .header-content {
                padding: 0 0.5rem;
            }
            
            .container {
                padding: 2rem 0.5rem;
            }
            
            .welcome-title {
                font-size: 2rem;
            }
            
            .admin-card {
                padding: 2rem;
            }

            .admin-icon {
                width: 80px;
                height: 80px;
                font-size: 3rem;
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
                Leave Management System
            </h1>
            <div class="user-info">
                <div class="user-avatar">
                    <%= username.substring(0,1).toUpperCase() %>
                </div>
                <span><%= username %><span class="admin-badge">Admin</span></span>
            </div>
        </div>
    </header>

    <div class="container">
        <!-- Welcome Section -->
        <div class="welcome-section">
            <h2 class="welcome-title">Admin Dashboard</h2>
            <p class="welcome-subtitle">Manage employee leave requests efficiently</p>
        </div>

        <!-- Admin Card -->
        <div class="admin-card">
            <div class="admin-icon">
                <i class="fas fa-tasks"></i>
            </div>
            <h3 class="admin-title">Manage Leave Requests</h3>
            <p class="admin-description">Review, approve, or reject employee leave applications with ease</p>
            <a href="<%= request.getContextPath() %>/AdminLeaveRequestsServlet" class="admin-button">
                <i class="fas fa-arrow-right"></i>
                View Requests
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
