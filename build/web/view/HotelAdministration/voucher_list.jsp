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
        
        .modal { display: none; position: fixed; z-index: 100; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.4); }
        .modal-content { background-color: #fefefe; margin: 10% auto; padding: 20px; border: 1px solid #888; width: 450px; border-radius: 8px; }
        .close { color: #aaa; float: right; font-size: 28px; font-weight: bold; }
        .close:hover, .close:focus { color: black; text-decoration: none; cursor: pointer; }
        .btn-action { padding: 10px 15px; margin-top: 10px; cursor: pointer; border: none; border-radius: 4px; }
    </style>
</head>
<body>
    <h1>Voucher Management</h1>

    <c:if test="${param.success != null}">
        <p style="color: green;">Success!</p>
    </c:if>
    <c:if test="${param.error != null}">
        <p style="color: red;">Error!</p>
    </c:if>

    <hr>
    
    <button onclick="openCreateModal()">Create New Voucher</button>
    
    <hr>
    
    <h2>Voucher List</h2>
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
                    <tr><td colspan="7">No Vouchers Available.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="v" items="${voucherList}">
                        <c:set var="isExpired" value="${v.endDate.time < (System.currentTimeMillis() - 86400000)}"/>
                        <c:set var="statusText" value="${isExpired ? 'Expired' : 'Active'}"/>
                        
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
                                    '${v.description}')">Edit</button>
                                
                                <form method="POST" action="${pageContext.request.contextPath}/admin/vouchers/action" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="voucherId" value="${v.voucherId}">
                                    <button type="submit" onclick="return confirm('Are you sure you want to delete voucher ${v.code}?')">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
    
    <div id="createVoucherModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeCreateModal()">&times;</span>
            <h2>Create New Voucher</h2>
            <form id="newVoucherForm" method="POST" action="${pageContext.request.contextPath}/admin/vouchers/action">
                <input type="hidden" name="action" value="create">
                
                <label>1. Voucher Code:</label><br>
                <input type="text" name="code" required><br><br>
                
                <label>2. Discount Value:</label><br>
                <input type="number" id="createDiscountValue" name="discountValue" step="0.01" required><br><br>

                <label>3. Expiry Date:</label><br>
                <input type="date" name="endDate" required><br><br>
                
                <label>4. Description:</label><br>
                <textarea name="description" rows="3" required></textarea><br><br>
                
                <button type="submit" class="btn-action" style="background-color: green; color: white;">➕ Create Voucher</button>
            </form>
        </div>
    </div>
    
    <div id="editVoucherModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeEditModal()">&times;</span>
            <h2>Update Voucher</h2>
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
                
                <button type="submit" class="btn-action" style="background-color: #3f51b5; color: white;">Update</button>
            </form>
        </div>
    </div>
    
    <br><a href="${pageContext.request.contextPath}/admin-home">← Back to Dashboard</a>

    <script>
        var createModal = document.getElementById("createVoucherModal");
        var editModal = document.getElementById("editVoucherModal");

        function openCreateModal() {
            document.getElementById("newVoucherForm").reset(); 
            createModal.style.display = "block";
        }
        function closeCreateModal() {
            createModal.style.display = "none";
        }

        function openEditModal(voucherId, code, discountValue, endDate, description) {
            document.getElementById("editVoucherId").value = voucherId;
            document.getElementById("editCode").value = code;
            document.getElementById("editDiscountValue").value = discountValue;
            document.getElementById("editEndDate").value = endDate; 
            document.getElementById("editDescription").value = description;
            
            editModal.style.display = "block";
        }

        function closeEditModal() {
            editModal.style.display = "none";
        }

        window.onclick = function(event) {
            if (event.target == createModal || event.target == editModal) {
                event.target.style.display = "none";
            }
        }
    </script>
</body>
</html>