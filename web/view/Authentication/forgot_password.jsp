<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/view/Authentication/css/style.css">
</head>
<body>
<div class="login-container">
    <div class="login-card">
        <div class="login-header">
            <div class="logo-icon">🔒</div>
            <h2>Forgot Password</h2>
            <p>Enter credentials to verify your account</p>
        </div>

        <form action="<%=request.getContextPath()%>/forgot-password-auth" method="post">
            
            <div class="form-group">
                <div class="input-wrapper">
                    <input type="text" id="username" name="username" required>
                    <label for="username">Username</label>
                    <span class="input-line"></span>
                </div>
            </div>

            <div class="form-group">
                <div class="input-wrapper">
                    <input type="email" id="email" name="email" required>
                    <label for="email">Registered Email</label>
                    <span class="input-line"></span>
                </div>
            </div>

            <div class="form-group">
                <div class="input-wrapper">
                    <input type="tel" id="phone" name="phone" required>
                    <label for="phone">Registered Phone Number</label>
                    <span class="input-line"></span>
                </div>
            </div>

            <button type="submit" class="login-btn btn">Verify and Continue</button>
        </form>

        <% // Hiển thị lỗi từ bước xác thực
           if (request.getParameter("error") != null) { %>
            <div style="color: #ff0080; text-align:center; margin-top: 15px;">
                ❌ Thông tin Username, Email, hoặc Phone không chính xác. Vui lòng kiểm tra lại.
            </div>
        <% } %>
        
        <div class="auth-options" style="justify-content: center; margin-top: 20px;">
            <a href="<%=request.getContextPath()%>/login" style="color: #00ff88;">Back to Login</a>
        </div>
        
    </div>
</div>
</body>
</html>