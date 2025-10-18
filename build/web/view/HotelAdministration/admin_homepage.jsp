<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
</head>
<body>
    <h1>Welcome, <%= session.getAttribute("user") %> (Admin)</h1>
    <a href="viewBookings.jsp">View Bookings</a><br>
    <a href="manageRooms.jsp">Manage Rooms</a><br>
    <a href="manageVouchers.jsp">Manage Vouchers</a><br>
    <a href="viewReports.jsp">View Reports</a><br>
    <br>
    <a href="logout.jsp">Logout</a>
</body>
</html>
