<%-- 
    Document   : CheckOut
    Created on : Oct 19, 2025, 2:17:15 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check Out</title>
        <style>
            
            .send-btn {
                background-color: #3498db;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .send-btn:hover {
                background-color: #2980b9;
            }

        </style>
    </head>
    <body>
        <p>ID Room: <input type="text" name="idroom" value="" placeholder="ID Room" />
        <p>Customer Name: <input type="text" name="name" value="" placeholder="Name" />
        <p>Check-out Date: <input type="text"  value="" placeholder="Date" />    
        <p>Note</p>    
        <input type="text" name="Note" value="" />
        <input type="submit" class="send-btn" value="Submit" />
    </body>
</html>
