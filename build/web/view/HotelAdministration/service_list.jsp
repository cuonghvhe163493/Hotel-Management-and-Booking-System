<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Service Management</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        /* Style cho Modal Sửa */
        .modal { display: none; position: fixed; z-index: 100; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.4); }
        .modal-content { background-color: #fefefe; margin: 10% auto; padding: 25px; border: 1px solid #888; width: 400px; border-radius: 8px; }
        .close { color: #aaa; float: right; font-size: 28px; font-weight: bold; }
        .close:hover, .close:focus { color: black; text-decoration: none; cursor: pointer; }
        .btn-action { padding: 10px 15px; margin-top: 10px; cursor: pointer; border: none; border-radius: 4px; }
    </style>
</head>
<body>
    <h1>Quản lý Dịch vụ Khách sạn</h1>

    <c:if test="${param.success != null}">
        <p style="color: green;">✅ Thao tác **${param.success}** thành công!</p>
    </c:if>
    <c:if test="${param.error != null}">
        <p style="color: red;">❌ Lỗi: 
            <c:choose>
                <c:when test="${param.error == 'delete_fk'}">Lỗi Khóa Ngoại: Dịch vụ đang được sử dụng.</c:when>
                <c:when test="${param.error == 'db_create'}">Lỗi tạo dịch vụ: Dữ liệu bị trùng hoặc thiếu.</c:when>
                <c:otherwise>Lỗi hệ thống: ${param.error}</c:otherwise>
            </c:choose>
        </p>
    </c:if>

    <hr>
    
    <button onclick="openCreateModal()">➕ Tạo Dịch vụ Mới</button>
    
    <hr>
    
    <h2>Danh sách Dịch vụ</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Service Name</th>
                <th>Price</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty serviceList}">
                    <tr><td colspan="5">Chưa có dịch vụ nào được thêm vào hệ thống.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="s" items="${serviceList}">
                        <tr>
                            <td>${s.serviceId}</td>
                            <td>${s.serviceName}</td>
                            <td><fmt:formatNumber value="${s.price}" pattern="#,##0"/> VND</td>
                            <td>${s.description}</td>
                            <td>
                                <button onclick="openEditModal(
                                    ${s.serviceId}, 
                                    '${s.serviceName}', 
                                    '${s.description}', 
                                    ${s.price})">Sửa</button>
                                
                                <form method="POST" action="${pageContext.request.contextPath}/admin/services" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="serviceId" value="${s.serviceId}">
                                    <button type="submit" onclick="return confirm('Bạn có chắc chắn muốn xóa dịch vụ ${s.serviceName}?')">Xóa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
    
    <div id="createServiceModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeCreateModal()">&times;</span>
            <h2>Tạo Dịch vụ Mới</h2>
            <form id="newServiceForm" method="POST" action="${pageContext.request.contextPath}/admin/services">
                <input type="hidden" name="action" value="create">
                
                <label>Service Name:</label><br>
                <input type="text" name="name" required><br><br>
                
                <label>Description:</label><br>
                <textarea name="description" rows="3" required></textarea><br><br>
                
                <label>Price (Giá dịch vụ):</label><br>
                <input type="number" name="price" step="0.01" required><br><br>
                
                <button type="submit" class="btn-action" style="background-color: green; color: white;">➕ Thêm Dịch vụ</button>
            </form>
        </div>
    </div>

    <div id="editServiceModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeEditModal()">&times;</span>
            <h2>Sửa Dịch vụ</h2>
            <form id="editServiceForm" method="POST" action="${pageContext.request.contextPath}/admin/services">
                <input type="hidden" name="action" value="update">
                <input type="hidden" id="editServiceId" name="serviceId">
                
                <label>Service Name:</label><br>
                <input type="text" id="editName" name="name" required><br><br>
                
                <label>Description:</label><br>
                <textarea id="editDescription" name="description" rows="3" required></textarea><br><br>

                <label>Price:</label><br>
                <input type="number" id="editPrice" name="price" step="0.01" required><br><br>

                <button type="submit" class="btn-action" style="background-color: #3f51b5; color: white;">Lưu Thay Đổi</button>
            </form>
        </div>
    </div>
    
    <br><a href="${pageContext.request.contextPath}/admin-home">← Quay lại Dashboard</a>

    <script>
        var createModal = document.getElementById("createServiceModal");
        var editModal = document.getElementById("editServiceModal");

        // === LOGIC CREATE (Mở Modal) ===
        function openCreateModal() {
            document.getElementById("newServiceForm").reset(); 
            createModal.style.display = "block";
        }
        function closeCreateModal() {
            createModal.style.display = "none";
        }
        
        // === Logic Edit ===
        function openEditModal(serviceId, name, description, price) {
            document.getElementById("editServiceId").value = serviceId;
            document.getElementById("editName").value = name;
            document.getElementById("editDescription").value = description;
            document.getElementById("editPrice").value = price;
            
            editModal.style.display = "block";
        }

        function closeEditModal() {
            editModal.style.display = "none";
        }

        // Đóng modal khi click ra ngoài
        window.onclick = function(event) {
            if (event.target == createModal || event.target == editModal) {
                event.target.style.display = "none";
            }
        }
    </script>
</body>
</html>