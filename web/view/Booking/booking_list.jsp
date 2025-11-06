<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Booking History</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body { background-color: #f8f9fa; font-family: Arial, sans-serif; }
        .center_o { background: #343a40; color: #fff; padding: 60px 0 40px; }
        .center_o h2 { font-size: 2.5rem; margin-bottom: 0.5rem; }
        .center_o h6 a { text-decoration: none; }
        .card { border-radius: 1rem; }
        .badge { font-size: 0.9rem; padding: 0.4em 0.7em; }
        .table th, .table td { vertical-align: middle; text-align: center; }
        .table tbody tr:hover { background-color: #f1f1f1; }
        .btn-sm { margin: 2px; }
    </style>
</head>
<body>
    <jsp:include page="/view/common/header.jsp" />

    <section class="center_o text-center">
        <div class="container-xl">
            <h2 class="text-uppercase">My Booking History</h2>
            <h6 class="mb-0 mt-3 text-warning">
                <a class="text-white" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                <span class="mx-2 text-muted">/</span> Bookings
            </h6>
        </div>
    </section>

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
                                    <option value="balance_due" ${param.statusFilter=='balance_due' ? 'selected' : ''}>Balance Due</option>
                                    <option value="draft" ${param.statusFilter=='draft' ? 'selected' : ''}>Draft</option>
                                </select>
                                <button type="submit" class="btn btn-primary btn-sm">Apply</button>
                            </form>

                            <div class="table-responsive">
                                <table class="table table-bordered align-middle text-center">
                                    <thead class="table-warning">
                                        <tr>
                                            <th>
                                                Check-in
                                                <c:url var="sortDateAscUrl" value="booking-list">
                                                    <c:param name="sortBy" value="dateAsc" />
                                                    <c:if test="${not empty param.statusFilter}">
                                                        <c:param name="statusFilter" value="${param.statusFilter}" />
                                                    </c:if>
                                                </c:url>
                                                <a href="${sortDateAscUrl}">&#9650;</a>

                                                <c:url var="sortDateDescUrl" value="booking-list">
                                                    <c:param name="sortBy" value="dateDesc" />
                                                    <c:if test="${not empty param.statusFilter}">
                                                        <c:param name="statusFilter" value="${param.statusFilter}" />
                                                    </c:if>
                                                </c:url>
                                                <a href="${sortDateDescUrl}">&#9660;</a>
                                            </th>

                                            <th>Check-out</th>
                                            <th>Status Booking</th>
                                            <th>
                                                Total
                                                <c:url var="sortPriceAscUrl" value="booking-list">
                                                    <c:param name="sortBy" value="priceAsc" />
                                                    <c:if test="${not empty param.statusFilter}">
                                                        <c:param name="statusFilter" value="${param.statusFilter}" />
                                                    </c:if>
                                                </c:url>
                                                <a href="${sortPriceAscUrl}">&#9650;</a>

                                                <c:url var="sortPriceDescUrl" value="booking-list">
                                                    <c:param name="sortBy" value="priceDesc" />
                                                    <c:if test="${not empty param.statusFilter}">
                                                        <c:param name="statusFilter" value="${param.statusFilter}" />
                                                    </c:if>
                                                </c:url>
                                                <a href="${sortPriceDescUrl}">&#9660;</a>
                                            </th>

                                            <th>Detail</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <c:forEach var="b" items="${bookings}">
                                            <tr>
                                                <td>${b.checkInDate}</td>
                                                <td>${b.checkOutDate}</td>
                                                <td>
                                                    <span class="badge
                                                        <c:choose>
                                                            <c:when test="${b.status == 'completed'}">bg-success</c:when>
                                                            <c:when test="${b.status == 'pending'}">bg-secondary</c:when>
                                                            <c:when test="${b.status == 'cancelled'}">bg-danger</c:when>
                                                            <c:otherwise>bg-info</c:otherwise>
                                                        </c:choose>">
                                                        ${b.status}
                                                    </span>
                                                </td>
                                                <td>${b.grandTotal}</td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-outline-primary"
                                                            data-bs-toggle="modal" data-bs-target="#bookingModal${b.bookingId}">
                                                        View Details
                                                    </button>
                                                </td>
                                                <td>
                                                    <c:if test="${b.status == 'pending' || b.status == 'balance_due'}">
                                                        <form action="${pageContext.request.contextPath}/payment" method="post" style="display:inline;">
                                                            <input type="hidden" name="bookingId" value="${b.bookingId}">
                                                            <input type="hidden" name="grandTotal" value="${b.grandTotal}">
                                                            <input type="hidden" name="orderInfo" value="Payment for booking #${b.bookingId}">
                                                            <button type="submit" class="btn btn-sm btn-warning">Pay Now</button>
                                                        </form>
                                                        <form action="${pageContext.request.contextPath}/booking-list" method="post" style="display:inline;">
                                                            <input type="hidden" name="bookingId" value="${b.bookingId}">
                                                            <input type="hidden" name="action" value="delete">
                                                            <button type="submit" class="btn btn-sm btn-danger"
                                                                    onclick="return confirm('Are you sure you want to cancel this booking?')">
                                                                Cancel
                                                            </button>
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

    <!-- Modal for each booking -->
    <c:forEach var="b" items="${bookings}">
        <div class="modal fade" id="bookingModal${b.bookingId}" tabindex="-1" aria-labelledby="bookingModalLabel${b.bookingId}" aria-hidden="true">
            <div class="modal-dialog modal-xl modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-warning text-dark">
                        <h5 class="modal-title" id="bookingModalLabel${b.bookingId}">Booking's Details</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="table-responsive">
                            <table class="table table-bordered text-center align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>Room Number</th>
                                        <th>Check-in</th>
                                        <th>Check-out</th>
                                        <th>Nights</th>
                                        <th>Guests</th>
                                        <th>Rate per Night</th>
                                        <th>Total</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="r" items="${not empty roomsMap[b.bookingId] ? roomsMap[b.bookingId] : emptyList}">
                                        <tr>
                                            <td>${r.roomNumber}</td>
                                            <td>${r.checkInDate}</td>
                                            <td>${r.checkOutDate}</td>
                                            <td>${r.nights}</td>
                                            <td>${r.guestsCount}</td>
                                            <td>${r.ratePerNight}</td>
                                            <td>${r.lineTotal}</td>
                                            <td>
                                                <span class="badge
                                                    <c:choose>
                                                        <c:when test="${r.status == 'reserved'}">bg-secondary</c:when>
                                                        <c:when test="${r.status == 'checked_in'}">bg-info</c:when>
                                                        <c:when test="${r.status == 'checked_out'}">bg-success</c:when>
                                                        <c:when test="${r.status == 'cancelled'}">bg-danger</c:when>
                                                        <c:otherwise>bg-light text-dark</c:otherwise>
                                                    </c:choose>">
                                                    ${r.status}
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
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
