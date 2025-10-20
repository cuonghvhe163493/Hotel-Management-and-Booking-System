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
        <title>Check In</title>
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
        <header>
            <h1>Check-in</h1>
        </header>
        <p>Booked</p>
        <select name="Booked">
            <option>Yes</option>
            <option>No</option>
        </select>
        <div class=""check-in-container>
            <p>ID Room: <input type="text" name="idroom" value="" placeholder="ID Room" />
            <p>Customer Name: <input type="text" name="name" value="" placeholder="Name" />

            <div>
                <p>Number of people: 
                <label for="numberInput"></label>
                <input type="text" id="numberInput" list="people" placeholder="Number of people">
                <datalist id="people">
                    <option value="1">
                    <option value="2">
                    <option value="3">
                    <option value="4">
                    <option value="5">
                    <option value="6">
                    <option value="7">
                    <option value="8">
                    <option value="9">
                    <option value="10">
                </datalist>
            </div>
            <p>Citizen ID: <input type="text" value="" placeholder="Citizen ID" />
            <p>Check-in Date: <input type="text"  value="" placeholder="Date" />    
            <p>Check-out Date: <input type="text"  value="" placeholder="Date" /> 
            <p>Gmail: <input type="text"  value="" placeholder="Gmail" />   
            <p>Phone: <input type="text"  value="" placeholder="Phone" /> 
            
            <p>Note</p>    
            <input type="text" name="Note" value="" />
            <input type="submit" class="send-btn" value="Submit" />
        </div>
        






    </body>
</html>