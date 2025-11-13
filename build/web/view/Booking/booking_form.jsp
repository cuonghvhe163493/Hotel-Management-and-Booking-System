<%-- 
    Document   : booking_form
    Created on : Nov 2, 2025
    Author     : taqua
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Booking Form</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"/>
    </head>
    <body class="bg-light">
        <!-- Header -->
        <jsp:include page="/view/common/header.jsp" />

        <!-- Page Banner -->
        <section id="center" class="center_o pt-4 pb-5 text-center bg-dark text-white">
            <div class="container-xl">
                <h2 class="text-uppercase">My Booking</h2>
                <h6 class="mb-0 mt-3 text-warning">
                    <a class="text-white" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                    <span class="mx-2 text-muted">/</span>My Booking
                </h6>
            </div>
        </section>

        <div class="container mt-5">
            <div class="card shadow-lg p-4">
                <h2 class="text-center mb-4 text-primary fw-bold">Confirm Your Booking</h2>

                <!-- Nếu cart trống -->
                <c:if test="${empty sessionScope.cart}">
                    <div class="alert alert-warning text-center">
                        Your cart is empty. 
                        <a href="${pageContext.request.contextPath}/rooms" class="alert-link">Go back to choose rooms</a>.
                    </div>
                </c:if>

                <c:if test="${not empty sessionScope.cart}">

                    <!-- Thông tin user -->
                    <c:if test="${not empty sessionScope.user}">
                        <div class="mb-4">
                            <h4 class="text-secondary">User Information</h4>
                            <p><strong>Name:</strong> ${sessionScope.user.username}</p>
                            <p><strong>Email:</strong> ${sessionScope.user.email}</p>
                            <p><strong>Phone:</strong> ${sessionScope.user.phone}</p>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/confirm-booking" method="post">
                        <!-- Danh sách phòng -->
                        <h4 class="text-secondary mb-3">Rooms in Your Cart</h4>
                        <c:set var="grandTotal" value="0" />

                        <c:forEach var="item" items="${sessionScope.cart}" varStatus="status">
                            <div class="mb-4 p-3 border rounded bg-white">
                                <h5>Room ${status.index + 1}: <c:out value="${item.room.roomNumber}" /></h5>
                                <p>Type: <c:out value="${item.room.roomType}" />, Capacity: <c:out value="${item.room.capacity}" />, Price/Night: <c:out value="${item.room.pricePerNight}"/> ₫</p>

                                <!-- Check-in / Check-out -->
                                <h6 class="text-muted">Booking Dates</h6>
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label fw-semibold">Check-in Date</label>
                                        <input type="date" name="checkInDate_${status.index}" class="form-control"
                                               value="<fmt:formatDate value='${item.checkIn}' pattern='yyyy-MM-dd'/>" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-semibold">Check-out Date</label>
                                        <input type="date" name="checkOutDate_${status.index}" class="form-control"
                                               value="<fmt:formatDate value='${item.checkOut}' pattern='yyyy-MM-dd'/>" readonly>
                                    </div>
                                </div>

                                <!-- Guests -->
                                <h6 class="text-muted">Guest Information</h6>
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Number of Guests</label>
                                    <input type="number" name="guestsCount_${status.index}" min="1" class="form-control"
                                           value="<c:out value='${item.guests != null ? item.guests : 1}' />" required>
                                </div>

                                <!-- Note -->
                                <h6 class="text-muted">Special Requests</h6>
                                <div class="mb-3">
                                    <textarea name="note_${status.index}" class="form-control" rows="2"
                                              placeholder="Any special requests?"><c:out value='${item.note}' /></textarea>
                                </div>

                                <!-- Hidden field: roomId -->
                                <input type="hidden" name="roomId_${status.index}" value="<c:out value='${item.room.roomId}' />"/>

                                <!-- Tính số đêm và tổng tiền tạm thời cho phòng này -->
                                <c:set var="nights" value="${(item.checkOut.time - item.checkIn.time)/(1000*60*60*24)}" />
                                <c:set var="roomTotal" value="${item.room.pricePerNight * (nights > 0 ? nights : 1)}" />
                                <c:set var="grandTotal" value="${grandTotal + roomTotal}" />

                                <p class="text-end text-primary fw-semibold">
                                    Subtotal for this room: 
                                    <fmt:formatNumber value="${roomTotal}" type="number" maxFractionDigits="0" groupingUsed="true"/> ₫
                                </p>
                            </div>
                        </c:forEach>

                        <!-- Tổng tiền -->
                        <div class="border-top pt-3 mb-4">
                            <h5 class="fw-bold text-end text-success">
                                Total:
                                <fmt:formatNumber value="${grandTotal}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </h5>
                        </div>

                        <!-- Submit -->
                        <div class="text-end">
                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-secondary px-4">Back to Cart</a>
                            <button type="submit" class="btn btn-success px-4 fw-bold">
                                <i class="fa fa-check"></i> Confirm Booking
                            </button>
                        </div>

                        <!-- Hidden: số lượng phòng -->
                        <input type="hidden" name="roomCount" value="${fn:length(sessionScope.cart)}"/>
                    </form>
                </c:if>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
