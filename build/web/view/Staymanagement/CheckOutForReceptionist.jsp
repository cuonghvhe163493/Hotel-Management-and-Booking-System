
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Check In</title>
        <link href="${pageContext.request.contextPath}/view/Staymanagement/css/bootstrap.min.css" rel="stylesheet" >
        <link href="${pageContext.request.contextPath}/view/Staymanagement/css/font-awesome.min.css" rel="stylesheet" >
        <link href="${pageContext.request.contextPath}/view/Staymanagement/css/global.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/view/Staymanagement/css/rooms.css" rel="stylesheet">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/Staymanagement/css/checkin.css">
        <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@500&display=swap" rel="stylesheet">
        <script src="js/bootstrap.bundle.min.js"></script>
    </head>

    <body>
        <div class="main_room">
            <div class="main_o1">
                <section id="top" class="pt-3 pb-3">
                    <div class="container-xl">
                        <div class="row top_1">
                            <div class="col-md-4">
                                <div class="top_1l">
                                    <span class="d-inline-block bg_yell  rounded-circle float-start me-2 text-center"><a href="#"><i class="fa fa-phone text-white"></i></a></span>
                                    <h6 class="mb-0 lh-base font_14"><a class="text-white" href="#">For Further Inquires : <br>
                                            +(000) 345 67 89</a></h6>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="top_1m text-center mt-2">
                                    <h3 class="mb-0"><a class="text-white" href="index.html"><i class="fa fa-plane col_yell"></i> HMBS</a></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <section id="header">
                    <nav class="navbar navbar-expand-md navbar-light pt-3 pb-3" id="navbar_sticky">
                        <div class="container-xl">
                            <a class="navbar-brand fs-3 p-0 fw-bold text-white" href="index.html"><i class="fa fa-plane col_yell"></i> HMBS </a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                <ul class="navbar-nav mb-0">

                                    <li class="nav-item">
                                        <a class="nav-link" aria-current="page" href="index.html">Home</a>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link" href="about.html">About </a>
                                    </li>

                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle active" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                            Rooms
                                        </a>
                                        <ul class="dropdown-menu drop_1" aria-labelledby="navbarDropdown">
                                            <li><a class="dropdown-item" href="rooms.html"> Rooms</a></li>
                                            <li><a class="dropdown-item border-0" href="detail.html"> Room Detail</a></li>
                                        </ul>
                                    </li>

                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                            Blog
                                        </a>
                                        <ul class="dropdown-menu drop_1" aria-labelledby="navbarDropdown">
                                            <li><a class="dropdown-item" href="blog.html"> Blog</a></li>
                                            <li><a class="dropdown-item border-0" href="blog_detail.html"> Blog Detail</a></li>
                                        </ul>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link" href="services.html">Services</a>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link" href="gallery.html">Gallery</a>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link" href="contact.html">Contact</a>
                                    </li>

                                </ul>
                                <ul class="navbar-nav mb-0 ms-auto">
                                    <li class="nav-item">
                                        <a class="nav-link button" href="#">BOOK NOW </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </nav>
                </section>
                <section id="center" class="center_o pt-4 pb-5">
                    <div class="container-xl">
                        <div class="row center_o1 text-center">
                            <div class="col-md-12">
                                <h2 class="text-white text-uppercase">Rooms</h2>
                                <h6 class="mb-0 mt-3 col_yell"><a class="text-white" href="#">Stay Room</a> <span class="mx-2 text-muted">/</span> Check In </h6>
                            </div>
                        </div>
                    </div>   
                </section>
            </div>
        </div>

        <div class="check-in">
            <div class="check-in-container">

                
                <p class="word-booked">Booked</p>
                <select class="booked-selection" name="Booked" id="bookedSelect">
                    <option value="Yes">Yes</option>
                    <option value="No">No</option>
                </select>
                
                <form action="${pageContext.request.contextPath}/CheckInServlet" method="get" class="check-in-input-container">
                    <div id="bookingIdField" style="display:block;">
                        <p>Phone Number: <input type="text" name="phoneNumber" placeholder="Phone Number" /></p>   
                        <input type="submit" class="send-btn" value="Check" />
                    </div>
                </form>

                
                <form action="${pageContext.request.contextPath}/CheckInServlet" method="post" class="check-in-input-container">
                    <div id="extraFields" style="display:none;">
                        <p>Room ID: <input type="text" name="idroom" placeholder="ID Room" required /></p>
                        <p>Customer Name: <input type="text" name="name" placeholder="Name" required /></p>
                        <p>Citizen ID: <input type="text" name="citizenId" placeholder="Citizen ID" required /></p>
                        <div>
                            <p>Number of people: 
                                <input type="text" id="numberInput" name="numPeople" list="people" placeholder="Number of people">
                                <datalist id="people">
                                    <option value="1"><option value="2"><option value="3"><option value="4">
                                    <option value="5"><option value="6"><option value="7"><option value="8">
                                    <option value="9"><option value="10">
                                </datalist>
                            </p>
                        </div>

                        <p>Check-in Date: <input type="date" name="checkInDate" /></p>    
                        <p>Check-out Date: <input type="date" name="checkOutDate" /></p> 
                        <p>Gmail: <input type="email" name="gmail" placeholder="Gmail" /></p>
                        <p>Phone: <input type="text" name="phone" placeholder="Phone" /></p>
                        <p>Note<input type="text" name="note" value="" /></p>
                        <input type="submit" class="send-btn" value="Check" />
                    </div>

                </form>
                <div class="info-customer">
                    <br>
                    <h4>Information Customer</h4>
                    <p>===============================================</p>
                    <p>Customer name: ${info.name}</p>
                    <p>User Id: ${info.userId}</p>
                    <p>Email: ${info.gmail}</p>
                    <p>===============================================</p>
                </div>    
            </div>
            <div class="check-info-container">
                <h3>Booking Information</h3>
                <div style="margin-bottom: 10px;">
                    <input type="checkbox" id="selectAll" />
                    <label for="selectAll"><strong>Select All Rooms</strong></label>
                </div>

                <form action="${pageContext.request.contextPath}/CheckInServlet" method="post" id="checkInfoForm">
                    <div id="roomListContainer" class="room-list-container">
                        <c:forEach var="room" items="${list}">
                            <div class="room-block" data-roomid="${room.roomId}">                                
                                <input type="checkbox" name="selectedRooms" value="${room.roomId}" id="room_${room.roomId}">
                                <label for="room_${room.roomId}">
                                    <strong>Booking ID: ${room.bookingId}</strong><br>
                                    <strong>Room: ${room.roomNumber} - Room ID: ${room.roomId}</strong><br>
                                    Type: ${room.roomType} - Check In Date: ${room.checkInDate}<br>
                                    Price: ${room.pricePerNight}
                                </label>
                            </div>
                                <p>================================================</p>
                        </c:forEach>
                    </div>

                    <br>
                    <input type="submit" class="send-btn" value="Check In">
                </form>
            </div>       
        </div>
        <script>
            document.getElementById('selectAll').addEventListener('change', function () {
                const checkboxes = document.querySelectorAll('input[name="selectedRooms"]');
                checkboxes.forEach(cb => cb.checked = this.checked);
            });
        </script>            
        <script>
            const bookedSelect = document.getElementById("bookedSelect");
            const extraFields = document.getElementById("extraFields");
            const bookingIdField = document.getElementById("bookingIdField");

            bookedSelect.addEventListener("change", function () {
                if (this.value === "No") {
                    extraFields.style.display = "block";
                    bookingIdField.style.display = "none";
                } else if (this.value === "Yes") {
                    extraFields.style.display = "none";
                    bookingIdField.style.display = "block";
                } else {
                    extraFields.style.display = "none";
                    bookingIdField.style.display = "none";
                }
            });
        </script>

        <section id="footer" class="p-4 bg-dark text-light">
            <div class="container-xl">
                <div class="row">
                    <!-- Logo & Description -->
                    <div class="col-md-3 mb-4">
                        <h4 class="text-white mb-2">
                            <i class="fa fa-plane text-warning"></i>HMBS
                        </h4>
                        <p class="small mb-0">
                            Your comfort is our priority. Experience modern hospitality with us.
                        </p>
                    </div>
                    <div class="col-md-3 mb-4">
                        <h6 class="text-white mb-3">Quick Links</h6>
                        <ul class="list-unstyled small">
                            <li><a href="#" class="text-light text-decoration-none">Home</a></li>
                            <li><a href="#" class="text-light text-decoration-none">About</a></li>
                            <li><a href="#" class="text-light text-decoration-none">Rooms</a></li>
                            <li><a href="#" class="text-light text-decoration-none">Contact</a></li>
                        </ul>
                    </div>

                    
                    <div class="col-md-3 mb-4">
                        <h6 class="text-white mb-3">Contact Us</h6>
                        <p class="small mb-1">123 Street, New York, USA</p>
                        <p class="small mb-1">Phone: +1 234 567 890</p>
                        <p class="small mb-0">Email: info@hotells.com</p>
                    </div>

                    
                    <div class="col-md-3 mb-4">
                        <h6 class="text-white mb-3">Stay Updated</h6>
                        <div class="input-group">
                            <input type="email" class="form-control rounded-0" placeholder="Your Email">
                            <button class="btn btn-warning text-dark rounded-0" type="button">
                                <i class="fa fa-paper-plane"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <hr class="border-secondary my-3">

                <div class="text-center small">
                    © 2025 HMBS. All Rights Reserved.
                </div>
            </div>
        </section>

        <script>
            window.onscroll = function () {
                myFunction()
            };
            var navbar_sticky = document.getElementById("navbar_sticky");
            var sticky = navbar_sticky.offsetTop;
            var navbar_height = document.querySelector('.navbar').offsetHeight;
            function myFunction() {
                if (window.pageYOffset >= sticky + navbar_height) {
                    navbar_sticky.classList.add("sticky")

                } else {
                    navbar_sticky.classList.remove("sticky");
                    document.body.style.paddingTop = '0'
                }
            }
        </script>



    </body>
</html>