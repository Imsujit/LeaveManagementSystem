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
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
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
            height: 60px;
        }

        .logo {
            font-size: 1.3rem;
            font-weight: bold;
            color: #111827;
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .back-btn {
            padding: 0.6rem 1.2rem;
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            font-size: 0.875rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            border: none;
            box-shadow: 0 2px 4px rgba(79, 70, 229, 0.2);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .back-btn:hover {
            background: linear-gradient(135deg, #4338ca 0%, #6d28d9 100%);
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(79, 70, 229, 0.3);
        }

        .back-btn:active {
            transform: translateY(0);
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 500;
            color: #374151;
            font-size: 0.9rem;
        }

        .user-avatar {
            width: 28px;
            height: 28px;
            background: #667eea;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 500;
            font-size: 0.8rem;
        }

        .container {
            max-width: 500px;
            margin: 0 auto;
            padding: 2rem 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: calc(100vh - 60px);
        }

        .form-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
        }

        .form-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem;
            text-align: center;
        }

        .form-header h3 {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .form-header p {
            opacity: 0.9;
            font-size: 0.85rem;
        }

        .form-content {
            padding: 1rem;
        }

        .form-grid {
            display: grid;
            gap: 0.8rem;
        }

        .form-group {
            position: relative;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 0.8rem;
        }

        label {
            display: block;
            margin-bottom: 0.3rem;
            color: #374151;
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .label-icon {
            margin-right: 0.5rem;
            color: #667eea;
        }

        input[type="date"],
        select,
        textarea {
            width: 100%;
            padding: 0.7rem 0.8rem;
            border: 2px solid #e5e7eb;
            border-radius: 6px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            background: #f9fafb;
            font-family: inherit;
        }

        input[type="date"]:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        select {
            cursor: pointer;
        }

        textarea {
            resize: vertical;
            min-height: 80px;
            font-family: inherit;
        }

        .submit-btn {
            width: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.95rem;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-top: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(102, 126, 234, 0.4);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        .form-footer {
            background: #f8f9fa;
            padding: 0.8rem 1rem;
            text-align: center;
            border-top: 1px solid #e5e7eb;
        }

        .form-footer p {
            color: #6b7280;
            font-size: 0.75rem;
            margin: 0;
        }

        .form-footer a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .form-footer a:hover {
            color: #5a67d8;
            text-decoration: underline;
        }

        .leave-info {
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            border: 1px solid #bae6fd;
            border-radius: 6px;
            padding: 0.6rem;
            margin-bottom: 0.8rem;
        }

        .leave-info h4 {
            color: #0369a1;
            font-size: 0.75rem;
            font-weight: 600;
            margin-bottom: 0.3rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .leave-info ul {
            color: #0c4a6e;
            font-size: 0.7rem;
            margin-left: 1rem;
        }

        .leave-info li {
            margin-bottom: 0.15rem;
        }

        .character-count {
            text-align: right;
            font-size: 0.7rem;
            color: #6b7280;
            margin-top: 0.2rem;
        }

        .character-count.warning {
            color: #d97706;
        }

        .character-count.error {
            color: #dc2626;
        }

        @media (max-width: 768px) {
            .header-content {
                padding: 0 0.5rem;
                height: 55px;
            }

            .container {
                padding: 1rem 0.5rem;
            }

            .form-content {
                padding: 0.8rem;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .form-footer {
                padding: 0.6rem 0.8rem;
            }

            .back-btn {
                padding: 0.5rem 1rem;
                font-size: 0.8rem;
            }
        }

        /* Loading animation */
        .submit-btn.loading {
            opacity: 0.7;
            cursor: not-allowed;
        }

        .submit-btn.loading::after {
            content: '';
            width: 14px;
            height: 14px;
            margin-left: 8px;
            border: 2px solid transparent;
            border-top: 2px solid white;
            border-radius: 50%;
            display: inline-block;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
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
        <!-- Form Container -->
        <div class="form-container">
            <div class="form-header">
                <h3><i class="fas fa-calendar-plus"></i> Leave Request Form</h3>
                <p>Fill in the required information</p>
            </div>

            <div class="form-content">
                <!-- Leave Information -->
                <div class="leave-info">
                    <h4><i class="fas fa-info-circle"></i> Quick Guidelines</h4>
                    <ul>
                        <li>Sick Leave: Medical certificate for 3+ days</li>
                        <li>Casual/Earned Leave: Apply in advance</li>
                        <li>Maximum 15 days per request</li>
                    </ul>
                </div>

                <form action="<%= request.getContextPath() %>/LeaveRequestServlet" method="post" id="leaveForm">
                    <div class="form-grid">
                        <!-- Leave Type -->
                        <div class="form-group">
                            <label for="leaveType">
                                <i class="fas fa-list-ul label-icon"></i>
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

                        <!-- Date Range -->
                        <div class="form-row">
                            <div class="form-group">
                                <label for="fromDate">
                                    <i class="fas fa-calendar-day label-icon"></i>
                                    From Date
                                </label>
                                <input type="date" id="fromDate" name="fromDate" required>
                            </div>
                            <div class="form-group">
                                <label for="toDate">
                                    <i class="fas fa-calendar-day label-icon"></i>
                                    To Date
                                </label>
                                <input type="date" id="toDate" name="toDate" required>
                            </div>
                        </div>

                        <!-- Reason -->
                        <div class="form-group">
                            <label for="reason">
                                <i class="fas fa-comment-alt label-icon"></i>
                                Reason for Leave
                            </label>
                            <textarea 
                                id="reason" 
                                name="reason" 
                                rows="3" 
                                required 
                                placeholder="Please provide reason for your leave request..."
                                maxlength="300"
                                oninput="updateCharacterCount()"
                            ></textarea>
                            <div class="character-count" id="charCount">0/300 characters</div>
                        </div>

                        <!-- Submit Button -->
                        <button type="submit" class="submit-btn" id="submitBtn">
                            <i class="fas fa-paper-plane"></i>
                            Submit Request
                        </button>
                    </div>
                </form>
            </div>

            <div class="form-footer">
                <p><a href="#" onclick="showHelp()">View Policy</a> | <a href="<%= request.getContextPath() %>/LeaveStatusServlet">Check Status</a></p>
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

        // Update character count
        function updateCharacterCount() {
            const textarea = document.getElementById('reason');
            const charCount = document.getElementById('charCount');
            const current = textarea.value.length;
            const max = 300;
            
            charCount.textContent = `${current}/${max} characters`;
            
            if (current > max * 0.9) {
                charCount.className = 'character-count error';
            } else if (current > max * 0.7) {
                charCount.className = 'character-count warning';
            } else {
                charCount.className = 'character-count';
            }
        }

        // Date validation
        document.getElementById('fromDate').addEventListener('change', function() {
            const fromDate = this.value;
            const toDateInput = document.getElementById('toDate');
            toDateInput.setAttribute('min', fromDate);
            
            if (toDateInput.value && toDateInput.value < fromDate) {
                toDateInput.value = fromDate;
            }
        });

        // Form submission with loading state
        document.getElementById('leaveForm').addEventListener('submit', function(e) {
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.classList.add('loading');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Submitting...';
            
            // Validate dates
            const fromDate = new Date(document.getElementById('fromDate').value);
            const toDate = new Date(document.getElementById('toDate').value);
            const diffTime = Math.abs(toDate - fromDate);
            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1;
            
            if (diffDays > 15) {
                e.preventDefault();
                alert('Maximum 15 days leave allowed per request');
                submitBtn.classList.remove('loading');
                submitBtn.innerHTML = '<i class="fas fa-paper-plane"></i> Submit Request';
                return false;
            }
        });

        // Show help modal
        function showHelp() {
            alert('Leave Policy:\n\n• Sick Leave: Medical certificate required for 3+ consecutive days\n• Casual Leave: Apply at least 1 day in advance\n• Earned Leave: Apply at least 7 days in advance\n• Emergency Leave: Can be applied on the same day\n• Maximum 15 days per single request\n• All leaves subject to manager approval');
        }
    </script>
</body>
</html>
