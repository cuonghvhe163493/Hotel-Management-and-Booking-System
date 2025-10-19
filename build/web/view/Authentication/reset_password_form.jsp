<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% 
    // Lấy username từ Query Parameter (URL)
    String username = request.getParameter("username");
    if (username == null || username.isEmpty()) {
        // Nếu không có username (người dùng chưa xác thực), chuyển hướng lại
        response.sendRedirect(request.getContextPath() + "/view/Authentication/forgot_password.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Set New Password</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/view/Authentication/css/style.css">
</head>
<body>
<div class="login-container">
    <div class="login-card">
        <div class="login-header">
            <div class="logo-icon">🔑</div>
            <h2>Set New Password</h2>
            <p>Account verified. Set new password for user: <strong><%= username %></strong></p>
        </div>

        <form action="<%=request.getContextPath()%>/reset-password" method="post">
            
            <input type="hidden" name="username_final" value="<%= username %>">

            <div class="form-group">
                <div class="input-wrapper">
                    <input type="password" id="newPassword" name="newPassword" required>
                    <label for="newPassword">New Password</label>
                    <span class="input-line"></span>
                </div>
            </div>

            <div class="form-group">
                <div class="input-wrapper">
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                    <label for="confirmPassword">Confirm New Password</label>
                    <span class="input-line"></span>
                </div>
            </div>

            <button type="submit" class="login-btn btn">Change Password</button>
        </form>

        <% // Xử lý lỗi từ bước reset
           String error = request.getParameter("error");
           if (error != null) { %>
            <div style="color: #ff0080; text-align:center; margin-top: 15px;">
                <% if ("mismatch".equals(error)) { %>
                    ❌ Mật khẩu mới và xác nhận mật khẩu không khớp.
                <% } else if ("db_fail".equals(error)) { %>
                    ❌ Lỗi hệ thống: Không thể cập nhật mật khẩu. Vui lòng thử lại.
                <% } %>
            </div>
        <% } %>
    </div>
</div>
</body>
</html>