<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Booking Confirmation</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"/>
    </head>
    <body class="bg-light">
        <!-- Header -->
        <jsp:include page="/view/common/header.jsp" />

        <!-- Page Banner -->
        <section id="center" class="center_o pt-4 pb-5 text-center bg-dark text-white">
            <div class="container-xl">
                <h2 class="text-uppercase">Confirm Your Booking</h2>
                <h6 class="mb-0 mt-3 text-warning">
                    <a class="text-white" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                    <span class="mx-2 text-muted">/</span> Booking Confirmation
                </h6>
            </div>
        </section>

        <div class="container mt-5 mb-5">
            <div class="card shadow-lg border-0">
                <div class="card-body p-5">

                    <!-- Empty cart check -->
                    <c:if test="${empty sessionScope.cartExtraServices and empty sessionScope.cartServices}">
                        <div class="alert alert-warning text-center">
                            <h5>Your cart is empty!</h5>
                            <p>Please add services to proceed with booking.</p>
                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-primary mt-2">
                                Back to Cart
                            </a>
                        </div>
                    </c:if>

                    <!-- Show booking details if cart has items -->
                    <c:if test="${not empty sessionScope.cartExtraServices or not empty sessionScope.cartServices}">
                        <h3 class="text-center mb-4 text-primary fw-bold">Review Your Booking</h3>

                        <!-- User Info -->
                        <c:if test="${not empty sessionScope.user}">
                            <div class="card card-body mb-4 bg-light">
                                <h5 class="mb-3">Customer Information</h5>
                                <div class="row">
                                    <div class="col-md-6">
                                        <p><strong>Name:</strong> ${sessionScope.user.username}</p>
                                        <p><strong>Email:</strong> ${sessionScope.user.email}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <p><strong>Phone:</strong> ${sessionScope.user.phone}</p>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <!-- ALL SERVICES IN CART -->
                        <h5 class="mb-3">Services to Book</h5>
                        <div class="table-responsive mb-4">
                            <table class="table table-bordered table-hover">
                                <thead class="table-warning">
                                    <tr>
                                        <th>Service Name</th>
                                        <th>Type</th>
                                        <th>Check-in / Start</th>
                                        <th>Check-out / End</th>
                                        <th>Guests</th>
                                        <th>Price</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="grandTotal" value="0" />
                                    
                                    <!-- EXTRA SERVICES -->
                                    <c:forEach var="item" items="${sessionScope.cartExtraServices}">
                                        <tr>
                                            <td><strong>${item.service.serviceName}</strong> <span class="badge bg-info">Extra</span></td>
                                            <td>${item.service.serviceType}</td>
                                            <td><fmt:formatDate value="${item.checkInDate}" pattern="yyyy-MM-dd"/></td>
                                            <td><fmt:formatDate value="${item.checkOutDate}" pattern="yyyy-MM-dd"/></td>
                                            <td>${item.guestsCount}</td>
                                            <td>
                                                <fmt:formatNumber value="${item.service.servicePrice}" type="number" maxFractionDigits="0"/> VNĐ
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${item.service.servicePrice * item.guestsCount}" type="number" maxFractionDigits="0"/> VNĐ
                                            </td>
                                        </tr>
                                        <c:set var="grandTotal" value="${grandTotal + item.service.servicePrice * item.guestsCount}" />
                                    </c:forEach>

                                    <!-- REGULAR SERVICES -->
                                    <c:forEach var="item" items="${sessionScope.cartServices}">
                                        <tr>
                                            <td><strong>${item.service.serviceName}</strong> <span class="badge bg-success">Service</span></td>
                                            <td>${item.service.serviceType}</td>
                                            <td><fmt:formatDate value="${item.checkInDate}" pattern="yyyy-MM-dd"/></td>
                                            <td><fmt:formatDate value="${item.checkOutDate}" pattern="yyyy-MM-dd"/></td>
                                            <td>${item.guestsCount}</td>
                                            <td>
                                                <fmt:formatNumber value="${item.service.price}" type="number" maxFractionDigits="0"/> VNĐ
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${item.service.price * item.guestsCount}" type="number" maxFractionDigits="0"/> VNĐ
                                            </td>
                                        </tr>
                                        <c:set var="grandTotal" value="${grandTotal + item.service.price * item.guestsCount}" />
                                    </c:forEach>

                                </tbody>
                                <tfoot>
                                    <tr class="table-light fw-bold">
                                        <td colspan="6" class="text-end">Grand Total:</td>
                                        <td>
                                            <fmt:formatNumber value="${grandTotal}" type="number" maxFractionDigits="0"/> VNĐ
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>

                        <!-- Action Buttons -->
                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-secondary btn-lg">
                                <i class="fa fa-arrow-left"></i> Back to Cart
                            </a>
                            <a href="${pageContext.request.contextPath}/extra-service-confirm" class="btn btn-success btn-lg">
                                <i class="fa fa-check"></i> Confirm & Pay
                            </a>
                        </div>
                    </c:if>

                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
