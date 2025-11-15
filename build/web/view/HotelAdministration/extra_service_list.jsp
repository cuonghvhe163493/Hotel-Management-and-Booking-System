<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Extra Service Management</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        
        .modal { display: none; position: fixed; z-index: 100; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.4); }
        .modal-content { background-color: #fefefe; margin: 10% auto; padding: 20px; border: 1px solid #888; width: 50%; max-width: 600px; border-radius: 8px; }
        .close { color: #aaa; float: right; font-size: 28px; font-weight: bold; }
        .close:hover, .close:focus { color: black; text-decoration: none; cursor: pointer; }
        .btn-action { padding: 10px 15px; margin-top: 10px; cursor: pointer; border: none; border-radius: 4px; }
    </style>
</head>
<body>
    <h1>Extra Services Management</h1>

    <c:if test="${param.success != null}">
        <p style="color: green;"> Operation **${param.success}** successful!</p>
    </c:if>
    <c:if test="${param.error != null}">
        <p style="color: red;"> Error: 
            <c:choose>
                <c:when test="${param.error == 'delete_fk'}">Foreign Key Error: Service is currently in use.</c:when>
                <c:when test="${param.error == 'format_number'}">Format Error: Reservation ID or Price must be a valid number.</c:when>
                <c:otherwise>System Error: ${param.error}</c:otherwise>
            </c:choose>
        </p>
    </c:if>

    <hr>

    <button onclick="openCreateModal()">➕ Add New Extra Service</button>

    <hr>

    <h2>Extra Service List</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Res. ID</th> 
                <th>Service Name</th>
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
                    <tr><td colspan="8">No extra services recorded yet.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="s" items="${extraServiceList}">
                        <tr>
                            <td>${s.extraServiceId}</td>
                            <td>${s.reservationId}</td> 
                            <td>${s.serviceName}</td>
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
                                    '${s.status}')">Edit</button>
                                
                                <form method="POST" action="${pageContext.request.contextPath}/admin/extra-services" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="serviceId" value="${s.extraServiceId}">
                                    <button type="submit" onclick="return confirm('Delete service ${s.extraServiceId}?')">Delete</button>
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
            <h2>Add New Extra Service</h2>
            <form id="newServiceForm"> 
                <label>Reservation ID:</label><br>
                <input type="number" id="newReservationId" required><br><br>
                
                <label>Service Name:</label><br>
                <input type="text" id="newName" required><br><br>
                
                <label>Description:</label><br>
                <textarea id="newDescription" rows="2" required></textarea><br><br>
                
                <label>Price:</label><br>
                <input type="number" id="newPrice" step="0.01" required><br><br>
                
                <label>Start Time:</label><br>
                <input type="datetime-local" id="newStartTime" required><br><br>
                
                <label>End Time:</label><br>
                <input type="datetime-local" id="newEndTime" required><br><br>

                <button type="button" class="btn-action" onclick="showConfirmModal()" style="background-color: #3f51b5; color: white;">Continue (Confirm)</button>
            </form>
        </div>
    </div>

    <div id="confirmCreateModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeConfirmModal()">&times;</span>
            <h2>Confirm Service Addition</h2>
            
            <p>Are you sure you want to add this new service to the system?</p>
            <div id="confirmDetails"></div>
            
            <form method="POST" action="${pageContext.request.contextPath}/admin/extra-services" style="margin-top: 20px;">
                <input type="hidden" name="action" value="create">
                
                <input type="hidden" id="finalReservationId" name="reservationId">
                <input type="hidden" id="finalName" name="name">
                <input type="hidden" id="finalDescription" name="description">
                <input type="hidden" id="finalPrice" name="price">
                <input type="hidden" id="finalStartTime" name="startTime">
                <input type="hidden" id="finalEndTime" name="endTime">
                
                <button type="button" onclick="closeConfirmModal()" class="btn-action" style="background-color: gray; color: white;">← Go Back</button>
                <button type="submit" class="btn-action" style="background-color: green; color: white;">Add New Service (Confirm)</button>
            </form>
        </div>
    </div>
    
    <div id="editServiceModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeEditModal()">&times;</span>
            <h2>Edit Extra Service</h2>
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
                
                <button type="submit" class="btn-action" style="background-color: #3f51b5; color: white;">Save Changes</button>
            </form>
        </div>
    </div>
    
    <br><a href="${pageContext.request.contextPath}/admin-home">← Back to Dashboard</a>

    <script>
        var createModal = document.getElementById("createServiceModal");
        var confirmModal = document.getElementById("confirmCreateModal");
        var editModal = document.getElementById("editServiceModal");

        function openCreateModal() {
            document.getElementById("newServiceForm").reset(); 
            createModal.style.display = "block";
        }
        function closeCreateModal() {
            createModal.style.display = "none";
        }

        function showConfirmModal() {
            const form = document.getElementById("newServiceForm");
            
            if (!form.checkValidity()) {
                form.reportValidity();
                return;
            }

            const resId = document.getElementById('newReservationId').value;
            const name = document.getElementById('newName').value;
            const description = document.getElementById('newDescription').value;
            const price = document.getElementById('newPrice').value;
            const startTime = document.getElementById('newStartTime').value;
            const endTime = document.getElementById('newEndTime').value;

            document.getElementById('finalReservationId').value = resId;
            document.getElementById('finalName').value = name;
            document.getElementById('finalDescription').value = description;
            document.getElementById('finalPrice').value = price;
            document.getElementById('finalStartTime').value = startTime;
            document.getElementById('finalEndTime').value = endTime;
            
            const formattedPrice = new Intl.NumberFormat('en-US', { style: 'currency', currency: 'VND' }).format(price);
            
            document.getElementById('confirmDetails').innerHTML = `
                <p>Reservation ID: <b>${resId}</b></p>
                <p>Service Name: <b>${name}</b></p>
                <p>Description: <b>${description}</b></p>
                <p>Price: <b>${formattedPrice}</b></p>
                <p>Time: ${startTime} to ${endTime}</p>
            `;

            closeCreateModal();
            confirmModal.style.display = "block";
        }

        function closeConfirmModal() {
            confirmModal.style.display = "none";
            openCreateModal(); 
        }
        
        function openEditModal(serviceId, reservationId, name, description, price, startTime, endTime, status) {
            document.getElementById("editServiceId").value = serviceId;
            document.getElementById("editReservationId").value = reservationId; 
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
            if (event.target == createModal || event.target == confirmModal || event.target == editModal) {
                event.target.style.display = "none";
            }
        }
        
        function filterRooms() {
             
        }
        
        document.addEventListener('DOMContentLoaded', filterRooms);
    </script>
</body>
</html>