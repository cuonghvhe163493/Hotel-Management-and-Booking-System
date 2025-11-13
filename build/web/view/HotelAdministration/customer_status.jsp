<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Change Customer Status</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        /* 🟢 SỬA CSS MÀU SẮC */
        .status-active { color: green; font-weight: bold; }
        .status-suspended, .status-pending { color: #856404; font-weight: bold; background-color: #fff3cd; padding: 2px 5px; border-radius: 3px; } /* MÀU VÀNG */
        .status-banned { color: red; font-weight: bold; background-color: #f8d7da; padding: 2px 5px; border-radius: 3px; } /* MÀU ĐỎ */
    </style>
</head>
<body>
    <h1>Quản lý Trạng thái Khách hàng</h1>
    
    <c:if test="${param.success == 'update'}">
        <p style="color: green;">✅ Cập nhật trạng thái thành công!</p>
    </c:if>
    <c:if test="${param.error != null}">
        <p style="color: red;">❌ Lỗi: Không thể thực hiện thao tác.</p>
    </c:if>

    <hr>

    <h2>Danh sách Khách hàng (${customerList.size()} người)</h2>
    
    <c:choose>
        <c:when test="${empty customerList}">
            <p>Không có khách hàng nào trong hệ thống.</p>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Trạng thái Hiện tại</th>
                        <th>Hành động (Thay đổi Status)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="customer" items="${customerList}">
                        <tr>
                            <td>${customer.userId}</td>
                            <td>${customer.username}</td>
                            <td>${customer.email}</td>
                            <td>${customer.phone}</td>
                            <td>
                                <span class="status-${customer.accountStatus}">
                                    ${customer.accountStatus}
                                </span>
                            </td>
                            <td>
                                <form method="POST" action="${pageContext.request.contextPath}/admin/customer-status" style="display: flex; gap: 10px; align-items: center;">
                                    
                                    <input type="hidden" name="customerID" value="${customer.userId}">
                                    
                                    <select name="status" required>
                                        <option value="active" ${customer.accountStatus == 'active' ? 'selected' : ''}>Active</option>
                                        <option value="suspended" ${customer.accountStatus == 'suspended' ? 'selected' : ''}>Suspended (Vàng)</option>
                                        <option value="banned" ${customer.accountStatus == 'banned' ? 'selected' : ''}>Banned (Đỏ)</option>
                                        </select>
                                    
                                    <button type="submit">Lưu</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>

    <br><a href="${pageContext.request.contextPath}/admin-home">← Quay lại Dashboard</a>
</body>
</html>