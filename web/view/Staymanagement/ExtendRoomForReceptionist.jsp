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
        <link href="${pageContext.request.contextPath}/view/Staymanagement/css/bootstrap.min.css" rel="stylesheet" >
        <link href="${pageContext.request.contextPath}/view/Staymanagement/css/font-awesome.min.css" rel="stylesheet" >
        <link href="${pageContext.request.contextPath}/view/Staymanagement/css/global.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/view/Staymanagement/css/stay.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@500&display=swap" rel="stylesheet">
        <script src="js/bootstrap.bundle.min.js"></script>
        
    </head>
    <body>
        <jsp:include page="/view/common/header.jsp" />
        <h3 class="word_3">Extend Room</h3>
        <div>
            
            <div>
                <p>Thông báo</p>
            </div>           
            <div>
                <form action="${pageContext.request.contextPath}/ExtendServlet" method="post">
                    <h3>Extend</h3>
                    <p>Room Id:<input type="text" name="roomId" value="" />
                    <p>Time to extend:<input type="date" name="time" value="" />
                    <input type="submit" value="Submit" />
                    ${mess}
                </form>
            </div>

        </div>

    </body>
</html>
