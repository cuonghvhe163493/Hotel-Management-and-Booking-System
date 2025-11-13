<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Receptionist Management</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        .modal { display: none; position: fixed; z-index: 100; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.4); }
        .modal-content { background-color: #fefefe; margin: 5% auto; padding: 20px; border: 1px solid #888; width: 50%; }
        .close { color: #aaa; float: right; font-size: 28px; font-weight: bold; }
        .close:hover, .close:focus { color: black; text-decoration: none; cursor: pointer; }
    </style>
</head>
<body>
    <h1>Quản lý Tài khoản Lễ tân</h1>

    <c:if test="${param.success != null}">
        <p style="color: green;">✅ Thao tác **${param.success}** thành công!</p>
    </c:if>
    <c:if test="${param.error != null}">
        <p style="color: red;">❌ Lỗi: 
            <c:choose>
                <c:when test="${param.error == 'delete_fk'}">Lỗi Khóa Ngoại: Không thể xóa tài khoản vì nó có liên kết dữ liệu khác.</c:when>
                <c:otherwise>${param.error}</c:otherwise>
            </c:choose>
        </p>
    </c:if>

    <hr>
   
    
    <hr>
    
    <h2>Danh sách Lễ tân (${receptionistList.size()} người)</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Address</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty receptionistList}">
                    <tr><td colspan="7">Chưa có tài khoản lễ tân nào.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="r" items="${receptionistList}">
                        <tr>
                            <td>${r.userId}</td>
                            <td>${r.username}</td>
                            <td>${r.email}</td>
                            <td>${r.phone}</td>
                            <td>${r.address}</td>
                            
                            <td>
                                <form method="POST" action="${pageContext.request.contextPath}/admin/receptionists" style="display: inline;">
                                    <input type="hidden" name="action" value="update_status">
                                    <input type="hidden" name="userId" value="${r.userId}">
                                    <select name="newStatus" onchange="this.form.submit()">
                                        <option value="active" ${r.accountStatus == 'active' ? 'selected' : ''}>Active</option>
                                        <option value="suspended" ${r.accountStatus == 'suspended' ? 'selected' : ''}>Suspended</option>
                                        <option value="banned" ${r.accountStatus == 'banned' ? 'selected' : ''}>Banned</option>
                                    </select>
                                </form>
                            </td>
                            <td>
                                <button onclick="openEditModal(
                                    ${r.userId}, 
                                    '${r.username}', 
                                    '${r.email}', 
                                    '${r.phone}', 
                                    '${r.address}')">Sửa</button>
                                
                                <form method="POST" action="${pageContext.request.contextPath}/admin/receptionists" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="userId" value="${r.userId}">
                                    <button type="submit" onclick="return confirm('Bạn có chắc chắn muốn xóa tài khoản ${r.username}?')">Xóa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
    
    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeEditModal()">&times;</span>
            <h2>Sửa Thông tin Lễ tân</h2>
            <form id="editForm" method="POST" action="${pageContext.request.contextPath}/admin/receptionists">
                <input type="hidden" name="action" value="update">
                <input type="hidden" id="editUserId" name="userId">
                
                <label>Username:</label><br>
                <input type="text" id="editUsername" name="username" required><br><br>
                
                <label>Email:</label><br>
                <input type="email" id="editEmail" name="email" required><br><br>
                
                <label>Phone:</label><br>
                <input type="tel" id="editPhone" name="phone" required><br><br>
                
                <label>Address:</label><br>
                <textarea id="editAddress" name="address" rows="2" required></textarea><br><br>
                
                <label>Password (Để trống nếu không đổi):</label><br>
                <input type="password" id="editPassword" name="password" value="UNCHANGED" required><br><br> 

                <button type="submit">Lưu Thay Đổi</button>
            </form>
        </div>
    </div>
    
    <br><a href="${pageContext.request.contextPath}/admin-home">← Quay lại Dashboard</a>

    <script>
        var modal = document.getElementById("editModal");

        function openEditModal(userId, username, email, phone, address) {
            document.getElementById("editUserId").value = userId;
            document.getElementById("editUsername").value = username;
            document.getElementById("editEmail").value = email;
            document.getElementById("editPhone").value = phone;
            document.getElementById("editAddress").value = address;
            // Đặt password mặc định là giá trị giả để Controller biết không cần thay đổi
            document.getElementById("editPassword").value = "UNCHANGED"; 
            
            modal.style.display = "block";
        }

        function closeEditModal() {
            modal.style.display = "none";
        }

        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
</body>
</html>