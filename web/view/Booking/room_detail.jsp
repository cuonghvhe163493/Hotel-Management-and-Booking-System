<%-- 
    Document   : room_detail
    Created on : Oct 20, 2025, 10:50:00 AM
    Author     : taqua
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    java.util.Date now = new java.util.Date();
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết phòng</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/rooms.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@500&display=swap" rel="stylesheet">
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </head>

    <body>

        <!-- Include header -->
        <jsp:include page="/view/common/header.jsp" />

        <!-- Page Banner -->
        <section id="center" class="center_o pt-4 pb-5 text-center bg-dark text-white">
            <div class="container-xl">
                <h2 class="text-uppercase">Room Detail</h2>
                <h6 class="mb-0 mt-3 text-warning">
                    <a class="text-white" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                    <span class="mx-2 text-muted">/</span> Room Detail
                </h6>
            </div>
        </section>

        <!-- Room Detail Content -->
        <section id="room" class="p_3">
            <div class="container-xl">
                <c:if test="${not empty room}">
                    <div class="row mb-4">
                        <div class="col-md-5">
                            <c:choose>
                                <c:when test="${room.roomType eq 'Single'}"><c:set var="imgFile" value="single_room.jpg"/></c:when>
                                <c:when test="${room.roomType eq 'Double'}"><c:set var="imgFile" value="double_room.jpg"/></c:when>
                                <c:when test="${room.roomType eq 'Suite'}"><c:set var="imgFile" value="suite_room.jpg"/></c:when>
                                <c:when test="${room.roomType eq 'Family'}"><c:set var="imgFile" value="family_room.jpg"/></c:when>
                                <c:when test="${room.roomType eq 'Deluxe'}"><c:set var="imgFile" value="deluxe_room.jpg"/></c:when>
                                <c:otherwise><c:set var="imgFile" value="default_room.jpg"/></c:otherwise>
                            </c:choose>
                            <img src="${pageContext.request.contextPath}/img/${imgFile}" class="img-fluid rounded" alt="Room Image">
                        </div>
                        <div class="col-md-7">
                            <h1 class="mb-3">${room.roomType} Room - #${room.roomNumber}</h1>
                            <ul class="list-unstyled mb-3">
                                <li><i class="fa fa-user me-2 col_yell"></i> ${room.capacity} Guests</li>
                                <li><i class="fa fa-bed me-2 col_yell"></i> Standard Bed</li>
                                <li>
                                    <i class="fa fa-money me-2 col_yell"></i>
                                    <fmt:formatNumber value="${room.pricePerNight}" type="number" maxFractionDigits="0"/> VNĐ/night
                                </li>
                                <li><i class="fa fa-info-circle me-2 col_yell"></i> Status: ${room.roomStatus}</li>
                            </ul>

                            <div class="row text-center mb-3">
                                <div class="col-3">
                                    <i class="fa fa-tv col_yell fs-3 mb-1"></i>
                                    <div>Cable TV</div>
                                </div>
                                <div class="col-3">
                                    <i class="fa fa-wifi col_yell fs-3 mb-1"></i>
                                    <div>Free Wifi</div>
                                </div>
                                <div class="col-3">
                                    <i class="fa fa-coffee col_yell fs-3 mb-1"></i>
                                    <div>Hot Drinks</div>
                                </div>
                                <div class="col-3">
                                    <i class="fa fa-key col_yell fs-3 mb-1"></i>
                                    <div>Key Access</div>
                                </div>
                            </div>

                            <!-- Hiển thị lỗi nếu có -->
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">${error}</div>
                            </c:if>

                            <c:if test="${isBooked}">
                                <div class="alert alert-danger mt-3">
                                    This room is already booked for the selected dates.
                                </div>
                            </c:if>


                            <!-- Form add to cart -->
                            <form action="${pageContext.request.contextPath}/cart" method="post" class="mt-3">
                                <input type="hidden" name="action" value="add"/>
                                <input type="hidden" name="roomId" value="${room.roomId}"/>
                                <div class="row g-2">
                                    <div class="col-md-4">
                                        <label class="form-label">Check-in</label>
                                        <input type="date" name="checkInDate" class="form-control" required
                                               min="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd'/>"
                                               value="${param.checkInDate != null ? param.checkInDate : ''}"/>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Check-out</label>
                                        <input type="date" name="checkOutDate" class="form-control" required
                                               min="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd'/>"
                                               value="${param.checkOutDate != null ? param.checkOutDate : ''}"/>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="form-label">Guests</label>
                                        <input type="number" name="guestsCount" class="form-control"
                                               min="1" max="${room.capacity}" 
                                               value="${param.guestsCount != null ? param.guestsCount : 1}" required/>
                                    </div>
                                    <div class="col-md-12 mt-2">
                                        <button type="submit" class="btn btn-warning">
                                            Add to Cart
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Similar Rooms -->
                    <div class="mt-5">
                        <h3 class="mb-4">Similar Rooms</h3>
                        <div class="row">
                            <c:forEach var="r" items="${similarRooms}">
                                <a href="room-detail?id=${r.roomId}" class="col-md-4 mb-3 text-decoration-none d-block">
                                    <div class="card h-100">
                                        <c:choose>
                                            <c:when test="${r.roomType eq 'Single'}"><c:set var="imgFile" value="single_room.jpg"/></c:when>
                                            <c:when test="${r.roomType eq 'Double'}"><c:set var="imgFile" value="double_room.jpg"/></c:when>
                                            <c:when test="${r.roomType eq 'Suite'}"><c:set var="imgFile" value="suite_room.jpg"/></c:when>
                                            <c:when test="${r.roomType eq 'Family'}"><c:set var="imgFile" value="family_room.jpg"/></c:when>
                                            <c:when test="${r.roomType eq 'Deluxe'}"><c:set var="imgFile" value="deluxe_room.jpg"/></c:when>
                                            <c:otherwise><c:set var="imgFile" value="default_room.jpg"/></c:otherwise>
                                        </c:choose>

                                        <img src="${pageContext.request.contextPath}/img/${imgFile}" class="card-img-top" alt="Room Image">

                                        <div class="card-body text-center">
                                            <h6 class="card-title">${r.roomType} - #${r.roomNumber}</h6>
                                            <p class="card-text">
                                                ${r.capacity} Guests | 
                                                <fmt:formatNumber value="${r.pricePerNight}" type="number" maxFractionDigits="0"/> VNĐ/night
                                            </p>

                                        </div>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </div>
        </section>
    </body>
</html>
