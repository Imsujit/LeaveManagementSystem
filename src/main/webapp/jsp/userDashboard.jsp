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
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }

        .header {
            background: white;
            color: #1a202c;
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
            color: #1a202c;
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
            gap: 0.8rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
        }

        .user-avatar {
            width: 38px;
            height: 38px;
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 1rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 3rem 1rem;
        }

        .welcome-section {
            text-align: center;
            margin-bottom: 3rem;
            color: white;
        }

        .welcome-title {
            font-size: 2.8rem;
            font-weight: 700;
            margin-bottom: 0.8rem;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
            letter-spacing: -1px;
        }

        .welcome-subtitle {
            font-size: 1.2rem;
            opacity: 0.9;
            font-weight: 400;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .dashboard-card {
            background: white;
            padding: 2.5rem;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            text-align: center;
            transition: all 0.3s ease;
            border: 1px solid rgba(255,255,255,0.2);
            backdrop-filter: blur(10px);
        }

        .dashboard-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 25px 50px rgba(0,0,0,0.15);
        }

        .card-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 1.5rem;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            color: white;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }

        .card-icon.apply {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
        }

        .card-icon.status {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .card-title {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 0.8rem;
            color: #1a202c;
            letter-spacing: -0.5px;
        }

        .card-description {
            color: #64748b;
            font-size: 1rem;
            margin-bottom: 1.8rem;
            line-height: 1.5;
        }

        .card-button {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem 2rem;
            border: none;
            border-radius: 12px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .card-button:hover {
            background: linear-gradient(135deg, #5a67d8 0%, #6b46c1 100%);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        }

        .card-button.secondary {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            box-shadow: 0 4px 12px rgba(72, 187, 120, 0.3);
        }

        .card-button.secondary:hover {
            background: linear-gradient(135deg, #38a169 0%, #2f855a 100%);
            box-shadow: 0 8px 20px rgba(72, 187, 120, 0.4);
        }

        .logout-section {
            text-align: center;
        }

        .logout-btn {
            background: linear-gradient(135deg, #e53e3e 0%, #c53030 100%);
            color: white;
            padding: 0.8rem 2rem;
            border: none;
            border-radius: 12px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(229, 62, 62, 0.3);
        }

        .logout-btn:hover {
            background: linear-gradient(135deg, #c53030 0%, #9c1c1c 100%);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(229, 62, 62, 0.4);
        }

        @media (max-width: 768px) {
            .header-content {
                padding: 0 0.5rem;
            }
            
            .container {
                padding: 2rem 0.5rem;
            }
            
            .welcome-title {
                font-size: 2.2rem;
            }
            
            .dashboard-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .dashboard-card {
                padding: 2rem;
            }

            .card-icon {
                width: 70px;
                height: 70px;
                font-size: 2rem;
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
                Leave Management System
            </h1>
            <div class="user-info">
                <div class="user-avatar">
                    <%= session.getAttribute("username") != null ? 
                        session.getAttribute("username").toString().substring(0,1).toUpperCase() : "U" %>
                </div>
                <span><%= session.getAttribute("username") %></span>
            </div>
        </div>
    </header>

    <div class="container">
        <!-- Welcome Section -->
        <div class="welcome-section">
            <h2 class="welcome-title">Welcome, <%= session.getAttribute("username") %>!</h2>
            <p class="welcome-subtitle">Your personal leave management dashboard</p>
        </div>

        <!-- Dashboard Cards -->
        <div class="dashboard-grid">
            <div class="dashboard-card">
                <div class="card-icon apply">
                    <i class="fas fa-plus-circle"></i>
                </div>
                <h3 class="card-title">Apply for Leave</h3>
                <p class="card-description">Submit a new leave request with all necessary details</p>
                <a href="<%= request.getContextPath() %>/jsp/leaveRequest.jsp" class="card-button">
                    <i class="fas fa-paper-plane"></i>
                    Apply Now
                </a>
            </div>

            <div class="dashboard-card">
                <div class="card-icon status">
                    <i class="fas fa-chart-line"></i>
                </div>
                <h3 class="card-title">View Leave Status</h3>
                <p class="card-description">Check the status and history of your leave requests</p>
                <a href="<%= request.getContextPath() %>/LeaveStatusServlet" class="card-button secondary">
                    <i class="fas fa-eye"></i>
                    View Status
                </a>
            </div>
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
