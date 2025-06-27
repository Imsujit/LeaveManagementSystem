<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Password Reset Error - Leave Management</title>
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
            width: 400px;
            max-width: 100%;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .message-header {
            background: linear-gradient(135deg, rgba(239, 68, 68, 0.9) 0%, rgba(220, 38, 38, 0.9) 100%);
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

        .error-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 1.8rem;
            color: white;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        .message-text {
            font-size: 0.95rem;
            color: #374151;
            margin-bottom: 1.5rem;
            line-height: 1.5;
            font-weight: 400;
        }

        .action-buttons {
            display: flex;
            gap: 0.8rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            padding: 0.7rem 1.2rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.85rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        .btn-primary {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(239, 68, 68, 0.4);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6b7280 0%, #4b5563 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(107, 114, 128, 0.3);
        }

        .btn-secondary:hover {
            background: linear-gradient(135deg, #4b5563 0%, #374151 100%);
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(107, 114, 128, 0.4);
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
            margin-bottom: 0.3rem;
            font-weight: 400;
        }

        .form-footer a {
            color: #ef4444;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
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

            .action-buttons {
                flex-direction: column;
            }

            .message-header h2 {
                font-size: 1.2rem;
            }

            .error-icon {
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
                <i class="fas fa-exclamation-triangle"></i>
                Password Reset Error
            </h2>
            <p>Unable to process your request</p>
        </div>
        
        <div class="message-content">
            <div class="error-icon">
                <i class="fas fa-times"></i>
            </div>
            
            <p class="message-text">
                <%= request.getAttribute("errorMessage") != null ? 
                    request.getAttribute("errorMessage") : 
                    "An error occurred while processing your password reset request." %>
            </p>
            
            <div class="action-buttons">
                <a href="<%=request.getContextPath()%>/jsp/forgot-password.jsp" class="btn btn-primary">
                    <i class="fas fa-redo"></i>
                    Try Again
                </a>
                <a href="<%=request.getContextPath()%>/jsp/login.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i>
                    Back to Login
                </a>
            </div>
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
