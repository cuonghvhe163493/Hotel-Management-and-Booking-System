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
        <meta charset="UTF-8" />
        <title>${service.name} | Hotells</title>

        <!-- Assets -->
        <link href="${ctx}/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${ctx}/css/font-awesome.min.css" rel="stylesheet" />
        <link href="${ctx}/css/global.css" rel="stylesheet" />
        <script src="${ctx}/js/bootstrap.bundle.min.js"></script>

        <style>
            .hero-img {
                width:100%;
                height:380px;
                object-fit:cover;
                border-radius:12px;
            }
            .spec-badge {
                font-size: .85rem;
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

        <!-- Header chung của site nếu bạn có include thì giữ nguyên -->
        <section class="py-4 bg-light">
            <div class="container-xl">

                <!-- Breadcrumb -->
                <nav aria-label="breadcrumb" class="mb-3">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="${ctx}/index.jsp">Home</a></li>
                        <li class="breadcrumb-item"><a href="${ctx}/service">Services</a></li>
                        <li class="breadcrumb-item active" aria-current="page">${service.name}</li>
                    </ol>
                </nav>

                <div class="row g-4">
                    <!-- Ảnh lớn -->
                    <div class="col-lg-7">
                        <!-- Vì model chưa có field ảnh, mặc định lấy theo code (vd: img/services/<code>.jpg) -->
                        <img class="hero-img"
                             src="${ctx}/img/services/${service.code}.jpg"
                             alt="${service.name}">
                    </div>

                    <!-- Thông tin chính -->
                    <div class="col-lg-5">
                        <h2 class="mb-2">${service.name}</h2>

                        <!-- Giá: ưu tiên priceLabel; nếu không có thì dùng minPriceCents -->
                        <c:choose>
                            <c:when test="${not empty priceLabel}">
                                <span class="badge bg-warning text-dark mb-2">${priceLabel}</span>
                            </c:when>
                            <c:when test="${not empty minPriceCents}">
                                <span class="badge bg-warning text-dark mb-2">
                                    From:
                                    $<fmt:formatNumber value="${minPriceCents/100.0}" type="number" minFractionDigits="2" />
                                </span>
                            </c:when>
                        </c:choose>

                        <!-- Mô tả ngắn: nếu bạn muốn, có thể cắt từ description -->
                        <p class="muted mt-2">
                            <c:out value="${service.description}" />
                        </p>

                        <hr/>

                        <!-- Thông số -->
                        <div class="mb-3">
                            <span class="badge bg-secondary spec-badge me-1">Code: ${service.code}</span>
                            <span class="badge bg-secondary spec-badge me-1">Unit: ${service.unit}</span>
                            <span class="badge bg-secondary spec-badge me-1">Tax: ${service.taxClass}</span>
                            <span class="badge ${service.active ? 'bg-success' : 'bg-danger'} spec-badge me-1">
                                ${service.active ? 'Active' : 'Inactive'}
                            </span>
                        </div>

                        <div class="mb-3 muted">
                            Created at:
                            <fmt:formatDate value="${service.createdAt.toInstant().toEpochMilli()}"
                                            pattern="yyyy-MM-dd HH:mm" type="both" />
                        </div>

                        <div class="d-flex gap-2">
                            <a class="btn btn-primary" href="#">BOOK NOW</a>
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
                                             alt="${r.name}">
                                    </a>
                                    <div class="card-body text-center">
                                        <h6 class="mb-1">
                                            <a class="text-decoration-none" href="${ctx}/service/detail?id=${r.serviceId}">
                                                ${r.name}
                                            </a>
                                        </h6>
                                        <!-- Nếu muốn hiển thị nhãn giá ngắn ở đây, bạn có thể thêm DTO hoặc tính trước ở servlet -->
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

            </div>
        </section>

    </body>
</html>

