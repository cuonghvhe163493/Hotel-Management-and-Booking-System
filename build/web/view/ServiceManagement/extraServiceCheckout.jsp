<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
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

<body class="bg-light">
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
    <div class="container mt-4">
        <h3 class="mb-3">Extra Service Checkout</h3>

        <div class="row g-4">
            <div class="col-lg-7">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title mb-3"><c:out value="${service.serviceName}" /></h5>
                        <p class="text-muted"><c:out value="${service.serviceDescription}" /></p>
                        <p class="mb-0">
                            Unit price:
                            <strong>$<fmt:formatNumber value="${service.servicePrice}" minFractionDigits="2"/></strong>
                        </p>
                        <p>
                            Quantity: <strong>${qty}</strong> &nbsp; | &nbsp;
                            Total: <strong>
                                $<fmt:formatNumber value="${service.servicePrice * qty}" minFractionDigits="2"/>
                            </strong>
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Customer Information</h5>

                        <form action="${ctx}/extraService/confirm" method="post">
                            <input type="hidden" name="serviceId" value="${service.extraServiceId}">
                            <input type="hidden" name="qty" value="${qty}">

                            <div class="mb-3">
                                <label class="form-label">Full name</label>
                                <input name="fullName" class="form-control" required value="${customerName}">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Phone</label>
                                <input name="phone" class="form-control" required value="${customerPhone}">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input name="email" type="email" class="form-control" required value="${customerEmail}">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Notes (optional)</label>
                                <textarea name="note" class="form-control" rows="3"></textarea>
                            </div>

                            <button type="submit" class="btn btn-primary w-100">Confirm & Book</button>
                            <a href="${ctx}/extraServiceDetail?id=${service.extraServiceId}" class="btn btn-outline-secondary w-100 mt-2">Back</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
</body>
</html>
