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
                        <a href="${pageContext.request.contextPath}/booking" class="btn btn-success px-4 py-2 fw-bold">
                            <i class="fa fa-calendar-check"></i> Proceed to Booking
                        </a>
                    </div>
                </c:if>
            </div>
        </section>
    </body>
</html>