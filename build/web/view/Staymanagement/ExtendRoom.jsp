<%-- 
    Document   : ExtendRoom
    Created on : Oct 19, 2025, 3:04:53 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Extend Room</title>
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
            <div>
            <input type="radio" name="Choose All" value="" />
            <p><input type="text" name="Time" value="" /></p>
            </div>
            <div>
            <table border="1">
                <thead>
                    <tr>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
            </div>
            <input type="submit" value="Submit" />
            
            
            
            
            
            
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
        
<!--script -->
<!--sticky navbar-->
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
