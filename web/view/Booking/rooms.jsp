<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Rooms</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/rooms.css" rel="stylesheet">
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <style>
            .room-count {
                color: #fff;
                margin-bottom: 15px;
            }
            .room-attr i {
                margin-right: 5px;
                color: #ffb800;
            }
            .pagination .page-link.active, .pagination .active>.page-link {
                background-color: #ffb800;
                border-color: #ffb800;
                color: #fff;
            }
            .floor-label {
                color: #fff;
                font-weight: bold;
                margin-bottom: 10px;
            }
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
                        <h2 class="text-white text-uppercase">Rooms</h2>
                        <h6 class="mb-0 mt-3 col_yell">
                            <a class="text-white" href="#">Home</a> <span class="mx-2 text-muted">/</span> Rooms
                        </h6>
                    </div>
                </section>
            </div>
        </div>

        <!-- Content -->
        <section id="room" class="p_3">
            <div class="container-xl">
                <div class="row">

                    <!-- Left: Room list -->
                    <div class="col-md-8">
                        <div class="room_1l">
                            <div class="room-count mb-3">${fn:length(rooms)} Rooms</div>

                            <!-- Form Check-in / Check-out -->
                            <form class="room_1l1 row bg-light p-4 px-3 mx-0 mb-4" action="${pageContext.request.contextPath}/rooms" method="get">
                                <div class="col-md-5">
                                    <label class="form-label">Check-in</label>
                                    <input class="form-control border-0" type="date" name="checkInDate" value="${param.checkInDate}">
                                </div>
                                <div class="col-md-5">
                                    <label class="form-label">Check-out</label>
                                    <input class="form-control border-0" type="date" name="checkOutDate" value="${param.checkOutDate}">
                                </div>
                                <div class="col-md-2 d-flex align-items-end">
                                    <button type="submit" class="btn btn-warning w-100 fw-bold">Check</button>
                                </div>
                                <!-- Giữ các param khác khi submit -->
                                <input type="hidden" name="sort" value="${param.sort}">
                                <input type="hidden" name="roomType" value="${param.roomType}">
                                <input type="hidden" name="capacity" value="${param.capacity}">
                                <input type="hidden" name="maxPrice" value="${param.maxPrice}">
                                <input type="hidden" name="availableOnly" value="${param.availableOnly}">
                            </form>

                            <!-- Rooms Loop -->
                            <c:set var="counter" value="0" />
                            <c:forEach var="room" items="${rooms}">
                                <c:set var="imgFile" value="default_room.jpg" />
                                <c:choose>
                                    <c:when test="${room.roomType eq 'Single'}"><c:set var="imgFile" value="single_room.jpg" /></c:when>
                                    <c:when test="${room.roomType eq 'Double'}"><c:set var="imgFile" value="double_room.jpg" /></c:when>
                                    <c:when test="${room.roomType eq 'Suite'}"><c:set var="imgFile" value="suite_room.jpg" /></c:when>
                                    <c:when test="${room.roomType eq 'Family'}"><c:set var="imgFile" value="family_room.jpg" /></c:when>
                                    <c:when test="${room.roomType eq 'Deluxe'}"><c:set var="imgFile" value="deluxe_room.jpg" /></c:when>
                                </c:choose>

                                <c:if test="${counter % 2 == 0}"><div class="room_2i row mt-4"></c:if>

                                        <div class="col-md-6">
                                            <div class="room_2il">
                                                <div class="room_2il1 position-relative">
                                                    <div class="room_2il1i">
                                                        <figure class="effect-jazz mb-0">
                                                            <a href="${pageContext.request.contextPath}/room-detail?id=${room.roomId}">
                                                            <img src="${pageContext.request.contextPath}/img/${imgFile}" class="w-100" alt="Room Image">
                                                        </a>
                                                    </figure>
                                                </div>
                                                <div class="room_2il1i1 text-center position-absolute w-100">
                                                    <span class="d-inline-block bg_yell text-white p-2 px-4">
                                                        <i class="fa fa-dollar"></i> ${room.pricePerNight}
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="room_2il2 bg-light text-center p-4">
                                                <h4 class="mt-2">
                                                    <a href="${pageContext.request.contextPath}/room-detail?id=${room.roomId}">
                                                        <i class="fa fa-bed"></i> ${room.roomType} Room - #${room.roomNumber}
                                                    </a>
                                                </h4>
                                                <p class="font_14 room-attr">
                                                <div><i class="fa fa-users"></i> Capacity: ${room.capacity}</div>
                                                <div><i class="fa fa-circle" style="color: ${room.roomStatus eq 'available' ? 'green' : 'red'}"></i> Status: ${room.roomStatus}</div>
                                                </p>
                                            </div>
                                        </div>
                                    </div>

                                    <c:set var="counter" value="${counter + 1}" />
                                    <c:if test="${counter % 2 == 0 || counter == fn:length(rooms)}"></div></c:if>
                                </c:forEach>

                            <!-- Pagination -->
                            <nav class="mt-4">
                                <ul class="pagination justify-content-center">
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link"
                                               href="${pageContext.request.contextPath}/rooms?page=${i}<c:if test='${not empty param.sort}'>&amp;sort=${param.sort}</c:if><c:if test='${not empty param.roomType}'>&amp;roomType=${param.roomType}</c:if><c:if test='${not empty param.capacity}'>&amp;capacity=${param.capacity}</c:if><c:if test='${not empty param.maxPrice}'>&amp;maxPrice=${param.maxPrice}</c:if><c:if test='${not empty param.availableOnly}'>&amp;availableOnly=${param.availableOnly}</c:if><c:if test='${not empty param.checkInDate}'>&amp;checkInDate=${param.checkInDate}</c:if><c:if test='${not empty param.checkOutDate}'>&amp;checkOutDate=${param.checkOutDate}</c:if>">
                                                ${i}
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </nav>

                        </div>
                    </div>

                    <!-- Right: Filter + Sort Sidebar -->
                    <div class="col-md-4">
                        <form action="${pageContext.request.contextPath}/rooms" method="get">
                            <div class="room_sidebar bg-light p-4 mb-3">
                                <h5 class="mb-3">Sort by:</h5>
                                <select name="sort" class="form-select" onchange="this.form.submit()">
                                    <option value="">Default</option>
                                    <option value="priceAsc" ${param.sort eq 'priceAsc' ? 'selected' : ''}>Price: Low → High</option>
                                    <option value="priceDesc" ${param.sort eq 'priceDesc' ? 'selected' : ''}>Price: High → Low</option>
                                    <option value="capacityAsc" ${param.sort eq 'capacityAsc' ? 'selected' : ''}>Capacity: Low → High</option>
                                    <option value="capacityDesc" ${param.sort eq 'capacityDesc' ? 'selected' : ''}>Capacity: High → Low</option>
                                </select>

                            </div>

                            <div class="room_sidebar bg-light p-4">
                                <h5 class="mb-3">Filter Rooms:</h5>

                                <div class="mb-4">
                                    <label class="form-label">Room Type</label>
                                    <select name="roomType" class="form-select">
                                        <option value="">All</option>
                                        <option value="Single" ${param.roomType eq 'Single' ? 'selected' : ''}>Single</option>
                                        <option value="Double" ${param.roomType eq 'Double' ? 'selected' : ''}>Double</option>
                                        <option value="Suite" ${param.roomType eq 'Suite' ? 'selected' : ''}>Suite</option>
                                        <option value="Family" ${param.roomType eq 'Family' ? 'selected' : ''}>Family</option>
                                        <option value="Deluxe" ${param.roomType eq 'Deluxe' ? 'selected' : ''}>Deluxe</option>
                                    </select>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label">Capacity</label>
                                    <input type="number" class="form-control" name="capacity" value="${param.capacity}">
                                </div>

                                <div class="mb-4">
                                    <label class="form-label">Max Price ($)</label>
                                    <input type="number" class="form-control" name="maxPrice" value="${param.maxPrice}">
                                </div>

                                <div class="mb-4 form-check">
                                    <input class="form-check-input" type="checkbox" name="availableOnly" value="true" id="availableOnly"
                                           ${param.availableOnly eq 'true' ? 'checked' : ''}>
                                    <label class="form-check-label" for="availableOnly">Available Only</label>
                                </div>

                                <button class="btn btn-primary w-100" type="submit">Apply Filters</button>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </section>
    </body>
</html>
