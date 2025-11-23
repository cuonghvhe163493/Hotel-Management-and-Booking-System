<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- CSS / JS -->
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/rooms.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>

<style>
    .col_yell {
        color: #ffb800;
    }
    .bg_yell {
        background-color: #ffb800;
    }
    #navbar_sticky {
        background-color: #222;
    }
    #navbar_sticky .nav-link {
        color: #fff !important;
        margin-right: 15px;
    }
    #navbar_sticky .nav-link:hover {
        color: #ffb800 !important;
    }
    #top {
        background-color: #111;
    }
</style>

<div class="main_room_dt">
    <div class="main_o1">

        <!-- ===== TOP CONTACT BAR ===== -->
        <section id="top" class="pt-3 pb-3">
            <div class="container-xl">
                <div class="row top_1">
                    <div class="col-md-4">
                        <div class="top_1l">
                            <span class="d-inline-block bg_yell rounded-circle float-start me-2 text-center" style="width:30px;height:30px;line-height:30px;">
                                <a href="#"><i class="fa fa-phone text-white"></i></a>
                            </span>
                            <h6 class="mb-0 lh-base font_14">
                                <a class="text-white" href="#">For Further Inquiries : <br> </a>
                            </h6>
                        </div>
                    </div>
                    <div class="col-md-4 text-center mt-2">
                        <h3 class="mb-0">
                            <a class="text-white fw-bold" href="${pageContext.request.contextPath}/index.jsp">
                                <i class="fa fa-plane col_yell"></i> Hotells
                            </a>
                        </h3>
                    </div>
                    <div class="col-md-4 mt-2 text-end">
                        <ul class="mb-0 list-unstyled d-inline-block">
                            <li class="d-inline-block mx-2"><a class="text-white" href="#"><i class="fa fa-facebook"></i></a></li>
                            <li class="d-inline-block mx-2"><a class="text-white" href="#"><i class="fa fa-instagram"></i></a></li>
                            <li class="d-inline-block mx-2"><a class="text-white" href="#"><i class="fa fa-tripadvisor"></i></a></li>
                        </ul>

                        <!-- Login / Logout -->
                        <ul class="mb-0 list-unstyled d-inline-block ms-3">
                            <c:choose>
                                <c:when test="${empty sessionScope.user}">
                                    <li class="d-inline-block">
                                        <a href="${pageContext.request.contextPath}/login" class="text-warning fw-bold me-2">Login</a>
                                    </li>
                                    <li class="d-inline-block">
                                        <a href="${pageContext.request.contextPath}/view/Authentication/register.jsp" class="text-white fw-bold">Register</a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="d-inline-block">
                                        <a href="${pageContext.request.contextPath}/logout" 
                                           class="fw-bold me-2" 
                                           style="color:#ffb800;">Logout</a>
                                    </li>

                                    <li class="d-inline-block text-white ms-2">
                                        Hello, ${sessionScope.user.username}
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </div>
            </div>
        </section>

        <!-- ===== NAVBAR ===== -->
        <section id="header">
            <c:set var="cartCount" value="0" />
            <c:if test="${not empty sessionScope.cart || not empty sessionScope.cartServices || not empty sessionScope.cartExtraServices}">
                <c:set var="cartCount" value="${fn:length(sessionScope.cart) + fn:length(sessionScope.cartServices) + fn:length(sessionScope.cartExtraServices)}" />
            </c:if>

            <nav class="navbar navbar-expand-md navbar-dark pt-3 pb-3" id="navbar_sticky">
                <div class="container-xl">
                    <a class="navbar-brand fs-3 fw-bold text-white" href="${pageContext.request.contextPath}/index">
                        <i class="fa fa-plane col_yell"></i> Hotells
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarSupportedContent">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav mb-0">
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Home</a></li>                          
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/rooms">Rooms</a></li>

                            <c:choose>
                                <c:when test="${sessionScope.role == 'customer'}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/stayRoom?id=${sessionScope.customerId}">Stay Room</a>
                                    </li>
                                </c:when>
                                <c:when test="${sessionScope.role == 'hotel_manager'}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/stayRoomReceptionist">Stay Room</a>
                                    </li>
                                </c:when>
                            </c:choose>

                            <li class="nav-item"><a class="nav-link" href="services">Services</a></li>
                            <li class="nav-item"><a class="nav-link" href="extra-services">Extra Services</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/booking-list">Booking History</a></li>
                            
                        </ul>

                        <!-- Cart icon ch? hi?n th? khi login -->
                        <c:if test="${not empty sessionScope.user}">
                            <ul class="navbar-nav ms-auto">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                                        <i class="fa fa-shopping-cart me-1"></i> Cart 
                                        <span class="badge bg-warning text-dark">${cartCount}</span>
                                    </a>
                                </li>
                            </ul>
                        </c:if>

                    </div>
                </div>
            </nav>
        </section>
    </div>
</div>
