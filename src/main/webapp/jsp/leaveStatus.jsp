<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.leaveapp.LeaveRequest" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leave Status - Leave Management</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background-color: #f9fafb;
            color: #111827;
            min-height: 100vh;
        }

        .header {
            background: white;
            border-bottom: 1px solid #e5e7eb;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 64px;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: #111827;
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .back-btn {
            padding: 0.5rem 1rem;
            background: #16a34a;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 500;
            transition: all 0.3s ease;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .back-btn:hover {
            background: #15803d;
            transform: translateY(-1px);
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 500;
            color: #374151;
        }

        .user-avatar {
            width: 32px;
            height: 32px;
            background: #16a34a;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 500;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        .page-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 2rem;
            font-weight: bold;
            color: #111827;
            margin-bottom: 0.5rem;
        }

        .page-subtitle {
            color: #6b7280;
            font-size: 1rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.2s ease;
        }

        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .stat-number {
            font-size: 1.8rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .stat-number.total { color: #3b82f6; }
        .stat-number.approved { color: #16a34a; }
        .stat-number.pending { color: #d97706; }
        .stat-number.rejected { color: #dc2626; }

        .stat-label {
            color: #6b7280;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .actions-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .filter-buttons {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 0.5rem 1rem;
            border: 1px solid #d1d5db;
            background: white;
            color: #374151;
            border-radius: 6px;
            font-size: 0.875rem;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .filter-btn:hover,
        .filter-btn.active {
            background: #16a34a;
            color: white;
            border-color: #16a34a;
        }

        .apply-leave-btn {
            padding: 0.75rem 1.5rem;
            background: #16a34a;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .apply-leave-btn:hover {
            background: #15803d;
            transform: translateY(-1px);
        }

        .table-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .table-header {
            background: linear-gradient(135deg, #16a34a 0%, #15803d 100%);
            color: white;
            padding: 1.5rem;
            text-align: center;
        }

        .table-header h3 {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .table-header p {
            opacity: 0.9;
            font-size: 0.875rem;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #f8f9fa;
        }

        th {
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            color: #374151;
            border-bottom: 2px solid #e5e7eb;
            font-size: 0.875rem;
            white-space: nowrap;
        }

        td {
            padding: 1rem;
            border-bottom: 1px solid #e5e7eb;
            font-size: 0.875rem;
        }

        tbody tr {
            transition: background-color 0.2s ease;
        }

        tbody tr:hover {
            background-color: #f9fafb;
        }

        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 500;
            text-transform: uppercase;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }

        .status-approved {
            background: #dcfce7;
            color: #166534;
        }

        .status-pending {
            background: #fef3c7;
            color: #92400e;
        }

        .status-rejected {
            background: #fee2e2;
            color: #991b1b;
        }

        .leave-type {
            font-weight: 500;
            color: #374151;
        }

        .date-range {
            color: #6b7280;
            font-size: 0.875rem;
        }

        .reason-cell {
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .no-data {
            text-align: center;
            padding: 3rem;
            color: #6b7280;
        }

        .no-data-icon {
            font-size: 3rem;
            color: #d1d5db;
            margin-bottom: 1rem;
        }

        .no-data h3 {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #374151;
        }

        .no-data p {
            margin-bottom: 1.5rem;
        }

        @media (max-width: 768px) {
            .header-content {
                padding: 0 0.5rem;
                flex-direction: column;
                height: auto;
                padding-top: 1rem;
                padding-bottom: 1rem;
                gap: 1rem;
            }

            .container {
                padding: 1rem 0.5rem;
            }

            .page-title {
                font-size: 1.5rem;
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .actions-bar {
                flex-direction: column;
                align-items: stretch;
            }

            .filter-buttons {
                justify-content: center;
            }

            th, td {
                padding: 0.75rem 0.5rem;
                font-size: 0.8rem;
            }

            .reason-cell {
                max-width: 120px;
            }
        }

        @media (max-width: 480px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }

            .filter-buttons {
                flex-direction: column;
            }

            .filter-btn {
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-content">
            <h1 class="logo">Leave Management</h1>
            <div class="nav-actions">
                <a href="<%= request.getContextPath() %>/jsp/userDashboard.jsp" class="back-btn">
                    <i class="fas fa-arrow-left"></i>
                    Back to Dashboard
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
        <!-- Page Header -->
        <div class="page-header">
            <h2 class="page-title">Your Leave Status</h2>
            <p class="page-subtitle">Track and manage your leave requests</p>
        </div>

        <%
            List<LeaveRequest> leaveList = (List<LeaveRequest>) request.getAttribute("leaveList");
            int totalRequests = 0;
            int approvedRequests = 0;
            int pendingRequests = 0;
            int rejectedRequests = 0;
            
            if (leaveList != null) {
                totalRequests = leaveList.size();
                for (LeaveRequest lr : leaveList) {
                    String status = lr.getStatus().toLowerCase();
                    if (status.equals("approved")) approvedRequests++;
                    else if (status.equals("pending")) pendingRequests++;
                    else if (status.equals("rejected")) rejectedRequests++;
                }
            }
        %>

        <!-- Statistics Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number total"><%=totalRequests%></div>
                <div class="stat-label">Total Requests</div>
            </div>
            <div class="stat-card">
                <div class="stat-number approved"><%=approvedRequests%></div>
                <div class="stat-label">Approved</div>
            </div>
            <div class="stat-card">
                <div class="stat-number pending"><%=pendingRequests%></div>
                <div class="stat-label">Pending</div>
            </div>
            <div class="stat-card">
                <div class="stat-number rejected"><%=rejectedRequests%></div>
                <div class="stat-label">Rejected</div>
            </div>
        </div>

        <!-- Actions Bar -->
        <div class="actions-bar">
            <div class="filter-buttons">
                <button class="filter-btn active" onclick="filterTable('all')">All</button>
                <button class="filter-btn" onclick="filterTable('approved')">Approved</button>
                <button class="filter-btn" onclick="filterTable('pending')">Pending</button>
                <button class="filter-btn" onclick="filterTable('rejected')">Rejected</button>
            </div>
            <a href="<%= request.getContextPath() %>/jsp/leaveRequest.jsp" class="apply-leave-btn">
                <i class="fas fa-plus"></i>
                Apply for Leave
            </a>
        </div>

        <!-- Table Container -->
        <div class="table-container">
            <div class="table-header">
                <h3>Leave Request History</h3>
                <p>Complete overview of your leave applications</p>
            </div>
            
            <% if (leaveList != null && !leaveList.isEmpty()) { %>
                <div class="table-wrapper">
                    <table id="leaveTable">
                        <thead>
                            <tr>
                                <th><i class="fas fa-calendar-alt"></i> Leave Type</th>
                                <th><i class="fas fa-calendar-day"></i> From Date</th>
                                <th><i class="fas fa-calendar-day"></i> To Date</th>
                                <th><i class="fas fa-comment"></i> Reason</th>
                                <th><i class="fas fa-info-circle"></i> Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (LeaveRequest lr : leaveList) {
                                    String statusClass = "status-" + lr.getStatus().toLowerCase();
                                    String statusIcon = "";
                                    if (lr.getStatus().toLowerCase().equals("approved")) {
                                        statusIcon = "fas fa-check-circle";
                                    } else if (lr.getStatus().toLowerCase().equals("pending")) {
                                        statusIcon = "fas fa-clock";
                                    } else if (lr.getStatus().toLowerCase().equals("rejected")) {
                                        statusIcon = "fas fa-times-circle";
                                    }
                            %>
                            <tr data-status="<%=lr.getStatus().toLowerCase()%>">
                                <td class="leave-type"><%=lr.getLeaveType()%></td>
                                <td class="date-range"><%=lr.getFromDate()%></td>
                                <td class="date-range"><%=lr.getToDate()%></td>
                                <td class="reason-cell" title="<%=lr.getReason()%>"><%=lr.getReason()%></td>
                                <td>
                                    <span class="status-badge <%=statusClass%>">
                                        <i class="<%=statusIcon%>"></i>
                                        <%=lr.getStatus()%>
                                    </span>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            <% } else { %>
                <div class="no-data">
                    <div class="no-data-icon">
                        <i class="fas fa-calendar-times"></i>
                    </div>
                    <h3>No Leave Records Found</h3>
                    <p>You haven't submitted any leave requests yet.</p>
                    <a href="<%= request.getContextPath() %>/jsp/leaveRequest.jsp" class="apply-leave-btn">
                        <i class="fas fa-plus"></i>
                        Apply for Your First Leave
                    </a>
                </div>
            <% } %>
        </div>
    </div>

    <script>
        function filterTable(status) {
            const table = document.getElementById('leaveTable');
            const rows = table ? table.getElementsByTagName('tbody')[0].getElementsByTagName('tr') : [];
            const buttons = document.querySelectorAll('.filter-btn');
            
            // Update active button
            buttons.forEach(btn => btn.classList.remove('active'));
            event.target.classList.add('active');
            
            // Filter rows
            for (let i = 0; i < rows.length; i++) {
                const row = rows[i];
                const rowStatus = row.getAttribute('data-status');
                
                if (status === 'all' || rowStatus === status) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            }
        }

        // Add smooth animations
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.stat-card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    card.style.transition = 'all 0.5s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
    </script>
</body>
</html>
