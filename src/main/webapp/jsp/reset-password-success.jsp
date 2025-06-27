<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Password Reset Successful - Leave Management</title>
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
            padding: 2rem 1rem;
        }

        .message-container {
            width: 380px;
            max-width: 100%;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .message-header {
            background: linear-gradient(135deg, rgba(59, 130, 246, 0.9) 0%, rgba(37, 99, 235, 0.9) 100%);
            color: white;
            padding: 1.5rem;
            text-align: center;
        }

        .message-header h2 {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 0.3rem;
            letter-spacing: -0.5px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .message-header p {
            font-size: 0.85rem;
            opacity: 0.9;
            font-weight: 400;
        }

        .message-content {
            padding: 1.5rem;
            text-align: center;
        }

        .success-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 1.8rem;
            color: white;
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }

        .message-text {
            font-size: 0.95rem;
            color: #374151;
            margin-bottom: 1.5rem;
            line-height: 1.5;
            font-weight: 400;
        }

        .login-btn {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
            padding: 0.8rem 2rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.95rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
            font-family: inherit;
        }

        .login-btn:hover {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(59, 130, 246, 0.4);
        }

        .form-footer {
            text-align: center;
            padding: 1rem 1.5rem;
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            border-top: 1px solid #e2e8f0;
        }

        .form-footer p {
            color: #64748b;
            font-size: 0.8rem;
            margin: 0;
            font-weight: 400;
        }

        .form-footer a {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            transition: all 0.3s ease;
        }

        .form-footer a:hover {
            color: #2563eb;
            text-decoration: underline;
        }

        @media (max-width: 480px) {
            body {
                padding: 1rem 0.5rem;
            }

            .message-container {
                width: 100%;
            }

            .message-header {
                padding: 1.2rem;
            }

            .message-content {
                padding: 1.2rem;
            }

            .form-footer {
                padding: 0.8rem 1.2rem;
            }

            .message-header h2 {
                font-size: 1.2rem;
            }

            .success-icon {
                width: 50px;
                height: 50px;
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="message-container">
        <div class="message-header">
            <h2>
                <i class="fas fa-check-circle"></i>
                Password Reset Complete
            </h2>
            <p>Your password has been successfully updated</p>
        </div>
        
        <div class="message-content">
            <div class="success-icon">
                <i class="fas fa-key"></i>
            </div>
            
            <p class="message-text">
                <%= request.getAttribute("successMessage") != null ? 
                    request.getAttribute("successMessage") : 
                    "Your password has been successfully reset. You can now login with your new password." %>
            </p>
            
            <a href="<%=request.getContextPath()%>/jsp/login.jsp" class="login-btn">
                <i class="fas fa-sign-in-alt"></i>
                Login Now
            </a>
        </div>

        <div class="form-footer">
            <p>Need help? <a href="<%=request.getContextPath()%>/jsp/register.jsp">
                <i class="fas fa-user-plus"></i>
                Create new account
            </a></p>
        </div>
    </div>
</body>
</html>
