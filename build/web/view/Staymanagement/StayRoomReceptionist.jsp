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
        <div class="stay-room-list-container">
            <h3>Stay Room</h3>
            <!--            list stay room-->
            <div class="search-box">
                <form action="${pageContext.request.contextPath}/searchBooking" method="get" class="searchStay">
                    <div>
                        <label for="searchType">Search with:</label>
                        <select name="searchType" id="searchType" >
                            <option value="phone" ${param.searchType == 'phone' ? 'selected' : ''}>Phone</option>
                            <option value="bookingId" ${param.searchType == 'bookingId' ? 'selected' : ''}>Booking Id</option>
                            <option value="roomId" ${param.searchType == 'roomId' ? 'selected' : ''}>Room Id</option>
                            
                        </select>
                    </div>
                    <div>
                        <input type="text" 
                               name="search" 
                               placeholder="Enter phone number or booking id or room id" 
                               value="${param.search}" 
                                />
                    </div>
                    <button type="submit" class="send-btn">Search</button>
                </form>
            </div>
            <div class="table-container">                    
            <table class="list-table">
                <thead>
                    <tr>
                        <th>Booking Id</th>
                        <th>Room Id</th>
                        <th>Room Number</th>
                        <th>Status</th>
                        <th>Check In Date</th>
                        <th>Check Out Date</th>
                        <th>Details</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="room" items="${stayroom}">
                        <tr>
                            <td>${room.bookingId}</td>
                            <td>${room.roomId}</td>
                            <td>${room.roomNumber}</td>
                            <td>${room.status}</td>
                            <td>${room.checkInDate}</td>
                            <td>${room.checkOutDate}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/details?roomId=${room.roomId}&bookingId=${room.bookingId}&role=1"
                                   class="link-details">Details</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            </div>
            <c:if test="${empty stayroom}">
                                <p class="no-results">No results found.</p>
                            </c:if>                  

        </div>


        <div class="func-chat-container">
            <!--function for use-->
            <div class="func-container">
                <h4 class="word-stay-functions">Stay Functions</h4>

                <div class="func-single">
                    <a href="ServicesRoom.jsp" class="word_2"><input type="button" value="SERVICES ROOM" class="func-btn_1" /></a>
                </div> 

                <div class="func-box">
                    <div>
                        <a href="${pageContext.request.contextPath}/view/Staymanagement/CheckInForReceptionist.jsp"><input type="button" value="CHECK-IN" class="func-btn" /></a>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/view/Staymanagement/CheckOutForReceptionist.jsp"><input type="button" value="CHECK-OUT" class="func-btn" /></a>
                    </div>
                </div>

                <div class="func-box">
                    <div>
                        <a href="${pageContext.request.contextPath}/ChangeRoom"><input type="button" value="CHANGE ROOM" class="func-btn" /></a>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/view/Staymanagement/ExtendRoomForReceptionist.jsp"><input type="button" value="EXTEND ROOM" class="func-btn" /></a>
                    </div>
                </div>
            </div>
            <!--small chat box-->
            <div class="chat-container">
                <div>
                    <h4 class="word-chat">Chat Box  <a href="CommunicationChatBox.jsp">CHAT BOX</a></h4>

                </div>
                <div class="box">
                    <div class="message user">Test 1</div>
                    <div class="message staff">Test 2</div>
                    <div class="message user">Test 3</div>
                    <div class="message staff">Test4</div>
                    <div class="message user">Test5</div>
                    <div class="message staff">Test6</div>
                    <div class="message user">Test 7</div>
                    <div class="message staff">Test 8</div>
                </div>
                <div class="input-wrapper">
                    <input   type="text" placeholder="Enter message...">
                    <button class="send-btn">Send</button>
                </div>
            </div>
        </div>
        


    </body>
</html>