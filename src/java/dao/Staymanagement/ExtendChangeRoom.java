/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.Staymanagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.StayRoom;
import utils.DBConnection;

/**
 *
 * @author Admin
 */
public class ExtendChangeRoom {

    public boolean extendRoom(int roomId, String time) {
        String sql = "UPDATE Booking_Rooms SET check_out_date = ? WHERE room_id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, java.sql.Date.valueOf(time));
            ps.setInt(2, roomId);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            System.out.println("Error when extending room: " + e.getMessage());
            return false;
        }
    }

    public boolean changeRoom(int roomId, int roomIdToChange) {
        String sql = "UPDATE Booking_Rooms SET room_id = ? WHERE room_id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roomIdToChange);
            ps.setInt(2, roomId);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            System.out.println("Error when extending room: " + e.getMessage());
            return false;
        }
    }

    public List<Integer> getRoom(String status) {
        List<Integer> list = new ArrayList<>();

        String sql = "SELECT room_id \n"
                + "FROM Rooms\n"
                + "WHERE room_status = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getInt("room_id"));

                }
            }
        } catch (SQLException e) {
            System.out.println("Error when fetching room list: " + e.getMessage());
        }
        return list;
    }
}
