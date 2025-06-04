<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Login</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
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
      background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
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

    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 0.8rem;
      border: 2px solid #e1e8ed;
      border-radius: 8px;
      font-size: 0.95rem;
      transition: all 0.3s ease;
      background: #f8f9fa;
    }

    input[type="text"]:focus,
    input[type="password"]:focus {
      outline: none;
      border-color: #27ae60;
      background: white;
      box-shadow: 0 0 0 3px rgba(39, 174, 96, 0.1);
    }

    .submit-btn {
      width: 100%;
      background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
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
      box-shadow: 0 4px 15px rgba(39, 174, 96, 0.4);
    }

    .submit-btn:active {
      transform: translateY(0);
    }

    .form-footer {
      text-align: center;
      padding: 1.5rem 2rem;
      background: #f8f9fa;
      border-top: 1px solid #e1e8ed;
    }

    .form-footer p {
      color: #6c757d;
      font-size: 0.9rem;
      margin: 0;
    }

    .form-footer a {
      color: #27ae60;
      text-decoration: none;
      font-weight: 500;
      transition: color 0.3s ease;
    }

    .form-footer a:hover {
      color: #2ecc71;
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

    /* Welcome message styling */
    .welcome-message {
      text-align: center;
      margin-bottom: 1rem;
      padding: 1rem;
      background: linear-gradient(135deg, #ecf0f1 0%, #bdc3c7 100%);
      border-radius: 8px;
      color: #2c3e50;
    }

    .welcome-message h3 {
      margin-bottom: 0.5rem;
      font-size: 1.1rem;
    }

    .welcome-message p {
      font-size: 0.85rem;
      opacity: 0.8;
    }
  </style>
</head>
<body>
  <div class="form-container">
    <div class="form-header">
      <h2>Welcome Back</h2>
      <p>Sign in to your account</p>
    </div>
    
    <div class="form-content">
      <div class="welcome-message">
        <h3>Leave Management System</h3>
        <p>Access your dashboard and manage your leave</p>
      </div>

      <% 
         String error = (String) session.getAttribute("errorMessage");
         if (error != null) { 
      %>
         <div style="color:red; margin-bottom: 1rem; text-align:center;"><%= error %></div>
      <%
          session.removeAttribute("errorMessage");
         } 
      %>

      <form action="<%=request.getContextPath()%>/LoginServlet" method="post">
        <div class="form-group">
          <label for="username">Username</label>
          <input type="text" id="username" name="username" required placeholder="Enter your username">
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" required placeholder="Enter your password">
        </div>

        <input type="submit" value="Sign In" class="submit-btn">
      </form>
    </div>

    <div class="form-footer">
      <p>Don't have an account? <a href="<%=request.getContextPath()%>/jsp/register.jsp">Register here</a></p>
    </div>
  </div>

  <script>
    // Add loading state to form submission
    document.querySelector('form').addEventListener('submit', function() {
      const submitBtn = document.querySelector('.submit-btn');
      submitBtn.classList.add('loading');
      submitBtn.value = 'Signing In...';
    });

    // Add focus effects
    const inputs = document.querySelectorAll('input');
    inputs.forEach(input => {
      input.addEventListener('focus', function() {
        this.parentElement.style.transform = 'scale(1.02)';
      });
      
      input.addEventListener('blur', function() {
        this.parentElement.style.transform = 'scale(1)';
      });
    });

    // Auto-focus on username field
    document.addEventListener('DOMContentLoaded', function() {
      document.getElementById('username').focus();
    });
  </script>
</body>
</html>
