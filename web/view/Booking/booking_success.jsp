<%-- 
    Document   : booking_success
    Created on : Nov 2, 2025
    Author     : taqua
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Booking Success</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/rooms.css" rel="stylesheet">
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <style>
            .card-success {
                background-color: #fff;
                border-radius: 15px;
                padding: 2rem;
                box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.15);
            }
            .btn-theme {
                background-color: #ffb800;
                color: #fff;
                border: none;
            }
            .btn-theme:hover {
                background-color: #e6a800;
            }
        </style>
    </head>
    <body class="bg-light">

        <!-- Header -->
        <jsp:include page="/view/common/header.jsp" />

        <!-- Page Banner -->
        <section id="center" class="center_o pt-4 pb-5 text-center bg-dark text-white">
            <div class="container-xl">
                <h2 class="text-uppercase">My Booking</h2>
                <h6 class="mb-0 mt-3">
                    <a class="text-white" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                    <span class="mx-2 col_yell">/</span>My Booking
                </h6>
            </div>
        </section>

        <!-- Booking Card -->
        <div class="container mt-5">
            <div class="card card-success text-center mx-auto" style="max-width: 700px;">
                <h2 class="fw-bold mb-4 col_yell">Booking Successful!</h2>

                <c:if test="${bookingSuccess}">
                    <p>Thank you, <strong>${user.username}</strong>. Your booking (#${bookingId}) has been confirmed.</p>
                    <p>
                        Subtotal: <strong class="col_yell">${subtotal} ₫</strong> | 
                        Discount: <strong class="col_yell">${discount} ₫</strong> | 
                        Total: <strong class="col_yell">${grandTotal} ₫</strong>
                    </p>
                    <p>Please choose what to do next:</p>

                    <div class="d-flex justify-content-center gap-3 mt-3 flex-wrap">
                        <!-- Form đi tới Payment bằng POST -->
                        <form action="${pageContext.request.contextPath}/payment" method="post">
                            <input type="hidden" name="bookingId" value="${bookingId}">
                            <input type="hidden" name="grandTotal" value="${grandTotal}">
                            <input type="hidden" name="orderInfo" value="Payment for booking #${bookingId}">
                            <button type="submit" class="btn btn-theme btn-lg">Go to Payment</button>
                        </form>

                        <!-- Nút đi tới Booking History -->
                        <a id="btnViewMyServices" href="${pageContext.request.contextPath}/booking-list" class="btn btn-secondary btn-lg"
                           onclick="window.location.href='${pageContext.request.contextPath}/booking-list'; return false;">
                            View My Bookings
                        </a>
                    </div>

                </c:if>
            </div>
        </div>

        <!-- Success Message -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success container mt-4">
                ${sessionScope.successMessage}
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
