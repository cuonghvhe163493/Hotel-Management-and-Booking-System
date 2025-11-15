<%-- 
    Document   : newjsp
    Created on : Oct 18, 2025, 3:46:58 AM
    Author     : Hoang Viet Cuong
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Stay Room</title>
        <link href="${pageContext.request.contextPath}/view/Staymanagement/css/bootstrap.min.css" rel="stylesheet" >
        <link href="${pageContext.request.contextPath}/view/Staymanagement/css/font-awesome.min.css" rel="stylesheet" >
        <link href="${pageContext.request.contextPath}/view/Staymanagement/css/global.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/view/Staymanagement/css/stay.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@500&display=swap" rel="stylesheet">
        <script src="js/bootstrap.bundle.min.js"></script>
    </head>

    <body>

        <jsp:include page="/view/common/header.jsp" />
        <div class="table-func-box">
            <div class="stay-room-list-container">
                <h3>Stay Room</h3>
                <!--            list stay room-->
                <table class="list-table">
                    <thead>
                        <tr>
                            <th>Room Id</th>
                            <th>Booking Id</th>
                            <th>Number Room</th>

                            <th>Type</th>
                            <th>Check-in Date</th>
                            <th>Check-out Date</th>
                            <th>Details</th>
                        </tr>
                    </thead>
                    <tbody >
                        <c:forEach var="room" items="${stayroom}">
                            <tr>
                                <td>${room.roomId}</td>
                                <td>${room.bookingId}</td>
                                <td>${room.roomNumber}</td>

                                <td>${room.roomType}</td>
                                <td>${room.checkInDate}</td>
                                <td>${room.checkOutDate}</td>   

                                <td><a class="dropdown-item" href="${pageContext.request.contextPath}/details?roomId=${room.roomId}&bookingId=${room.bookingId}"> Details</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>


            <div class="func-chat-container">
                <!--function for use-->
                <div class="func-container">
                    <h4 class="word-stay-functions">Stay Functions</h4>

                    <div class="func-box">
                        <a href="CheckOut.jsp"><input type="button" value="SERVICES ROOM" class="func-btn" /></a>
                        <a href="CheckOut.jsp"><input type="button" value="CHAT BOX" class="func-btn" /></a>
                    </div> 

                    <div class="func-box">
                        <div>
                            <a href="${pageContext.request.contextPath}/CheckInServletForCustomer?mode=0&id=${sessionScope.customerId}"><input type="button" value="CHECK-IN" class="func-btn" /></a>
                        </div>
                        <div>
                            <a href="${pageContext.request.contextPath}/CheckOutServletForCustomer?mode=0&id=${sessionScope.customerId}"><input type="button" value="CHECK-OUT" class="func-btn" /></a>
                        </div>
                    </div>

                    <div class="func-box">
                        <div>
                            <a href="ChangeRoom.jsp"><input type="button" value="CHANGE ROOM" class="func-btn" /></a>
                        </div>
                        <div>
                            <a href="ExtendRoom.jsp"><input type="button" value="EXTEND ROOM" class="func-btn" /></a>
                        </div>
                    </div>
                </div>


            </div>
        </div>



    </body>
</html>