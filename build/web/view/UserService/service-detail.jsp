<%-- 
    Document   : service-detail
    Created on : Nov 12, 2025, 6:42:22 AM
    Author     : Legion
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Service Detail</title>
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
                <h2 class="text-uppercase">Service Detail</h2>
                <h6 class="mb-0 mt-3 text-warning">
                    <a class="text-white" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                    <span class="mx-2 text-muted">/</span> Service Detail
                </h6>
            </div>
        </section>

        <section id="room" class="p_3">
            <div class="container-xl">
                <c:if test="${not empty service}">
                    <div class="row mb-4">
                        <div class="col-md-5">
                            <c:set var="imgFile" value="single_room.jpg"/>
                            <img src="${pageContext.request.contextPath}/img/${imgFile}" class="img-fluid rounded" alt="Room Image">
                        </div>
                        <div class="col-md-7">
                            <h1 class="mb-3">${service.serviceName}</h1>
                            <ul class="list-unstyled mb-3">
                                <li><i class="fa fa-user me-2 col_yell"></i> ${service.serviceType}</li>
                                <li><i class="fa fa-money me-2 col_yell"></i> ${service.price} $/night</li>
                                <li><i class="fa fa-info-circle me-2 col_yell"></i> Description ${service.description}</li>
                            </ul>

                            <!-- Form add to cart -->
                            <form action="${pageContext.request.contextPath}/service-cart" method="post" class="mt-3">
                                <input type="hidden" name="action" value="add"/>
                                <input type="hidden" name="serviceId" value="${service.serviceId}"/>
                                <div class="row g-2">
                                    <div class="col-md-4">
                                        <label class="form-label">Time-start</label>
                                        <input type="date" name="checkInDate" class="form-control" required
                                               min="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd'/>"
                                               value="${param.checkInDate != null ? param.checkInDate : ''}"/>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Time-end</label>
                                        <input type="date" name="checkOutDate" class="form-control" required
                                               min="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd'/>"
                                               value="${param.checkOutDate != null ? param.checkOutDate : ''}"/>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="form-label">Guests</label>
                                        <input type="number" name="guestsCount" class="form-control"
                                               min="1"
                                               value="${param.guestsCount != null ? param.guestsCount : 1}" required/>
                                    </div>
                                    <div class="col-md-12 mt-2">
                                        <button type="submit" class="btn btn-warning">
                                            Add to Cart
                                        </button>

                                    </div>

                                    <c:if test="${param.success ne null}">
                                        <div class="alert alert-success" role="alert">
                                            Add to cart successfully
                                        </div>
                                    </c:if>
                                </div>
                            </form>
                        </div>
                    </div>
                </c:if>
            </div>
        </section>
    </body>
</html>
