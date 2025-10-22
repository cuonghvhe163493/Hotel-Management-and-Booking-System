<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
    <h1>Admin Dashboard</h1>

    <h3>Số lượng Receptionist: ${receptionistCount != null ? receptionistCount : "Không có dữ liệu"}</h3>
    <h3>Số lượng Customer: ${customerCount != null ? customerCount : "Không có dữ liệu"}</h3>
    <h3>Phòng còn trống: ${availableRooms != null ? availableRooms : "Không có dữ liệu"}</h3>
    <h3>Phòng đã đặt: ${bookedRooms != null ? bookedRooms : "Không có dữ liệu"}</h3>
    <h3>Điểm đánh giá trung bình: ${avgRating != null ? avgRating : "Không có dữ liệu"}</h3>

    <a href="edit_profile">Chỉnh sửa hồ sơ</a>
</body>
</html>