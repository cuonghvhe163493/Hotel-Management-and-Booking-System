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
            /* 1. GHI ĐÈ CSS GÂY LỖI CHO BODY */
            body {
                /* Bỏ display:flex, align-items, justify-content, height, overflow từ style.css */
                background-color: #273733 !important; /* Màu nền body */
                margin: 0 !important;
                min-height: 100vh !important;
                display: flex !important;
                flex-direction: column !important; /* Xếp Header, Main, Footer theo cột */
                overflow-x: hidden !important; /* Chỉ ẩn cuộn ngang */
                height: auto !important; /* Cho phép body tự điều chỉnh chiều cao */
                overflow-y: auto !important; /* Cho phép cuộn dọc nếu cần */
                padding-top: 0 !important; /* Reset padding */
            }
            
            /* 2. Đảm bảo Header hiển thị đúng */
            .main_1 {
                position: relative !important; 
                width: 100%;
                background-color: #38423f; 
                padding: 0 !important; 
                z-index: 10; 
                height: auto !important; /* Để header tự điều chỉnh chiều cao */
            }
            
            .main_1 #top, .main_1 #header {
                display: block !important; 
                background-color: #38423f; 
                padding-top: 1rem !important; 
                padding-bottom: 1rem !important;
                border-bottom: none; 
                position: relative !important; /* Bỏ sticky tạm thời */
                top: auto !important;
                z-index: auto !important;
                 box-shadow: none !important;
            }
             /* Đảm bảo nav bên trong header cũng hiển thị */
             #navbar_sticky {
                 display: block !important;
                 position: relative !important; 
                 top: auto !important;
                 background-color: transparent !important; /* Reset màu nền */
                 box-shadow: none !important;
             }
             /* Xóa class sticky nếu nó bị kẹt */
            #navbar_sticky.sticky {
                 position: relative !important; 
            }

            /* 3. Cấu hình khu vực Content (Login Form) */
            .main { /* Đổi tên class content để tránh xung đột */
                flex-grow: 1; 
                display: flex;
                align-items: center; 
                justify-content: center; 
                padding: 50px 20px; 
                margin: 0;
                position: relative; 
                z-index: 1; 
            }
            /* Giữ nguyên CSS cho login-container và login-card */
             .login-container {
                position: relative; /* Đảm bảo z-index hoạt động */
                z-index: 10;
                width: 100%;
                max-width: 420px;
             }
             /* .login-card giữ nguyên từ file style.css của bạn */
             

            /* 4. Footer (giữ nguyên) */
            #footer {
                background-color: #463b3f; 
                padding: 1.5rem 0 0.5rem 0; 
                width: 100%; 
                margin-top: auto; /* Đảm bảo footer ở cuối trang */
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
            .top_1m, .top_1r { margin-top: 0 !important; }
            .top_1m a { color: white !important; }
            
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
                                <li class="nav-item"> <a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/index.jsp">Home</a> </li>
                                <li class="nav-item"> <a class="nav-link" href="#">About </a> </li>
                                <li class="nav-item dropdown"> <a class="nav-link dropdown-toggle" href="#" id="roomsDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false"> Rooms </a> <ul class="dropdown-menu drop_1" aria-labelledby="roomsDropdown"> <li><a class="dropdown-item" href="#"> Rooms</a></li> <li><a class="dropdown-item border-0" href="#"> Room Detail</a></li> </ul> </li>
                                <li class="nav-item dropdown"> <a class="nav-link dropdown-toggle" href="#" id="blogDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false"> Blog </a> <ul class="dropdown-menu drop_1" aria-labelledby="blogDropdown"> <li><a class="dropdown-item" href="#"> Blog</a></li> <li><a class="dropdown-item border-0" href="#"> Blog Detail</a></li> </ul> </li>
                                <li class="nav-item"> <a class="nav-link" href="#">Services</a> </li>
                                <li class="nav-item"> <a class="nav-link" href="#">Gallery</a> </li>
                                <li class="nav-item"> <a class="nav-link" href="#">Contact</a> </li>
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

                    <form class="login-form" id="loginForm" action="${pageContext.request.contextPath}/login" method="post" novalidate>
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
                            ✅ Registration successful! Redirecting to login...
                        </div>
                        <script>
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

                    <% if (request.getParameter("error") != null) { %>
                    <script>alert('Invalid username or password!');</script>
                    <% } %>
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
        </body>
</html>