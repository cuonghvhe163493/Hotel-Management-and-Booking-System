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
        <title>Change Room</title>
        <style>
            .body-box{
                display: flex;
                justify-content: center; 
                align-items: center;     
                min-height: 100vh;       
                margin: 0;
                background-color: #f5f5f5;
            }
            .change-container {
                width: 350px;
                font-family: Arial, sans-serif;
                border: 1px solid #ddd;
                border-radius: 6px;
                overflow: hidden;
            }

            .change-header {
                background-color: #ff9800;
                color: white;
                padding: 10px 15px;
                font-weight: bold;
            }

            .change-body {
                background: #fafafa;
                padding: 18px;
            }

            .change-title {
                margin-top: 0;
                color: #ff9800;
            }

            .change-select {
                width: 100%;
                padding: 8px;
                margin: 6px 0 12px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .change-btn {
                padding: 8px 18px;
                border: none;
                background-color: #ff9800;
                color: white;
                border-radius: 5px;
                cursor: pointer;
            }

            .change-btn:hover {
                opacity: 0.9;
            }

        </style>

    </head>
    <body >
        <jsp:include page="/view/common/header.jsp" />
        <div class="body-box">
            

            <div class="change-container">
                <h3 class="word_3">Change Room</h3>
                <div class="change-header">
                    <p>Notification</p>
                </div>

                <div class="change-body">
                    <form action="${pageContext.request.contextPath}/ChangeRoom" method="post" class="change-form">
                        <h3 class="change-title">Change Room</h3>

                        <p>Current Room ID:
                            <select name="roomId" class="change-select">
                                <option value="">-- Select Current Room --</option>
                                <c:forEach var="r" items="${list_1}">
                                    <option value="${r}">${r}</option>
                                </c:forEach>
                            </select>
                        </p>

                        <p>Room ID to Change:
                            <select name="roomIdToChange" class="change-select">
                                <option value="">-- Select New Room --</option>
                                <c:forEach var="r" items="${list_2}">
                                    <option value="${r}">${r}</option>
                                </c:forEach>
                            </select>
                        </p>

                        <input type="submit" value="Submit" class="change-btn" />
                        ${mess}
                    </form>
                </div>

            </div>
        </div>        

    </body>
</html>
