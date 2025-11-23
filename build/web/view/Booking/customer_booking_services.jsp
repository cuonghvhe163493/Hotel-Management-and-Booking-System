<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Booking Services</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        :root {
            --primary-color: #ffb800;
            --dark-color: #343a40;
            --light-color: #f8f9fa;
        }

        body {
            background-color: var(--light-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .center_o {
            background: var(--dark-color);
            color: #fff;
            padding: 60px 0 40px;
        }

        .center_o h2 {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            font-weight: 700;
        }

        .center_o h6 a {
            text-decoration: none;
            color: #fff;
        }

        .center_o .text-warning {
            color: var(--primary-color) !important;
        }

        /* Statistics Cards */
        .stat-card {
            background: linear-gradient(135deg, var(--primary-color) 0%, #ffcc00 100%);
            color: white;
            border-radius: 1rem;
            padding: 2rem;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            display: block;
        }

        .stat-label {
            font-size: 0.95rem;
            opacity: 0.95;
            margin-top: 0.5rem;
        }

        /* Service Card */
        .service-card {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            border-left: 4px solid var(--primary-color);
            transition: box-shadow 0.3s ease;
        }

        .service-card:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .service-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 1rem;
            flex-wrap: wrap;
        }

        .service-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--dark-color);
            margin: 0;
        }

        .booking-id-badge {
            background: var(--primary-color);
            color: var(--dark-color);
            padding: 0.5rem 1rem;
            border-radius: 2rem;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 2rem;
            font-weight: 600;
            font-size: 0.85rem;
        }

        .status-pending {
            background-color: #ffc107;
            color: var(--dark-color);
        }

        .status-completed {
            background-color: #28a745;
            color: white;
        }

        .status-cancelled {
            background-color: #dc3545;
            color: white;
        }

        .service-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
        }

        .detail-label {
            font-size: 0.85rem;
            color: #666;
            font-weight: 500;
            text-transform: uppercase;
            margin-bottom: 0.25rem;
        }

        .detail-value {
            font-size: 1.1rem;
            color: var(--dark-color);
            font-weight: 600;
        }

        .service-table {
            font-size: 0.95rem;
            margin-top: 1rem;
        }

        .service-table th {
            background-color: #f8f9fa;
            color: var(--dark-color);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            border-bottom: 2px solid var(--primary-color);
        }

        .service-table td {
            padding: 1rem;
            vertical-align: middle;
        }

        .service-row:hover {
            background-color: #f8f9fa;
        }

        .price-highlight {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 1.1rem;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem 1rem;
            color: #999;
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .empty-state h4 {
            color: #666;
            margin-bottom: 0.5rem;
        }

        .empty-state p {
            color: #999;
        }

        /* Total Section */
        .total-section {
            background: linear-gradient(135deg, #fff9e6 0%, #fffbf0 100%);
            border: 2px solid var(--primary-color);
            border-radius: 1rem;
            padding: 2rem;
            margin-top: 2rem;
        }

        .total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.75rem 0;
            font-size: 1.1rem;
        }

        .total-row.grand-total {
            border-top: 2px solid var(--primary-color);
            padding-top: 1rem;
            margin-top: 1rem;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
        }

        /* Action Buttons */
        .btn-primary-custom {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: var(--dark-color);
            font-weight: 600;
        }

        .btn-primary-custom:hover {
            background-color: #e6a600;
            border-color: #e6a600;
            color: var(--dark-color);
        }

        .btn-sm-custom {
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .center_o h2 {
                font-size: 1.75rem;
            }

            .service-details {
                grid-template-columns: 1fr;
            }

            .stat-card {
                margin-bottom: 1rem;
            }

            .service-table {
                font-size: 0.85rem;
            }

            .service-table td {
                padding: 0.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="/view/common/header.jsp" />

    <!-- Page Banner -->
    <section class="center_o text-center">
        <div class="container-xl">
            <h2 class="text-uppercase"><i class="bi bi-cart-check"></i> My Booking Services</h2>
            <h6 class="mb-0 mt-3">
                <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
                <span class="mx-2 text-muted">/</span> My Services
            </h6>
        </div>
    </section>

    <!-- Main Content -->
    <section class="py-5">
        <div class="container-xl">

            <!-- Statistics Section -->
            <c:if test="${not empty statistics}">
                <div class="row mb-5">
                    <div class="col-md-4 mb-3">
                        <div class="stat-card">
                            <span class="stat-number">${statistics.totalBookings}</span>
                            <span class="stat-label">Total Bookings</span>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="stat-card" style="background: linear-gradient(135deg, #28a745 0%, #20c997 100%);">
                            <span class="stat-number">${statistics.totalServices}</span>
                            <span class="stat-label">Total Services</span>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="stat-card" style="background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);">
                            <span class="stat-number">
                                <fmt:formatNumber value="${statistics.totalSpent}" type="number" maxFractionDigits="0"/>
                            </span>
                            <span class="stat-label">Total Spent (VNĐ)</span>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Bookings List -->
            <c:choose>
                <c:when test="${empty bookings}">
                    <div class="empty-state">
                        <i class="bi bi-inbox"></i>
                        <h4>No Bookings Found</h4>
                        <p>You haven't made any bookings yet.</p>
                        <a href="${pageContext.request.contextPath}/extra-services" class="btn btn-primary-custom mt-3">
                            <i class="bi bi-plus-circle"></i> Book Services Now
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="booking" items="${bookings}">
                        <div class="service-card">
                            <!-- Service Card Header -->
                            <div class="service-header">
                                <div>
                                    <h5 class="service-title">
                                        <i class="bi bi-bookmark-fill"></i> 
                                        Booking Services
                                    </h5>
                                </div>
                                <div class="d-flex gap-2 flex-wrap mt-2">
                                    <span class="booking-id-badge">#${booking.bookingId}</span>
                                    <span class="status-badge status-${booking.status}">
                                        <c:choose>
                                            <c:when test="${booking.status == 'pending'}">
                                                <i class="bi bi-hourglass-split"></i> PENDING
                                            </c:when>
                                            <c:when test="${booking.status == 'completed'}">
                                                <i class="bi bi-check-circle-fill"></i> COMPLETED
                                            </c:when>
                                            <c:when test="${booking.status == 'cancelled'}">
                                                <i class="bi bi-x-circle-fill"></i> CANCELLED
                                            </c:when>
                                            <c:otherwise>${booking.status}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>

                            <!-- Booking Details Grid -->
                            <div class="service-details">
                                <div class="detail-item">
                                    <span class="detail-label"><i class="bi bi-calendar-event"></i> Check-in</span>
                                    <span class="detail-value">
                                        <fmt:formatDate value="${booking.checkInDate}" pattern="dd/MM/yyyy"/>
                                    </span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label"><i class="bi bi-calendar-check"></i> Check-out</span>
                                    <span class="detail-value">
                                        <fmt:formatDate value="${booking.checkOutDate}" pattern="dd/MM/yyyy"/>
                                    </span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label"><i class="bi bi-tag"></i> Created</span>
                                    <span class="detail-value">
                                        <fmt:formatDate value="${booking.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                    </span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label"><i class="bi bi-wallet2"></i> Paid Amount</span>
                                    <span class="detail-value price-highlight">
                                        <fmt:formatNumber value="${booking.paidTotal}" type="number" maxFractionDigits="0"/> VNĐ
                                    </span>
                                </div>
                            </div>

                            <!-- Services Table -->
                            <c:if test="${not empty bookingServicesMap[booking.bookingId]}">
                                <div class="service-table">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th><i class="bi bi-box"></i> Service Name</th>
                                                <th class="text-center"><i class="bi bi-person"></i> Guests</th>
                                                <th class="text-center"><i class="bi bi-calendar-range"></i> Dates</th>
                                                <th class="text-end"><i class="bi bi-tag-fill"></i> Price</th>
                                                <th class="text-end"><i class="bi bi-calculator"></i> Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="service" items="${bookingServicesMap[booking.bookingId]}">
                                                <tr class="service-row">
                                                    <td>
                                                        <strong>${service.serviceName}</strong>
                                                    </td>
                                                    <td class="text-center">
                                                        <span class="badge bg-info">${service.guestsCount}</span>
                                                    </td>
                                                    <td class="text-center" style="font-size: 0.9rem;">
                                                        <fmt:formatDate value="${service.checkInDate}" pattern="dd/MM"/>
                                                        <br/> - 
                                                        <fmt:formatDate value="${service.checkOutDate}" pattern="dd/MM"/>
                                                    </td>
                                                    <td class="text-end">
                                                        <fmt:formatNumber value="${service.price}" type="number" maxFractionDigits="0"/> VNĐ
                                                    </td>
                                                    <td class="text-end">
                                                        <span class="price-highlight">
                                                            <fmt:formatNumber value="${service.total}" type="number" maxFractionDigits="0"/> VNĐ
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <tr class="table-light fw-bold">
                                                <td colspan="4" class="text-end">Subtotal (Services):</td>
                                                <td class="text-end">
                                                    <c:set var="serviceSubtotal" value="0" />
                                                    <c:forEach var="service" items="${bookingServicesMap[booking.bookingId]}">
                                                        <c:set var="serviceSubtotal" value="${serviceSubtotal + service.total}" />
                                                    </c:forEach>
                                                    <fmt:formatNumber value="${serviceSubtotal}" type="number" maxFractionDigits="0"/> VNĐ
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>

                            <!-- Booking Totals -->
                            <div class="total-section">
                                <div class="total-row">
                                    <span><i class="bi bi-receipt"></i> Subtotal:</span>
                                    <span class="price-highlight">
                                        <fmt:formatNumber value="${booking.subtotal}" type="number" maxFractionDigits="0"/> VNĐ
                                    </span>
                                </div>
                                <div class="total-row">
                                    <span><i class="bi bi-percent"></i> Discount:</span>
                                    <span style="color: #dc3545;">
                                        -<fmt:formatNumber value="${booking.discountTotal}" type="number" maxFractionDigits="0"/> VNĐ
                                    </span>
                                </div>
                                <div class="total-row grand-total">
                                    <span><i class="bi bi-wallet-fill"></i> Grand Total:</span>
                                    <span>
                                        <fmt:formatNumber value="${booking.grandTotal}" type="number" maxFractionDigits="0"/> VNĐ
                                    </span>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="mt-3">
                                <c:if test="${booking.status == 'pending'}">
                                    <form action="${pageContext.request.contextPath}/payment" method="post" style="display:inline;">
                                        <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                        <input type="hidden" name="grandTotal" value="${booking.grandTotal}">
                                        <input type="hidden" name="orderInfo" value="Payment for booking #${booking.bookingId}">
                                        <button type="submit" class="btn btn-primary-custom btn-sm-custom">
                                            <i class="bi bi-credit-card"></i> Pay Now
                                        </button>
                                    </form>
                                </c:if>
                                <button type="button" class="btn btn-outline-secondary btn-sm-custom" data-bs-toggle="modal" data-bs-target="#detailsModal${booking.bookingId}">
                                    <i class="bi bi-zoom-in"></i> View Details
                                </button>
                                <a href="${pageContext.request.contextPath}/booking-list" class="btn btn-outline-primary btn-sm-custom">
                                    <i class="bi bi-arrow-left"></i> Back to Bookings
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

        </div>
    </section>

    <!-- Details Modals -->
    <c:forEach var="booking" items="${bookings}">
        <div class="modal fade" id="detailsModal${booking.bookingId}" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-warning text-dark">
                        <h5 class="modal-title">Booking #${booking.bookingId} - Full Details</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Full Service Table -->
                        <h6 class="mb-3">All Services</h6>
                        <div class="table-responsive">
                            <table class="table table-sm table-bordered">
                                <thead class="table-light">
                                    <tr>
                                        <th>Service Name</th>
                                        <th class="text-center">Check-in</th>
                                        <th class="text-center">Check-out</th>
                                        <th class="text-center">Guests</th>
                                        <th class="text-end">Price</th>
                                        <th class="text-end">Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="service" items="${bookingServicesMap[booking.bookingId]}">
                                        <tr>
                                            <td>${service.serviceName}</td>
                                            <td class="text-center">
                                                <fmt:formatDate value="${service.checkInDate}" pattern="dd/MM/yyyy"/>
                                            </td>
                                            <td class="text-center">
                                                <fmt:formatDate value="${service.checkOutDate}" pattern="dd/MM/yyyy"/>
                                            </td>
                                            <td class="text-center">${service.guestsCount}</td>
                                            <td class="text-end">
                                                <fmt:formatNumber value="${service.price}" type="number" maxFractionDigits="0"/>
                                            </td>
                                            <td class="text-end fw-bold">
                                                <fmt:formatNumber value="${service.total}" type="number" maxFractionDigits="0"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Summary -->
                        <hr/>
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Status:</strong> ${booking.status}</p>
                                <p><strong>Check-in:</strong> <fmt:formatDate value="${booking.checkInDate}" pattern="dd/MM/yyyy"/></p>
                                <p><strong>Check-out:</strong> <fmt:formatDate value="${booking.checkOutDate}" pattern="dd/MM/yyyy"/></p>
                            </div>
                            <div class="col-md-6 text-end">
                                <p><strong>Subtotal:</strong> <fmt:formatNumber value="${booking.subtotal}" type="number" maxFractionDigits="0"/> VNĐ</p>
                                <p><strong>Discount:</strong> <fmt:formatNumber value="${booking.discountTotal}" type="number" maxFractionDigits="0"/> VNĐ</p>
                                <p class="fs-5"><strong style="color: var(--primary-color);">Grand Total: <fmt:formatNumber value="${booking.grandTotal}" type="number" maxFractionDigits="0"/> VNĐ</strong></p>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

</body>
</html>
