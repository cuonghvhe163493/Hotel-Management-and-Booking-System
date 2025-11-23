<%-- 
    Document   : ExtendRoom
    Created on : Oct 19, 2025, 3:04:53 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Extend Room</title>
        <style>
            .body-box{
                display: flex;
                justify-content: center; 
                align-items: center;     
                min-height: 100vh;       
                margin: 0;
                background-color: #f5f5f5;
            }
            .extend-container {
                width: 350px;
                font-family: Arial, sans-serif;
                border: 1px solid #ddd;
                border-radius: 6px;
                overflow: hidden;
            }

            .extend-header {
                background-color: #ff9800;
                color: white;
                padding: 10px 15px;
                font-weight: bold;
            }

            .extend-body {
                background: #fafafa;
                padding: 18px;
            }

            .extend-form h3 {
                margin-top: 0;
                color: #ff9800;
            }

            .extend-input {
                width: 100%;
                padding: 8px;
                margin: 6px 0 12px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .extend-btn {
                padding: 8px 18px;
                border: none;
                background-color: #ff9800;
                color: white;
                border-radius: 5px;
                cursor: pointer;
            }

            .extend-btn:hover {
                opacity: 0.9;
            }

        </style>

    </head>
    <body>
        <jsp:include page="/view/common/header.jsp" />
        <div class="body-box">
        
        <div class="extend-container">
            <h3 class="word_3">Extend Room</h3>
            <div class="extend-header">
                <p>Notification</p>
            </div>

            <div class="extend-body">
                <form action="${pageContext.request.contextPath}/ExtendServlet" method="post" class="extend-form">
                    <h3>Extend Room</h3>

                    <p>Room Id:
                        <input type="text" name="roomId" class="extend-input" />
                    </p>

                    <p>Time to extend:
                        <input type="date" name="time" class="extend-input" />
                    </p>

                    <input type="submit" value="Submit" class="extend-btn" />
                    ${mess}
                </form>
            </div>

        </div>
        </div>


    </body>
</html>
