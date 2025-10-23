<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Room Management</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        
        /* CSS cho màu trạng thái (ĐÃ ĐẢO NGƯỢC LOGIC) */
        .status-cell { font-weight: bold; padding: 5px 10px; border-radius: 4px; text-align: center; }
        
        /* 🟢 OCCUPIED (Đã đặt) => XANH LÁ */
        .status-occupied { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; } 
        
        /* 🟡 AVAILABLE (Còn trống) => VÀNG */
        .status-available { background-color: #fff3cd; color: #856404; border: 1px solid #ffeeba; } 
        
        /* 🔴 MAINTENANCE (Bảo trì/Hỏng) => ĐỎ */
        .status-maintenance { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; } 
        
        /* Style cho Modal Sửa (Giữ nguyên) */
        .modal { display: none; position: fixed; z-index: 1; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.4); }
        .modal-content { background-color: #fefefe; margin: 15% auto; padding: 20px; border: 1px solid #888; width: 80%; }
        .close { color: #aaa; float: right; font-size: 28px; font-weight: bold; }
        .close:hover, .close:focus { color: black; text-decoration: none; cursor: pointer; }
    </style>
</head>
<body>
    <h1>Quản lý Phòng Khách sạn</h1>

    <c:if test="${param.success != null}">
        <p style="color: green;">✅ Thao tác **${param.success}** thành công!</p>
    </c:if>
    <c:if test="${param.error != null}">
        <p style="color: red;">❌ Lỗi: Không thể thực hiện thao tác. 
            <c:choose>
                <c:when test="${param.error == 'db_create'}">Lỗi cơ sở dữ liệu khi tạo phòng (Có thể trùng Room Number).</c:when>
                <c:when test="${param.error == 'delete_fk'}">Lỗi Khóa Ngoại: Phòng đang có đặt chỗ hoặc lịch sử đặt chỗ. Không thể xóa.</c:when>
                <c:otherwise>Lỗi không xác định: ${param.error}</c:otherwise>
            </c:choose>
        </p>
    </c:if>
    
    <div style="margin-bottom: 20px;">
        <h2>Lọc Theo Trạng thái</h2>
        <select id="statusFilter" onchange="filterRooms()">
            <option value="all">Tất cả Phòng</option>
            <option value="occupied">🟢 Đã đặt/Có khách (Xanh lá)</option>
            <option value="available">🟡 Có thể sử dụng (Vàng)</option>
            <option value="maintenance">🔴 Bảo trì/Hỏng (Đỏ)</option>
        </select>
    </div>

    <hr>
    
    <h2>Thêm Phòng Mới</h2>
    <form method="POST" action="${pageContext.request.contextPath}/admin/rooms/action">
        <input type="hidden" name="action" value="create">
        
        <label>Room Number:</label><br>
        <input type="text" name="roomNumber" required><br><br>
        
        <label>Room Type (Ví dụ: Standard, Deluxe, Suite):</label><br>
        <input type="text" name="roomType" required><br><br>

        <label>Capacity (Sức chứa):</label><br>
        <input type="number" name="capacity" min="1" required><br><br>
        
        <label>Price Per Night (Giá/đêm):</label><br>
        <input type="number" name="price" step="0.01" required><br><br>
        
        <button type="submit">➕ Tạo Phòng (Create button)</button>
    </form>
    
    <hr>
    
    <h2>Danh sách Phòng</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Room Number</th>
                <th>Room Type (Desc)</th>
                <th>Price/Night</th>
                <th>Capacity</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody id="roomTableBody">
            <c:choose>
                <c:when test="${empty roomList}">
                    <tr><td colspan="7">Chưa có phòng nào được thêm vào hệ thống.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="room" items="${roomList}">
                        <tr class="room-row" data-status="${room.roomStatus}">
                            <td>${room.roomId}</td>
                            <td>${room.roomNumber}</td>
                            <td>${room.roomType}</td>
                            <td><fmt:formatNumber value="${room.pricePerNight}" pattern="#,##0.00"/></td>
                            <td>${room.capacity}</td>
                            <td>
                                <c:set var="statusClass" value=""/>
                                <c:choose>
                                    <c:when test="${room.roomStatus == 'available'}">
                                        <c:set var="statusClass" value="status-available"/>
                                    </c:when>
                                    <c:when test="${room.roomStatus == 'occupied'}">
                                        <c:set var="statusClass" value="status-occupied"/>
                                    </c:when>
                                    <c:when test="${room.roomStatus == 'maintenance'}">
                                        <c:set var="statusClass" value="status-maintenance"/>
                                    </c:when>
                                </c:choose>
                                <div class="status-cell ${statusClass}">
                                    ${room.roomStatus}
                                </div>
                            </td>
                            <td>
                                <button onclick="openEditModal(${room.roomId}, 
                                                               '${room.roomNumber}', 
                                                               '${room.roomType}', 
                                                               ${room.pricePerNight}, 
                                                               ${room.capacity}, 
                                                               '${room.roomStatus}')">Sửa</button>
                                
                                <form method="POST" action="${pageContext.request.contextPath}/admin/rooms/action" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="roomId" value="${room.roomId}">
                                    <button type="submit" onclick="return confirm('Bạn có chắc chắn muốn xóa phòng ${room.roomNumber}?')">Xóa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
    
    <div id="editRoomModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeEditModal()">&times;</span>
            <h2>Sửa Thông Tin Phòng</h2>
            <form id="editRoomForm" method="POST" action="${pageContext.request.contextPath}/admin/rooms/action">
                <input type="hidden" name="action" value="update">
                <input type="hidden" id="editRoomId" name="roomId">
                
                <label>Room Number:</label><br>
                <input type="text" id="editRoomNumber" name="roomNumber" required><br><br>
                
                <label>Room Type (Description):</label><br>
                <input type="text" id="editRoomType" name="roomType" required><br><br>
                
                <label>Capacity (Sức chứa):</label><br>
                <input type="number" id="editCapacity" name="capacity" min="1" required><br><br>
                
                <label>Price Per Night (Giá/đêm):</label><br>
                <input type="number" id="editPrice" name="price" step="0.01" required><br><br>

                <label>Status:</label><br>
                <select id="editStatus" name="roomStatus" required>
                    <option value="available">available</option>
                    <option value="occupied">occupied</option>
                    <option value="maintenance">maintenance</option>
                </select><br><br>
                
                <button type="submit">Lưu Thay Đổi</button>
            </form>
        </div>
    </div>
    
    <br><a href="${pageContext.request.contextPath}/admin-home">← Quay lại Dashboard</a>

    <script>
        // === Logic Modal (Giữ nguyên) ===
        var modal = document.getElementById("editRoomModal");
        var span = document.getElementsByClassName("close")[0];

        function openEditModal(roomId, roomNumber, roomType, price, capacity, status) {
            document.getElementById("editRoomId").value = roomId;
            document.getElementById("editRoomNumber").value = roomNumber;
            document.getElementById("editRoomType").value = roomType;
            document.getElementById("editCapacity").value = capacity;
            document.getElementById("editPrice").value = price;
            document.getElementById("editStatus").value = status;
            
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
        
        // === Logic Filter (Cập nhật) ===
        function filterRooms() {
            const filterValue = document.getElementById('statusFilter').value;
            const rows = document.querySelectorAll('.room-row');

            rows.forEach(row => {
                const status = row.getAttribute('data-status');
                
                if (filterValue === 'all') {
                    row.style.display = ''; 
                } else if (status === filterValue) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none'; 
                }
            });
        }
        
        document.addEventListener('DOMContentLoaded', filterRooms);
    </script>
</body>
</html>