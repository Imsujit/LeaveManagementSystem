<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Forgot Password</title>
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

    .form-container {
      width: 450px;
      background: white;
      border-radius: 12px;
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
      overflow: hidden;
    }

    .form-header {
      background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
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

    /* Error Message Styling */
    .error-message {
      background: #fee2e2;
      border: 1px solid #fecaca;
      color: #dc2626;
      padding: 1rem;
      border-radius: 8px;
      margin-bottom: 1.5rem;
      font-size: 0.9rem;
      text-align: center;
      font-weight: 500;
      white-space: pre-line; /* Allows line breaks */
    }

    .info-message {
      background: #fff3cd;
      border: 1px solid #ffeaa7;
      color: #856404;
      padding: 1rem;
      border-radius: 8px;
      margin-bottom: 1.5rem;
      font-size: 0.9rem;
      text-align: center;
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

    input[type="email"] {
      width: 100%;
      padding: 0.8rem;
      border: 2px solid #e1e8ed;
      border-radius: 8px;
      font-size: 0.95rem;
      transition: all 0.3s ease;
      background: #f8f9fa;
    }

    input[type="email"]:focus {
      outline: none;
      border-color: #e74c3c;
      background: white;
      box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.1);
    }

    /* Error state for inputs */
    input.error {
      border-color: #dc2626;
      background: #fef2f2;
    }

    input.error:focus {
      border-color: #dc2626;
      box-shadow: 0 0 0 3px rgba(220, 38, 38, 0.1);
    }

    .submit-btn {
      width: 100%;
      background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
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
      box-shadow: 0 4px 15px rgba(231, 76, 60, 0.4);
    }

    .submit-btn:active {
      transform: translateY(0);
    }

    .back-to-login {
      text-align: center;
      margin-top: 1rem;
      padding-top: 1rem;
      border-top: 1px solid #e1e8ed;
    }

    .back-to-login a {
      color: #3498db;
      text-decoration: none;
      font-size: 0.9rem;
      font-weight: 500;
      transition: color 0.3s ease;
    }

    .back-to-login a:hover {
      color: #2980b9;
      text-decoration: underline;
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

    .register-link {
      margin-top: 0.5rem;
    }

    .register-link a {
      color: #e74c3c;
      text-decoration: none;
      font-weight: 500;
      transition: color 0.3s ease;
    }

    .register-link a:hover {
      color: #c0392b;
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
      <h2>🔐 Forgot Password</h2>
      <p>Reset your account password</p>
    </div>
    
    <div class="form-content">
      <!-- Display Error Message -->
      <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="error-message">
          <%= request.getAttribute("errorMessage") %>
        </div>
      <% } else { %>
        <div class="info-message">
          📧 Enter your email address and we'll send you a link to reset your password.
        </div>
      <% } %>

      <form action="<%=request.getContextPath()%>/ForgotPasswordServlet" method="post" id="forgotForm">
        <div class="form-group">
          <label for="email">Email Address</label>
          <input type="email" id="email" name="email" required placeholder="Enter your registered email address"
                 value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                 class="<%= request.getAttribute("errorMessage") != null ? "error" : "" %>">
        </div>

        <input type="submit" value="Send Reset Link" class="submit-btn" id="submitBtn">
      </form>

      <!-- Back to Login Link -->
      <div class="back-to-login">
        <a href="<%=request.getContextPath()%>/jsp/login.jsp">← Back to Login</a>
      </div>
    </div>

    <div class="form-footer">
      <p>🔒 We'll never share your email with anyone else.</p>
      <div class="register-link">
        <p>Don't have an account? <a href="<%=request.getContextPath()%>/jsp/register.jsp">Register here</a></p>
      </div>
    </div>
  </div>

  <script>
    // Add loading state to form submission
    document.getElementById('forgotForm').addEventListener('submit', function() {
      const submitBtn = document.getElementById('submitBtn');
      submitBtn.classList.add('loading');
      submitBtn.value = 'Sending Email...';
    });

    // Remove error styling on input focus
    document.getElementById('email').addEventListener('focus', function() {
      this.classList.remove('error');
    });

    // Auto-focus on email field
    document.addEventListener('DOMContentLoaded', function() {
      document.getElementById('email').focus();
    });
  </script>
</body>
</html>
