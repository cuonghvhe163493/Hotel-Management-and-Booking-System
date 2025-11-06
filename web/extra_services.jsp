<%-- 
    Document   : services
    Created on : Oct 20, 2025, 10:52:31 AM
    Author     : Hoang Viet Cuong
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Hotells</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" >
        <link href="css/font-awesome.min.css" rel="stylesheet" >
        <link href="css/global.css" rel="stylesheet">
        <link href="css/about.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@500&display=swap" rel="stylesheet">
        <script src="js/bootstrap.bundle.min.js"></script>

        <style>
            .filter-form {
                display: flex;
                align-items: center;
                gap: 10px;
                justify-content: center;
                margin: 30px auto;
                flex-wrap: wrap;
                max-width: 1000px;
            }

            .filter-form input,
            .filter-form select {
                padding: 10px 14px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 15px;
                outline: none;
                transition: all 0.2s ease;
                min-width: 150px;
            }

            .filter-form input:focus,
            .filter-form select:focus {
                border-color: #ff7b00;
                box-shadow: 0 0 0 2px rgba(255, 123, 0, 0.2);
            }

            .filter-form button {
                background-color: #ff7b00;
                color: white;
                padding: 10px 18px;
                border: none;
                border-radius: 6px;
                font-size: 15px;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }

            .filter-form button:hover {
                background-color: #e36b00;
            }

            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 12px;
                margin: 30px 0;
                font-family: 'Poppins', sans-serif;
            }

            .page-btn {
                text-decoration: none;
                background-color: #4e73df;
                color: white;
                padding: 8px 16px;
                border-radius: 8px;
                transition: all 0.3s ease;
                font-weight: 500;
            }

            .page-btn:hover {
                background-color: #375ac9;
            }

            .page-btn.disabled {
                background-color: #ccc;
                cursor: not-allowed;
                pointer-events: none;
            }

            .page-number {
                font-size: 16px;
                font-weight: 600;
                color: #333;
            }
        </style>

    </head>
    <body>

        <div class="main_serv">
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
                                    <h3 class="mb-0"><a class="text-white" href="index.html"><i class="fa fa-plane col_yell"></i> Hotells</a></h3>
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
                            <a class="navbar-brand fs-3 p-0 fw-bold text-white" href="index.html"><i class="fa fa-plane col_yell"></i> Hotells </a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                <ul class="navbar-nav mb-0">

                                    <li class="nav-item">
                                        <a class="nav-link" aria-current="page" href="index.jsp">Home</a>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link" href="about.html">About </a>
                                    </li>

                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
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
                                        <a class="nav-link" href="services">Services</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="extra-services">Extra Services</a>
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
                                <h2 class="text-white text-uppercase">Services</h2>
                                <h6 class="mb-0 mt-3 col_yell"><a class="text-white" href="#">Home</a> <span class="mx-2 text-muted">/</span> Extra Services</h6>
                            </div>
                        </div>
                    </div>   
                </section>
            </div>
        </div>

        <section id="serv_pg" class="p_3 bg-light">
            <div class="container-xl">


                <div>
                    <form action="extra-services" method="get" class="filter-form">
                        <input type="text" name="name" placeholder="Search by name" value="${param.name}" />
                        <input type="number" step="0.01" name="minPrice" placeholder="Min price" value="${param.minPrice}" />
                        <input type="number" step="0.01" name="maxPrice" placeholder="Max price" value="${param.maxPrice}" />
                        <select name="serviceType">
                            <option value="">All Types</option>
                            <c:forEach items="${serviceTypes}" var="type">
                                <option value="${type}" ${param.serviceType == type ? 'selected' : ''}>${type}</option>
                            </c:forEach>
                        </select>
                        <button type="submit">Lọc</button>
                        <!-- Nút reset đổi thành button thường để dùng JS -->
                        <button type="button" onclick="resetAndSubmit()">Làm mới</button>
                    </form>
                </div>

                <script>
                    function resetAndSubmit() {
                        const form = document.querySelector('.filter-form');
                        // Xóa nội dung các input
                        form.querySelectorAll('input').forEach(input => input.value = '');
                        // Chọn lại option đầu tiên trong select
                        form.querySelector('select').selectedIndex = 0;
                        // Gửi lại form (submit)
                        form.submit();
                    }
                </script>

                <c:forEach var="service" items="${services}" varStatus="status">

                    <!-- Start a new row every 3 items -->
                    <c:if test="${status.index % 3 == 0}">
                        <div class="room_2i row mt-4">
                        </c:if>

                        <div class="col-md-4">
                            <div class="room_2il">
                                <div class="room_2il1 position-relative">
                                    <div class="room_2il1i">
                                        <div class="grid clearfix">
                                            <figure class="effect-jazz mb-0">
                                                <a href="#"><img src="img/13.jpg" class="w-100" alt="img25"></a>
                                            </figure>
                                        </div>
                                    </div>
                                    <div class="room_2il1i1 text-center position-absolute w-100">
                                        <span class="d-inline-block  bg_yell text-white p-2 px-4">Views</span>
                                    </div>
                                </div>
                                <div class="room_2il2 bg-white text-center p-4">
                                    <h4 class="mt-2"><a href="#">${service.serviceName}</a></h4>
                                    <h4 class="mt-2"> 
                                        <c:choose>
                                            <c:when test="${service.servicePrice > 0}">
                                                Giá: $${service.servicePrice}
                                            </c:when>
                                            <c:otherwise>
                                                Miễn phí
                                            </c:otherwise>
                                        </c:choose></h4>
                                    <p class="font_14 mb-0">
                                        ${service.serviceDescription}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <c:if test="${(status.index + 1) % 3 == 0 || status.last}">
                        </div>
                    </c:if>
                </c:forEach>

            </div>   
            <<section>
                <!-- 📄 Pagination -->
                <div class="pagination">
                    <c:set var="page" value="${page != null ? page : 1}" />
                    <c:set var="pageSize" value="${pageSize != null ? pageSize : 9}" />

                    <c:url var="prevUrl" value="extra-services">
                        <c:param name="page" value="${page - 1}" />
                        <c:param name="pageSize" value="${pageSize}" />
                        <c:param name="name" value="${param.name}" />
                        <c:param name="minPrice" value="${param.minPrice}" />
                        <c:param name="maxPrice" value="${param.maxPrice}" />
                        <c:param name="serviceType" value="${param.serviceType}" />
                    </c:url>

                    <c:url var="nextUrl" value="extra-services">
                        <c:param name="page" value="${page + 1}" />
                        <c:param name="pageSize" value="${pageSize}" />
                        <c:param name="name" value="${param.name}" />
                        <c:param name="minPrice" value="${param.minPrice}" />
                        <c:param name="maxPrice" value="${param.maxPrice}" />
                        <c:param name="serviceType" value="${param.serviceType}" />
                    </c:url>

                    <a href="${prevUrl}" class="page-btn ${page <= 1 ? 'disabled' : ''}">Previous</a>
                    <span class="page-number">Page ${page} </span>
                    <a href="${nextUrl}" class="page-btn">Next</a>
                </div>
            </section>
        </section>



        <section id="sub" class="pt-5 pb-5">
            <div class="container-xl">
                <div class="row sub_1 text-center">
                    <div class="col-md-12">
                        <div class="sub_1l">
                            <h6>CALL TO ACTION</h6>
                            <h1 class="mt-3">READY FOR UNFORGATABLE <br> TRAVEL REMEMBER US!</h1>
                            <p>Fusce hic augue velit wisi quibusdam pariatur, iusto primis, nec nemo, rutrum. Vestibulum  <br> cumque laudantium. Sit ornare mollitia tenetur, aptent.</p>
                            <ul class="mb-0 mt-4">
                                <li class="d-inline-block"><a class="button text-uppercase" href="#">CONTACT US! </a></li>
                                <li class="d-inline-block ms-2"><a class="button_1  text-uppercase" href="#">LEARN MORE </a></li>
                            </ul>
                        </div>
                    </div>

                </div>

            </div>
        </section>

        <section id="footer" class="p_3 bg_dark">
            <div class="container-xl">
                <div class="row footer_1">
                    <div class="col-md-3">
                        <div class="footer_1i">
                            <h3 class="mb-0 mb-3"><a class="text-white" href="index.html"><i class="fa fa-plane col_yell"></i> Hotells</a></h3>
                            <p class="mb-0 text-light">We always strive for growth and development as StylemixThemes. We don’t want to have a large team, we want to have a team that works in unity. Our slogan is “Every day is the last day”.</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="footer_1i">
                            <h5 class="text-white mb-4">GALLERY</h5>
                            <div class="footer_1i1 row">
                                <div class="col-md-4 pe-0 col-4">
                                    <div class="grid clearfix">
                                        <figure class="effect-jazz mb-0">
                                            <a href="#"><img src="img/7.jpg" class="w-100" alt="img25"></a>
                                        </figure>
                                    </div>
                                </div>
                                <div class="col-md-4 pe-0 col-4">
                                    <div class="grid clearfix">
                                        <figure class="effect-jazz mb-0">
                                            <a href="#"><img src="img/8.jpg" class="w-100" alt="img25"></a>
                                        </figure>
                                    </div>
                                </div>
                                <div class="col-md-4 pe-0 col-4">
                                    <div class="grid clearfix">
                                        <figure class="effect-jazz mb-0">
                                            <a href="#"><img src="img/9.jpg" class="w-100" alt="img25"></a>
                                        </figure>
                                    </div>
                                </div>
                            </div>
                            <div class="footer_1i1 row mt-3">
                                <div class="col-md-4 pe-0 col-4">
                                    <div class="grid clearfix">
                                        <figure class="effect-jazz mb-0">
                                            <a href="#"><img src="img/10.jpg" class="w-100" alt="img25"></a>
                                        </figure>
                                    </div>
                                </div>
                                <div class="col-md-4 pe-0 col-4">
                                    <div class="grid clearfix">
                                        <figure class="effect-jazz mb-0">
                                            <a href="#"><img src="img/11.jpg" class="w-100" alt="img25"></a>
                                        </figure>
                                    </div>
                                </div>
                                <div class="col-md-4 pe-0 col-4">
                                    <div class="grid clearfix">
                                        <figure class="effect-jazz mb-0">
                                            <a href="#"><img src="img/12.jpg" class="w-100" alt="img25"></a>
                                        </figure>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="footer_1i">
                            <h5 class="text-white mb-3">CONTACT US</h5>
                            <p class="text-light mb-2">1230 Porta avenue, Semper,
                                New York City, NZ 10117 US</p>
                            <p class="text-light mb-2"><span class="fw-bold">Tel:</span>  +(123) 456 7890 </p>
                            <p class="text-light mb-2"><span class="fw-bold">Fax:</span>  +(123) 456 7890 </p>
                            <p class="mb-0"> <a class="text-light" href="#">info@gmail.com</a> </p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="footer_1i">
                            <h5 class="text-white mb-3">STAY IN TOUCH</h5>
                            <p class="mb-3 text-light">We denounce with righteous and in and dislike men who are so beguiled and demo realized.</p>
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Your Email">
                                <span class="input-group-btn">
                                    <button class="btn btn-primary bg_yell rounded-0 p-2 px-3 border-0" type="button">
                                        <i class="fa fa-location-arrow"></i> </button>
                                </span>
                            </div>
                        </div>
                    </div>
                </div><hr class="mt-4 mb-4 hr_1">
                <div class="row footer_2 text-center">
                    <div class="col-md-12">
                        <p class="mb-0 text-light">© 2013 Your Website Name. All Rights Reserved | Design by <a class="col_yell fw-bold" href="http://www.templateonweb.com">TemplateOnWeb</a></p>
                    </div>
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
                    //document.body.style.paddingTop = navbar_height + 'px';
                } else {
                    navbar_sticky.classList.remove("sticky");
                    document.body.style.paddingTop = '0'
                }
            }
        </script>

    </body>

</html>