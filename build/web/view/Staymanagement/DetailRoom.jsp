<%-- 
    Document   : CommunicationChatBox
    Created on : Oct 24, 2025, 10:35:55 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Communication</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" >
        <link href="css/font-awesome.min.css" rel="stylesheet" >
        <link href="css/global.css" rel="stylesheet">
        <link href="css/rooms.css" rel="stylesheet">
        <link href="css/stay.css" rel="stylesheet">
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

                            <div class="col-md-4">
                                <div class="top_1r mt-2 text-end">
                                    <ul class="mb-0">
                                        <li class="d-inline-block"><a class="text-white" href="#"><i class="fa fa-facebook"></i></a></li>
                                        <li class="d-inline-block"><a class="text-white" href="#"><i class="fa fa-instagram"></i></a></li>
                                        <li class="d-inline-block"><a class="text-white" href="#"><i class="fa fa-tripadvisor"></i></a></li>
                                        <li class="d-inline-block"><a class="text-white" href="#"><i class="fa fa-pinterest"></i></a></li>
                                        <li class="d-inline-block"><a class="text-white" href="#"><i class="fa fa-tumblr"></i></a></li>
                                    </ul>
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
                                <h6 class="mb-0 mt-3 col_yell"><a class="text-white" href="#">Home</a> <span class="mx-2 text-muted">/</span> Rooms </h6>
                            </div>
                        </div>
                    </div>   
                </section>
            </div>
        </div>

        <div>
            <h1>Details</h1>
            <div>
                <!--customer-->
                <p>Room Number: ${room.room}</p>
                <p>Room Id: ${room.roomId}</p>
                <p>Room type: ${room.roomType}</p>
                <p>Booking Id: ${room.bookingId}</p>
                <p>Number of people: </p>
                <p>Service: </p>
                <p>Capacity: ${room.capacity}</p>
                <p>Price: ${room.pricePerNight}</p>
                <p>Check In Date: ${room.checkInDate}</p>
                <p>Check Out Date: ${room.checkOutDate}</p>
                    
            </div>

            <!--receptionist-->               
            <div>
                Booking ID:

                Booking status:

                Check In Date:

                Check Out Date:

                Room ID:

                Room number:

                Room status:

                Room type:

                Capacity:

                Price Per Night:

                Price:

                Deposit required:

                Customer name:

                Number of people:

                Email:

                Phone:    
            </div>            

        </div>









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

                    <!-- Contact -->
                    <div class="col-md-3 mb-4">
                        <h6 class="text-white mb-3">Contact Us</h6>
                        <p class="small mb-1">123 Street, New York, USA</p>
                        <p class="small mb-1">Phone: +1 234 567 890</p>
                        <p class="small mb-0">Email: info@hotells.com</p>
                    </div>

                    <!-- Newsletter -->
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
    </body>
</html>
