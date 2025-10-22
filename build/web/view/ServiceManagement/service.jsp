<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
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

                                <ul class="navbar-nav mb-0 ms-auto">
                                    <li class="nav-item"><a class="nav-link button" href="#">BOOK NOW</a></li>
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
                                <h6 class="mb-0 mt-3 col_yell"><a class="text-white" href="${ctx}/index.jsp">Home</a> <span class="mx-2 text-muted">/</span> Services</h6>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>

        <section id="serv_pg" class="p_3 bg-light">
            <div class="container-xl">
                <div class="room_2i row">
                    <div class="col-md-4">
                        <div class="room_2il">
                            <div class="room_2il1 position-relative">
                                <div class="room_2il1i">
                                    <div class="grid clearfix">
                                        <figure class="effect-jazz mb-0">
                                            <a href="#"><img src="${ctx}/img/7.jpg" class="w-100" alt="img25"></a>
                                        </figure>
                                    </div>
                                </div>
                                <div class="room_2il1i1 text-center position-absolute w-100">
                                    <span class="d-inline-block bg_yell text-white p-2 px-4">View</span>
                                </div>
                            </div>
                            <div class="room_2il2 bg-white text-center p-4">
                                <h4 class="mt-2"><a href="#">Dịch vụ dọn phòng</a></h4>
                                <p class="font_14 mb-0">nhân viên sẽ tiến hành dọn phòng và sắp xếp đồ đạc ngăn nắp để khách</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="room_2il">
                            <div class="room_2il1 position-relative">
                                <div class="room_2il1i">
                                    <div class="grid clearfix">
                                        <figure class="effect-jazz mb-0">
                                            <a href="#"><img src="${ctx}/img/8.jpg" class="w-100" alt="img25"></a>
                                        </figure>
                                    </div>
                                </div>
                                <div class="room_2il1i1 text-center position-absolute w-100">
                                    <span class="d-inline-block bg_yell text-white p-2 px-4">View</span>
                                </div>
                            </div>
                            <div class="room_2il2 bg-white text-center p-4">
                                <h4 class="mt-2"><a href="#">Wifi & máy điều hòa</a></h4>
                                <p class="font_14 mb-0">Hầu hết khách sạn hiện nay đều cung cấp dịch vụ Wi-Fi (kết nối Internet) 
                                                        và air conditioner (máy lạnh, máy điều hoà) miễn phí, 
                                                       dù là khách ở ngắn hạn hay dài hạn.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="room_2il">
                            <div class="room_2il1 position-relative">
                                <div class="room_2il1i">
                                    <div class="grid clearfix">
                                        <figure class="effect-jazz mb-0">
                                            <a href="#"><img src="${ctx}/img/9.jpg" class="w-100" alt="img25"></a>
                                        </figure>
                                    </div>
                                </div>
                                <div class="room_2il1i1 text-center position-absolute w-100">
                                    <span class="d-inline-block bg_yell text-white p-2 px-4">View</span>
                                </div>
                            </div>
                            <div class="room_2il2 bg-white text-center p-4">
                                <h4 class="mt-2"><a href="#">Sạc pin điện thoại</a></h4>
                                <p class="font_14 mb-0">Điện thoại là vật bất ly thân của hầu hết mọi người. 
                                    Tuy nhiên không phải lúc nào bạn cũng mang theo dây sạc pin 
                                    hoặc có khi nó bất ngờ bị hỏng hãy đến quầy lễ tân và hỏi, 
                                    nhân viên sẽ vui vẻ giao cho bạn dây sạc phù hợp.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="room_2i row mt-4">
                    <div class="col-md-4">
                        <div class="room_2il">
                            <div class="room_2il1 position-relative">
                                <div class="room_2il1i">
                                    <div class="grid clearfix">
                                        <figure class="effect-jazz mb-0">
                                            <a href="#"><img src="${ctx}/img/13.jpg" class="w-100" alt="img25"></a>
                                        </figure>
                                    </div>
                                </div>
                                <div class="room_2il1i1 text-center position-absolute w-100">
                                    <span class="d-inline-block bg_yell text-white p-2 px-4">View</span>
                                </div>
                            </div>
                            <div class="room_2il2 bg-white text-center p-4">
                                <h4 class="mt-2"><a href="#">Bộ dụng cụ vệ sinh cá nhân</a></h4>
                                <p class="font_14 mb-0">Bao gồm: xà bông tắm, dầu gội đầu, bàn chải cùng kem đánh răng,…một số nơi còn có mũ chụp tóc, chỉ nha khoa, nước súc miệng, dao cạo râu, lược chải tóc, …</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="room_2il">
                            <div class="room_2il1 position-relative">
                                <div class="room_2il1i">
                                    <div class="grid clearfix">
                                        <figure class="effect-jazz mb-0">
                                            <a href="#"><img src="${ctx}/img/14.jpg" class="w-100" alt="img25"></a>
                                        </figure>
                                    </div>
                                </div>
                                <div class="room_2il1i1 text-center position-absolute w-100">
                                    <span class="d-inline-block bg_yell text-white p-2 px-4">View</span>
                                </div>
                            </div>
                            <div class="room_2il2 bg-white text-center p-4">
                                <h4 class="mt-2"><a href="#">Đồ chơi cho trẻ</a></h4>
                                <p class="font_14 mb-0">Những bộ đồ chơi sẽ được khách sạn bố trí sẵn trong phòng nếu bạn báo trước với 
                                    khách sạn nơi bạn đến rằng bạn sẽ mang theo trẻ em.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="room_2il">
                            <div class="room_2il1 position-relative">
                                <div class="room_2il1i">
                                    <div class="grid clearfix">
                                        <figure class="effect-jazz mb-0">
                                            <a href="#"><img src="${ctx}/img/15.jpg" class="w-100" alt="img25"></a>
                                        </figure>
                                    </div>
                                </div>
                                <div class="room_2il1i1 text-center position-absolute w-100">
                                    <span class="d-inline-block bg_yell text-white p-2 px-4">View</span>
                                </div>
                            </div>
                            <div class="room_2il2 bg-white text-center p-4">
                                <h4 class="mt-2"><a href="#">Ổ cắm điện và thiết bị chuyển đổi dòng điện</a></h4>
                                <p class="font_14 mb-0">Khi có sự khác biệt về đầu cắm điện, 
                                    hoặc có nhu cầu sử dụng nhiều hơn số ổ cắm điện trong phòng, 
                                    hãy liên hệ lễ tân để được giúp đỡ nhé</p>
                            </div>
                        </div>
                    </div>
                </div>
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
