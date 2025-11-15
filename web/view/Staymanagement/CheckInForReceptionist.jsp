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
            <div class="check-in-container">

                
<!--                <p class="word-booked">Booked</p>
                <select class="booked-selection" name="Booked" id="bookedSelect">
                    <option value="Yes">Yes</option>
                    <option value="No">No</option>
                </select>-->
                
                <form action="${pageContext.request.contextPath}/CheckInServlet" method="get" class="check-in-input-container">
                    <div id="bookingIdField" style="display:block;">
                        <input type="text" 
                               name="phoneNumber" 
                               id="phoneNumber"
                               placeholder="Phone Number" 
                               maxlength="15" 
                               class="form-input"
                               oninput="this.value = this.value.replace(/[^0-9]/g, '')" 
                               onkeypress="return event.charCode >= 48 && event.charCode <= 57" 
                               required />   
                        <input type="hidden" name="mode" value="0" />
                        <input type="submit" class="send-btn" value="Check" />
                    </div>
                </form>

                
                <form action="${pageContext.request.contextPath}/CheckInServlet" method="post" class="check-in-input-container">
                    <div id="extraFields" style="display:none;">
                        <p>Room ID: <input type="text" name="idroom" placeholder="ID Room" required /></p>
                        <p>Customer Name: <input type="text" name="name" placeholder="Name" required /></p>
                        <p>Citizen ID: <input type="text" name="citizenId" placeholder="Citizen ID" required /></p>
                        <div>
                            <p>Number of people: 
                                <input type="text" id="numberInput" name="numPeople" list="people" placeholder="Number of people">
                                <datalist id="people">
                                    <option value="1"><option value="2"><option value="3"><option value="4">
                                    <option value="5"><option value="6"><option value="7"><option value="8">
                                    <option value="9"><option value="10">
                                </datalist>
                            </p>
                        </div>

                        <p>Check-in Date: <input type="date" name="checkInDate" /></p>    
                        <p>Check-out Date: <input type="date" name="checkOutDate" /></p> 
                        <p>Gmail: <input type="email" name="gmail" placeholder="Gmail" /></p>
                        <p>Phone: <input type="text" name="phone" placeholder="Phone" /></p>
                        <p>Note<input type="text" name="note" value="" /></p>
                        <input type="submit" class="send-btn" value="Check" />
                    </div>

                </form>
                <div class="info-customer">
                    <br>
                    <h4>Information Customer</h4>
                    <p>===============================================</p>
                    <p>Customer name: ${info.name}</p>
                    <p>User Id: ${info.userId}</p>
                    <p>Email: ${info.gmail}</p>
                    <p>===============================================</p>
                </div>    
            </div>
            <div class="check-info-container">
                <h3>Booking Information</h3>
                <div style="margin-bottom: 10px;">
                    <input type="checkbox" id="selectAll" />
                    <label for="selectAll"><strong>Select All Rooms</strong></label>
                </div>

                <form action="${pageContext.request.contextPath}/CheckInServlet" method="post" id="checkInfoForm">
                    <div id="roomListContainer" class="room-list-container">
                        <c:forEach var="room" items="${list}">
                            <div class="room-block" data-roomid="${room.roomId}">                                
                                <input type="checkbox" name="selectedRooms" value="${room.roomId}" id="room_${room.roomId}">
                                <label for="room_${room.roomId}">
                                    <strong>Booking ID: ${room.bookingId}</strong><br>
                                    <strong>Room: ${room.roomNumber} - Room ID: ${room.roomId}</strong><br>
                                    <p>Type: ${room.roomType} </p> 
                                    <p>Check In Date: ${room.checkInDate} </p>
                                    <p>Price: ${room.pricePerNight} </p>
                                </label>
                            </div>
                                <p>================================================</p>
                        </c:forEach>
                    </div>

                    <br>
                    <input type="submit" class="send-btn" value="Check In">
                </form>
            </div>       
        </div>
        <script>
            document.getElementById('selectAll').addEventListener('change', function () {
                const checkboxes = document.querySelectorAll('input[name="selectedRooms"]');
                checkboxes.forEach(cb => cb.checked = this.checked);
            });
        </script>            
        <script>
            const bookedSelect = document.getElementById("bookedSelect");
            const extraFields = document.getElementById("extraFields");
            const bookingIdField = document.getElementById("bookingIdField");

            bookedSelect.addEventListener("change", function () {
                if (this.value === "No") {
                    extraFields.style.display = "block";
                    bookingIdField.style.display = "none";
                } else if (this.value === "Yes") {
                    extraFields.style.display = "none";
                    bookingIdField.style.display = "block";
                } else {
                    extraFields.style.display = "none";
                    bookingIdField.style.display = "none";
                }
            });
        </script>

    </body>
</html>