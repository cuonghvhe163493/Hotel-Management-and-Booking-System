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
        .cart-section {
            background-color: #f9f9f9;
            padding: 40px 20px;
            border-radius: 10px;
        }
        .cart-table th, .cart-table td {
            vertical-align: middle !important;
        }
        .btn-success {
            background-color: #ffb800;
            border: none;
        }
        .btn-success:hover {
            background-color: #e6a600;
        }
        .section-title {
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
        }
        .divider {
            height: 2px;
            background-color: #ddd;
            margin: 40px 0;
        }
    </style>
</head>
<body>
    <!-- Include header -->
    <jsp:include page="/view/common/header.jsp" />

   

    <!-- Page Banner -->
    <section id="center" class="center_o pt-4 pb-5 text-center bg-dark text-white">
        <div class="container-xl">
            <h2 class="text-uppercase">My Cart</h2>
            <h6 class="mb-0 mt-3 text-warning">
                <a class="text-white" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                <span class="mx-2 text-muted">/</span> My Cart
            </h6>
        </div>
    </section>

    <!-- Main Cart Content -->
    <section id="cart" class="cart-section">
        <div class="container-xl">

            <!-- ================= ROOM CART SECTION ================= -->
            <div id="room-cart">
                <h4 class="section-title"><i class="fa fa-bed"></i> Room Cart</h4>

                <c:if test="${empty sessionScope.cart}">
                    <div class="text-center">
                        <h5>Your room cart is empty.</h5>
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
                                        <td>
                                            <fmt:formatNumber value="${item.room.pricePerNight}" type="number" maxFractionDigits="0"/> VNĐ/night
                                        </td>
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
                        <a href="${pageContext.request.contextPath}/booking" class="btn btn-success px-4 py-2 fw-bold">
                            <i class="fa fa-calendar-check"></i> Proceed Room Booking
                        </a>
                    </div>
                </c:if>
            </div>

            <div class="divider"></div>

            <!-- ================= UNIFIED SERVICE CART SECTION ================= -->
            <div id="unified-service-cart">
                <h4 class="section-title"><i class="fa fa-concierge-bell"></i> Services & Add-ons</h4>

                <!-- EXTRA SERVICES -->
                <c:if test="${not empty sessionScope.cartExtraServices}">
                    <h5 style="color: #333; margin-top: 20px; margin-bottom: 15px;">
                        <i class="fa fa-box-open"></i> Extra Services
                    </h5>
                    <div class="table-responsive mb-4">
                        <table class="table table-bordered cart-table">
                            <thead class="table-dark">
                                <tr>
                                    <th>Service</th>
                                    <th>Type</th>
                                    <th>Guests</th>
                                    <th>Start</th>
                                    <th>End</th>
                                    <th>Price</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${sessionScope.cartExtraServices}" varStatus="status">
                                    <tr>
                                        <td>${item.service.serviceName}</td>
                                        <td>${item.service.serviceType}</td>
                                        <td>${item.guestsCount}</td>
                                        <td><fmt:formatDate value="${item.checkInDate}" pattern="yyyy-MM-dd"/></td>
                                        <td><fmt:formatDate value="${item.checkOutDate}" pattern="yyyy-MM-dd"/></td>
                                        <td>
                                            <fmt:formatNumber value="${item.service.servicePrice}" type="number"/>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/extra-service-cart?index=${status.index}" class="btn btn-danger btn-sm">
                                                <i class="fa fa-trash"></i> Remove
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>

                <!-- REGULAR SERVICES -->
                <c:if test="${not empty sessionScope.cartServices}">
                    <h5 style="color: #333; margin-top: 20px; margin-bottom: 15px;">
                        <i class="fa fa-cog"></i> Regular Services
                    </h5>
                    <div class="table-responsive mb-4">
                        <table class="table table-bordered cart-table">
                            <thead class="table-dark">
                                <tr>
                                    <th>Service</th>
                                    <th>Type</th>
                                    <th>Guests</th>
                                    <th>Check-in</th>
                                    <th>Check-out</th>
                                    <th>Price/night</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${sessionScope.cartServices}" varStatus="status">
                                    <form action="${pageContext.request.contextPath}/service-cart" method="post">
                                        <tr>
                                            <td>${item.service.serviceName}</td>
                                            <td>${item.service.serviceType}</td>
                                            <td>
                                                <input type="hidden" name="action" value="update"/>
                                                <input type="hidden" name="index" value="${status.index}">
                                                <input type="number" name="guestcount" value="${item.guestsCount}" min="1">
                                            </td>
                                            <td>
                                                <input type="date" name="checkIn" value="<fmt:formatDate value='${item.checkInDate}' pattern='yyyy-MM-dd'/>">
                                            </td>
                                            <td>
                                                <input type="date" name="checkOut" value="<fmt:formatDate value='${item.checkOutDate}' pattern='yyyy-MM-dd'/>">
                                            </td>
                                            <td>${item.service.price}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/service-cart?index=${status.index}" class="btn btn-danger btn-sm">
                                                    <i class="fa fa-trash"></i> Remove
                                                </a>
                                                <button type="submit" class="btn btn-info btn-sm">
                                                    <i class="fa fa-pencil"></i> Update
                                                </button>
                                            </td>
                                        </tr>
                                    </form>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>

                <!-- EMPTY STATE -->
                <c:if test="${empty sessionScope.cartExtraServices and empty sessionScope.cartServices}">
                    <div class="text-center">
                        <h5>Your service cart is empty.</h5>
                        <div class="mt-3">
                            <a href="${pageContext.request.contextPath}/extra-services" class="btn btn-primary mx-2">Browse Extra Services</a>
                            <a href="${pageContext.request.contextPath}/services" class="btn btn-primary mx-2">Browse Services</a>
                        </div>
                    </div>
                </c:if>

                <!-- UNIFIED CHECKOUT BUTTON (ONLY SHOW IF ANYTHING IN CART) -->
                <c:if test="${not empty sessionScope.cartExtraServices or not empty sessionScope.cartServices}">
                    <div class="text-end mt-5">
                        <a href="${pageContext.request.contextPath}/service-booking" class="btn btn-success px-5 py-3 fw-bold btn-lg">
                            <i class="fa fa-check-circle"></i> Proceed to Checkout
                        </a>
                    </div>
                </c:if>
            </div>

        </div>
    </section>
</body>
</html>
