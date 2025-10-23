<%-- 
    Document   : room_detail
    Created on : Oct 20, 2025, 10:50:00 AM
    Author     : taqua
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết phòng</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/font-awesome.min.css" rel="stylesheet">
        <link href="css/global.css" rel="stylesheet">
        <link href="css/rooms.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@500&display=swap" rel="stylesheet">
        <script src="js/bootstrap.bundle.min.js"></script>
    </head>
    <body>

        <!-- Header & Navbar (giữ nguyên) -->
        <div class="main_room_dt">
            <div class="main_o1">
                <section id="top" class="pt-3 pb-3">
                    <div class="container-xl">
                        <div class="row top_1">
                            <div class="col-md-4">
                                <div class="top_1l">
                                    <span class="d-inline-block bg_yell rounded-circle float-start me-2 text-center">
                                        <a href="#"><i class="fa fa-phone text-white"></i></a>
                                    </span>
                                    <h6 class="mb-0 lh-base font_14">
                                        <a class="text-white" href="#">For Further Inquires : <br> +(012) 345 67 89</a>
                                    </h6>
                                </div>
                            </div>
                            <div class="col-md-4 text-center mt-2">
                                <h3 class="mb-0"><a class="text-white" href="index.html"><i class="fa fa-plane col_yell"></i> Hotells</a></h3>
                            </div>
                            <div class="col-md-4 mt-2 text-end">
                                <ul class="mb-0">
                                    <li class="d-inline-block"><a class="text-white" href="#"><i class="fa fa-facebook"></i></a></li>
                                    <li class="d-inline-block"><a class="text-white" href="#"><i class="fa fa-instagram"></i></a></li>
                                    <li class="d-inline-block"><a class="text-white" href="#"><i class="fa fa-tripadvisor"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </section>

                <section id="header">
                    <nav class="navbar navbar-expand-md navbar-light pt-3 pb-3" id="navbar_sticky">
                        <div class="container-xl">
                            <a class="navbar-brand fs-3 fw-bold text-white" href="index.html"><i class="fa fa-plane col_yell"></i> Hotells </a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                <ul class="navbar-nav mb-0">
                                    <li class="nav-item"><a class="nav-link" href="index.html">Home</a></li>
                                    <li class="nav-item"><a class="nav-link" href="about.html">About </a></li>
                                    <li class="nav-item"><a class="nav-link" href="rooms">Rooms </a></li>
                                </ul>
                                <ul class="navbar-nav ms-auto">
                                    <li class="nav-item"><a class="nav-link button" href="#">BOOK NOW</a></li>
                                </ul>
                            </div>
                        </div>
                    </nav>
                </section>

                <section id="center" class="center_o pt-4 pb-5">
                    <div class="container-xl text-center">
                        <h2 class="text-white text-uppercase">Room Detail</h2>
                        <h6 class="mb-0 mt-3 col_yell">
                            <a class="text-white" href="#">Home</a> <span class="mx-2 text-muted">/</span> Room Detail
                        </h6>
                    </div>
                </section>
            </div>
        </div>

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
                                <li><i class="fa fa-money me-2 col_yell"></i> ${room.pricePerNight} $/night</li>
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

                            <a href="rooms" class="btn btn-primary mt-3">Quay lại danh sách phòng</a>
                        </div>
                    </div>

                    <!-- Room & Suites -->
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
                                            <p class="card-text">${r.capacity} Guests | ${r.pricePerNight} $/night</p>
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



