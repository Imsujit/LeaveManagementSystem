<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register - Leave Management</title>
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
    position: relative;
    overflow: hidden;
  }

  body::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="white" stroke-width="0.5" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
    animation: slide 15s linear infinite;
  }

  @keyframes slide {
    0% { transform: translateX(0); }
    100% { transform: translateX(10px); }
  }

  .register-container {
    position: relative;
    z-index: 1;
    animation: fadeIn 0.8s ease-out;
  }

  @keyframes fadeIn {
    from {
      opacity: 0;
      transform: scale(0.95);
    }
    to {
      opacity: 1;
      transform: scale(1);
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
    background: linear-gradient(135deg, rgba(34, 197, 94, 0.9) 0%, rgba(22, 163, 74, 0.9) 100%);
    color: white;
    padding: 1.8rem 1.5rem;
    text-align: center;
    position: relative;
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

  input[type="text"],
  input[type="email"],
  input[type="password"],
  select {
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

  select {
    cursor: pointer;
  }

  input[type="text"]:focus,
  input[type="email"]:focus,
  input[type="password"]:focus,
  select:focus {
    outline: none;
    border-color: #22c55e;
    background: white;
    box-shadow: 0 0 0 3px rgba(34, 197, 94, 0.1);
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

  input:focus + .input-icon,
  select:focus + .input-icon {
    color: #22c55e;
  }

  .submit-btn {
    width: 100%;
    background: linear-gradient(135deg, #22c55e 0%, #16a34a 100%);
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
    box-shadow: 0 4px 12px rgba(34, 197, 94, 0.3);
    font-family: inherit;
  }

  .submit-btn:hover {
    background: linear-gradient(135deg, #16a34a 0%, #15803d 100%);
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(34, 197, 94, 0.4);
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
    color: #22c55e;
    text-decoration: none;
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    gap: 0.4rem;
    transition: all 0.3s ease;
  }

  .form-footer a:hover {
    color: #16a34a;
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
</style>
</head>
<body>
<div class="register-container">
  <div class="form-container">
    <div class="form-header">
      <h2>
        <i class="fas fa-user-plus"></i>
        Create Account
      </h2>
      <p>Join our leave management system</p>
    </div>
    
    <div class="form-content">
      <!-- Display Error Message -->
      <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="error-message">
          <i class="fas fa-exclamation-triangle"></i>
          <%= request.getAttribute("errorMessage") %>
        </div>
      <% } %>

      <form action="<%=request.getContextPath()%>/RegisterServlet" method="post" id="registerForm">
        <div class="form-group">
          <label for="username">
            <i class="fas fa-user"></i>
            Username
          </label>
          <div class="input-wrapper">
            <input 
              type="text" 
              id="username" 
              name="username" 
              required 
              placeholder="Enter your username"
              value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"
            >
            <i class="fas fa-user input-icon"></i>
          </div>
        </div>

        <div class="form-group">
          <label for="email">
            <i class="fas fa-envelope"></i>
            Email Address
          </label>
          <div class="input-wrapper">
            <input 
              type="email" 
              id="email" 
              name="email" 
              required 
              placeholder="Enter your email"
              value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
            >
            <i class="fas fa-envelope input-icon"></i>
          </div>
        </div>

        <div class="form-group">
          <label for="password">
            <i class="fas fa-lock"></i>
            Password
          </label>
          <div class="input-wrapper">
            <input 
              type="password" 
              id="password" 
              name="password" 
              required 
              placeholder="Enter your password"
            >
            <i class="fas fa-lock input-icon"></i>
          </div>
        </div>

        <div class="form-group">
          <label for="role">
            <i class="fas fa-user-tag"></i>
            Role
          </label>
          <div class="input-wrapper">
            <select id="role" name="role" required>
              <option value="">-- Select Role --</option>
              <option value="user" <%= "user".equals(request.getAttribute("role")) ? "selected" : "" %>>User</option>
              <option value="admin" <%= "admin".equals(request.getAttribute("role")) ? "selected" : "" %>>Admin</option>
            </select>
            <i class="fas fa-user-tag input-icon"></i>
          </div>
        </div>

        <button type="submit" class="submit-btn" id="submitBtn">
          <i class="fas fa-user-plus"></i>
          Create Account
        </button>
      </form>
    </div>

    <div class="form-footer">
      <p>Already have an account? <a href="<%=request.getContextPath()%>/jsp/login.jsp">
        <i class="fas fa-sign-in-alt"></i>
        Login here
      </a></p>
    </div>
  </div>
</div>

<script>
  document.getElementById('registerForm').addEventListener('submit', function(e) {
    const email = document.getElementById('email').value;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    
    if (!emailRegex.test(email)) {
      e.preventDefault();
      alert('Please enter a valid email address');
      return false;
    }
    
    const submitBtn = document.getElementById('submitBtn');
    submitBtn.style.opacity = '0.7';
    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Creating Account...';
  });

  document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('username').focus();
  });
</script>
</body>
</html>
