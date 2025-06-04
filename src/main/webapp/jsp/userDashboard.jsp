<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - Leave Management</title>
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
            color: #667eea;
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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

        .action-buttons {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .action-btn {
            padding: 2rem 1.5rem;
            border-radius: 20px;
            text-decoration: none;
            font-weight: 600;
            text-align: center;
            transition: all 0.3s ease;
            font-size: 1.1rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 1rem;
            border: none;
            cursor: pointer;
            background: white;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .action-btn i {
            font-size: 3rem;
        }

        .action-btn.primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .action-btn.primary:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
        }

        .action-btn.secondary {
            background: white;
            color: #495057;
            border: 2px solid #e9ecef;
        }

        .action-btn.secondary:hover {
            background: #f8f9fa;
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }

        .logout-section {
            text-align: center;
        }

        .logout-btn {
            padding: 0.75rem 2rem;
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
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
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.3);
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(239, 68, 68, 0.4);
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem 0.5rem;
            }

            .welcome-title {
                font-size: 2rem;
            }

            .action-buttons {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .action-btn {
                padding: 1.5rem;
            }

            .action-btn i {
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-content">
            <h1 class="logo">
                <i class="fas fa-calendar-check"></i>
                Leave Management
            </h1>
            <div class="user-info">
                <div class="user-avatar">
                    <%= session.getAttribute("username") != null ? 
                        session.getAttribute("username").toString().substring(0,1).toUpperCase() : "U" %>
                </div>
                <div class="user-name"><%= session.getAttribute("username") %></div>
            </div>
        </div>
    </header>

    <div class="container">
        <!-- Welcome Section -->
        <div class="welcome-section">
            <h2 class="welcome-title">Welcome, <%= session.getAttribute("username") %>!</h2>
            <p class="welcome-subtitle">Your personal leave dashboard</p>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons">
            <a href="<%= request.getContextPath() %>/jsp/leaveRequest.jsp" class="action-btn primary">
                <i class="fas fa-plus-circle"></i>
                Apply for Leave
            </a>
            <a href="<%= request.getContextPath() %>/LeaveStatusServlet" class="action-btn secondary">
                <i class="fas fa-list-alt"></i>
                View Leave Status
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
