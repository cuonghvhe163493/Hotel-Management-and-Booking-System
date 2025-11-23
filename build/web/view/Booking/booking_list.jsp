<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>My Booking History</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <style>
            body {
                background-color: #f8f9fa;
                font-family: Arial, sans-serif;
            }
            .center_o {
                background: #343a40;
                color: #fff;
                padding: 60px 0 40px;
            }
            .center_o h2 {
                font-size: 2.5rem;
                margin-bottom: 0.5rem;
            }
            .center_o h6 a {
                text-decoration: none;
            }
            .card {
                border-radius: 1rem;
            }
            .badge {
                font-size: 0.9rem;
                padding: 0.4em 0.7em;
            }
            .table th, .table td {
                vertical-align: middle;
            }
            .table tbody tr:hover {
                background-color: #f1f1f1;
            }
            .btn-sm {
                margin: 2px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/view/common/header.jsp" />

        <!-- Page Banner -->
        <section class="center_o text-center">
            <div class="container-xl">
                <h2 class="text-uppercase">My Booking History</h2>
                <h6 class="mb-0 mt-3 text-warning">
                    <a class="text-white" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                    <span class="mx-2 text-muted">/</span> Bookings
                </h6>
            </div>
        </section>

        <!-- Bookings Section -->
        <section class="py-5">
            <div class="container">
                <div class="card shadow-lg border-0">
                    <div class="card-body">
                        <h4 class="mb-4 text-center fw-bold">Your Bookings</h4>

                        <c:choose>
                            <c:when test="${empty bookings}">
                                <p class="text-center text-muted">You have no bookings yet.</p>
                            </c:when>
                            <c:otherwise>
                                <!-- Filter Form -->
                                <form method="get" action="booking-list" class="mb-3 d-flex gap-2 align-items-center justify-content-end">
                                    <label for="statusFilter" class="mb-0">Filter by status:</label>
                                    <select name="statusFilter" id="statusFilter" class="form-select w-auto">
                                        <option value="">All Status</option>
                                        <option value="pending" ${param.statusFilter=='pending' ? 'selected' : ''}>Pending</option>
                                        <option value="completed" ${param.statusFilter=='completed' ? 'selected' : ''}>Completed</option>
                                        <option value="cancelled" ${param.statusFilter=='cancelled' ? 'selected' : ''}>Cancelled</option>
                                    </select>
                                    <button type="submit" class="btn btn-primary btn-sm">Apply</button>
                                </form>

                                <div class="table-responsive">
                                    <table class="table table-bordered align-middle">
                                        <thead class="table-warning">
                                            <tr>
                                                <th>Booking ID</th>
                                                <th>Check-in</th>
                                                <th>Check-out</th>
                                                <th>Status</th>
                                                <th>Total</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="b" items="${bookings}">
                                                <tr>
                                                    <td>#${b.bookingId}</td>
                                                    <td><fmt:formatDate value="${b.checkInDate}" pattern="yyyy-MM-dd"/></td>
                                                    <td><fmt:formatDate value="${b.checkOutDate}" pattern="yyyy-MM-dd"/></td>
                                                    <td>
                                                        <span class="badge
                                                              <c:choose>
                                                                  <c:when test="${b.status == 'completed'}">bg-success</c:when>
                                                                  <c:when test="${b.status == 'pending'}">bg-warning</c:when>
                                                                  <c:when test="${b.status == 'cancelled'}">bg-danger</c:when>
                                                                  <c:otherwise>bg-secondary</c:otherwise>
                                                              </c:choose>">
                                                            ${b.status}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <fmt:formatNumber value="${b.grandTotal}" type="number" maxFractionDigits="0"/> VNĐ
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-sm btn-outline-primary" 
                                                                data-bs-toggle="modal" data-bs-target="#bookingModal${b.bookingId}">
                                                            View Details
                                                        </button>
                                                        <c:if test="${b.status == 'pending'}">
                                                            <form action="${pageContext.request.contextPath}/payment" method="post" style="display:inline;">
                                                                <input type="hidden" name="bookingId" value="${b.bookingId}">
                                                                <input type="hidden" name="grandTotal" value="${b.grandTotal}">
                                                                <input type="hidden" name="orderInfo" value="Payment for booking #${b.bookingId}">
                                                                <button type="submit" class="btn btn-sm btn-warning">Pay</button>
                                                            </form>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </section>

        <!-- Modals for each booking -->
        <c:forEach var="b" items="${bookings}">
            <div class="modal fade" id="bookingModal${b.bookingId}" tabindex="-1">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header bg-warning text-dark">
                            <h5 class="modal-title">Booking #${b.bookingId} Details</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <h6 class="mb-3">Room(s) Booked</h6>
                            <c:choose>
                                <c:when test="${not empty roomsMap[b.bookingId] && roomsMap[b.bookingId].size() > 0}">
                                    <div class="table-responsive mb-4">
                                        <table class="table table-bordered table-sm">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Room</th>
                                                    <th>Check-in</th>
                                                    <th>Check-out</th>
                                                    <th>Guests</th>
                                                    <th>Price/Night</th>
                                                    <th>Total</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="r" items="${roomsMap[b.bookingId]}">
                                                    <tr>
                                                        <td>#${r.roomNumber}</td>
                                                        <td><fmt:formatDate value="${r.checkInDate}" pattern="yyyy-MM-dd"/></td>
                                                        <td><fmt:formatDate value="${r.checkOutDate}" pattern="yyyy-MM-dd"/></td>
                                                        <td>${r.guestsCount}</td>
                                                        <td><fmt:formatNumber value="${r.ratePerNight}" type="number" maxFractionDigits="0"/> VNĐ</td>
                                                        <td><fmt:formatNumber value="${r.lineTotal}" type="number" maxFractionDigits="0"/> VNĐ</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-muted">No rooms booked for this booking.</p>
                                </c:otherwise>
                            </c:choose>

                            <h6 class="mb-3 mt-4">Services Booked</h6>
                            <c:choose>
                                <c:when test="${not empty servicesMap[b.bookingId] && servicesMap[b.bookingId].size() > 0}">
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-sm">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Service Name</th>
                                                    <th>Check-in</th>
                                                    <th>Check-out</th>
                                                    <th>Guests</th>
                                                    <th>Price</th>
                                                    <th>Total</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="s" items="${servicesMap[b.bookingId]}">
                                                    <tr>
                                                        <td>${s.serviceName}</td>
                                                        <td><fmt:formatDate value="${s.checkInDate}" pattern="yyyy-MM-dd"/></td>
                                                        <td><fmt:formatDate value="${s.checkOutDate}" pattern="yyyy-MM-dd"/></td>
                                                        <td>${s.guestsCount}</td>
                                                        <td><fmt:formatNumber value="${s.price}" type="number" maxFractionDigits="0"/> VNĐ</td>
                                                        <td><fmt:formatNumber value="${s.total}" type="number" maxFractionDigits="0"/> VNĐ</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-muted">No services booked for this booking.</p>
                                </c:otherwise>
                            </c:choose>

                            <hr/>
                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <p><strong>Check-in Date:</strong> <fmt:formatDate value="${b.checkInDate}" pattern="yyyy-MM-dd"/></p>
                                    <p><strong>Check-out Date:</strong> <fmt:formatDate value="${b.checkOutDate}" pattern="yyyy-MM-dd"/></p>
                                </div>
                                <div class="col-md-6 text-end">
                                    <p><strong>Subtotal:</strong> <fmt:formatNumber value="${b.subtotal}" type="number" maxFractionDigits="0"/> VNĐ</p>
                                    <p><strong>Discount:</strong> <fmt:formatNumber value="${b.discountTotal}" type="number" maxFractionDigits="0"/> VNĐ</p>
                                    <p class="fs-5"><strong>Grand Total:</strong> <fmt:formatNumber value="${b.grandTotal}" type="number" maxFractionDigits="0"/> VNĐ</p>
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
