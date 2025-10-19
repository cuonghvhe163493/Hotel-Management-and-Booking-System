<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Create Account - Hotel Management</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/view/Authentication/css/style.css">
  <style>
    body {
      background: #0a0a0f;
      color: white;
      font-family: 'Inter', sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .register-card {
      background: #151520;
      border-radius: 16px;
      padding: 40px;
      width: 400px;
      box-shadow: 0 0 40px rgba(0, 255, 136, 0.3);
    }
    .register-card h2 {
      text-align: center;
      margin-bottom: 20px;
    }
    .form-group {
      margin-bottom: 15px;
    }
    label {
      display: block;
      color: #00ff88;
      font-size: 14px;
      margin-bottom: 5px;
    }
    input {
      width: 100%;
      padding: 10px;
      border: 1px solid #2a2a35;
      border-radius: 6px;
      background: #1a1a25;
      color: white;
    }
    input:focus {
      outline: none;
      border-color: #00ff88;
      box-shadow: 0 0 6px rgba(0, 255, 136, 0.3);
    }
    .submit-btn {
      width: 100%;
      background: linear-gradient(135deg, #00ff88, #0099ff);
      border: none;
      padding: 12px;
      border-radius: 6px;
      color: #0a0a0f;
      font-weight: bold;
      cursor: pointer;
      margin-top: 10px;
      transition: 0.3s;
    }
    .submit-btn:hover {
      box-shadow: 0 0 15px rgba(0, 255, 136, 0.5);
    }
    .error {
      color: #ff4d6d;
      font-size: 13px;
      margin-top: 5px;
    }
  </style>
</head>

<body>
  <div class="register-card">
    <h2>Sign Up</h2>
    <form id="registerForm" action="<%=request.getContextPath()%>/register" method="post" novalidate>
      
      <div class="form-group">
        <label>Username</label>
        <input type="text" name="username" required>
        <div class="error" id="usernameError"></div>
      </div>

      <div class="form-group">
        <label>Email</label>
        <input type="email" name="email" required>
        <div class="error" id="emailError"></div>
      </div>

      <div class="form-group">
        <label>Phone</label>
        <input type="text" name="phone" required>
        <div class="error" id="phoneError"></div>
      </div>

      <div class="form-group">
        <label>Address</label>
        <input type="text" name="address" required>
        <div class="error" id="addressError"></div>
      </div>

      <div class="form-group">
        <label>Date of Birth</label>
        <input type="date" name="dob" required>
      </div>

      <div class="form-group">
        <label>Password</label>
        <input type="password" name="password" required>
        <div class="error" id="passwordError"></div>
      </div>

      <div class="form-group">
        <label>Confirm Password</label>
        <input type="password" name="confirmPassword" required>
        <div class="error" id="confirmError"></div>
      </div>

      <button type="submit" class="submit-btn">Create Account</button>
    </form>

    <% if (request.getParameter("error") != null) { %>
      <p style="color:#ff4d6d;text-align:center;margin-top:10px;">Registration failed or email already exists!</p>
    <% } else if (request.getParameter("success") != null) { %>
      <p style="color:#00ff88;text-align:center;margin-top:10px;">Registration successful! Login now.</p>
    <% } %>
  </div>

  <script>
    document.getElementById("registerForm").addEventListener("submit", function (e) {
      let valid = true;
      let form = e.target;

      const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/;
      const phonePattern = /^[0-9]{9,12}$/;
      const pass = form.password.value.trim();
      const confirm = form.confirmPassword.value.trim();

      document.querySelectorAll(".error").forEach(el => el.textContent = "");

      if (form.username.value.trim().length < 4) {
        document.getElementById("usernameError").textContent = "Username must be at least 4 characters.";
        valid = false;
      }
      if (!emailPattern.test(form.email.value)) {
        document.getElementById("emailError").textContent = "Invalid email format.";
        valid = false;
      }
      if (!phonePattern.test(form.phone.value)) {
        document.getElementById("phoneError").textContent = "Phone must be 9–12 digits.";
        valid = false;
      }
      if (pass.length < 6) {
        document.getElementById("passwordError").textContent = "Password must be at least 6 characters.";
        valid = false;
      }
      if (pass !== confirm) {
        document.getElementById("confirmError").textContent = "Passwords do not match.";
        valid = false;
      }

      if (!valid) e.preventDefault();
    });
  </script>
</body>
</html>
