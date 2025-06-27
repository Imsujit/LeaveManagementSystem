<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apply for Leave - Leave Management</title>
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
            color: #1a202c;
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

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .back-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 0.6rem 1.2rem;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
        }

        .back-btn:hover {
            background: linear-gradient(135deg, #5a67d8 0%, #6b46c1 100%);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #64748b;
            font-weight: 500;
        }

        .user-avatar {
            width: 32px;
            height: 32px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .container {
            max-width: 500px;
            margin: 0 auto;
            padding: 2rem 1rem 4rem;
            min-height: calc(100vh - 80px);
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .form-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.8rem;
            text-align: center;
            position: relative;
        }

        .form-header h2 {
            font-size: 1.6rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.6rem;
        }

        .form-header p {
            font-size: 0.9rem;
            opacity: 0.9;
            font-weight: 400;
        }

        .form-content {
            padding: 1.5rem;
        }

        .info-box {
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            border: 1px solid #7dd3fc;
            color: #0c4a6e;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1.2rem;
            font-size: 0.85rem;
        }

        .info-box h4 {
            margin-bottom: 0.6rem;
            font-size: 0.9rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .info-box ul {
            margin-left: 1rem;
            line-height: 1.5;
        }

        .info-box li {
            margin-bottom: 0.2rem;
        }

        .form-group {
            margin-bottom: 1.2rem;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }

        label {
            display: block;
            margin-bottom: 0.4rem;
            color: #374151;
            font-weight: 600;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        input[type="date"],
        select,
        textarea {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            background: #f8fafc;
            font-family: inherit;
        }

        input[type="date"]:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-1px);
        }

        select {
            cursor: pointer;
        }

        textarea {
            resize: vertical;
            min-height: 80px;
            line-height: 1.5;
        }

        .submit-btn {
            width: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 0.9rem;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 0.95rem;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-top: 0.8rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.6rem;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .submit-btn:hover {
            background: linear-gradient(135deg, #5a67d8 0%, #6b46c1 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(102, 126, 234, 0.4);
        }

        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }
            
            .form-row {
                grid-template-columns: 1fr;
            }

            .container {
                padding: 1rem 0.5rem 3rem;
                min-height: calc(100vh - 120px);
            }

            .form-content {
                padding: 1.2rem;
            }

            .form-header {
                padding: 1.5rem;
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
            <div class="nav-actions">
                <a href="<%= request.getContextPath() %>/jsp/userDashboard.jsp" class="back-btn">
                    <i class="fas fa-home"></i>
                    Dashboard
                </a>
                <div class="user-info">
                    <div class="user-avatar">
                        <%= session.getAttribute("username") != null ? 
                            session.getAttribute("username").toString().substring(0,1).toUpperCase() : "U" %>
                    </div>
                    <span><%= session.getAttribute("username") %></span>
                </div>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="form-container">
            <div class="form-header">
                <h2>
                    <i class="fas fa-calendar-plus"></i>
                    Apply for Leave
                </h2>
                <p>Fill in your leave request details</p>
            </div>

            <div class="form-content">
                <div class="info-box">
                    <h4>
                        <i class="fas fa-info-circle"></i>
                        Guidelines
                    </h4>
                    <ul>
                        <li>Sick Leave: Medical certificate required for 3+ days</li>
                        <li>Apply in advance for planned leaves</li>
                        <li>Maximum 15 days per request</li>
                    </ul>
                </div>

                <form action="<%= request.getContextPath() %>/LeaveRequestServlet" method="post">
                    <div class="form-group">
                        <label for="leaveType">
                            <i class="fas fa-list-ul"></i>
                            Leave Type
                        </label>
                        <select id="leaveType" name="leaveType" required>
                            <option value="">-- Select Leave Type --</option>
                            <option value="Sick Leave">Sick Leave</option>
                            <option value="Casual Leave">Casual Leave</option>
                            <option value="Earned Leave">Earned Leave</option>
                            <option value="Maternity Leave">Maternity Leave</option>
                            <option value="Paternity Leave">Paternity Leave</option>
                            <option value="Emergency Leave">Emergency Leave</option>
                        </select>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="fromDate">
                                <i class="fas fa-calendar-day"></i>
                                From Date
                            </label>
                            <input type="date" id="fromDate" name="fromDate" required>
                        </div>
                        <div class="form-group">
                            <label for="toDate">
                                <i class="fas fa-calendar-day"></i>
                                To Date
                            </label>
                            <input type="date" id="toDate" name="toDate" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="reason">
                            <i class="fas fa-comment-alt"></i>
                            Reason for Leave
                        </label>
                        <textarea id="reason" name="reason" rows="3" required 
                                  placeholder="Please provide reason for your leave request..."></textarea>
                    </div>

                    <button type="submit" class="submit-btn">
                        <i class="fas fa-paper-plane"></i>
                        Submit Request
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Set minimum date to today
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('fromDate').setAttribute('min', today);
            document.getElementById('toDate').setAttribute('min', today);
        });

        // Date validation
        document.getElementById('fromDate').addEventListener('change', function() {
            const fromDate = this.value;
            const toDateInput = document.getElementById('toDate');
            toDateInput.setAttribute('min', fromDate);
            
            if (toDateInput.value && toDateInput.value < fromDate) {
                toDateInput.value = fromDate;
            }
        });
    </script>
</body>
</html>
