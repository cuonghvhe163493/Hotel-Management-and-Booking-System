<!DOCTYPE html>
<%@ page import="model.User" %>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Hotels</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" >
        <link href="css/font-awesome.min.css" rel="stylesheet" >
        <link href="css/global.css" rel="stylesheet">
        <link href="css/index.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@500&display=swap" rel="stylesheet">
        <script src="js/bootstrap.bundle.min.js"></script>

    </head>
    <body>

        <div class="main clearfix position-relative">
            <div class="main_1 clearfix position-absolute top-0 w-100">
                <section id="top" class="pt-3 pb-3">
                    <div class="container-xl">
                        <div class="row top_1">

                            <!-- Left: Phone -->
                            <div class="col-md-4">
                                <div class="top_1l">
                                    <span class="d-inline-block bg_yell rounded-circle float-start me-2 text-center">
                                        <a href="#"><i class="fa fa-phone text-white"></i></a>
                                    </span>
                                    <h6 class="mb-0 lh-base font_14">
                                        <a class="text-white" href="#">
                                            For Further Inquires : <br> +(000) 345 67 89
                                        </a>
                                    </h6>
                                </div>
                            </div>

                            <!-- Center: Logo -->
                            <div class="col-md-4">
                                <div class="top_1m text-center mt-2">
                                    <h3 class="mb-0">
                                        <a class="text-white" href="<%=request.getContextPath()%>/index">
                                            <i class="fa fa-plane col_yell"></i> Hotels
                                        </a>
                                    </h3>
                                </div>
                            </div>

                            <!-- Right: Login / Logout -->
                            <div class="col-md-4">
                                <div class="top_1r mt-2 text-end">
                                    <ul class="mb-0">
                                        <%
    model.User user = null;
    if (session != null) {
        Object obj = session.getAttribute("user");
        if (obj instanceof model.User) {
            user = (model.User) obj;
        }
    }
                                        %>


                                        <% if (user == null) { %>
                                        <!-- Ch?a login -->
                                        <li class="d-inline-block">
                                            <a href="<%=request.getContextPath()%>/login" 
                                               class="text-warning fw-bold me-2">Login</a>
                                        </li>
                                        <li class="d-inline-block">
                                            <a href="<%=request.getContextPath()%>/view/Authentication/register.jsp" 
                                               class="text-white fw-bold">Register</a>
                                        </li>
                                        <% } else { %>
                                        <!-- ?? login -->
                                        <li class="d-inline-block">
                                            <a href="<%=request.getContextPath()%>/logout" 
                                               class="fw-bold me-2" 
                                               style="color:#ffb800;">Logout</a>
                                        </li>
                                        <% } %>
                                    </ul>
                                </div>
                            </div>

                        </div>
                    </div>
                </section>

                <section id="header">
                    <nav class="navbar navbar-expand-md navbar-light pt-3 pb-3" id="navbar_sticky">
                        <div class="container-xl">
                            <a class="navbar-brand fs-3 p-0 fw-bold text-white" href="index.jsp"><i class="fa fa-plane col_yell"></i> Hotels </a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                <ul class="navbar-nav mb-0">

                                    <li class="nav-item">
                                        <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link" href="rooms">Rooms</a>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link" href="services">Services</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="extra-services">Extra Services</a>
                                    </li>

                                </ul>
                            </div>
                        </div>
                    </nav>
                </section>
            </div>
            <div class="main_2 clearfix">
                <section id="center" class="center_home">
                    <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-indicators">
                            <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-label="Slide 1" aria-current="true"></button>
                            <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
                            <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
                        </div>
                        <div class="carousel-inner">
                            <!-- Slide 1 -->
                            <div class="carousel-item active">
                                <img src="img/anh1.jpg" class="d-block w-100" alt="...">
                                <div class="carousel-caption d-md-block">
                                    <h1 class="font_60">Welcome to Hotels</h1>
                                    <p class="text-white mt-3">Experience luxury and comfort at our hotel. Book your stay now!</p>
                                    <ul class="mb-0 mt-4">
                                        <li class="d-inline-block">
                                            <a class="button text-uppercase" href="http://localhost:9999/HotelManagementandBookingSystem/view/Authentication/register.jsp">Login</a>
                                        </li>
                                        <li class="d-inline-block ms-2">
                                            <a class="button_1 text-uppercase" href="http://localhost:9999/HotelManagementandBookingSystem/view/Authentication/register.jsp">Register</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <!-- Slide 2 -->
                            <div class="carousel-item">
                                <img src="img/anh2.jpg" class="d-block w-100" alt="...">
                                <div class="carousel-caption d-md-block">
                                    <h1 class="font_60">Explore Our Rooms</h1>
                                    <p class="text-white mt-3">Choose from a variety of rooms designed for comfort and style. Check availability now.</p>
                                    <ul class="mb-0 mt-4">
                                        <li class="d-inline-block">
                                            <a class="button text-uppercase" href="http://localhost:9999/HotelManagementandBookingSystem/rooms">View Rooms</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <!-- Slide 3 -->
                            <div class="carousel-item">
                                <img src="img/anh3.jpg" class="d-block w-100" alt="...">
                                <div class="carousel-caption d-md-block">
                                    <h1 class="font_60">Our Services</h1>
                                    <p class="text-white mt-3">Discover our premium services and facilities to make your stay unforgettable.</p>
                                    <ul class="mb-0 mt-4">
                                        <li class="d-inline-block">
                                            <a class="button text-uppercase" href="http://localhost:9999/HotelManagementandBookingSystem/services">View Services</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                </section>
            </div>


            <section id="serv" class="p_3">
                <div class="container-xl">
                    <div class="row serv_1 text-center mb-4">
                        <div class="col-md-12">
                            <hr class="line mx-auto">
                            <h1 class="mb-0">Best Service for You</h1>
                        </div>
                    </div>

                    <!-- Service 1: Rooms & Apartments -->
                    <div class="row serv_2">
                        <div class="col-md-6 p-0">
                            <div class="serv_2l">
                                <div class="grid clearfix">
                                    <figure class="effect-jazz mb-0">
                                        <a href="http://localhost:9999/HotelManagementandBookingSystem/rooms"><img src="img/anh4.jpg" class="w-100" alt="Rooms & Apartments"></a>
                                    </figure>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 p-0">
                            <div class="serv_2r text-center shadow_box">
                                <h4>ROOMS & APARTMENTS</h4>
                                <p class="mt-4 mb-4">Experience luxurious and comfortable rooms tailored to your needs, with modern amenities and cozy decor.</p>
                                <span>
                                    <a class="d-inline-block rounded-circle col_yell" href="http://localhost:9999/HotelManagementandBookingSystem/rooms"><i class="fa fa-long-arrow-right"></i></a>
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- Service 2: Service -->
                    <div class="row serv_2">
                        <div class="col-md-6 p-0">
                            <div class="serv_2r text-center shadow_box">
                                <h4>SERVICE</h4>
                                <p class="mt-4 mb-4">Enjoy gourmet meals and refreshing drinks in our elegant restaurant, offering a variety of local and international cuisines.</p>
                                <span>
                                    <a class="d-inline-block rounded-circle col_yell" href="http://localhost:9999/HotelManagementandBookingSystem/services"><i class="fa fa-long-arrow-right"></i></a>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-6 p-0">
                            <div class="serv_2l">
                                <div class="grid clearfix">
                                    <figure class="effect-jazz mb-0">
                                        <a href="http://localhost:9999/HotelManagementandBookingSystem/services"><img src="img/anh5.jpg" class="w-100" alt="Service"></a>
                                    </figure>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>


            <section id="choose" class="p_3">
                <div class="container-xl">
                    <div class="row serv_1 text-center mb-4">
                        <div class="col-md-12">
                            <hr class="line mx-auto">
                            <h1>Why Choose Us</h1>
                            <p class="mb-0">
                                Experience comfort, elegance, and exceptional service at our hotel. 
                                From cozy rooms to world-class amenities, we ensure every stay is memorable. 
                                Relax, unwind, and let us take care of the rest.
                            </p>
                        </div>
                    </div>
                    <div class="row choose_1">
                        <div class="col-md-3 col-sm-6">
                            <div class="choose_1i text-center">
                                <span class="d-inline-block rounded-circle shadow_box font_60"><i class="fa fa-wifi"></i></span>
                                <h6 class="mb-0 mt-4">INTERNET</h6>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="choose_1i text-center">
                                <span class="d-inline-block rounded-circle shadow_box font_60"><i class="fa fa-glass"></i></span>
                                <h6 class="mb-0 mt-4">DRINKS</h6>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="choose_1i text-center">
                                <span class="d-inline-block rounded-circle shadow_box font_60"><i class="fa fa-coffee"></i></span>
                                <h6 class="mb-0 mt-4">CONCIERGE</h6>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="choose_1i text-center">
                                <span class="d-inline-block rounded-circle shadow_box font_60"><i class="fa fa-glide"></i></span>
                                <h6 class="mb-0 mt-4">POOL</h6>
                            </div>
                        </div>
                    </div>
                    <div class="row choose_1 mt-4">
                        <div class="col-md-3 col-sm-6">
                            <div class="choose_1i text-center">
                                <span class="d-inline-block rounded-circle shadow_box font_60"><i class="fa fa-yoast"></i></span>
                                <h6 class="mb-0 mt-4">FITNESS</h6>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="choose_1i text-center">
                                <span class="d-inline-block rounded-circle shadow_box font_60"><i class="fa fa-shirtsinbulk"></i></span>
                                <h6 class="mb-0 mt-4">LOUNDRY</h6>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="choose_1i text-center">
                                <span class="d-inline-block rounded-circle shadow_box font_60"><i class="fa fa-spoon"></i></span>
                                <h6 class="mb-0 mt-4">RESTAURANT</h6>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="choose_1i text-center">
                                <span class="d-inline-block rounded-circle shadow_box font_60"><i class="fa fa-scribd"></i></span>
                                <h6 class="mb-0 mt-4">SPA</h6>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section id="gallery" class="p_3 bg_dark">
                <div class="container-xl">
                    <div class="row serv_1 text-center mb-4">
                        <div class="col-md-12">
                            <hr class="line mx-auto">
                            <h1 class="mb-0 text-white">Hotells Gallery</h1>
                        </div>
                    </div>
                    <div class="homei row mt-4">
                        <!-- ?nh 1 -->
                        <div class="col-md-4">
                            <div class="homei1">
                                <div class="homei1i position-relative">
                                    <div class="homei1i1">
                                        <div class="grid clearfix">
                                            <figure class="effect-jazz mb-0">
                                                <a href="#"><img src="img/glr1.jpg" class="w-100" alt="abc"></a>
                                            </figure>
                                        </div>
                                    </div>
                                    <div class="homei1i2 text-center position-absolute w-100 top-0">
                                        <ul class="mb-0">
                                            <li class="d-inline-block me-1"><a data-bs-target="#exampleModal" data-bs-toggle="modal" href="#"><i class="fa fa-link"></i></a></li>
                                            <li class="d-inline-block"><a data-bs-target="#exampleModal" data-bs-toggle="modal" href="#"><i class="fa fa-search"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title text-black" id="exampleModalLabel">Hotells</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <img src="img/glr1.jpg" class="w-100" alt="abc">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- ?nh 2 -->
                        <div class="col-md-4">
                            <div class="homei1">
                                <div class="homei1i position-relative">
                                    <div class="homei1i1">
                                        <div class="grid clearfix">
                                            <figure class="effect-jazz mb-0">
                                                <a href="#"><img src="img/glr2.jpg" class="w-100" alt="abc"></a>
                                            </figure>
                                        </div>
                                    </div>
                                    <div class="homei1i2 text-center position-absolute w-100 top-0">
                                        <ul class="mb-0">
                                            <li class="d-inline-block me-1"><a data-bs-target="#exampleModal1" data-bs-toggle="modal" href="#"><i class="fa fa-link"></i></a></li>
                                            <li class="d-inline-block"><a data-bs-target="#exampleModal1" data-bs-toggle="modal" href="#"><i class="fa fa-search"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title text-black" id="exampleModalLabel">Hotells</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <img src="img/glr2.jpg" class="w-100" alt="abc">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- ?nh 3 -->
                        <div class="col-md-4">
                            <div class="homei1">
                                <div class="homei1i position-relative">
                                    <div class="homei1i1">
                                        <div class="grid clearfix">
                                            <figure class="effect-jazz mb-0">
                                                <a href="#"><img src="img/glr3.jpg" class="w-100" alt="abc"></a>
                                            </figure>
                                        </div>
                                    </div>
                                    <div class="homei1i2 text-center position-absolute w-100 top-0">
                                        <ul class="mb-0">
                                            <li class="d-inline-block me-1"><a data-bs-target="#exampleModal2" data-bs-toggle="modal" href="#"><i class="fa fa-link"></i></a></li>
                                            <li class="d-inline-block"><a data-bs-target="#exampleModal2" data-bs-toggle="modal" href="#"><i class="fa fa-search"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title text-black" id="exampleModalLabel">Hotells</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <img src="img/glr3.jpg" class="w-100" alt="abc">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </section>


            <section id="location" class="p-3">
                <div class="container">
                    <h2 class="mb-4 text-center">Hotel at FPT University HoaLac</h2>
                    <div class="map-responsive">
                        <iframe 
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.759186354353!2d105.4492!3d21.0784!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3134547c7b8b9a3f%3A0x123456789abcdef!2sFPT%20University%20Hoa%20Lac!5e0!3m2!1sen!2s!4v1700000000000" 
                            width="100%" 
                            height="450" 
                            style="border:0;" 
                            allowfullscreen="" 
                            loading="lazy">
                        </iframe>
                    </div>
                </div>
            </section>

            <footer class="bg-dark text-light py-4">
                <div class="container text-center">
                    <h4 class="mb-3">Hotells</h4>
                    <p class="mb-1">1230 Porta avenue, Semper, New York City, NZ 10117 US</p>
                    <p class="mb-1"><strong>Tel:</strong> +(123) 456 7890 | <strong>Fax:</strong> +(123) 456 7890</p>
                    <p class="mb-0"><a href="mailto:info@gmail.com" class="text-light">info@gmail.com</a></p>
                    <hr class="bg-light my-3">
                    <p class="mb-0">&copy; 2025 HMBS. All Rights Reserved.</p>
                </div>
            </footer>

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
                        //document.body.style.paddingTop = navbar_height + 'px';
                    } else {
                        navbar_sticky.classList.remove("sticky");
                        document.body.style.paddingTop = '0'
                    }
                }
            </script>
    </body>
</html>