<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="userProfile" scope="request" type="model.User" />
<html>
<head>
    <title>Update Profile</title>
    </head>
<body>
    <div style="max-width: 600px; margin: 50px auto; padding: 20px; border: 1px solid #ccc;">
        <h1>Cập nhật Hồ sơ Người dùng</h1>
        
        <c:if test="${param.success == 'update'}">
            <p style="color: green;">✅ Hồ sơ đã được cập nhật thành công!</p>
        </c:if>
        <c:if test="${param.error != null}">
            <p style="color: red;">❌ Lỗi: Cập nhật thất bại. Vui lòng thử lại.</p>
        </c:if>
        
        <form method="POST" action="${pageContext.request.contextPath}/edit_profile">
            
            <p><strong>User ID:</strong> ${userProfile.userId}</p>
            <p><strong>Role:</strong> ${userProfile.role}</p>

            <label for="name">Name (Username):</label><br>
            <input type="text" id="name" name="name" value="${userProfile.username}" required><br><br>

            <label for="phone">Phone:</label><br>
            <input type="tel" id="phone" name="phone" value="${userProfile.phone}" required><br><br>

            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email" value="${userProfile.email}" required><br><br>
            
            <label for="password">Password (Để trống nếu không đổi):</label><br>
            <input type="password" id="password" name="password" value="••••••" required><br><br> 
            
            <button type="submit">Lưu Thay Đổi</button>
            
        </form>
        
        <br><a href="${pageContext.request.contextPath}/admin-home">← Quay lại Dashboard</a>
    </div>
    
    </body>
</html>