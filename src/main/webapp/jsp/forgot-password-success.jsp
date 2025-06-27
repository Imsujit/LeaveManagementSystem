<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Email Sent - Forgot Password</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
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
      background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
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
      color: #27ae60;
      margin-bottom: 1rem;
    }

    .message-text {
      font-size: 1.1rem;
      color: #2c3e50;
      margin-bottom: 1.5rem;
      line-height: 1.6;
    }

    .info-box {
      background: #e8f5e8;
      border: 1px solid #c3e6c3;
      color: #2d5a2d;
      padding: 1rem;
      border-radius: 8px;
      margin-bottom: 2rem;
      font-size: 0.9rem;
    }

    .back-btn {
      background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
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

    .back-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 15px rgba(39, 174, 96, 0.4);
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
      <h2>📧 Email Sent Successfully</h2>
    </div>
    
    <div class="message-content">
      <div class="success-icon">✅</div>
      
      <p class="message-text">
        <%= request.getAttribute("successMessage") != null ? 
            request.getAttribute("successMessage") : 
            "Password reset link has been sent to your email address." %>
      </p>
      
      <div class="info-box">
        <strong>📋 Next Steps:</strong><br>
        1. Check your email inbox (and spam folder)<br>
        2. Click the reset link in the email<br>
        3. Create your new password<br>
        4. Login with your new credentials
      </div>
      
      <a href="<%=request.getContextPath()%>/jsp/login.jsp" class="back-btn">
        ← Back to Login
      </a>
    </div>
  </div>
</body>
</html>
