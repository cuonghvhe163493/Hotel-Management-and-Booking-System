<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Booking Cart</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <style>
        .cart-section { background-color: #f9f9f9; padding: 40px 20px; border-radius: 10px; }
        .cart-table th, .cart-table td { vertical-align: middle !important; }
        .btn-success { background-color: #ffb800; border: none; }
        .btn-success:hover { background-color: #e6a600; }
    </style>
</head>
<body>
    <!-- Header -->
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
                    <c:set var="cartCount" value="0"/>
                    <c:if test="${not empty sessionScope.cart}">
                        <c:set var="cartCount" value="${fn:length(sessionScope.cart)}"/>
                    </c:if>
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
                                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/rooms">Rooms </a></li>
                                </ul>
                                <ul class="navbar-nav ms-auto">
                                    <li class="nav-item"><a class="nav-link button" href="#">BOOK NOW</a></li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                                            Cart <span class="badge bg-warning text-dark">${cartCount}</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </nav>
                </section>

                <section id="center" class="center_o pt-4 pb-5">
                    <div class="container-xl text-center">
                        <h2 class="text-white text-uppercase">Cart</h2>
                        <h6 class="mb-0 mt-3 col_yell">
                            <a class="text-white" href="#">Home</a> <span class="mx-2 text-muted">/</span> Your Cart
                        </h6>
                    </div>
                </section>
            </div>
        </div>

    <!-- Main Cart Content -->
    <section id="cart" class="cart-section">
        <div class="container-xl">
            <c:if test="${empty sessionScope.cart}">
                <div class="text-center">
                    <h4>Your cart is empty.</h4>
                    <a href="${pageContext.request.contextPath}/rooms" class="btn btn-primary mt-3">Browse Rooms</a>
                </div>
            </c:if>

            <c:if test="${not empty sessionScope.cart}">
                <div class="table-responsive">
                    <table class="table table-bordered cart-table">
                        <thead class="table-dark">
                            <tr>
                                <th>Room</th>
                                <th>Type</th>
                                <th>Guests</th>
                                <th>Check-in</th>
                                <th>Check-out</th>
                                <th>Price/night ($)</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${sessionScope.cart}">
                                <tr>
                                    <td>#${item.room.roomNumber}</td>
                                    <td>${item.room.roomType}</td>
                                    <td>${item.guests}</td>
                                    <td><fmt:formatDate value="${item.checkIn}" pattern="yyyy-MM-dd"/></td>
                                    <td><fmt:formatDate value="${item.checkOut}" pattern="yyyy-MM-dd"/></td>
                                    <td>${item.room.pricePerNight}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="remove">
                                            <input type="hidden" name="roomId" value="${item.room.roomId}">
                                            <input type="hidden" name="checkIn" value="<fmt:formatDate value='${item.checkIn}' pattern='yyyy-MM-dd'/>">
                                            <input type="hidden" name="checkOut" value="<fmt:formatDate value='${item.checkOut}' pattern='yyyy-MM-dd'/>">
                                            <button type="submit" class="btn btn-danger btn-sm">
                                                <i class="fa fa-trash"></i> Remove
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="text-end mt-4">
                    <a href="${pageContext.request.contextPath}/confirm-booking" class="btn btn-success px-4 py-2 fw-bold">
                        <i class="fa fa-check"></i> Confirm Booking
                    </a>
                </div>
            </c:if>
        </div>
    </section>
</body>
</html>
