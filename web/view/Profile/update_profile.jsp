<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Profile</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/view/Profile/css/update_profile.css">
</head>
<body>
<div class="update-container">
    <h2>Update Profile</h2>

    <form action="<%=request.getContextPath()%>/update-profile" method="post">
        <div class="form-group">
            <input type="text" name="username" value="<%=session.getAttribute("user")%>" placeholder="Username" required>
        </div>
        <div class="form-group">
            <input type="email" name="email" placeholder="Email" required>
        </div>
        <div class="form-group">
            <input type="text" name="phone" placeholder="Phone" required>
        </div>
        <div class="form-group">
            <input type="text" name="address" placeholder="Address">
        </div>
        <div class="form-group">
            <input type="password" name="password" placeholder="New Password" required>
        </div>
        <div class="form-group">
            <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
        </div>
        <button type="submit">Save Changes</button>

        <% if ("success".equals(request.getParameter("msg"))) { %>
            <div class="message">✅ Profile updated successfully!</div>
        <% } else if ("error".equals(request.getParameter("msg"))) { %>
            <div class="message error">❌ Failed to update profile!</div>
        <% } %>
    </form>
</div>
</body>
</html>
