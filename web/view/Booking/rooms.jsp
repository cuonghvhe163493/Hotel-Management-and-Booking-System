<%-- 
    Document   : rooms
    Created on : Oct 20, 2025
    Author     : taqua
--%>

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
            .room-count { color: #fff; margin-bottom: 15px; }
            .room-attr i { margin-right: 5px; color: #ffb800; }
            .pagination button.active { background-color: #ffb800; border-color: #ffb800; }
            .floor-label { color: #fff; font-weight: bold; margin-bottom: 10px; }
        </style>
    </head>
    <body>
        <!-- Header & Navbar -->
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
                        <h2 class="text-white text-uppercase">Rooms</h2>
                        <h6 class="mb-0 mt-3 col_yell">
                            <a class="text-white" href="#">Home</a> <span class="mx-2 text-muted">/</span> Rooms
                        </h6>
                    </div>
                </section>
            </div>
        </div>

        <section id="room" class="p_3">
            <div class="container-xl">
                <div class="row">

                    <!-- Left: Room list -->
                    <div class="col-md-8">
                        <div class="room_1l">
                            <div class="room-count mb-3">0 Rooms</div>

                            <div class="room_1l1 row bg-light p-4 px-3 mx-0">
                                <div class="col-md-7">
                                    <input class="form-control border-0" id="example-date" type="date" name="date">
                                </div>
                                <div class="col-md-5">
                                    <h6 class="mb-0"><a class="button d-block text-center fw-bold" href="detail.html">Check Rates</a></h6>
                                </div>
                            </div>

                            <!-- Rooms Loop -->
                            <c:set var="counter" value="0"/>
                            <c:forEach var="room" items="${rooms}">
                                <c:set var="imgFile" value="" />
                                <c:choose>
                                    <c:when test="${room.roomType eq 'Single'}"><c:set var="imgFile" value="single_room.jpg" /></c:when>
                                    <c:when test="${room.roomType eq 'Double'}"><c:set var="imgFile" value="double_room.jpg" /></c:when>
                                    <c:when test="${room.roomType eq 'Suite'}"><c:set var="imgFile" value="suite_room.jpg" /></c:when>
                                    <c:when test="${room.roomType eq 'Family'}"><c:set var="imgFile" value="family_room.jpg" /></c:when>
                                    <c:when test="${room.roomType eq 'Deluxe'}"><c:set var="imgFile" value="deluxe_room.jpg" /></c:when>
                                    <c:otherwise><c:set var="imgFile" value="default_room.jpg" /></c:otherwise>
                                </c:choose>

                                <c:if test="${counter % 2 == 0}"><div class="room_2i row mt-4"></c:if>
                                        <div class="col-md-6">
                                            <div class="room_2il" 
                                                 data-type="${room.roomType}" 
                                                 data-capacity="${room.capacity}" 
                                                 data-status="${room.roomStatus}" 
                                                 data-price="${room.pricePerNight}"
                                                 data-room-number="${room.roomNumber}">
                                                <div class="room_2il1 position-relative">
                                                    <div class="room_2il1i">
                                                        <figure class="effect-jazz mb-0">
                                                            <a href="room-detail?id=${room.roomId}">
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
                                                        <a href="room-detail?id=${room.roomId}">
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
                                    <c:set var="counter" value="${counter + 1}"/>
                                    <c:if test="${counter % 2 == 0 || counter == fn:length(rooms)}"></div></c:if>
                                </c:forEach>

                            <div class="pagination-container mt-4 text-center"></div>
                        </div>
                    </div>

                    <!-- Right: Filter + Sort Sidebar -->
                    <div class="col-md-4">
                        <div class="room_sidebar bg-light p-4 mb-3">
                            <h5 class="mb-3">Sort by:</h5>
                            <select id="sortRooms" class="form-select">
                                <option value="default">Default</option>
                                <option value="priceAsc">Price: Low → High</option>
                                <option value="priceDesc">Price: High → Low</option>
                                <option value="capacityAsc">Capacity: Low → High</option>
                                <option value="capacityDesc">Capacity: High → Low</option>
                            </select>
                        </div>

                        <div class="room_sidebar bg-light p-4">
                            <h5 class="mb-3">Filter Rooms:</h5>
                            <div class="mb-4">
                                <label for="priceRange" class="form-label">Price (max $)</label>
                                <input type="number" id="priceRange" class="form-control" placeholder="Enter max price">
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Room Type</label>
                                <c:set var="roomTypesSet" value=""/>
                                <c:forEach var="r" items="${rooms}">
                                    <c:if test="${not fn:contains(roomTypesSet, r.roomType)}">
                                        <c:set var="roomTypesSet" value="${roomTypesSet},${r.roomType}" />
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="roomType" value="${r.roomType}" id="type_${r.roomType}">
                                            <label class="form-check-label" for="type_${r.roomType}">${r.roomType}</label>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Capacity</label>
                                <c:forEach var="cap" items="${[1,2,3,4,5]}">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="capacity" value="${cap}" id="cap_${cap}">
                                        <label class="form-check-label" for="cap_${cap}">${cap} person(s)</label>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Floor</label>
                                <c:set var="floorSet" value=""/>
                                <c:forEach var="r" items="${rooms}">
                                    <c:set var="floor" value="${fn:substring(r.roomNumber, 0, fn:length(r.roomNumber) - 2)}"/>
                                    <c:if test="${not fn:contains(floorSet, floor)}">
                                        <c:set var="floorSet" value="${floorSet},${floor}" />
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="floor" value="${floor}" id="floor_${floor}">
                                            <label class="form-check-label" for="floor_${floor}">${floor}</label>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>

                            <div class="mb-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="availableOnly" value="true" id="availableOnly">
                                    <label class="form-check-label" for="availableOnly">Available Only</label>
                                </div>
                            </div>

                            <button class="btn btn-primary w-100" type="button" id="applyFilters">Apply Filters</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const container = document.querySelector(".room_1l");
                const roomCards = Array.from(container.querySelectorAll(".room_2il"));
                const roomCountEl = document.querySelector(".room-count");

                const priceInput = document.getElementById("priceRange");
                const typeChecks = Array.from(document.querySelectorAll("input[name='roomType']"));
                const capacityChecks = Array.from(document.querySelectorAll("input[name='capacity']"));
                const availableOnlyCheck = document.getElementById("availableOnly");
                const applyBtn = document.getElementById("applyFilters");
                const sortSelect = document.getElementById("sortRooms");

                const roomsPerPage = 6;
                let currentPage = 1;
                let filteredCards = roomCards.slice();

                // ensure dataset
                roomCards.forEach(card => {
                    card.dataset.price = parseFloat(card.dataset.price) || 0;
                    card.dataset.capacity = parseInt(card.dataset.capacity) || 0;
                    card.dataset.type = card.dataset.type || "";
                    card.dataset.status = card.dataset.status.toLowerCase();
                    card.dataset.roomNumber = parseInt(card.dataset.roomNumber) || 0;
                    const roomNumber = parseInt(card.dataset.roomNumber) || 0;
                    card.dataset.floor = Math.floor(roomNumber / 100);
                });

                const paginationContainer = document.querySelector(".pagination-container");

                function updateRoomCount() {
                    roomCountEl.textContent = filteredCards.length + " Rooms";
                }

                function filterRooms() {
                    const maxPrice = parseFloat(priceInput.value) || Infinity;
                    const selectedTypes = typeChecks.filter(c => c.checked).map(c => c.value);
                    const selectedCaps = capacityChecks.filter(c => c.checked).map(c => parseInt(c.value));
                    const availableOnly = availableOnlyCheck.checked;
                    const floorChecks = Array.from(document.querySelectorAll("input[name='floor']"));
                    const selectedFloors = floorChecks.filter(c => c.checked).map(c => parseInt(c.value));

                    filteredCards = roomCards.filter(card => {
                        const price = parseFloat(card.dataset.price);
                        const type = card.dataset.type;
                        const capacity = parseInt(card.dataset.capacity);
                        const status = card.dataset.status;
                        const floor = parseInt(card.dataset.floor);

                        if (price > maxPrice) return false;
                        if (selectedTypes.length && !selectedTypes.includes(type)) return false;
                        if (selectedCaps.length && !selectedCaps.includes(capacity)) return false;
                        if (availableOnly && status !== "available") return false;
                        if (selectedFloors.length && !selectedFloors.includes(floor)) return false;

                        return true;
                    });

                    currentPage = 1;
                    sortRooms();
                }

                function sortRooms() {
                    const sortType = sortSelect.value;
                    filteredCards.sort((a, b) => {
                        const priceA = Number(a.dataset.price);
                        const priceB = Number(b.dataset.price);
                        const capA = Number(a.dataset.capacity);
                        const capB = Number(b.dataset.capacity);
                        const roomA = Number(a.dataset.roomNumber);
                        const roomB = Number(b.dataset.roomNumber);

                        switch (sortType) {
                            case "priceAsc": return priceA - priceB;
                            case "priceDesc": return priceB - priceA;
                            case "capacityAsc": return capA - capB;
                            case "capacityDesc": return capB - capA;
                            default: return roomA - roomB;
                        }
                    });
                    currentPage = 1;
                    showPage(currentPage);
                }

                function showPage(page) {
                    container.querySelectorAll(".room_2i").forEach(r => r.remove());
                    const start = (page - 1) * roomsPerPage;
                    const end = start + roomsPerPage;

                    for (let i = start; i < end && i < filteredCards.length; i += 2) {
                        const row = document.createElement("div");
                        row.className = "room_2i row mt-4";
                        row.appendChild(filteredCards[i].parentElement.cloneNode(true));
                        if (filteredCards[i + 1] && i + 1 < end)
                            row.appendChild(filteredCards[i + 1].parentElement.cloneNode(true));
                        container.insertBefore(row, paginationContainer);
                    }
                    updateRoomCount();
                    renderPagination(Math.ceil(filteredCards.length / roomsPerPage));
                }

                function renderPagination(totalPages) {
                    paginationContainer.innerHTML = "";
                    if (totalPages <= 1) return;
                    for (let i = 1; i <= totalPages; i++) {
                        const btn = document.createElement("button");
                        btn.textContent = i;
                        btn.className = "btn btn-sm btn-secondary mx-1";
                        if (i === currentPage) btn.classList.add("active");
                        btn.addEventListener("click", () => {
                            currentPage = i;
                            showPage(currentPage);
                        });
                        paginationContainer.appendChild(btn);
                    }
                }

                applyBtn.addEventListener("click", filterRooms);
                sortSelect.addEventListener("change", sortRooms);

                // initial sort by room number
                sortRooms();
            });
        </script>
    </body>
</html>
