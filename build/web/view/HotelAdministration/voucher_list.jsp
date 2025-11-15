<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Voucher Management</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h1>Quản lý Mã Giảm Giá (Voucher)</h1>

    <c:if test="${param.success != null}">
        <p style="color: green;"> Thao tác ${param.success}** thành công!</p>
    </c:if>
    <c:if test="${param.error != null}">
        <p style="color: red;"> Lỗi: Không thể thực hiện thao tác. (Chi tiết: ${param.error})</p>
    </c:if>

    <hr>
    
    <h2>Tạo Voucher Mới</h2>
    <form method="POST" action="${pageContext.request.contextPath}/admin/vouchers/action" style="max-width: 500px;">
        <input type="hidden" name="action" value="create">
        
        <label>1. Voucher Code:</label><br>
        <input type="text" name="code" required><br><br>
        
        <label>2. Discount Value :</label><br>
        <input type="number" name="discountValue" step="0.01" required><br><br>

        <label>3. Expiry Date</label><br>
        <input type="date" name="endDate" required><br><br>
        
        <label>4. Description:</label><br>
        <textarea name="description" rows="3" required></textarea><br><br>
        
        <button type="submit"> Tạo Voucher (Create button)</button>
    </form>
    
    <hr>
    
    <h2>Danh sách Voucher</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Code</th>
                <th>Description</th>
                <th>Discount Value</th>
                <th>Expiry Date</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty voucherList}">
                    <tr><td colspan="7">Chưa có voucher nào.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="v" items="${voucherList}">
                        <c:set var="isExpired" value="${v.endDate.time < (System.currentTimeMillis() - 86400000)}"/>
                        <c:set var="statusText" value="${isExpired ? 'Đã hết hạn' : 'Đang hoạt động'}"/>
                        
                        <tr>
                            <td>${v.voucherId}</td>
                            <td>${v.code}</td>
                            <td>${v.description}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${v.discountType == 'percentage'}">
                                        <fmt:formatNumber value="${v.discountValue * 100}" pattern="0.##"/>%
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatNumber value="${v.discountValue}" pattern="#,##0"/> VND
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value="${v.endDate}" pattern="yyyy-MM-dd"/></td>
                            <td style="color: ${isExpired ? 'red' : 'green'}; font-weight: bold;">${statusText}</td>
                            <td>
                                <button onclick="openEditModal(
                                    ${v.voucherId}, 
                                    '${v.code}', 
                                    ${v.discountValue}, 
                                    '<fmt:formatDate value="${v.endDate}" pattern="yyyy-MM-dd"/>', 
                                    '${v.description}')">Sửa</button>
                                
                                <form method="POST" action="${pageContext.request.contextPath}/admin/vouchers/action" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="voucherId" value="${v.voucherId}">
                                    <button type="submit" onclick="return confirm('Bạn có chắc chắn muốn xóa voucher ${v.code}?')">Xóa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
    
    <div id="editVoucherModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeEditModal()">&times;</span>
        <h2>Cập nhật Voucher</h2>
        
        <form id="editVoucherForm" method="POST" action="${pageContext.request.contextPath}/admin/vouchers/action">
            <input type="hidden" name="action" value="update">
            <input type="hidden" id="editVoucherId" name="voucherId">
            
            <label>1. Voucher Code:</label><br>
            <input type="text" id="editCode" name="code" required><br><br>
            
            <label>2. Discount Value:</label><br>
            <input type="number" id="editDiscountValue" name="discountValue" step="0.01" required><br><br>

            <label>3. Expiry Date:</label><br>
            <input type="date" id="editEndDate" name="endDate" required><br><br>
            
            <label>4. Description:</label><br>
            <textarea id="editDescription" name="description" rows="3" required></textarea><br><br>
            
            <button type="submit">Cập nhật (Update button)</button>
        </form>
    </div>
</div>
    
    <br><a href="${pageContext.request.contextPath}/admin-home">← Quay lại Dashboard</a>

    <script>
        var modal = document.getElementById("editVoucherModal");
        var span = document.getElementsByClassName("close")[0];

        function openEditModal(voucherId, code, discountValue, endDate, description) {
            document.getElementById("editVoucherId").value = voucherId;
            document.getElementById("editCode").value = code;
            document.getElementById("editDiscountValue").value = discountValue;
            document.getElementById("editDescription").value = description;
            
            modal.style.display = "block";
        }

        function closeEditModal() {
            modal.style.display = "none";
        }

        // Đóng modal khi click ra ngoài
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
</body>
</html>