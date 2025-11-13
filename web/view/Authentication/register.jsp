<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account - Hotel Management</title>
    
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet" >
    <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/index.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@500&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    
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
            font-family: 'Inter', sans-serif; 
            color: white; 
        }
        
        
        .main_1 {
            position: relative !important; width: 100%; background-color: #38423f; padding: 0 !important; z-index: 10; height: auto !important; 
        }
        .main_1 #top, .main_1 #header {
            display: block !important; background-color: #38423f; padding-top: 1rem !important; padding-bottom: 1rem !important;
            border-bottom: none; position: relative !important; top: auto !important; z-index: auto !important; box-shadow: none !important;
        }
        #navbar_sticky { display: block !important; position: relative !important; top: auto !important; background-color: transparent !important; box-shadow: none !important; }
        #navbar_sticky.sticky { position: relative !important; }

      
        .main-content-area { 
            flex-grow: 1; display: flex; align-items: center; justify-content: center; padding: 50px 20px; margin: 0; position: relative; z-index: 1; 
        }

     
        .register-card {
            background: #2A3232; border-radius: 16px; padding: 40px; width: 100%; max-width: 450px; 
            box-shadow: 0 0 40px rgba(0, 255, 136, 0.3); border: 1px solid #2a2a35; transition: all 0.3s ease; margin-left: auto; margin-right: auto;
        }
        .register-card:hover { box-shadow: 0 0 60px rgba(0, 255, 136, 0.35); transform: translateY(-2px); }
        .register-card h2 { text-align: center; margin-bottom: 30px; color: #fff; }
        .form-group { margin-bottom: 20px; position: relative; }
        .form-group label { display: block; color: #a0a0b0; font-size: 14px; margin-bottom: 8px; }
        .form-group input { width: 100%; padding: 14px; background: #1a1a25; border: 1px solid #2a2a35; border-radius: 6px; color: white; font-size: 15px; transition: all 0.3s ease; outline: none; }
        .form-group input:focus { border-color: #00ff88; box-shadow: 0 0 10px rgba(0, 255, 136, 0.4); }
        .form-group input[type="date"] { color-scheme: dark; }
        .form-group input[type="date"]:required:invalid::-webkit-datetime-edit { color: #a0a0b0; }
        .submit-btn { width: 100%; background: linear-gradient(135deg, #00ff88, #0099ff); border: none; padding: 15px; border-radius: 6px; color: #0a0a0f; font-size: 16px; font-weight: 600; cursor: pointer; margin-top: 20px; transition: all 0.3s ease; }
        .submit-btn:hover { transform: translateY(-1px); box-shadow: 0 0 25px rgba(0, 255, 136, 0.5); }
        .error { color: #ff4d6d; font-size: 12px; margin-top: 6px; min-height: 1em; }
        .register-card p[style*="color"] { font-size: 14px; }

        /* 5. Footer (giữ nguyên) */
        #footer { background-color: #463b3f; padding: 1.5rem 0 0.5rem 0; width: 100%; margin-top: auto; }
        #footer .container-xl { max-width: 1320px; margin-left: auto; margin-right: auto; padding-left: 20px; padding-right: 20px; }
        #footer .row.footer_1 { margin-bottom: 10px; }
        #footer .hr_1 { margin-top: 10px !important; margin-bottom: 10px !important; }
        .top_1m, .top_1r { margin-top: 0 !important; }
        .top_1m a { color: white !important; }

        /* Responsive */
        @media (max-width: 480px) {
          .register-card { padding: 25px; }
          .form-group input, .submit-btn { padding: 12px; font-size: 14px; }
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

    <div class="main-content-area clearfix">
        <div class="register-card">
            <h2>Register</h2>
            <form id="registerForm" action="<%=request.getContextPath()%>/register" method="post" novalidate>
                
              <div class="form-group">
                <label for="username">Username</label> 
                <input type="text" id="username" name="username" required>
                <div class="error" id="usernameError"></div>
              </div>
        
              <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
                <div class="error" id="emailError"></div>
              </div>
        
              <div class="form-group">
                <label for="phone">Phone</label>
                <input type="tel" id="phone" name="phone" required> 
                <div class="error" id="phoneError"></div>
              </div>
        
              <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" required>
                <div class="error" id="addressError"></div>
              </div>
        
              <div class="form-group">
                <label for="dob">Date of Birth</label>
                <input type="date" id="dob" name="dob" required>
                <div class="error" id="dobError"></div> 
              </div>
        
              <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
                <div class="error" id="passwordError"></div>
              </div>
        
              <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
                <div class="error" id="confirmError"></div>
              </div>
        
              <button type="submit" class="submit-btn">Create Account</button>
            </form>
        
            <% 
              if (request.getParameter("error") != null) { 
                String errorType = request.getParameter("error");
                String errorMessage = "";
                if ("missing".equals(errorType)) {
                    errorMessage = "Vui lòng điền đầy đủ các trường bắt buộc.";
                } else if ("pass".equals(errorType)) {
                    errorMessage = "Mật khẩu và xác nhận mật khẩu không khớp.";
                } else if ("exists".equals(errorType)) {
                    errorMessage = "Tên đăng nhập hoặc Email này đã tồn tại.";
                } else {
                    errorMessage = "Đăng ký thất bại do lỗi hệ thống.";
                }
            %>
            <p style="color:#ff4d6d;text-align:center;margin-top:15px;">❌ <%= errorMessage %></p>
            <% } else if (request.getParameter("success") != null) { %>
               <script>
                    window.location.href = "<%=request.getContextPath()%>/view/Authentication/login.jsp?success=true"; 
               </script>
            <% } %>
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
    <script>
        document.getElementById("registerForm").addEventListener("submit", function (e) {
            let valid = true;
            let form = e.target;
            document.querySelectorAll(".error").forEach(el => el.textContent = "");
            
            // Regex cơ bản
            const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            const phonePattern = /^[0-9]{9,12}$/;
            
            const pass = form.password.value.trim();
            const confirm = form.confirmPassword.value.trim();
            
            // Validate Username
            if (form.username.value.trim().length < 4) { document.getElementById("usernameError").textContent = "Username must be at least 4 characters."; valid = false; }
            
            // Validate Email
            if (!emailPattern.test(form.email.value.trim())) { document.getElementById("emailError").textContent = "Invalid email format."; valid = false; }
            
            // Validate Phone
            if (!phonePattern.test(form.phone.value.trim())) { document.getElementById("phoneError").textContent = "Phone must be 9–12 digits."; valid = false; }
            
            // Validate Address
            if (form.address.value.trim() === "") { document.getElementById("addressError").textContent = "Address cannot be empty."; valid = false; }
            
            // Validate DOB
            if (form.dob.value === "") { document.getElementById("dobError").textContent = "Date of Birth is required."; valid = false; }
            
            // Validate Password Length
            if (pass.length < 6) { document.getElementById("passwordError").textContent = "Password must be at least 6 characters."; valid = false; }
            
            // Validate Confirm Password
            if (pass !== confirm) { document.getElementById("confirmError").textContent = "Passwords do not match."; valid = false; } 
            else if (confirm === "") { document.getElementById("confirmError").textContent = "Please confirm your password."; valid = false;}
            
            if (!valid) e.preventDefault();
        });
    </script>
</body>
</html>