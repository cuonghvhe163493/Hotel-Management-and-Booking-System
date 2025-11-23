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
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background: #f5f5f5;
            }

            /* Tiêu đề */
            .word_3 {
                text-align: center;
                font-size: 26px;
                color: #ff7f32;
                margin-top: 20px;
                margin-bottom: 25px;
            }

            /* Khung chi tiết */
            .details-box {
                width: 60%;
                margin: 0 auto 25px auto;
                background: white;
                border-radius: 10px;
                padding: 20px 25px;
                box-shadow: 0 3px 10px rgba(0,0,0,0.1);
                border-left: 5px solid #ff7f32;
            }

            /* Các dòng thông tin */
            .details-box p {
                font-size: 16px;
                margin: 8px 0;
                padding-bottom: 4px;
                border-bottom: 1px solid #eee;
            }

            /* Nhãn mạnh hơn một chút */
            .details-box p strong {
                color: #ff7f32;
            }

            /* Responsive cho mobile */
            @media (max-width: 768px) {
                .details-box {
                    width: 90%;
                    padding: 15px;
                }

                .word_3 {
                    font-size: 22px;
                }
            }

        </style>
    </head>
    <body>
        <jsp:include page="/view/common/header.jsp" />
        <h3 class="word_3">Details</h3>
        <div>

            <div class="details-box">
                <c:if test="${role == 'customer'}">
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
                <c:if test="${role == 'hotel_manager'}">
                    <div>
                        <p>Room Number: ${room.roomNumber}</p>
                        <p>Room Id: ${room.roomId}</p>
                        <p>Room type: ${room.roomType}</p>
                        <p>Room status: ${room.roomStatus}</p>
                        <p>Booking Id: ${room.bookingId}</p>
                        <p>Booking status:  ${room.status}</p>
                        <p>Number of people: ${room.guestCount}</p>
                        <p>Service: </p>
                        <p>Capacity: ${room.capacity}</p>
                        <p>Price: ${room.pricePerNight}</p>
                        <p>Check In Date: ${room.checkInDate}</p>
                        <p>Check Out Date: ${room.checkOutDate}</p>
                        <p>Customer name: ${room.name}</p>
                        <p>Email: ${room.gmail}</p>
                        <p>Phone: ${room.phone}</p>
                    </div>
                </c:if>
            </div>

                     

        </div>










    </body>
</html>
