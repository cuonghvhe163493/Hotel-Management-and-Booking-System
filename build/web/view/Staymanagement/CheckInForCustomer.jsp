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
        <title>Check In</title>
        <link href="${pageContext.request.contextPath}/view/Staymanagement/css/bootstrap.min.css" rel="stylesheet" >
        <link href="${pageContext.request.contextPath}/view/Staymanagement/css/font-awesome.min.css" rel="stylesheet" >
        <link href="${pageContext.request.contextPath}/view/Staymanagement/css/global.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/view/Staymanagement/css/rooms.css" rel="stylesheet">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/Staymanagement/css/checkin.css">
        <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@500&display=swap" rel="stylesheet">
        <script src="js/bootstrap.bundle.min.js"></script>
    </head>

    <body>
        <jsp:include page="/view/common/header.jsp" />
        <h3>Check In</h3>
        <div class="check-in">
            <div>
                <div>
                    <form action="${pageContext.request.contextPath}/CheckInServletForCustomer" method="get" class="check-in-container">
                        <p>Booking ID</p>
                        <select name="selectedValue">
                            <c:forEach var="id" items="${listbooking}">
                                <option value="${id}">
                                    ${id} 
                                </option>   
                            </c:forEach>
                        </select>   
                        <input type="hidden" name="mode" value="1" />
                        <input type="hidden" name="id" value="${sessionScope.customerId}" />
                        <input type="submit" class="send-btn" value="Check" />
                    </form>    
                </div>
                <div>
                    <table>
                        <thead>
                            <tr>
                                <th>Room Id</th> 
                                <th>Number Room</th>
                                <th>Check-in Date</th> 
                                <th>Price Per Night</th> 
                                <th>Details</th>
                            </tr>
                        </thead>
                        <tbody >
                            <c:forEach var="room" items="${stayroom}">
                                <tr>
                                    <td>${room.roomId}</td>                                  
                                    <td>${room.roomNumber}</td>
                                    <td>${room.checkInDate}</td>  
                                    <td>${room.pricePerNight}</td> 
                                    <td><a class="dropdown-item" href="${pageContext.request.contextPath}/details?roomId=${room.roomId}&bookingId=${room.bookingId}"> Details</a></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>           
            </div>    

            <div>
                <p>Price Each Room: 
                    <c:forEach var="room" items="${stayroom}">
                    <p>Room: ${room.roomNumber} : ${room.price}   </p>
                    <p>Deposit (10%): ${room.deposit}  </p>
                    <p>==========================</p>
                </c:forEach>
                <p>Services:   
                <p>The total amount of deposit: 
                    <c:if test="${not empty stayroom}">
                        <c:set var="firstRoom" value="${stayroom[0]}" />
                            ${firstRoom.totalDeposit} 
                    </c:if>
            </div>    


        </div>





        



    </body>
</html>