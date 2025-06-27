<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password - Leave Management</title>
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
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="waves" width="100" height="20" patternUnits="userSpaceOnUse"><path d="M0 10 Q25 0 50 10 T100 10 V20 H0 Z" fill="white" opacity="0.05"/></pattern></defs><rect width="100" height="100" fill="url(%23waves)"/></svg>');
  }

  .forgot-container {
    position: relative;
    z-index: 1;
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
    background: linear-gradient(135deg, rgba(139, 69, 19, 0.9) 0%, rgba(160, 82, 45, 0.9) 100%);
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
    white-space: pre-line;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.4rem;
  }

  .info-section {
    background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
    border: 1px solid #7dd3fc;
    border-radius: 10px;
    padding: 1rem;
    margin-bottom: 1.2rem;
    text-align: center;
  }

  .info-section h4 {
    color: #0c4a6e;
    font-size: 0.95rem;
    font-weight: 600;
    margin-bottom: 0.6rem;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.4rem;
  }

  .info-section p {
    color: #075985;
    font-size: 0.85rem;
    line-height: 1.5;
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

  input[type="email"] {
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

  input[type="email"]:focus {
    outline: none;
    border-color: #8b4513;
    background: white;
    box-shadow: 0 0 0 3px rgba(139, 69, 19, 0.1);
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
    color: #8b4513;
  }

  input.error {
    border-color: #ef4444;
    background: #fef2f2;
  }

  .submit-btn {
    width: 100%;
    background: linear-gradient(135deg, #8b4513 0%, #a0522d 100%);
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
    box-shadow: 0 4px 12px rgba(139, 69, 19, 0.3);
    font-family: inherit;
  }

  .submit-btn:hover {
    background: linear-gradient(135deg, #a0522d 0%, #8b4513 100%);
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(139, 69, 19, 0.4);
  }

  .back-to-login {
    text-align: center;
    margin-top: 1.2rem;
    padding-top: 1.2rem;
    border-top: 1px solid #e2e8f0;
  }

  .back-to-login a {
    color: #667eea;
    text-decoration: none;
    font-size: 0.85rem;
    font-weight: 500;
    display: inline-flex;
    align-items: center;
    gap: 0.4rem;
    transition: all 0.3s ease;
  }

  .back-to-login a:hover {
    color: #5a67d8;
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
    font-size: 0.8rem;
    margin-bottom: 0.6rem;
    font-weight: 400;
  }

  .register-link a {
    color: #8b4513;
    text-decoration: none;
    font-weight: 600;
    font-size: 0.85rem;
    display: inline-flex;
    align-items: center;
    gap: 0.4rem;
    transition: all 0.3s ease;
  }

  .register-link a:hover {
    color: #a0522d;
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
<div class="forgot-container">
  <div class="form-container">
    <div class="form-header">
      <h2>
        <i class="fas fa-key"></i>
        Forgot Password
      </h2>
      <p>Reset your account password</p>
    </div>
    
    <div class="form-content">
      <!-- Display Error Message -->
      <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="error-message">
          <i class="fas fa-exclamation-triangle"></i>
          <%= request.getAttribute("errorMessage") %>
        </div>
      <% } else { %>
        <div class="info-section">
          <h4>
            <i class="fas fa-envelope"></i>
            Password Reset
          </h4>
          <p>Enter your email address and we'll send you a link to reset your password.</p>
        </div>
      <% } %>

      <form action="<%=request.getContextPath()%>/ForgotPasswordServlet" method="post" id="forgotForm">
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
              placeholder="Enter your registered email"
              value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
              class="<%= request.getAttribute("errorMessage") != null ? "error" : "" %>"
            >
            <i class="fas fa-envelope input-icon"></i>
          </div>
        </div>

        <button type="submit" class="submit-btn" id="submitBtn">
          <i class="fas fa-paper-plane"></i>
          Send Reset Link
        </button>
      </form>

      <div class="back-to-login">
        <a href="<%=request.getContextPath()%>/jsp/login.jsp">
          <i class="fas fa-arrow-left"></i>
          Back to Login
        </a>
      </div>
    </div>

    <div class="form-footer">
      <p><i class="fas fa-shield-alt"></i> We'll never share your email with anyone else.</p>
      <div class="register-link">
        <p>Don't have an account? <a href="<%=request.getContextPath()%>/jsp/register.jsp">
          <i class="fas fa-user-plus"></i>
          Register here
        </a></p>
      </div>
    </div>
  </div>
</div>

<script>
  document.getElementById('forgotForm').addEventListener('submit', function() {
    const submitBtn = document.getElementById('submitBtn');
    submitBtn.style.opacity = '0.7';
    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Sending Email...';
  });

  document.getElementById('email').addEventListener('focus', function() {
    this.classList.remove('error');
  });

  document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('email').focus();
  });
</script>
</body>
</html>
