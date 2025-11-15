<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Forgot Password - Hotels</title>

        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" >
        <link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet" >
        <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/index.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@500&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/Authentication/css/style.css">

        <style>
            /* CSS GHI ĐÈ ĐỂ FORM CĂN GIỮA MÀ VẪN GIỮ HEADER/FOOTER */
            body {
                background-color: #273733 !important;
                margin: 0 !important;
                min-height: 100vh !important;
                display: flex !important;
                flex-direction: column !important;
                overflow-x: hidden !important;
                height: auto !important;
                overflow-y: auto !important;
                padding-top: 0 !important;
            }
            .main { /* Khu vực chứa form login/forgot */
                flex-grow: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 50px 20px;
            }
            .main_1 #top, .main_1 #header {
                background-color: #38423f !important;
            }
            .main_1 {
                position: relative !important;
                width: 100%;
                background-color: #38423f;
            }
            .login-container {
                z-index: 10;
            } /* Đảm bảo form nằm trên cùng */
            #footer {
                background-color: #463b3f !important;
                margin-top: auto !important;
            }
        </style>
    </head>
    <body>

        <div class="main_1 clearfix">
            <section id="top" class="pt-3 pb-3" style="background-color: #38423f;">
                <div class="container-xl">
                    <div class="row top_1">
                        <div class="col-md-4">
                            <div class="top_1l">
                                <span class="d-inline-block bg_yell rounded-circle float-start me-2 text-center"><a href="#"><i class="fa fa-phone text-white"></i></a></span>
                                <h6 class="mb-0 lh-base font_14"><a class="text-white" href="#">For Further Inquires : <br>
                                        +(000) 345 67 89</a></h6>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="top_1m text-center mt-2">
                                <h3 class="mb-0"><a class="text-white" href="<%=request.getContextPath()%>/index.jsp"><i class="fa fa-plane col_yell"></i> Hotels</a></h3>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="top_1r mt-2 text-end">
                                <ul class="mb-0">
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
                        <a class="navbar-brand fs-3 p-0 fw-bold text-white" href="<%=request.getContextPath()%>/index.jsp"><i class="fa fa-plane col_yell"></i> Hotels </a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav mb-0">

                                <li class="nav-item">
                                    <a class="nav-link active" aria-current="page" 
                                       href="${pageContext.request.contextPath}/index.jsp">Home</a>
                                </li>

                                <li class="nav-item">
                                    <a class="nav-link" 
                                       href="${pageContext.request.contextPath}/rooms">Rooms</a>
                                </li>

                                <li class="nav-item">
                                    <a class="nav-link" 
                                       href="${pageContext.request.contextPath}/services">Services</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" 
                                       href="${pageContext.request.contextPath}/extra-services">Extra Services</a>
                                </li>

                            </ul>
                        </div>
                    </div>
                </nav>
            </section>
        </div>

        <div class="main clearfix">
            <div class="login-container">
                <div class="login-card">
                    <div class="login-header">
                        <div class="logo-icon">🔒</div>
                        <h2>Forgot Password</h2>
                        <p>Enter credentials to verify your account</p>
                    </div>

                    <form action="<%=request.getContextPath()%>/forgot-password-auth" method="post">
                        <div class="form-group"><div class="input-wrapper">
                                <input type="text" id="username" name="username" required><label for="username">Username</label><span class="input-line"></span>
                            </div></div>

                        <div class="form-group"><div class="input-wrapper">
                                <input type="email" id="email" name="email" required><label for="email">Registered Email</label><span class="input-line"></span>
                            </div></div>

                        <div class="form-group"><div class="input-wrapper">
                                <input type="tel" id="phone" name="phone" required><label for="phone">Registered Phone Number</label><span class="input-line"></span>
                            </div></div>

                        <button type="submit" class="login-btn btn">Verify and Continue</button>
                    </form>

                    <% // Hiển thị lỗi từ bước xác thực
              if (request.getParameter("error") != null) { %>
                    <div style="color: #ff0080; text-align:center; margin-top: 15px;">
                        ❌ Thông tin Username, Email, hoặc Phone không chính xác. Vui lòng kiểm tra lại.
                    </div>
                    <% } %>

                    <div class="auth-options" style="justify-content: center; margin-top: 20px;">
                        <a href="<%=request.getContextPath()%>/login" style="color: #00ff88;">Back to Login</a>
                    </div>

                </div>
            </div>
        </div>

        <section id="footer" class="bg_dark">
            <div class="container-xl">
                <div class="row footer_1">
                    <div class="col-md-3">
                        <div class="footer_1i">
                            <h3 class="mb-0 mb-3"><a class="text-white" href="<%=request.getContextPath()%>/index.jsp"><i class="fa fa-plane col_yell"></i> Hotells</a></h3>
                            <p class="mb-0 text-light">We always strive for growth and development as StylemixThemes. We don?t want to have a large team, we want to have a team that works in unity. Our slogan is ?Every day is the last day?.</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="footer_1i">
                            <h5 class="text-white mb-4">GALLERY</h5>
                            <div class="footer_1i1 row">
                                <div class="col-md-4 pe-0 col-4"> <div class="grid clearfix"> <figure class="effect-jazz mb-0"> <a href="#"><img src="img/7.jpg" class="w-100" alt="img25"></a> </figure> </div> </div>
                                <div class="col-md-4 pe-0 col-4"> <div class="grid clearfix"> <figure class="effect-jazz mb-0"> <a href="#"><img src="img/8.jpg" class="w-100" alt="img25"></a> </figure> </div> </div>
                                <div class="col-md-4 pe-0 col-4"> <div class="grid clearfix"> <figure class="effect-jazz mb-0"> <a href="#"><img src="img/9.jpg" class="w-100" alt="img25"></a> </figure> </div> </div>
                                <div class="col-md-4 pe-0 col-4 mt-3"> <div class="grid clearfix"> <figure class="effect-jazz mb-0"> <a href="#"><img src="img/10.jpg" class="w-100" alt="img25"></a> </figure> </div> </div>
                                <div class="col-md-4 pe-0 col-4 mt-3"> <div class="grid clearfix"> <figure class="effect-jazz mb-0"> <a href="#"><img src="img/11.jpg" class="w-100" alt="img25"></a> </figure> </div> </div>
                                <div class="col-md-4 pe-0 col-4 mt-3"> <div class="grid clearfix"> <figure class="effect-jazz mb-0"> <a href="#"><img src="img/12.jpg" class="w-100" alt="img25"></a> </figure> </div> </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="footer_1i">
                            <h5 class="text-white mb-3">CONTACT US</h5>
                            <p class="text-light mb-2">1230 Porta avenue, Semper, New York City, NZ 10117 US</p>
                            <p class="text-light mb-2"><span class="fw-bold">Tel:</span> +(123) 456 7890 </p>
                            <p class="text-light mb-2"><span class="fw-bold">Fax:</span> +(123) 456 7890 </p>
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
                                    <button class="btn btn-primary bg_yell rounded-0 p-2 px-3 border-0" type="button"> <i class="fa fa-location-arrow"></i> </button>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <hr class="mt-4 mb-4 hr_1">
                <div class="row footer_2 text-center">
                    <div class="col-md-12">
                        <p class="mb-0 text-light">© 2013 Your Website Name. All Rights Reserved | Design by <a class="col_yell fw-bold" href="http://www.templateonweb.com">TemplateOnWeb</a></p>
                    </div>
                </div>
            </div>
        </section>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>