<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<html>
    <head>
        <title>Hotel Manager Dashboard</title>
        <style>
            /* BASE STYLES */
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f7f9;
                color: #333;
                margin: 0;
                padding: 20px;
            }
            .dashboard-container {
                max-width: 1400px;
                margin: 0 auto;
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            h1 {
                color: #1a237e;
                border-bottom: 2px solid #e0e0e0;
                padding-bottom: 10px;
                margin-bottom: 20px;
                display: inline-block;
            }

            /* HEADER/PROFILE ICON STYLES */
            .profile-menu {
                position: relative;
                cursor: pointer;
            }
            .profile-icon {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: #bbdefb;
                color: #1a237e;
                font-size: 20px;
                font-weight: bold;
                display: flex;
                align-items: center;
                justify-content: center;
                border: 2px solid #1a237e;
            }
            .dropdown-content {
                display: none;
                position: absolute;
                right: 0;
                background-color: #fff;
                min-width: 200px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 10;
                border-radius: 5px;
                overflow: hidden;
                top: 45px;
            }
            .dropdown-content a, .dropdown-content p {
                color: #333;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
                font-size: 0.9em;
                margin: 0;
            }
            .dropdown-content a:hover {
                background-color: #f1f1f1;
            }
            .dropdown-content .info {
                border-bottom: 1px solid #eee;
                font-weight: bold;
            }
            .dropdown-content .info span {
                font-weight: normal;
                color: #555;
                display: block;
                font-size: 0.85em;
            }
            .show {
                display: block;
            }

            /* CARD STYLES */
            .card-grid {
                display: flex;
                gap: 20px;
                margin-bottom: 20px;
                flex-wrap: wrap;
            }
            .stat-card {
                flex: 1 1 200px;
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                transition: transform 0.2s;
            }
            .stat-card h3 {
                margin-top: 0;
                font-size: 0.9em;
                color: #757575;
            }
            .stat-card .value {
                font-size: 2.5em;
                font-weight: 600;
                color: #1a237e;
            }
            .stat-card .detail {
                font-size: 0.85em;
                color: #616161;
                margin-top: 5px;
            }

            /* STATUS COLORS */
            .bg-room {
                background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            }
            .bg-staff {
                background: linear-gradient(135deg, #fce4ec, #f8bbd0);
            }
            .bg-customer {
                background: linear-gradient(135deg, #e8f5e9, #c8e6c9);
            }
            .bg-feedback {
                background: linear-gradient(135deg, #fff3e0, #ffe0b2);
            }

            /* CHART/WIDGET STYLES */
            .widget-grid {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 20px;
            }
            .widget {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            }
            .widget h3 {
                color: #1a237e;
                border-bottom: 1px dashed #eee;
                padding-bottom: 10px;
            }
            .management-links {
                padding: 20px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            }

            .trend-bar-horizontal {
                height: 15px;
                border-radius: 4px;
                margin-bottom: 10px;
                transition: width 1s ease-out;
            }

        </style>
    </head>
    <body>
        <c:set var="username" value="${sessionScope.user}" />
        <c:set var="userRole" value="${sessionScope.role}" />

        <div class="dashboard-container">

            <div class="header">
                <h1>Admin Dashboard</h1>

                <div class="profile-menu" onclick="toggleDropdown()">
                    <div class="profile-icon">
                        <c:out value="${fn:toUpperCase(fn:substring(username, 0, 1))}" /> 
                    </div>
                    <div id="userDropdown" class="dropdown-content">
                        <p class="info">${username}<span>(${userRole})</span></p>
                        <a href="${pageContext.request.contextPath}/edit_profile">️ User Profile</a>
                        <a href="${pageContext.request.contextPath}/logout"> Logout</a>
                    </div>
                </div>
            </div>

            <c:if test="${not empty errorMessage}">
                <p style="color: red;"><strong>System Error:</strong> ${errorMessage}</p>
            </c:if>

            <div class="card-grid">

                <div class="stat-card bg-room">
                    <h3>Available Rooms</h3>
                    <div class="value" id="available-rooms">${availableRooms}</div>
                    <div class="detail">Total rooms: ${availableRooms + bookedRooms}</div>
                </div>

                <div class="stat-card bg-room">
                    <h3>Booked Rooms</h3>
                    <div class="value" id="booked-rooms">${bookedRooms}</div>
                    <div class="detail">Rooms currently serving customers.</div>
                </div>

                <div class="stat-card bg-feedback">
                    <h3>Average Rating</h3>
                    <div class="value" id="avg-rating">
                        <fmt:formatNumber value="${avgRating}" pattern="0.00"/>
                    </div>
                    <div class="detail">
                        <c:if test="${avgRating == 0}">(No ratings yet)</c:if>
                        <c:if test="${avgRating >= 4}">Excellent service quality.</c:if>
                        </div>
                    </div>

                    <div class="stat-card bg-staff">
                        <h3>Receptionist Staff</h3>
                        <div class="value" id="receptionist-count">${receptionistCount}</div>
                    <div class="detail">Staff ready to serve.</div>
                </div>

                <div class="stat-card bg-customer">
                    <h3>Customer Base</h3>
                    <div class="value" id="customer-count">${customerCount}</div>
                    <div class="detail">Total number of customer accounts.</div>
                </div>

            </div>

            <div class="widget-grid">

                <div class="widget">
                    <h3>Occupancy and Inventory Analysis by Room Type</h3>

                    <div style="padding-top: 10px;">
                        <c:set var="colorString" value="#3f51b5,#ff9800,#721c24,#009688,#E91E63"/>
                        <c:set var="chartColor" value="${fn:split(colorString, ',')}"/>
                        <c:set var="colorIndex" value="${0}"/>

                        <c:forEach var="entry" items="${occupancyByType}">
                            <c:set var="type" value="${entry.key}"/>
                            <c:set var="dataMap" value="${entry.value}"/>
                            <c:set var="total" value="${dataMap.Total}"/>
                            <c:set var="occupied" value="${dataMap.Occupied}"/>

                            <c:set var="rate" value="${(occupied / total) * 100}"/>
                            <c:set var="color" value="${chartColor[colorIndex]}"/>

                            <p style="margin-bottom: 5px;">${type} (<fmt:formatNumber value="${rate}" pattern="0"/>% Occupancy)</p>
                            <div class="trend-bar-horizontal" style="background-color: ${color}; width: ${rate}%;"></div>
                            <div style="font-size: 0.75em; color: #757575;">
                                <span style="color: ${color};">Occupied: ${occupied}</span> / Total: ${total}
                            </div>

                            <c:set var="colorIndex" value="${colorIndex + 1}"/>
                        </c:forEach>

                    </div>

                   
                </div>

                <div class="management-links">
                    <h3>System Management</h3>
                    <p><a href="${pageContext.request.contextPath}/admin/rooms">️ ⚙ ️Manage Hotel Rooms </a></p>
                    <p><a href="${pageContext.request.contextPath}/admin/customer-status">👥 Change Customer Status</a></p>
                    <p><a href="${pageContext.request.contextPath}/admin/vouchers">️ ⚙ ️Manage Vouchers</a></p>
                    <p><a href="${pageContext.request.contextPath}/admin/services">️ ⚙ ️Manage Services</a></p>
                    <p><a href="${pageContext.request.contextPath}/admin/extra-services">⚙ ️Manage Extra Services</a></p>
                    <p><a href="${pageContext.request.contextPath}/admin/receptionists"> ⚙️ Manage Receptionist Accounts</a></p>
                </div>

            </div>
        </div>

        <script>
            function toggleDropdown() {
                document.getElementById("userDropdown").classList.toggle("show");
            }

            window.onclick = function (event) {
                if (!event.target.closest('.profile-menu')) {
                    var dropdowns = document.getElementsByClassName("dropdown-content");
                    for (var i = 0; i < dropdowns.length; i++) {
                        var openDropdown = dropdowns[i];
                        if (openDropdown.classList.contains('show')) {
                            openDropdown.classList.remove('show');
                        }
                    }
                }
            }
        </script>
    </body>
</html>