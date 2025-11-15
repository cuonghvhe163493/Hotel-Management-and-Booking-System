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
        .modal { display: none; position: fixed; z-index: 100; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.4); }
        .modal-content { background-color: #fefefe; margin: 10% auto; padding: 25px; border: 1px solid #888; width: 400px; border-radius: 8px; }
        .close { color: #aaa; float: right; font-size: 28px; font-weight: bold; }
        .close:hover, .close:focus { color: black; text-decoration: none; cursor: pointer; }
        .btn-action { padding: 10px 15px; margin-top: 10px; cursor: pointer; border: none; border-radius: 4px; }
    </style>
</head>
<body>
    <h1>Hotel Service Management</h1>

    <c:if test="${param.success != null}">
        <p style="color: green;">✅ **${param.success}** operation successful!</p>
    </c:if>
    <c:if test="${param.error != null}">
        <p style="color: red;">❌ Error: 
            <c:choose>
                <c:when test="${param.error == 'delete_fk'}">Foreign Key Error: Service is currently in use.</c:when>
                <c:when test="${param.error == 'db_create'}">Service creation error: Duplicate or missing data.</c:when>
                <c:otherwise>System Error: ${param.error}</c:otherwise>
            </c:choose>
        </p>
    </c:if>

    <hr>
    
    <button onclick="openCreateModal()">➕ Create New Service</button>
    
    <hr>
    
    <h2>Service List</h2>
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
                    <tr><td colspan="5">No services have been added to the system yet.</td></tr>
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
                                    ${s.price})">Edit</button>
                                
                                <form method="POST" action="${pageContext.request.contextPath}/admin/services" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="serviceId" value="${s.serviceId}">
                                    <button type="submit" onclick="return confirm('Are you sure you want to delete the service ${s.serviceName}?')">Delete</button>
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
            <h2>Create New Service</h2>
            <form id="newServiceForm" method="POST" action="${pageContext.request.contextPath}/admin/services">
                <input type="hidden" name="action" value="create">
                
                <label>Service Name:</label><br>
                <input type="text" name="name" required><br><br>
                
                <label>Description:</label><br>
                <textarea name="description" rows="3" required></textarea><br><br>
                
                <label>Price:</label><br>
                <input type="number" name="price" step="0.01" required><br><br>
                
                <button type="submit" class="btn-action" style="background-color: green; color: white;">➕ Add Service</button>
            </form>
        </div>
    </div>

    <div id="editServiceModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeEditModal()">&times;</span>
            <h2>Edit Service</h2>
            <form id="editServiceForm" method="POST" action="${pageContext.request.contextPath}/admin/services">
                <input type="hidden" name="action" value="update">
                <input type="hidden" id="editServiceId" name="serviceId">
                
                <label>Service Name:</label><br>
                <input type="text" id="editName" name="name" required><br><br>
                
                <label>Description:</label><br>
                <textarea id="editDescription" name="description" rows="3" required></textarea><br><br>

                <label>Price:</label><br>
                <input type="number" id="editPrice" name="price" step="0.01" required><br><br>

                <button type="submit" class="btn-action" style="background-color: #3f51b5; color: white;">Save Changes</button>
            </form>
        </div>
    </div>
    
    <br><a href="${pageContext.request.contextPath}/admin-home">← Back to Dashboard</a>

    <script>
        var createModal = document.getElementById("createServiceModal");
        var editModal = document.getElementById("editServiceModal");

        function openCreateModal() {
            document.getElementById("newServiceForm").reset(); 
            createModal.style.display = "block";
        }
        function closeCreateModal() {
            createModal.style.display = "none";
        }
        
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

        window.onclick = function(event) {
            if (event.target == createModal || event.target == editModal) {
                event.target.style.display = "none";
            }
        }
    </script>
</body>
</html>