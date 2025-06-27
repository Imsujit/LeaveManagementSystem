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
  <title>Reset Password</title>
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

    .form-container {
      width: 400px;
      background: white;
      border-radius: 12px;
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
      overflow: hidden;
    }

    .form-header {
      background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
      color: white;
      padding: 2rem;
      text-align: center;
    }

    .form-header h2 {
      font-size: 1.8rem;
      font-weight: 600;
      margin-bottom: 0.5rem;
    }

    .form-header p {
      opacity: 0.9;
      font-size: 0.95rem;
    }

    .form-content {
      padding: 2rem;
    }

    .form-group {
      margin-bottom: 1.5rem;
    }

    label {
      display: block;
      margin-bottom: 0.5rem;
      color: #2c3e50;
      font-weight: 500;
      font-size: 0.9rem;
    }

    input[type="password"] {
      width: 100%;
      padding: 0.8rem;
      border: 2px solid #e1e8ed;
      border-radius: 8px;
      font-size: 0.95rem;
      transition: all 0.3s ease;
      background: #f8f9fa;
    }

    input[type="password"]:focus {
      outline: none;
      border-color: #3498db;
      background: white;
      box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
    }

    .password-requirements {
      background: #e8f4fd;
      border: 1px solid #bee5eb;
      color: #0c5460;
      padding: 0.8rem;
      border-radius: 6px;
      font-size: 0.8rem;
      margin-top: 0.5rem;
    }

    .password-requirements ul {
      margin: 0.5rem 0 0 1rem;
    }

    .password-requirements li {
      margin-bottom: 0.2rem;
    }

    .submit-btn {
      width: 100%;
      background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
      color: white;
      padding: 0.9rem;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      font-size: 1rem;
      font-weight: 600;
      transition: all 0.3s ease;
      margin-top: 1rem;
    }

    .submit-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 15px rgba(52, 152, 219, 0.4);
    }

    .submit-btn:active {
      transform: translateY(0);
    }

    .submit-btn:disabled {
      opacity: 0.6;
      cursor: not-allowed;
      transform: none;
    }

    .form-footer {
      text-align: center;
      padding: 1.5rem 2rem;
      background: #f8f9fa;
      border-top: 1px solid #e1e8ed;
    }

    .form-footer p {
      color: #6c757d;
      font-size: 0.85rem;
      margin: 0;
    }

    .form-footer a {
      color: #3498db;
      text-decoration: none;
      font-weight: 500;
      transition: color 0.3s ease;
    }

    .form-footer a:hover {
      color: #2980b9;
      text-decoration: underline;
    }

    @media (max-width: 480px) {
      .form-container {
        width: 90%;
        margin: 1rem;
      }

      .form-header {
        padding: 1.5rem;
      }

      .form-header h2 {
        font-size: 1.5rem;
      }

      .form-content {
        padding: 1.5rem;
      }

      .form-footer {
        padding: 1rem 1.5rem;
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
  <div class="form-container">
    <div class="form-header">
      <h2>🔑 Reset Password</h2>
      <p>Create your new password</p>
    </div>
    
    <div class="form-content">
      <form action="<%=request.getContextPath()%>/ResetPasswordServlet" method="post" id="resetForm">
        <input type="hidden" name="token" value="<%=token%>">
        
        <div class="form-group">
          <label for="newPassword">New Password</label>
          <input type="password" id="newPassword" name="newPassword" required placeholder="Enter your new password">
          <div class="password-requirements">
            <strong>Password Requirements:</strong>
            <ul>
              <li>At least 6 characters long</li>
              <li>Mix of letters and numbers recommended</li>
              <li>Avoid common passwords</li>
            </ul>
          </div>
        </div>

        <div class="form-group">
          <label for="confirmPassword">Confirm New Password</label>
          <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Confirm your new password">
        </div>

        <input type="submit" value="Reset Password" class="submit-btn" id="submitBtn">
      </form>
    </div>

    <div class="form-footer">
      <p><a href="<%=request.getContextPath()%>/jsp/login.jsp">← Back to Login</a></p>
    </div>
  </div>

  <script>
    // Password confirmation validation
    document.getElementById('confirmPassword').addEventListener('input', function() {
      const newPassword = document.getElementById('newPassword').value;
      const confirmPassword = this.value;
      const submitBtn = document.getElementById('submitBtn');
      
      if (newPassword !== confirmPassword) {
        this.style.borderColor = '#e74c3c';
        submitBtn.disabled = true;
      } else {
        this.style.borderColor = '#27ae60';
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
      submitBtn.value = 'Resetting Password...';
    });

    // Auto-focus on new password field
    document.addEventListener('DOMContentLoaded', function() {
      document.getElementById('newPassword').focus();
    });
  </script>
</body>
</html>
