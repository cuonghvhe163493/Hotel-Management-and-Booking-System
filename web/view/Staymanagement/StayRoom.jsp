<%-- 
    Document   : newjsp
    Created on : Oct 18, 2025, 3:46:58 AM
    Author     : Hoang Viet Cuong
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Stay Room</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }
            body {
                background-color: #f0f2f5;
            }
            header {
                background-color: #2c3e50;
                color: white;
                text-align: center;
                padding: 1rem;
            }
            .stay-room-list-container {
                margin: 20px;
            }
            .stay-room-list-container h3 {
                margin-bottom: 10px;
            }
            .list-table {
                width: 100%;
                border-collapse: collapse;
                background-color: white;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }
            th {
                background-color: #34495e;
                color: white;
            }
            .func-chat-container {
                display: flex;
                gap: 20px;
                margin: 20px;
                flex-wrap: wrap;
            }           
            .func-container, .chat-container {
                flex: 1;
                min-width: 300px;
                padding: 20px;
                background-color: white;
                border: 1px solid #ddd;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
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
        <header>
            <h1>Stay Room Management</h1>
        </header>

        <div class="stay-room-list-container">
            <h3>Stay Room</h3>
            <table class="list-table">
                <thead>
                    <tr>
                        <th>Number Room</th>
                        <th>Status</th>
                        <th>Customer Name</th>
                        <th>Check-in Date</th>
                        <th>Check-out Date</th>
                        <th>Type</th>
                    </tr>
                </thead>
                <tbody >
                    <tr>
                        <td>123</td>
                        <td>Staying</td>
                        <td>Do Duc Anh</td>
                        <td>18/10/2025</td>
                        <td>20/10/2025</td>
                        <td>Type</td>
                    </tr>
                </tbody>
            </table>
        </div>


        <div class="func-chat-container">

            <div class="func-container">
                <h3>Stay Functions</h3>
                <ul>
                    <div>
                        <a href="ServicesRoom.jsp"><input type="button" value="SERVICES ROOM" /></a>
                    </div> 
                    <div>
                        <a href="CheckIn.jsp"><input type="button" value="CHECK-IN" /></a>
                    </div>
                    <div>
                        <a href="CheckOut.jsp"><input type="button" value="CHECK-OUT" /></a>
                    </div>
                    <div>
                        <a href="ChangeRoom.jsp"><input type="button" value="CHANGE ROOM" /></a>
                    </div>
                    <div>
                        <a href="ExtendRoom.jsp"><input type="button" value="EXTEND ROOM" /></a>
                    </div>
                </ul>

            </div>


            <div class="chat-container">
                <h2>Chat to Receptionist</h2>
                <div>
                    
                </div>
                <div >
                    <input type="text" placeholder="Enter message...">
                    <button class="send-btn">Send</button>
                </div>
            </div>
        </div>

    </body>
</html>