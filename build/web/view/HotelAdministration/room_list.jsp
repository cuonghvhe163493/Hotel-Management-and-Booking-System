<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <title>Room Management</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }

            .status-cell {
                font-weight: bold;
                padding: 5px 10px;
                border-radius: 4px;
                text-align: center;
            }
            .status-occupied {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            } 
            .status-available {
                background-color: #fff3cd;
                color: #856404;
                border: 1px solid #ffeeba;
            } 
            .status-maintenance {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            } 

            .modal {
                display: none;
                position: fixed;
                z-index: 100;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0,0,0,0.4);
            }
            .modal-content {
                background-color: #fefefe;
                margin: 10% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 400px;
                border-radius: 8px;
            }
            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }
            .close:hover, .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }
            .btn-action {
                padding: 10px 15px;
                margin-top: 10px;
                cursor: pointer;
                border: none;
                border-radius: 4px;
            }
            .btn-action:hover {
                opacity: 0.9;
            }
        </style>
    </head>
    <body>
        <h1>Hotel Room Management</h1>

        <c:if test="${param.success != null}">
            <p style="color: green;">✅ Operation **${param.success}** successful!</p>
        </c:if>
        <c:if test="${param.error != null}">
            <p style="color: red;"> Error: Could not complete operation. 
                <c:choose>
                    <c:when test="${param.error == 'db_create'}">Database error during room creation (Room Number might be duplicate).</c:when>
                    <c:when test="${param.error == 'delete_fk'}">Foreign Key Error: Room has existing bookings or history. Cannot delete.</c:when>
                    <c:otherwise>Unknown error: ${param.error}</c:otherwise>
                </c:choose>
            </p>
        </c:if>

        <button onclick="openCreateModal()"> Add New Room</button>

        <div style="margin-bottom: 20px;">
            <h2>Filter By Status</h2>
            <select id="statusFilter" onchange="filterRooms()">
                <option value="all">All Rooms</option>
                <option value="occupied"> Occupied </option>
                <option value="available">Available </option>
                <option value="maintenance"> Maintenance </option>
            </select>
        </div>

        <hr>

        <h2>Room List</h2>
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
                        <tr><td colspan="7">No rooms have been added to the system yet.</td></tr>
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
                                                                    '${room.roomStatus}')">Edit</button>

                                    <form method="POST" action="${pageContext.request.contextPath}/admin/rooms/action" style="display: inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="roomId" value="${room.roomId}">
                                        <button type="submit" onclick="return confirm('Are you sure you want to delete room ${room.roomNumber}?')">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <div id="createRoomModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeCreateModal()">&times;</span>
                <h2>Add New Room</h2>
                <form id="newRoomForm"> 
                    <label>Room Number:</label><br>
                    <input type="text" id="newRoomNumber" required><br><br>

                    <label>Room Type:</label><br>
                    <input type="text" id="newRoomType" required><br><br>

                    <label>Capacity:</label><br>
                    <input type="number" id="newCapacity" min="1" required><br><br>

                    <label>Price Per Night:</label><br>
                    <input type="number" id="newPrice" step="0.01" required><br><br>

                    <button type="button" class="btn-action" onclick="showConfirmModal()">Continue (Confirm)</button>
                </form>
            </div>
        </div>

        <div id="confirmCreateModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeConfirmModal()">&times;</span>
                <h2>Confirm Room Addition</h2>

                <p>Are you sure you want to add this new room to the system?</p>

                <form method="POST" action="${pageContext.request.contextPath}/admin/rooms/action" style="margin-top: 20px;">
                    <input type="hidden" name="action" value="create">

                    <input type="hidden" id="finalRoomNumber" name="roomNumber">
                    <input type="hidden" id="finalRoomType" name="roomType">
                    <input type="hidden" id="finalCapacity" name="capacity">
                    <input type="hidden" id="finalPrice" name="price">

                    <button type="button" onclick="closeConfirmModal()" class="btn-action" style="background-color: gray; color: white;">← Go Back</button>
                    <button type="submit" class="btn-action" style="background-color: green; color: white;">Add New Room (Confirm)</button>
                </form>
            </div>
        </div>

        <div id="editRoomModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeEditModal()">&times;</span>
                <h2>Edit Room Information</h2>
                <form id="editRoomForm" method="POST" action="${pageContext.request.contextPath}/admin/rooms/action">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" id="editRoomId" name="roomId">

                    <label>Room Number:</label><br>
                    <input type="text" id="editRoomNumber" name="roomNumber" required><br><br>

                    <label>Room Type (Description):</label><br>
                    <input type="text" id="editRoomType" name="roomType" required><br><br>

                    <label>Capacity:</label><br>
                    <input type="number" id="editCapacity" name="capacity" min="1" required><br><br>

                    <label>Price Per Night:</label><br>
                    <input type="number" id="editPrice" name="price" step="0.01" required><br><br>

                    <label>Status:</label><br>
                    <select id="editStatus" name="roomStatus" required>
                        <option value="available">available</option>
                        <option value="occupied">occupied</option>
                        <option value="maintenance">maintenance</option>
                    </select><br><br>

                    <button type="submit" class="btn-action" style="background-color: #3f51b5; color: white;">Save Changes</button>
                </form>
            </div>
        </div>

        <br><a href="${pageContext.request.contextPath}/admin-home">← Back to Dashboard</a>

        <script>
            var createModal = document.getElementById("createRoomModal");
            var confirmModal = document.getElementById("confirmCreateModal");
            var editModal = document.getElementById("editRoomModal");

            function openCreateModal() {
                createModal.style.display = "block";
                document.getElementById("newRoomForm").reset();
            }
            function closeCreateModal() {
                createModal.style.display = "none";
            }

            function showConfirmModal() {
                const form = document.getElementById("newRoomForm");

                if (!form.checkValidity()) {
                    form.reportValidity();
                    return;
                }

                const num = document.getElementById('newRoomNumber').value;
                const type = document.getElementById('newRoomType').value;
                const capacity = document.getElementById('newCapacity').value;
                const price = document.getElementById('newPrice').value;

                document.getElementById('finalRoomNumber').value = num;
                document.getElementById('finalRoomType').value = type;
                document.getElementById('finalCapacity').value = capacity;
                document.getElementById('finalPrice').value = price;

                closeCreateModal();
                confirmModal.style.display = "block";
            }

            function closeConfirmModal() {
                confirmModal.style.display = "none";
            }

            function openEditModal(roomId, roomNumber, roomType, price, capacity, status) {
                document.getElementById("editRoomId").value = roomId;
                document.getElementById("editRoomNumber").value = roomNumber;
                document.getElementById("editRoomType").value = roomType;
                document.getElementById("editCapacity").value = capacity;
                document.getElementById("editPrice").value = price;
                document.getElementById("editStatus").value = status;

                editModal.style.display = "block";
            }

            function closeEditModal() {
                editModal.style.display = "none";
            }

            window.onclick = function (event) {
                if (event.target == createModal || event.target == confirmModal || event.target == editModal) {
                    event.target.style.display = "none";
                }
            }

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