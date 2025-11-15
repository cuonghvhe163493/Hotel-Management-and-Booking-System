<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Neon Login - Hotel Management</title>

        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" >
        <link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet" >
        <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/index.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@500&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/Authentication/css/style.css">

        <style>

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


            .main_1 {
                position: relative !important;
                width: 100%;
                background-color: #38423f;
                padding: 0 !important;
                z-index: 10;
                height: auto !important;
            }

            .main_1 #top, .main_1 #header {
                display: block !important;
                background-color: #38423f;
                padding-top: 1rem !important;
                padding-bottom: 1rem !important;
                border-bottom: none;
                position: relative !important;
                top: auto !important;
                z-index: auto !important;
                box-shadow: none !important;
            }

            #navbar_sticky {
                display: block !important;
                position: relative !important;
                top: auto !important;
                background-color: transparent !important;
                box-shadow: none !important;
            }

            #navbar_sticky.sticky {
                position: relative !important;
            }


            .main {
                flex-grow: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 50px 20px;
                margin: 0;
                position: relative;
                z-index: 1;
            }

            .login-container {
                position: relative;
                z-index: 10;
                width: 100%;
                max-width: 420px;
            }




            #footer {
                background-color: #463b3f;
                padding: 1.5rem 0 0.5rem 0;
                width: 100%;
                margin-top: auto;
            }
            #footer .container-xl {
                max-width: 1320px;
                margin-left: auto;
                margin-right: auto;
                padding-left: 20px;
                padding-right: 20px;
            }
            #footer .row.footer_1 {
                margin-bottom: 10px;
            }
            #footer .hr_1 {
                margin-top: 10px !important;
                margin-bottom: 10px !important;
            }

            /* Reset khác */
            .top_1m, .top_1r {
                margin-top: 0 !important;
            }
            .top_1m a {
                color: white !important;
            }

        </style>
    </head>
    <body>
        <% 
            // Logic xử lý thông báo lỗi (error) và thông báo thành công từ register
            String error = request.getParameter("error");
            String loginMessage = null;
            if ("invalid".equals(error)) {
                loginMessage = "Sai tên đăng nhập hoặc mật khẩu.";
            } else if ("banned".equals(error)) {
                loginMessage = "Tài khoản này đã bị BAN và không thể truy cập.";
            } else if ("google_failed".equals(error)) {
                loginMessage = "Lỗi đăng nhập Google hoặc tài khoản Google bị BAN.";
            }
            
            // Lấy giá trị redirect nếu có trong query string
            String redirect = request.getParameter("redirect");
        %>

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
                        <a class="navbar-brand fs-3 p-0 fw-bold text-white" href="${pageContext.request.contextPath}/index.jsp"><i class="fa fa-plane col_yell"></i> Hotels </a>
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
                        <h2>Sign In</h2>
                        <p>Access your account</p>
                    </div>

                    <% if (loginMessage != null) { %>
                        <div style="color: #ff4d6d; text-align: center; margin-bottom: 15px; font-weight: 600;">
                            ❌ <%= loginMessage %>
                        </div>
                    <% } %>

                    <form class="login-form" id="loginForm" action="${pageContext.request.contextPath}/login" method="post" novalidate>
                        <input type="hidden" name="redirect" value="<%= redirect != null ? redirect : "" %>">

                        <div class="form-group">
                            <div class="input-wrapper">
                                <input type="text" id="username" name="username" required autocomplete="username" value="admin" placeholder=" ">
                                <label for="username">Username</label>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-wrapper password-wrapper">
                                <input type="password" id="password" name="password" required autocomplete="current-password" value="••••••" placeholder=" ">
                                <label for="password">Password</label>
                            </div>
                        </div>

                        <button type="submit" class="login-btn btn">Sign In</button>

                        <% if (request.getParameter("success") != null) { %>
                        <div style="color: #00ff88; text-align: center; margin-top: 15px; font-weight: 600;">
                            ✅ Đăng ký thành công! Đang chuyển hướng...
                        </div>
                        <script>
                            // Chuyển hướng sau 2 giây
                            setTimeout(function () {
                                window.location.href = "<%=request.getContextPath()%>/login";
                            }, 2000);
                        </script>
                        <% } %>
                    </form>

                    <div class="divider"><span>or</span></div>

                    <a href="<%=request.getContextPath()%>/google-login" class="social-btn google-btn">
                        <span class="social-icon google-icon"></span>
                        <span>Continue with Google</span>
                    </a>

                    <div class="auth-options">
                        <a href="<%=request.getContextPath()%>/view/Authentication/forgot_password.jsp" class="forgot-password">
                            Forgot password?
                        </a>

                        <div class="signup-link">
                            <p>New here? <a href="<%=request.getContextPath()%>/register">Create an account</a></p>
                        </div>
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
                            <p class="text-light mb-2">FPT, University, HaNoi City, VN</p>
                            <p class="text-light mb-2"><span class="fw-bold">Tel:</span> +(123) 456 7890 </p>
                            <p class="text-light mb-2"><span class="fw-bold">Fax:</span> +(123) 456 7890 </p>
                            <p class="mb-0"> <a class="text-light" href="#">vietcuong3032002@gmail.com</a> </p>
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
                        <p class="mb-0 text-light">All Rights Reserved | Design by SWP Team<a class="col_yell fw-bold" href="http://www.templateonweb.com">Web</a></p>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>