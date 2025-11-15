<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<html>
<head>
    <title>Hotel Manager Dashboard</title>
    <style>
        /* BASE STYLES */
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f7f9; color: #333; margin: 0; padding: 20px; }
        .dashboard-container { max-width: 1400px; margin: 0 auto; }
        .header { display: flex; justify-content: space-between; align-items: center; }
        h1 { color: #1a237e; border-bottom: 2px solid #e0e0e0; padding-bottom: 10px; margin-bottom: 20px; display: inline-block; }
        
        /* HEADER/PROFILE ICON STYLES */
        .profile-menu { position: relative; cursor: pointer; }
        .profile-icon { width: 40px; height: 40px; border-radius: 50%; background-color: #bbdefb; color: #1a237e; font-size: 20px; font-weight: bold; display: flex; align-items: center; justify-content: center; border: 2px solid #1a237e; }
        .dropdown-content { display: none; position: absolute; right: 0; background-color: #fff; min-width: 200px; box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); z-index: 10; border-radius: 5px; overflow: hidden; top: 45px; }
        .dropdown-content a, .dropdown-content p { color: #333; padding: 12px 16px; text-decoration: none; display: block; font-size: 0.9em; margin: 0; }
        .dropdown-content a:hover { background-color: #f1f1f1; }
        .dropdown-content .info { border-bottom: 1px solid #eee; font-weight: bold; }
        .dropdown-content .info span { font-weight: normal; color: #555; display: block; font-size: 0.85em;}
        .show { display: block; }

        /* CARD STYLES */
        .card-grid { display: flex; gap: 20px; margin-bottom: 20px; flex-wrap: wrap; }
        .stat-card { flex: 1 1 200px; background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); transition: transform 0.2s; }
        .stat-card:hover { transform: translateY(-3px); }
        .stat-card h3 { margin-top: 0; font-size: 0.9em; color: #757575; }
        .stat-card .value { font-size: 2.5em; font-weight: 600; color: #1a237e; }
        .stat-card .detail { font-size: 0.85em; color: #616161; margin-top: 5px; }

        /* MÀU SẮC TRẠNG THÁI */
        .bg-room { background: linear-gradient(135deg, #e3f2fd, #bbdefb); } 
        .bg-staff { background: linear-gradient(135deg, #fce4ec, #f8bbd0); } 
        .bg-customer { background: linear-gradient(135deg, #e8f5e9, #c8e6c9); } 
        .bg-feedback { background: linear-gradient(135deg, #fff3e0, #ffe0b2); } 
        
        /* CHART/WIDGET STYLES */
        .widget-grid { display: grid; grid-template-columns: 2fr 1fr; gap: 20px; }
        .widget { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.05); }
        .widget h3 { color: #1a237e; border-bottom: 1px dashed #eee; padding-bottom: 10px; }
        .management-links { padding: 20px; background: #fff; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.05); }

        /* MÔ PHỎNG LINE/BAR CHART */
        .chart-area { height: 250px; position: relative; padding-bottom: 15px; }
        .chart-base { position: absolute; left: 0; bottom: 0; height: 100%; width: 100%; border-left: 1px solid #eee; border-bottom: 1px solid #eee; display: flex; align-items: flex-end; justify-content: space-around; }
        .trend-bar { width: 12%; margin: 0 1%; background-color: #3f51b5; border-radius: 4px 4px 0 0; transition: height 1s ease-out; opacity: 0.7; }
        .trend-point { position: absolute; width: 10px; height: 10px; border-radius: 50%; background: #ff9800; z-index: 5; margin-left: -5px; }
        .month-label { font-size: 0.85em; color: #555; text-align: center; }

    </style>
</head>
<body>
    <%-- Lấy thông tin User từ Session --%>
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
                    <a href="${pageContext.request.contextPath}/edit_profile">⚙️ Profile Người dùng</a>
                    <a href="${pageContext.request.contextPath}/logout">🚪 Đăng xuất</a>
                </div>
            </div>
            </div>
        
        <c:if test="${not empty errorMessage}">
            <p style="color: red;"><strong>Lỗi hệ thống:</strong> ${errorMessage}</p>
        </c:if>

        <div class="card-grid">
            
            <div class="stat-card bg-room">
                <h3>Phòng CÓ THỂ ĐẶT</h3>
                <div class="value" id="available-rooms">${availableRooms}</div>
                <div class="detail">Tổng số phòng: ${availableRooms + bookedRooms}</div>
            </div>
            
            <div class="stat-card bg-room">
                <h3>Phòng ĐÃ ĐẶT</h3>
                <div class="value" id="booked-rooms">${bookedRooms}</div>
                <div class="detail">Phòng đang cần phục vụ khách hàng.</div>
            </div>

            <div class="stat-card bg-feedback">
                <h3>Đánh giá Trung bình</h3>
                <div class="value" id="avg-rating">
                    <fmt:formatNumber value="${avgRating}" pattern="0.00"/>
                </div>
                <div class="detail">
                    <c:if test="${avgRating == 0}">(Chưa có đánh giá)</c:if>
                    <c:if test="${avgRating >= 4}">Chất lượng dịch vụ tuyệt vời.</c:if>
                </div>
            </div>

            <div class="stat-card bg-staff">
                <h3>Đội ngũ Lễ tân</h3>
                <div class="value" id="receptionist-count">${receptionistCount}</div>
                <div class="detail">Nhân viên sẵn sàng phục vụ.</div>
            </div>
            
            <div class="stat-card bg-customer">
                <h3>Cơ sở Khách hàng</h3>
                <div class="value" id="customer-count">${customerCount}</div>
                <div class="detail">Tổng số tài khoản khách hàng.</div>
            </div>
            
        </div>
        
        <div class="widget-grid">
            
            <div class="widget">
                <h3>Xu hướng Hiệu suất & Chất lượng (6 tháng)</h3>
                
                <div class="chart-area">
                    <div class="chart-base">
                        <div class="trend-bar" style="height: 60%;"></div>
                        <div class="trend-bar" style="height: 75%;"></div>
                        <div class="trend-bar" style="height: 70%;"></div>
                        <div class="trend-bar" style="height: 85%;"></div>
                        <div class="trend-bar" style="height: 65%;"></div>
                        <div class="trend-bar" style="height: 78%;"></div>
                        
                        <div class="trend-point" style="top: 70%; left: 15%;"></div>
                        <div class="trend-point" style="top: 60%; left: 30%;"></div>
                        <div class="trend-point" style="top: 75%; left: 45%;"></div>
                        <div class="trend-point" style="top: 68%; left: 60%;"></div>
                        <div class="trend-point" style="top: 62%; left: 75%;"></div>
                        <div class="trend-point" style="top: 72%; left: 90%;"></div>
                    </div>
                </div>
                
                <div style="display: flex; justify-content: space-around; margin-top: 10px; font-size: 0.85em;">
                    <span>Th.5</span>
                    <span>Th.6</span>
                    <span>Th.7</span>
                    <span>Th.8</span>
                    <span>Th.9</span>
                    <span>Th.10</span>
                </div>
                
                <p style="margin-top: 15px; font-size: 0.9em;">
                    <span style="color: #3f51b5;">■ Tỷ lệ Lấp đầy (%)</span> | 
                    <span style="color: #ff9800;">● Điểm Đánh giá (1-5)</span>
                </p>
            </div>

            <div class="management-links">
                <h3>Quản Lý Hệ Thống</h3>
                <p><a href="${pageContext.request.contextPath}/admin/rooms">🛠️ Quản lý Phòng Khách sạn (CRUD)</a></p>
                <p><a href="${pageContext.request.contextPath}/admin/customer-status">👤 Thay đổi Trạng thái Khách hàng</a></p>
                <p><a href="${pageContext.request.contextPath}/admin/vouchers">🎟️ Quản lý Mã Giảm Giá (Voucher)</a></p>
                <p><a href="${pageContext.request.contextPath}/admin/services">⚙️ Quản lý Dịch vụ (Services)</a></p>
                <p><a href="${pageContext.request.contextPath}/admin/extra-services">🍴 Quản lý Dịch vụ Thêm (Extra Services)</a></p>
                <p><a href="${pageContext.request.contextPath}/admin/receptionists">💼 Quản lý Tài khoản Lễ tân</a></p>
            </div>
            
        </div>
    </div>

    <script>
        // === LOGIC DROPDOWN ===
        function toggleDropdown() {
            document.getElementById("userDropdown").classList.toggle("show");
        }
        
        // Đóng dropdown nếu click ra ngoài
        window.onclick = function(event) {
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