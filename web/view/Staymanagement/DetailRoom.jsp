<%-- 
    Document   : CommunicationChatBox
    Created on : Oct 24, 2025, 10:35:55 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Details</title>
        <style>
            
        </style>
</head>
<body>
    <jsp:include page="/view/common/header.jsp" />
    <h3 class="word_3">Details</h3>
    <div>

        <div class="details-box">
            <c:if test="${sessionScope.role == 'customer'}">
                <div>
                    <p>Room Number: ${room.roomNumber}</p>
                    <p>Room Id: ${room.roomId}</p>
                    <p>Room type: ${room.roomType}</p>
                    <p>Booking Id: ${room.bookingId}</p>
                    <p>Number of people: ${room.guestCount}</p>
                    <p>Service: </p>
                    <p>Capacity: ${room.capacity}</p>
                    <p>Price: ${room.pricePerNight}</p>
                    <p>Check In Date: ${room.checkInDate}</p>
                    <p>Check Out Date: ${room.checkOutDate}</p>
                </div>
            </c:if>
        </div>

        <!--receptionist-->               
        <div class="details-box">
            <c:if test="${sessionScope.role == 'hotel_manager'}">
                <div>
                    <p>Room Number: ${room.roomNumber}</p>
                    <p>Room Id: ${room.roomId}</p>
                    <p>Room type: ${room.roomType}</p>
                    <p>Booking Id: ${room.bookingId}</p>
                    <p>Number of people: ${room.guestCount}</p>
                    <p>Service: </p>
                    <p>Capacity: ${room.capacity}</p>
                    <p>Price: ${room.pricePerNight}</p>
                    <p>Check In Date: ${room.checkInDate}</p>
                    <p>Check Out Date: ${room.checkOutDate}</p>
                    <p>Booking status:  ${room.status}</p>
                    <p>Room status: ${room.roomStatus}</p>
                    <p>Customer name: ${room.name}</p>
                    <p>Number of people: ${room.guestCount}</p>
                    <p>Email: ${room.gmail}</p>
                    <p>Phone: ${room.phone}</p>
                </div>
            </c:if>

        </div>            

    </div>










</body>
</html>
