<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - Leave Management</title>
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
    position: relative;
    overflow: hidden;
    padding: 2rem 1rem;
  }

  body::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="dots" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="1.5" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23dots)"/></svg>');
    animation: float 20s ease-in-out infinite;
  }

  @keyframes float {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-10px); }
  }

  .login-container {
    position: relative;
    z-index: 1;
    animation: slideUp 0.8s ease-out;
  }

  @keyframes slideUp {
    from {
      opacity: 0;
      transform: translateY(30px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  .form-container {
    width: 380px;
    max-width: 100%;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    border-radius: 16px;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    border: 1px solid rgba(255, 255, 255, 0.2);
  }

  .form-header {
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.9) 0%, rgba(118, 75, 162, 0.9) 100%);
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

  .brand-section {
    text-align: center;
    margin-bottom: 1.2rem;
    padding: 1rem;
    background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
    border-radius: 10px;
  }

  .brand-title {
    font-size: 1.1rem;
    font-weight: 700;
    color: #1a202c;
    margin-bottom: 0.2rem;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.4rem;
  }

  .brand-subtitle {
    color: #64748b;
    font-size: 0.8rem;
    font-weight: 400;
  }

  .form-content {
    padding: 1.5rem;
  }

  .error-message, .success-message {
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

  .error-message {
    background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
    border: 1px solid #f87171;
    color: #dc2626;
  }

  .success-message {
    background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
    border: 1px solid #34d399;
    color: #065f46;
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
  input[type="password"] {
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

  input[type="text"]:focus,
  input[type="password"]:focus {
    outline: none;
    border-color: #667eea;
    background: white;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
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

  input:focus + .input-icon {
    color: #667eea;
  }

  input.error {
    border-color: #ef4444;
    background: #fef2f2;
  }

  .submit-btn {
    width: 100%;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
    font-family: inherit;
  }

  .submit-btn:hover {
    background: linear-gradient(135deg, #5a67d8 0%, #6b46c1 100%);
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(102, 126, 234, 0.4);
  }

  .forgot-password {
    text-align: center;
    margin-top: 1.2rem;
    padding-top: 1.2rem;
    border-top: 1px solid #e2e8f0;
  }

  .forgot-password a {
    color: #ef4444;
    text-decoration: none;
    font-size: 0.85rem;
    font-weight: 500;
    display: inline-flex;
    align-items: center;
    gap: 0.4rem;
    transition: all 0.3s ease;
  }

  .forgot-password a:hover {
    color: #dc2626;
    text-decoration: underline;
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
    margin-bottom: 0.4rem;
    font-weight: 400;
  }

  .form-footer a {
    color: #667eea;
    text-decoration: none;
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    gap: 0.4rem;
    transition: all 0.3s ease;
  }

  .form-footer a:hover {
    color: #5a67d8;
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
<div class="login-container">
  <div class="form-container">
    <div class="form-header">
      <h2>
        <i class="fas fa-sign-in-alt"></i>
        Welcome Back
      </h2>
      <p>Sign in to your account</p>
    </div>
    
    <div class="form-content">
      <div class="brand-section">
        <h3 class="brand-title">
          <i class="fas fa-calendar-check"></i>
          Leave Management
        </h3>
        <p class="brand-subtitle">Access your dashboard</p>
      </div>

      <!-- Display Error Message -->
      <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="error-message">
          <i class="fas fa-exclamation-triangle"></i>
          <%= request.getAttribute("errorMessage") %>
        </div>
      <% } %>

      <!-- Display Success Message -->
      <% if (request.getAttribute("successMessage") != null) { %>
        <div class="success-message">
          <i class="fas fa-check-circle"></i>
          <%= request.getAttribute("successMessage") %>
        </div>
      <% } %>

      <form action="<%=request.getContextPath()%>/LoginServlet" method="post" id="loginForm">
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
              class="<%= request.getAttribute("errorMessage") != null ? "error" : "" %>"
            >
            <i class="fas fa-user input-icon"></i>
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
              class="<%= request.getAttribute("errorMessage") != null ? "error" : "" %>"
            >
            <i class="fas fa-lock input-icon"></i>
          </div>
        </div>

        <button type="submit" class="submit-btn" id="submitBtn">
          <i class="fas fa-sign-in-alt"></i>
          Sign In
        </button>
      </form>

      <div class="forgot-password">
        <a href="<%=request.getContextPath()%>/jsp/forgot-password.jsp">
          <i class="fas fa-key"></i>
          Forgot your password?
        </a>
      </div>
    </div>

    <div class="form-footer">
      <p>Don't have an account?</p>
      <a href="<%=request.getContextPath()%>/jsp/register.jsp">
        <i class="fas fa-user-plus"></i>
        Register here
      </a>
    </div>
  </div>
</div>

<script>
  document.getElementById('loginForm').addEventListener('submit', function() {
    const submitBtn = document.getElementById('submitBtn');
    submitBtn.style.opacity = '0.7';
    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Signing In...';
  });

  const inputs = document.querySelectorAll('input');
  inputs.forEach(input => {
    input.addEventListener('focus', function() {
      this.classList.remove('error');
    });
  });

  document.addEventListener('DOMContentLoaded', function() {
    const usernameField = document.getElementById('username');
    const passwordField = document.getElementById('password');
    
    if (usernameField.value.trim() !== '') {
      passwordField.focus();
    } else {
      usernameField.focus();
    }
  });
</script>
</body>
</html>
