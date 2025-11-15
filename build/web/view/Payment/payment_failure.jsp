<%-- 
    Document   : payment_failure.jsp
    Created on : Nov 3, 2025, 10:45:55 AM
    Author     : taqua
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Thanh toán thất bại</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f7f6;
                margin: 0;
                padding: 20px;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .container {
                background-color: #ffffff;
                padding: 2em;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                text-align: center;
                max-width: 500px;
                width: 100%;
            }
            .icon {
                font-size: 5em;
                color: #dc3545;
            }
            h2 {
                color: #dc3545;
                margin-top: 0.5em;
            }
            p {
                color: #555;
                line-height: 1.6;
            }
            .reason {
                margin-top: 1.5em;
                padding: 1em;
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
                color: #721c24;
                border-radius: 5px;
            }
            .actions {
                margin-top: 2em;
            }
            .action-button {
                display: inline-block;
                margin: 0.5em;
                padding: 0.8em 1.5em;
                background-color: #007bff;
                color: #ffffff;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s;
            }
            .action-button:hover {
                background-color: #0056b3;
            }
            .contact-support {
                background-color: #6c757d;
            }
            .contact-support:hover {
                background-color: #5a6268;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="icon">
                <i class="fas fa-times-circle"></i>
            </div>
            <h2>Payment Failed!</h2>
            <p>An error occurred during the payment process. Please try again or contact us for assistance.</p>

            <%
                String errorCode = request.getParameter("vnp_TransactionStatus");
                String message = "Unknown reason.";
                if (errorCode != null) {
                    switch (errorCode) {
                        case "02": message = "The transaction failed due to invalid card/account information."; break;
                        case "07": message = "Payment deducted, but the transaction is suspected of fraud."; break;
                        case "09": message = "Your card/account has not been registered for Internet Banking service."; break;
                        case "10": message = "Your card/account has been locked."; break;
                        case "11": message = "Incorrect OTP entered for transaction authentication."; break;
                        case "24": message = "Transaction cancelled by the customer."; break;
                        // Add more VNPay error codes here if needed
                    }
                }
            %>

            <div class="reason">
                <p><strong>Reason:</strong> <%= message %></p>
            </div>

            <div class="actions">
                <a href="${pageContext.request.contextPath}/booking-list" class="back-button">
                    Back to Bookings List
                </a>
                <a href="contact.jsp" class="action-button contact-support">Contact Support</a>
            </div>
        </div>
    </body>
</html>
