<%-- 
    Document   : ServiceDetail
    Created on : Oct 20, 2025, 10:25:00 PM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt"  prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
    <head>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Hotells</title>

        <!-- Assets -->
        <link href="${ctx}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${ctx}/css/font-awesome.min.css" rel="stylesheet">
        <link href="${ctx}/css/global.css" rel="stylesheet">
        <link href="${ctx}/css/about.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@500&display=swap" rel="stylesheet">
        <script src="${ctx}/js/bootstrap.bundle.min.js"></script>
    </head>

    <style>
        .hero-img {
            width:100%;
            height:380px;
            object-fit:cover;
            border-radius:12px;
        }
        .spec-badge {
            font-size:.85rem;
        }
        .card-img-related {
            height:160px;
            object-fit:cover;
        }
        .muted {
            color:#6c757d;
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
                                <h3 class="mb-0"><a class="text-white" href="index.jsp"><i class="fa fa-plane col_yell"></i> Hotels</a></h3>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="top_1r mt-2 text-end">
                                <ul class="mb-0">
                                    <!-- Nút Login / Register -->
                                    <li class="d-inline-block">
                                        <a href="<%=request.getContextPath()%>/view/Authentication/login.jsp" 
                                           class="text-warning fw-bold me-2">Login</a>
                                    </li>
                                    <li class="d-inline-block">
                                        <a href="<%=request.getContextPath()%>/view/Authentication/register.jsp" 
                                           class="text-white fw-bold">Register</a>
                                    </li>
                                </ul>
                            </div>

                        </div>
                    </div>
                </div>
            </section>

            <section id="header">
                <nav class="navbar navbar-expand-md navbar-light pt-3 pb-3" id="navbar_sticky">
                    <div class="container-xl">
                        <a class="navbar-brand fs-3 p-0 fw-bold text-white" href="${ctx}/index.jsp">
                            <i class="fa fa-plane col_yell"></i> Hotells
                        </a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav mb-0">
                                <li class="nav-item"><a class="nav-link" href="${ctx}/index.jsp">Home</a></li>
                                <li class="nav-item"><a class="nav-link" href="${ctx}/about.jsp">About</a></li>

                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownRooms" role="button" data-bs-toggle="dropdown" aria-expanded="false">Rooms</a>
                                    <ul class="dropdown-menu drop_1" aria-labelledby="navbarDropdownRooms">
                                        <li><a class="dropdown-item" href="${ctx}/rooms.jsp">Rooms</a></li>
                                        <li><a class="dropdown-item border-0" href="${ctx}/detail.jsp">Room Detail</a></li>
                                    </ul>
                                </li>

                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownBlog" role="button" data-bs-toggle="dropdown" aria-expanded="false">Blog</a>
                                    <ul class="dropdown-menu drop_1" aria-labelledby="navbarDropdownBlog">
                                        <li><a class="dropdown-item" href="${ctx}/blog.jsp">Blog</a></li>
                                        <li><a class="dropdown-item border-0" href="${ctx}/blog_detail.jsp">Blog Detail</a></li>
                                    </ul>
                                </li>

                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        Service
                                    </a>
                                    <ul class="dropdown-menu drop_1" aria-labelledby="navbarDropdown">
                                        <li><a class="dropdown-item" href="<%=request.getContextPath()%>/view/ServiceManagement/service.jsp"> Service</a></li>
                                        <li><a class="dropdown-item border-0" href="<%=request.getContextPath()%>/view/ServiceManagement/extraService.jsp"> Extra Service</a></li>
                                    </ul>
                                </li>

                                <li class="nav-item"><a class="nav-link" href="${ctx}/gallery.jsp">Gallery</a></li>
                                <li class="nav-item"><a class="nav-link" href="${ctx}/contact.jsp">Contact</a></li>
                            </ul>
                        </div>
                    </div>
                </nav>
            </section>

            <section id="center" class="center_o pt-4 pb-5">
                <div class="container-xl">
                    <div class="row center_o1 text-center">
                        <div class="col-md-12">
                            <h2 class="text-white text-uppercase">Services Detail</h2>
                            <h6 class="mb-0 mt-3 col_yell"> Detail</h6>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
    <section class="py-4 bg-light">
        <div class="container-xl">

            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="mb-3">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${ctx}/index.jsp">Home</a></li>
                    <li class="breadcrumb-item"><a href="${ctx}/service">Extra Services</a></li>
                    <li class="breadcrumb-item active" aria-current="page">
                        <c:out value="${empty service.name ? 'Detail' : service.name}" />
                    </li>
                </ol>
            </nav>

            <div class="row g-4">
                <!-- Ảnh lớn -->
                <div class="col-lg-7">
                    <c:set var="imgPath" value="${ctx}/img/services/${service.code}.jpg" />
                    <img class="hero-img"
                         src="<c:out value='${imgPath}'/>"
                         alt="<c:out value='${service.name}'/>"
                         onerror="this.onerror=null;this.src='${ctx}/img/services/placeholder.jpg';" />
                </div>

                <!-- Thông tin chính -->
                <div class="col-lg-5">
                    <h2 class="mb-2"><c:out value="${service.name}" /></h2>

                    <!-- Giá -->
                    <c:choose>
                        <c:when test="${not empty priceLabel}">
                            <span class="badge bg-warning text-dark mb-2"><c:out value="${priceLabel}" /></span>
                        </c:when>
                        <c:when test="${not empty minPriceCents}">
                            <span class="badge bg-warning text-dark mb-2">
                                From: $
                                <fmt:formatNumber value="${minPriceCents/100.0}" type="number" minFractionDigits="2"/>
                            </span>
                        </c:when>
                    </c:choose>

                    <!-- Mô tả -->
                    <p class="muted mt-2"><c:out value="${service.description}" /></p>

                    <hr/>

                    <!-- Thông số -->
                    <div class="mb-3">
                        <c:if test="${not empty service.code}">
                            <span class="badge bg-secondary spec-badge me-1">Code: <c:out value="${service.code}"/></span>
                        </c:if>
                        <c:if test="${not empty service.unit}">
                            <span class="badge bg-secondary spec-badge me-1">Unit: <c:out value="${service.unit}"/></span>
                        </c:if>
                        <c:if test="${not empty service.taxClass}">
                            <span class="badge bg-secondary spec-badge me-1">Tax: <c:out value="${service.taxClass}"/></span>
                        </c:if>

                        <span class="badge spec-badge me-1
                              ${service.active ? 'bg-success' : 'bg-danger'}">
                            <c:out value="${service.active ? 'Active' : 'Inactive'}"/>
                        </span>
                    </div>


                    <c:if test="${not empty service.createdAt}">
                        <div class="mb-3 muted">
                            Created at:
                            <fmt:formatDate value="${service.createdAt}" pattern="yyyy-MM-dd HH:mm" />
                        </div>
                    </c:if>

                    <!-- Actions -->
                    <div class="d-flex gap-2">
                        <!-- Đặt booking qua POST để an toàn -->
                        <form action="${ctx}/extraService/checkout" method="get" class="d-inline">
                            <input type="hidden" name="serviceId" value="${service.extraServiceId}">
                            <div class="input-group">
                                <input name="qty" type="number" class="form-control" value="1" min="1" style="max-width:120px;">
                                <button type="submit" class="btn btn-primary">BOOK NOW</button>
                            </div>
                        </form>

                        <a class="btn btn-outline-secondary" href="${ctx}/service">Back to list</a>
                    </div>
                </div>
            </div>

            <!-- Dịch vụ liên quan -->
            <c:if test="${not empty related}">
                <h4 class="mt-5 mb-3">You may also like</h4>
                <div class="row g-4">
                    <c:forEach var="r" items="${related}">
                        <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                            <div class="card h-100">
                                <a href="${ctx}/service/detail?id=${r.serviceId}">
                                    <img class="card-img-top card-img-related"
                                         src="${ctx}/img/services/${r.code}.jpg"
                                         alt="<c:out value='${r.name}'/>"
                                         onerror="this.onerror=null;this.src='${ctx}/img/services/placeholder-thumb.jpg';" />
                                </a>
                                <div class="card-body text-center">
                                    <h6 class="mb-1">
                                        <a class="text-decoration-none" href="${ctx}/service/detail?id=${r.serviceId}">
                                            <c:out value="${r.name}" />
                                        </a>
                                    </h6>
                                    <!-- Có thể hiển thị nhãn giá rút gọn nếu Servlet đã chuẩn bị -->
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

        </div>
    </section>
    <section id="sub" class="pt-5 pb-5">
        <div class="container-xl">
            <div class="row sub_1 text-center">
                <div class="col-md-12">
                    <div class="sub_1l">
                        <h6>CALL TO ACTION</h6>
                        <h1 class="mt-3">READY FOR UNFORGATABLE <br/> TRAVEL REMEMBER US!</h1>
                        <p>Fusce hic augue velit wisi quibusdam pariatur, iusto primis, nec nemo, rutrum. Vestibulum
                            <br/> cumque laudantium. Sit ornare mollitia tenetur, aptent.</p>
                        <ul class="mb-0 mt-4">
                            <li class="d-inline-block"><a class="button text-uppercase" href="#">CONTACT US!</a></li>
                            <li class="d-inline-block ms-2"><a class="button_1 text-uppercase" href="#">LEARN MORE</a></li>
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
                        <h3 class="mb-0 mb-3">
                            <a class="text-white" href="${ctx}/index.jsp"><i class="fa fa-plane col_yell"></i> Hotells</a>
                        </h3>
                        <p class="mb-0 text-light">We always strive for growth and development as StylemixThemes...</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="footer_1i">
                        <h5 class="text-white mb-4">GALLERY</h5>
                        <div class="footer_1i1 row">
                            <div class="col-md-4 pe-0 col-4">
                                <div class="grid clearfix"><figure class="effect-jazz mb-0"><a href="#"><img src="${ctx}/img/7.jpg" class="w-100" alt="img25"></a></figure></div>
                            </div>
                            <div class="col-md-4 pe-0 col-4">
                                <div class="grid clearfix"><figure class="effect-jazz mb-0"><a href="#"><img src="${ctx}/img/8.jpg" class="w-100" alt="img25"></a></figure></div>
                            </div>
                            <div class="col-md-4 pe-0 col-4">
                                <div class="grid clearfix"><figure class="effect-jazz mb-0"><a href="#"><img src="${ctx}/img/9.jpg" class="w-100" alt="img25"></a></figure></div>
                            </div>
                        </div>
                        <div class="footer_1i1 row mt-3">
                            <div class="col-md-4 pe-0 col-4">
                                <div class="grid clearfix"><figure class="effect-jazz mb-0"><a href="#"><img src="${ctx}/img/10.jpg" class="w-100" alt="img25"></a></figure></div>
                            </div>
                            <div class="col-md-4 pe-0 col-4">
                                <div class="grid clearfix"><figure class="effect-jazz mb-0"><a href="#"><img src="${ctx}/img/11.jpg" class="w-100" alt="img25"></a></figure></div>
                            </div>
                            <div class="col-md-4 pe-0 col-4">
                                <div class="grid clearfix"><figure class="effect-jazz mb-0"><a href="#"><img src="${ctx}/img/12.jpg" class="w-100" alt="img25"></a></figure></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="footer_1i">
                        <h5 class="text-white mb-3">CONTACT US</h5>
                        <p class="text-light mb-2">1230 Porta avenue, Semper, New York City, NZ 10117 US</p>
                        <p class="text-light mb-2"><span class="fw-bold">Tel:</span> +(123) 456 7890</p>
                        <p class="text-light mb-2"><span class="fw-bold">Fax:</span> +(123) 456 7890</p>
                        <p class="mb-0"><a class="text-light" href="#">info@gmail.com</a></p>
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
                                    <i class="fa fa-location-arrow"></i>
                                </button>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            <hr class="mt-4 mb-4 hr_1">
            <div class="row footer_2 text-center">
                <div class="col-md-12">
                    <p class="mb-0 text-light">© 2013 Your Website Name. All Rights Reserved | Design by
                        <a class="col_yell fw-bold" href="http://www.templateonweb.com">TemplateOnWeb</a></p>
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
                navbar_sticky.classList.add("sticky");
            } else {
                navbar_sticky.classList.remove("sticky");
                document.body.style.paddingTop = '0';
            }
        }
    </script>

</body>
</html>
