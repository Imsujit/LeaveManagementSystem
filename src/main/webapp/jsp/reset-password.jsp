<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String token = request.getParameter("token");
    if (token == null || token.trim().isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password - Leave Management</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #333;
            position: relative;
            overflow: hidden;
            padding: 2rem 1rem;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="dots" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="1.5" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23dots)"/></svg>');
            animation: float 20s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        .reset-container {
            position: relative;
            z-index: 1;
            animation: slideUp 0.8s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-container {
            width: 400px;
            max-width: 100%;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .form-header {
            background: linear-gradient(135deg, rgba(239, 68, 68, 0.9) 0%, rgba(220, 38, 38, 0.9) 100%);
            color: white;
            padding: 1.8rem 1.5rem;
            text-align: center;
            position: relative;
        }

        .form-header::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="white" opacity="0.1"/><circle cx="75" cy="75" r="1" fill="white" opacity="0.1"/><circle cx="50" cy="10" r="0.5" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            opacity: 0.3;
        }

        .form-header > * {
            position: relative;
            z-index: 1;
        }

        .form-header h2 {
            font-size: 1.6rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            letter-spacing: -0.5px;
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

        .error-message {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            border: 1px solid #f87171;
            color: #dc2626;
            padding: 0.8rem;
            border-radius: 10px;
            margin-bottom: 1.2rem;
            font-size: 0.85rem;
            text-align: center;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.4rem;
        }

        .form-group {
            margin-bottom: 1.2rem;
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

        .input-wrapper {
            position: relative;
        }

        input[type="password"] {
            width: 100%;
            padding: 0.8rem 0.8rem 0.8rem 2.4rem;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            background: #f8fafc;
            font-family: inherit;
            font-weight: 400;
        }

        input[type="password"]:focus {
            outline: none;
            border-color: #ef4444;
            background: white;
            box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
            transform: translateY(-1px);
        }

        .input-icon {
            position: absolute;
            left: 0.8rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            transition: color 0.3s ease;
            font-size: 0.9rem;
        }

        input:focus + .input-icon {
            color: #ef4444;
        }

        input.error {
            border-color: #ef4444;
            background: #fef2f2;
        }

        .password-requirements {
            background: linear-gradient(135deg, #e8f4fd 0%, #dbeafe 100%);
            border: 1px solid #93c5fd;
            color: #1e40af;
            padding: 0.8rem;
            border-radius: 8px;
            font-size: 0.8rem;
            margin-top: 0.5rem;
        }

        .password-requirements h4 {
            margin-bottom: 0.5rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .password-requirements ul {
            margin: 0.5rem 0 0 1rem;
        }

        .password-requirements li {
            margin-bottom: 0.2rem;
        }

        .submit-btn {
            width: 100%;
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
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
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
            font-family: inherit;
        }

        .submit-btn:hover {
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(239, 68, 68, 0.4);
        }

        .submit-btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        .form-footer {
            text-align: center;
            padding: 1.2rem 1.5rem;
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            border-top: 1px solid #e2e8f0;
        }

        .form-footer p {
            color: #64748b;
            font-size: 0.85rem;
            margin: 0;
            font-weight: 400;
        }

        .form-footer a {
            color: #ef4444;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            transition: all 0.3s ease;
        }

        .form-footer a:hover {
            color: #dc2626;
            text-decoration: underline;
        }

        @media (max-width: 480px) {
            body {
                padding: 1rem 0.5rem;
            }

            .form-container {
                width: 100%;
            }

            .form-header {
                padding: 1.5rem 1.2rem;
            }

            .form-content {
                padding: 1.2rem;
            }

            .form-footer {
                padding: 1rem 1.2rem;
            }
        }

        /* Loading animation for submit button */
        .submit-btn.loading {
            opacity: 0.7;
            cursor: not-allowed;
        }

        .submit-btn.loading::after {
            content: '';
            width: 16px;
            height: 16px;
            margin-left: 10px;
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
    <div class="reset-container">
        <div class="form-container">
            <div class="form-header">
                <h2>
                    <i class="fas fa-key"></i>
                    Reset Password
                </h2>
                <p>Create your new password</p>
            </div>
            
            <div class="form-content">
                <!-- Display Error Message -->
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="error-message">
                        <i class="fas fa-exclamation-triangle"></i>
                        <%= request.getAttribute("errorMessage") %>
                    </div>
                <% } %>

                <form action="<%=request.getContextPath()%>/ResetPasswordServlet" method="post" id="resetForm">
                    <input type="hidden" name="token" value="<%=token%>">
                    
                    <div class="form-group">
                        <label for="newPassword">
                            <i class="fas fa-lock"></i>
                            New Password
                        </label>
                        <div class="input-wrapper">
                            <input 
                                type="password" 
                                id="newPassword" 
                                name="newPassword" 
                                required 
                                placeholder="Enter your new password"
                            >
                            <i class="fas fa-lock input-icon"></i>
                        </div>
                        <div class="password-requirements">
                            <h4>
                                <i class="fas fa-shield-alt"></i>
                                Password Requirements:
                            </h4>
                            <ul>
                                <li>At least 6 characters long</li>
                                <li>Mix of letters and numbers recommended</li>
                                <li>Avoid common passwords</li>
                            </ul>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">
                            <i class="fas fa-lock"></i>
                            Confirm New Password
                        </label>
                        <div class="input-wrapper">
                            <input 
                                type="password" 
                                id="confirmPassword" 
                                name="confirmPassword" 
                                required 
                                placeholder="Confirm your new password"
                            >
                            <i class="fas fa-lock input-icon"></i>
                        </div>
                    </div>

                    <button type="submit" class="submit-btn" id="submitBtn">
                        <i class="fas fa-key"></i>
                        Reset Password
                    </button>
                </form>
            </div>

            <div class="form-footer">
                <p><a href="<%=request.getContextPath()%>/jsp/login.jsp">
                    <i class="fas fa-arrow-left"></i>
                    Back to Login
                </a></p>
            </div>
        </div>
    </div>

    <script>
        // Password confirmation validation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = this.value;
            const submitBtn = document.getElementById('submitBtn');
            
            if (newPassword !== confirmPassword) {
                this.style.borderColor = '#ef4444';
                this.classList.add('error');
                submitBtn.disabled = true;
            } else {
                this.style.borderColor = '#22c55e';
                this.classList.remove('error');
                submitBtn.disabled = false;
            }
        });

        // Form submission with loading state
        document.getElementById('resetForm').addEventListener('submit', function(e) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (newPassword !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
                return false;
            }
            
            if (newPassword.length < 6) {
                e.preventDefault();
                alert('Password must be at least 6 characters long!');
                return false;
            }
            
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.classList.add('loading');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Resetting Password...';
        });

        // Auto-focus on new password field
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('newPassword').focus();
        });

        // Remove error styling on focus
        const inputs = document.querySelectorAll('input[type="password"]');
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.classList.remove('error');
            });
        });
    </script>
</body>
</html>
