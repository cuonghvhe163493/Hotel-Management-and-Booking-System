<%-- 
    Document   : CheckOut
    Created on : Oct 19, 2025, 2:17:15 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check Out</title>
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
        
        
        
        
        <h3>Check Out</h3>
        <div class="check-in">
            <div>
                <div>
                    <form action="${pageContext.request.contextPath}/CheckOutServletForCustomer" method="get" class="check-in-container">
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
                        <input class="send-btn" type="submit" value="Check" />
                    </form>    
                </div>
                        <br>
                <div class="table-container">
                    <table class="list-table">
                        <thead>
                            <tr>
                                <th>Room Id</th> 
                                <th>Number Room</th>
                                <th>Check-out Date</th> 
                                <th>Details</th>
                            </tr>
                        </thead>
                        <tbody >
                            <c:forEach var="room" items="${stayroom}">
                                <tr>
                                    <td>${room.roomId}</td>                                  
                                    <td>${room.roomNumber}</td>
                                    <td>${room.checkOutDate}</td>                            
                                    <td><a class="dropdown-item" href="${pageContext.request.contextPath}/details?roomId=${room.roomId}&bookingId=${room.bookingId}"> Details</a></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>           
            </div>    

            <div >
                <p>Price Each Room: 
                    <c:forEach var="room" items="${stayroom}">
                    <p>Room: ${room.roomNumber} : ${room.price}   </p>
                    <p>==========================</p>
                </c:forEach>
                <p>Services:   
                <p>The total amount of booking: 
                    <c:if test="${not empty stayroom}">
                        <c:set var="firstRoom" value="${stayroom[0]}" />
                            ${firstRoom.totalDeposit} 
                    </c:if>
            </div>    


        </div>
        
        
        
        
        
        
        
    </body>
</html>
