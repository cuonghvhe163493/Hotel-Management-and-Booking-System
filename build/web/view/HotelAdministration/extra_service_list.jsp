<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Extra Service Management</title>
    <style>
        /* BASE CSS */
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        
        /* MODAL STYLES */
        .modal { display: none; position: fixed; z-index: 100; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.4); }
        .modal-content { background-color: #fefefe; margin: 10% auto; padding: 20px; border: 1px solid #888; width: 50%; max-width: 600px; border-radius: 8px; }
        .close { color: #aaa; float: right; font-size: 28px; font-weight: bold; }
        .close:hover, .close:focus { color: black; text-decoration: none; cursor: pointer; }
        .btn-action { padding: 10px 15px; margin-top: 10px; cursor: pointer; border: none; border-radius: 4px; }
    </style>
</head>
<body>
    <h1>Quản lý Dịch vụ Thêm (Extra Services)</h1>

    <c:if test="${param.success != null}">
        <p style="color: green;">✅ Thao tác **${param.success}** thành công!</p>
    </c:if>
    <c:if test="${param.error != null}">
        <p style="color: red;">❌ Lỗi: 
            <c:choose>
                <c:when test="${param.error == 'delete_fk'}">Lỗi Khóa Ngoại: Dịch vụ đang được sử dụng.</c:when>
                <c:when test="${param.error == 'format_number'}">Lỗi định dạng: Reservation ID hoặc Giá phải là số hợp lệ.</c:when>
                <c:otherwise>Lỗi hệ thống: ${param.error}</c:otherwise>
            </c:choose>
        </p>
    </c:if>

    <hr>

    <h2>Thêm Dịch vụ Thêm Mới</h2>
    <form method="POST" action="${pageContext.request.contextPath}/admin/extra-services" style="max-width: 600px;">
        <input type="hidden" name="action" value="create">
        
        <label>Reservation ID (Mã đặt chỗ liên quan):</label><br>
        <input type="number" name="reservationId" required><br><br> <label>Service Name:</label><br>
        <input type="text" name="name" required><br><br>
        
        <label>Description:</label><br>
        <textarea name="description" rows="2" required></textarea><br><br>
        
        <label>Price (Giá dịch vụ):</label><br>
        <input type="number" name="price" step="0.01" required><br><br>
        
        <label>Start Time (Thời gian bắt đầu):</label><br>
        <input type="datetime-local" name="startTime" required><br><br>
        
        <label>End Time (Thời gian kết thúc):</label><br>
        <input type="datetime-local" name="endTime" required><br><br>

        <button type="submit">➕ Thêm Dịch vụ</button>
    </form>
    
    <hr>

    <h2>Danh sách Dịch vụ Thêm</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Res. ID</th> <th>Service Name</th>
                <th>Description</th> 
                <th>Price</th>
                <th>Time Range</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty extraServiceList}">
                    <tr><td colspan="8">Chưa có dịch vụ thêm nào được ghi nhận.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="s" items="${extraServiceList}">
                        <tr>
                            <td>${s.extraServiceId}</td>
                            <td>${s.reservationId}</td> <td>${s.serviceName}</td>
                            <td>${s.serviceDescription}</td> 
                            <td><fmt:formatNumber value="${s.servicePrice}" pattern="#,##0"/> VND</td>
                            <td>
                                <fmt:formatDate value="${s.serviceStartTime}" pattern="HH:mm dd/MM"/> - 
                                <fmt:formatDate value="${s.serviceEndTime}" pattern="HH:mm dd/MM"/>
                            </td>
                            <td>${s.status}</td>
                            <td>
                                <button onclick="openEditModal(
                                    ${s.extraServiceId}, 
                                    ${s.reservationId},
                                    '${s.serviceName}', 
                                    '${s.serviceDescription}', 
                                    ${s.servicePrice}, 
                                    '<fmt:formatDate value="${s.serviceStartTime}" pattern="yyyy-MM-dd'T'HH:mm"/>',
                                    '<fmt:formatDate value="${s.serviceEndTime}" pattern="yyyy-MM-dd'T'HH:mm"/>',
                                    '${s.status}')">Sửa</button>
                                
                                <form method="POST" action="${pageContext.request.contextPath}/admin/extra-services" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="serviceId" value="${s.extraServiceId}">
                                    <button type="submit" onclick="return confirm('Xóa dịch vụ ${s.extraServiceId}?')">Xóa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
    
    <div id="editServiceModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeEditModal()">&times;</span>
            <h2>Sửa Dịch vụ Thêm</h2>
            <form id="editServiceForm" method="POST" action="${pageContext.request.contextPath}/admin/extra-services">
                <input type="hidden" name="action" value="update">
                <input type="hidden" id="editServiceId" name="serviceId">
                
                <label>Reservation ID:</label><br>
                <input type="number" id="editReservationId" name="reservationId" required><br><br>
                
                <label>Service Name:</label><br>
                <input type="text" id="editName" name="name" required><br><br>
                
                <label>Description:</label><br>
                <textarea id="editDescription" name="description" rows="2" required></textarea><br><br>
                
                <label>Price:</label><br>
                <input type="number" id="editPrice" name="price" step="0.01" required><br><br>

                <label>Start Time:</label><br>
                <input type="datetime-local" id="editStartTime" name="startTime" required><br><br>
                
                <label>End Time:</label><br>
                <input type="datetime-local" id="editEndTime" name="endTime" required><br><br>
                
                <label>Status:</label><br>
                <select id="editStatus" name="status" required>
                    <option value="pending">Pending</option>
                    <option value="in_progress">In Progress</option>
                    <option value="completed">Completed</option>
                    <option value="cancelled">Cancelled</option>
                </select><br><br>
                
                <button type="submit" class="btn-action" style="background-color: #3f51b5; color: white;">Lưu Thay Đổi</button>
            </form>
        </div>
    </div>
    
    <br><a href="${pageContext.request.contextPath}/admin-home">← Quay lại Dashboard</a>

    <script>
        var editModal = document.getElementById("editServiceModal");

        function openEditModal(serviceId, reservationId, name, description, price, startTime, endTime, status) {
            document.getElementById("editServiceId").value = serviceId;
            document.getElementById("editReservationId").value = reservationId; // SỬA: Đổ giá trị Res ID vào input number
            document.getElementById("editName").value = name;
            document.getElementById("editDescription").value = description;
            document.getElementById("editPrice").value = price;
            document.getElementById("editStartTime").value = startTime;
            document.getElementById("editEndTime").value = endTime;
            document.getElementById("editStatus").value = status;
            
            editModal.style.display = "block";
        }

        function closeEditModal() {
            editModal.style.display = "none";
        }

        window.onclick = function(event) {
            if (event.target == editModal) {
                editModal.style.display = "none";
            }
        }
    </script>
</body>
</html>