<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Password Reset Error</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      color: #333;
    }

    .message-container {
      width: 500px;
      background: white;
      border-radius: 12px;
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
      overflow: hidden;
      text-align: center;
    }

    .message-header {
      background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
      color: white;
      padding: 2rem;
    }

    .message-header h2 {
      font-size: 1.8rem;
      font-weight: 600;
      margin-bottom: 0.5rem;
    }

    .message-content {
      padding: 2rem;
    }

    .error-icon {
      font-size: 4rem;
      color: #e74c3c;
      margin-bottom: 1rem;
    }

    .message-text {
      font-size: 1.1rem;
      color: #2c3e50;
      margin-bottom: 2rem;
      line-height: 1.6;
    }

    .action-buttons {
      display: flex;
      gap: 1rem;
      justify-content: center;
      flex-wrap: wrap;
    }

    .btn {
      padding: 0.9rem 1.5rem;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      font-size: 0.9rem;
      font-weight: 600;
      text-decoration: none;
      display: inline-block;
      transition: all 0.3s ease;
    }

    .btn-primary {
      background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
      color: white;
    }

    .btn-primary:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 15px rgba(231, 76, 60, 0.4);
    }

    .btn-secondary {
      background: #6c757d;
      color: white;
    }

    .btn-secondary:hover {
      background: #5a6268;
      transform: translateY(-2px);
    }

    @media (max-width: 480px) {
      .message-container {
        width: 90%;
        margin: 1rem;
      }

      .message-header {
        padding: 1.5rem;
      }

      .message-content {
        padding: 1.5rem;
      }

      .action-buttons {
        flex-direction: column;
      }
    }
  </style>
</head>
<body>
  <div class="message-container">
    <div class="message-header">
      <h2>❌ Password Reset Error</h2>
    </div>
    
    <div class="message-content">
      <div class="error-icon">🚫</div>
      
      <p class="message-text">
        <%= request.getAttribute("errorMessage") != null ? 
            request.getAttribute("errorMessage") : 
            "An error occurred while processing your password reset request." %>
      </p>
      
      <div class="action-buttons">
        <a href="<%=request.getContextPath()%>/jsp/forgot-password.jsp" class="btn btn-primary">
          🔄 Try Again
        </a>
        <a href="<%=request.getContextPath()%>/jsp/login.jsp" class="btn btn-secondary">
          ← Back to Login
        </a>
      </div>
    </div>
  </div>
</body>
</html>
