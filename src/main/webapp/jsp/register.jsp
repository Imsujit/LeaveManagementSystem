<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Register</title>
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

    input[type="text"],
    input[type="password"],
    select {
      width: 100%;
      padding: 0.8rem;
      border: 2px solid #e1e8ed;
      border-radius: 8px;
      font-size: 0.95rem;
      transition: all 0.3s ease;
      background: #f8f9fa;
    }

    input[type="text"]:focus,
    input[type="password"]:focus,
    select:focus {
      outline: none;
      border-color: #3498db;
      background: white;
      box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
    }

    select {
      cursor: pointer;
    }

    select option {
      padding: 0.5rem;
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
      color: #3498db;
      text-decoration: none;
      font-weight: 500;
      transition: color 0.3s ease;
    }

    .form-footer a:hover {
      color: #2980b9;
      text-decoration: underline;
    }

    .input-icon {
      position: relative;
    }

    .input-icon::before {
      content: '';
      position: absolute;
      left: 0.8rem;
      top: 50%;
      transform: translateY(-50%);
      width: 16px;
      height: 16px;
      background-size: contain;
      opacity: 0.5;
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
      <h2>Create Account</h2>
      <p>Join our leave management system</p>
    </div>
    
    <div class="form-content">
      <% 
         String error = (String) session.getAttribute("errorMessage");
         if (error != null) { 
      %>
         <div style="color:red; margin-bottom: 1rem; text-align:center;"><%= error %></div>
      <%
     session.removeAttribute("errorMessage");
   } 
      %>
      <form action="<%=request.getContextPath()%>/RegisterServlet" method="post">
        <div class="form-group">
          <label for="username">Username</label>
          <input type="text" id="username" name="username" required placeholder="Enter your username">
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" required placeholder="Enter your password">
        </div>

        <div class="form-group">
          <label for="role">Role</label>
          <select id="role" name="role" required>
            <option value="">--Select Role--</option>
            <option value="user">User</option>
            <option value="admin">Admin</option>
          </select>
        </div>

        <input type="submit" value="Create Account" class="submit-btn">
      </form>
    </div>

    <div class="form-footer">
      <p>Already have an account? <a href="<%=request.getContextPath()%>/jsp/login.jsp">Login here</a></p>
    </div>
  </div>

  <script>
    // Add loading state to form submission
    document.querySelector('form').addEventListener('submit', function() {
      const submitBtn = document.querySelector('.submit-btn');
      submitBtn.classList.add('loading');
      submitBtn.value = 'Creating Account...';
    });

    // Add focus effects
    const inputs = document.querySelectorAll('input, select');
    inputs.forEach(input => {
      input.addEventListener('focus', function() {
        this.parentElement.style.transform = 'scale(1.02)';
      });
      
      input.addEventListener('blur', function() {
        this.parentElement.style.transform = 'scale(1)';
      });
    });
  </script>
</body>
</html>
