<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Password Reset Successful</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
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
      background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
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

    .success-icon {
      font-size: 4rem;
      color: #3498db;
      margin-bottom: 1rem;
    }

    .message-text {
      font-size: 1.1rem;
      color: #2c3e50;
      margin-bottom: 2rem;
      line-height: 1.6;
    }

    .login-btn {
      background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
      color: white;
      padding: 0.9rem 2rem;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      font-size: 1rem;
      font-weight: 600;
      text-decoration: none;
      display: inline-block;
      transition: all 0.3s ease;
    }

    .login-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 15px rgba(52, 152, 219, 0.4);
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
    }
  </style>
</head>
<body>
  <div class="message-container">
    <div class="message-header">
      <h2>🎉 Password Reset Successful</h2>
    </div>
    
    <div class="message-content">
      <div class="success-icon">🔑</div>
      
      <p class="message-text">
        <%= request.getAttribute("successMessage") != null ? 
            request.getAttribute("successMessage") : 
            "Your password has been successfully reset. You can now login with your new password." %>
      </p>
      
      <a href="<%=request.getContextPath()%>/jsp/login.jsp" class="login-btn">
        🚀 Login Now
      </a>
    </div>
  </div>
</body>
</html>
