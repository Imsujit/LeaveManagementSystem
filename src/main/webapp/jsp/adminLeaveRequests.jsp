<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*, com.leaveapp.LeaveRequest"%>
<!DOCTYPE html>
<html>
<head>
<title>Admin - Leave Requests</title>
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
        min-height: 100vh;
        color: #1a202c;
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

    .nav-actions {
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .back-btn {
        background: rgba(255, 255, 255, 0.1);
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
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .back-btn:hover {
        background: rgba(255, 255, 255, 0.2);
        transform: translateY(-1px);
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
        max-width: 1200px;
        margin: 0 auto;
        padding: 2rem 1rem;
    }

    .page-title {
        text-align: center;
        color: #1a202c;
        margin-bottom: 2rem;
    }

    .page-title h2 {
        font-size: 2rem;
        font-weight: 700;
        margin-bottom: 0.5rem;
        letter-spacing: -1px;
    }

    .page-title p {
        color: #64748b;
        font-size: 1rem;
    }

    .table-container {
        background: white;
        border-radius: 16px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
        overflow: hidden;
        margin-bottom: 2rem;
        border: 1px solid #e2e8f0;
    }

    .table-header {
        background: linear-gradient(135deg, #e53e3e 0%, #c53030 100%);
        color: white;
        padding: 2rem;
        text-align: center;
    }

    .table-header h3 {
        font-size: 1.5rem;
        font-weight: 700;
        margin-bottom: 0.5rem;
        letter-spacing: -0.5px;
    }

    .table-header p {
        opacity: 0.9;
        font-size: 1rem;
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
        color: #374151;
        border-bottom: 2px solid #e2e8f0;
        font-size: 0.9rem;
    }

    td {
        padding: 1rem 0.8rem;
        border-bottom: 1px solid #e2e8f0;
        font-size: 0.9rem;
    }

    tbody tr {
        transition: background-color 0.2s ease;
    }

    tbody tr:hover {
        background-color: #f9fafb;
    }

    .status-badge {
        padding: 0.3rem 0.8rem;
        border-radius: 15px;
        font-size: 0.75rem;
        font-weight: 500;
        text-transform: uppercase;
    }

    .status-pending {
        background: #fef3c7;
        color: #92400e;
    }

    .status-approved {
        background: #dcfce7;
        color: #166534;
    }

    .status-rejected {
        background: #fee2e2;
        color: #991b1b;
    }

    .action-buttons {
        display: flex;
        gap: 0.5rem;
        justify-content: center;
    }

    .action-btn {
        padding: 0.5rem 1rem;
        border: none;
        border-radius: 8px;
        font-size: 0.8rem;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        min-width: 80px;
    }

    .approve-btn {
        background: linear-gradient(135deg, #22c55e 0%, #16a34a 100%);
        color: white;
        box-shadow: 0 2px 8px rgba(34, 197, 94, 0.3);
    }

    .approve-btn:hover {
        background: linear-gradient(135deg, #16a34a 0%, #15803d 100%);
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(34, 197, 94, 0.4);
    }

    .reject-btn {
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        color: white;
        box-shadow: 0 2px 8px rgba(239, 68, 68, 0.3);
    }

    .reject-btn:hover {
        background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(239, 68, 68, 0.4);
    }

    .no-data {
        text-align: center;
        padding: 3rem;
        color: #64748b;
        font-style: italic;
    }

    .stats-row {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1.5rem;
        margin-bottom: 2rem;
    }

    .stat-card {
        background: white;
        padding: 2rem;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        text-align: center;
        border: 1px solid #e2e8f0;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .stat-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
    }

    .stat-number {
        font-size: 2rem;
        font-weight: bold;
        color: #e53e3e;
        margin-bottom: 0.5rem;
    }

    .stat-label {
        color: #64748b;
        font-size: 0.9rem;
        font-weight: 500;
    }

    @media (max-width: 768px) {
        .header-content {
            flex-direction: column;
            gap: 1rem;
            text-align: center;
        }

        .container {
            padding: 1rem 0.5rem;
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
            padding: 0.4rem 0.8rem;
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
        <div class="header-content">
            <h1 class="logo">
                <i class="fas fa-shield-alt"></i>
                Leave Management - Admin
            </h1>
            <div class="nav-actions">
                <a href="<%=request.getContextPath()%>/jsp/adminDashboard.jsp" class="back-btn">
                    <i class="fas fa-home"></i>
                    Dashboard
                </a>
                <div class="user-info">
                    <div class="user-avatar">A</div>
                    <span>Admin<span class="admin-badge">Admin</span></span>
                </div>
            </div>
        </div>
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
