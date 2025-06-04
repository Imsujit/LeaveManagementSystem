<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*, com.leaveapp.LeaveRequest"%>
<!DOCTYPE html>
<html>
<head>
<title>Admin - Leave Requests</title>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
        min-height: 100vh;
        color: #333;
    }

    .header {
        background: white;
        padding: 0.8rem 2rem;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 2rem;
    }

    .logo {
        font-size: 1.3rem;
        font-weight: bold;
        color: #2c3e50;
    }

    .back-btn {
        padding: 0.5rem 1rem;
        background: #e74c3c;
        color: white;
        text-decoration: none;
        border-radius: 6px;
        font-weight: 500;
        transition: all 0.3s ease;
        font-size: 0.9rem;
    }

    .back-btn:hover {
        background: #c0392b;
        transform: translateY(-1px);
    }

    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 1rem;
    }

    .page-title {
        text-align: center;
        color: white;
        margin-bottom: 2rem;
    }

    .page-title h2 {
        font-size: 1.8rem;
        font-weight: 600;
        margin-bottom: 0.5rem;
    }

    .page-title p {
        opacity: 0.9;
        font-size: 1rem;
    }

    .table-container {
        background: white;
        border-radius: 12px;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        margin-bottom: 2rem;
    }

    .table-header {
        background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
        color: white;
        padding: 1.5rem;
        text-align: center;
    }

    .table-header h3 {
        font-size: 1.2rem;
        font-weight: 600;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    thead {
        background: #f8f9fa;
    }

    th {
        padding: 1rem 0.8rem;
        text-align: left;
        font-weight: 600;
        color: #2c3e50;
        border-bottom: 2px solid #e1e8ed;
        font-size: 0.9rem;
    }

    td {
        padding: 1rem 0.8rem;
        border-bottom: 1px solid #e1e8ed;
        font-size: 0.9rem;
    }

    tbody tr {
        transition: background-color 0.2s ease;
    }

    tbody tr:hover {
        background-color: #f8f9fa;
    }

    .status-badge {
        padding: 0.3rem 0.8rem;
        border-radius: 15px;
        font-size: 0.75rem;
        font-weight: 500;
        text-transform: uppercase;
    }

    .status-pending {
        background: #fff3cd;
        color: #856404;
    }

    .status-approved {
        background: #d4edda;
        color: #155724;
    }

    .status-rejected {
        background: #f8d7da;
        color: #721c24;
    }

    .action-buttons {
        display: flex;
        gap: 0.5rem;
        justify-content: center;
    }

    .action-btn {
        padding: 0.4rem 0.8rem;
        border: none;
        border-radius: 6px;
        font-size: 0.8rem;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        min-width: 70px;
    }

    .approve-btn {
        background: #27ae60;
        color: white;
    }

    .approve-btn:hover {
        background: #2ecc71;
        transform: translateY(-1px);
        box-shadow: 0 2px 8px rgba(39, 174, 96, 0.3);
    }

    .reject-btn {
        background: #e74c3c;
        color: white;
    }

    .reject-btn:hover {
        background: #c0392b;
        transform: translateY(-1px);
        box-shadow: 0 2px 8px rgba(231, 76, 60, 0.3);
    }

    .no-data {
        text-align: center;
        padding: 3rem;
        color: #6c757d;
        font-style: italic;
    }

    .stats-row {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1rem;
        margin-bottom: 2rem;
    }

    .stat-card {
        background: white;
        padding: 1.5rem;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        text-align: center;
    }

    .stat-number {
        font-size: 1.8rem;
        font-weight: bold;
        color: #e74c3c;
        margin-bottom: 0.5rem;
    }

    .stat-label {
        color: #6c757d;
        font-size: 0.9rem;
        font-weight: 500;
    }

    @media (max-width: 768px) {
        .header {
            padding: 0.8rem 1rem;
            flex-direction: column;
            gap: 1rem;
        }

        .container {
            padding: 0 0.5rem;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            min-width: 800px;
        }

        th, td {
            padding: 0.8rem 0.5rem;
            font-size: 0.8rem;
        }

        .action-buttons {
            flex-direction: column;
            gap: 0.3rem;
        }

        .action-btn {
            font-size: 0.75rem;
            padding: 0.3rem 0.6rem;
        }

        .stats-row {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media (max-width: 480px) {
        .stats-row {
            grid-template-columns: 1fr;
        }

        .page-title h2 {
            font-size: 1.5rem;
        }
    }
</style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <h1 class="logo">Leave Management - Admin</h1>
        <a href="<%=request.getContextPath()%>/jsp/adminDashboard.jsp" class="back-btn">
            Back to Dashboard
        </a>
    </header>

    <div class="container">
        <!-- Page Title -->
        <div class="page-title">
            <h2>Leave Requests Management</h2>
            <p>Review and manage employee leave requests</p>
        </div>

        <!-- Statistics Row -->
        <div class="stats-row">
            <%
            List<LeaveRequest> leaveRequests = (List<LeaveRequest>) request.getAttribute("leaveRequests");
            int totalRequests = 0;
            int pendingRequests = 0;
            int approvedRequests = 0;
            int rejectedRequests = 0;
            
            if (leaveRequests != null) {
                totalRequests = leaveRequests.size();
                for (LeaveRequest lr : leaveRequests) {
                    String status = lr.getStatus().toLowerCase();
                    if (status.equals("pending")) pendingRequests++;
                    else if (status.equals("approved")) approvedRequests++;
                    else if (status.equals("rejected")) rejectedRequests++;
                }
            }
            %>
            <div class="stat-card">
                <div class="stat-number"><%=totalRequests%></div>
                <div class="stat-label">Total Requests</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%=pendingRequests%></div>
                <div class="stat-label">Pending</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%=approvedRequests%></div>
                <div class="stat-label">Approved</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%=rejectedRequests%></div>
                <div class="stat-label">Rejected</div>
            </div>
        </div>

        <!-- Table Container -->
        <div class="table-container">
            <div class="table-header">
                <h3>Leave Requests</h3>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Employee</th>
                        <th>Leave Type</th>
                        <th>From Date</th>
                        <th>To Date</th>
                        <th>Reason</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    if (leaveRequests != null && !leaveRequests.isEmpty()) {
                        for (LeaveRequest lr : leaveRequests) {
                            String statusClass = "status-" + lr.getStatus().toLowerCase();
                    %>
                    <tr>
                        <td><%=lr.getId()%></td>
                        <td><strong><%=lr.getUsername()%></strong></td>
                        <td><%=lr.getLeaveType()%></td>
                        <td><%=lr.getFromDate()%></td>
                        <td><%=lr.getToDate()%></td>
                        <td><%=lr.getReason()%></td>
                        <td>
                            <span class="status-badge <%=statusClass%>">
                                <%=lr.getStatus()%>
                            </span>
                        </td>
                        <td>
                            <div class="action-buttons">
                                <form action="<%=request.getContextPath()%>/AdminActionServlet"
                                    method="post" style="display: inline;">
                                    <input type="hidden" name="id" value="<%=lr.getId()%>">
                                    <input type="hidden" name="action" value="Approved">
                                    <button type="submit" class="action-btn approve-btn">Approve</button>
                                </form>
                                <form action="<%=request.getContextPath()%>/AdminActionServlet"
                                    method="post" style="display: inline;">
                                    <input type="hidden" name="id" value="<%=lr.getId()%>">
                                    <input type="hidden" name="action" value="Rejected">
                                    <button type="submit" class="action-btn reject-btn">Reject</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="8" class="no-data">
                            No leave requests found. All requests have been processed.
                        </td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
