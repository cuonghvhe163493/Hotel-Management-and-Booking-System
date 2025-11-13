/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.Staymanagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.StayRoom;
import utils.DBConnection;

/**
 *
 * @author Admin
 */
public class ExtendChangeRoom {
    public boolean extendRoom(int roomId, String time) {
    String sql = "UPDATE Booking_Rooms SET check_out_date = ? WHERE room_id = ?";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setDate(1, java.sql.Date.valueOf(time)); 
        ps.setInt(2, roomId);

        int rowsUpdated = ps.executeUpdate();
        return rowsUpdated > 0; 

    } catch (SQLException e) {
        System.out.println("Error when extending room: " + e.getMessage());
        return false;
    }
}
}
