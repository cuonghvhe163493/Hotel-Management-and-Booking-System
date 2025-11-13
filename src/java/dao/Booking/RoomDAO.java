package dao.Booking;

import model.Room;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class RoomDAO {

    private Connection conn;

    // Constructor nhận Connection từ DBConnection
    public RoomDAO(Connection conn) {
        this.conn = conn;
    }

    // Lấy danh sách tất cả phòng
    public List<Room> getAllRooms() {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM Rooms";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Room room = mapResultSetToRoom(rs);
                rooms.add(room);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rooms;
    }

    // Lấy phòng theo ID
    public Room getRoomById(int roomId) {
        String sql = "SELECT * FROM Rooms WHERE room_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRoom(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Map ResultSet -> Room
    private Room mapResultSetToRoom(ResultSet rs) throws SQLException {
        Room room = new Room();
        room.setRoomId(rs.getInt("room_id"));
        room.setRoomNumber(rs.getString("room_number"));
        room.setRoomStatus(rs.getString("room_status"));
        room.setRoomType(rs.getString("room_type"));
        room.setCapacity(rs.getInt("capacity"));
        room.setPricePerNight(rs.getDouble("price_per_night")); // sửa đây

        Timestamp created = rs.getTimestamp("created_at");
        room.setCreatedAt(created != null ? new Date(created.getTime()) : null); // sửa đây

        Timestamp updated = rs.getTimestamp("updated_at");
        room.setUpdatedAt(updated != null ? new Date(updated.getTime()) : null); // sửa đây

        return room;
    }

    public List<Room> getSimilarRooms(int roomId) {
        List<Room> similarRooms = new ArrayList<>();
        Room currentRoom = getRoomById(roomId);
        if (currentRoom == null) {
            return similarRooms;
        }

        try {
            // 1. Lấy phòng cùng type + cùng capacity
            String sql = "SELECT TOP 3 * FROM Rooms WHERE room_status='available' AND room_id<>? AND room_type=? AND capacity=? ORDER BY NEWID()";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, roomId);
                ps.setString(2, currentRoom.getRoomType());
                ps.setInt(3, currentRoom.getCapacity());
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        similarRooms.add(mapResultSetToRoom(rs));
                    }
                }
            }

            // 2. Nếu chưa đủ 3, lấy thêm phòng cùng type
            if (similarRooms.size() < 3) {
                sql = "SELECT TOP ? * FROM Rooms WHERE room_status='available' AND room_id<>? AND room_type=? ORDER BY NEWID()";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, 3 - similarRooms.size());
                    ps.setInt(2, roomId);
                    ps.setString(3, currentRoom.getRoomType());
                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            Room r = mapResultSetToRoom(rs);
                            boolean exists = similarRooms.stream().anyMatch(x -> x.getRoomId() == r.getRoomId());
                            if (!exists) {
                                similarRooms.add(r);
                            }
                        }
                    }
                }
            }

            // 3. Nếu chưa đủ 3, lấy thêm phòng cùng capacity
            if (similarRooms.size() < 3) {
                sql = "SELECT TOP ? * FROM Rooms WHERE room_status='available' AND room_id<>? AND capacity=? ORDER BY NEWID()";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, 3 - similarRooms.size());
                    ps.setInt(2, roomId);
                    ps.setInt(3, currentRoom.getCapacity());
                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            Room r = mapResultSetToRoom(rs);
                            boolean exists = similarRooms.stream().anyMatch(x -> x.getRoomId() == r.getRoomId());
                            if (!exists) {
                                similarRooms.add(r);
                            }
                        }
                    }
                }
            }

            // 4. Nếu vẫn chưa đủ, lấy thêm phòng bất kỳ
            if (similarRooms.size() < 3) {
                sql = "SELECT TOP ? * FROM Rooms WHERE room_status='available' AND room_id<>? ORDER BY NEWID()";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, 3 - similarRooms.size());
                    ps.setInt(2, roomId);
                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            Room r = mapResultSetToRoom(rs);
                            boolean exists = similarRooms.stream().anyMatch(x -> x.getRoomId() == r.getRoomId());
                            if (!exists) {
                                similarRooms.add(r);
                            }
                        }
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return similarRooms;
    }

    private String getImageNameForType(String roomType) {
        switch (roomType) {
            case "Single":
                return "single_room.jpg";
            case "Double":
                return "double_room.jpg";
            case "Suite":
                return "suite_room.jpg";
            case "Family":
                return "family_room.jpg";
            case "Deluxe":
                return "deluxe_room.jpg";
            default:
                return "default_room.jpg";
        }
    }

    public boolean isRoomBooked(int roomId, java.util.Date checkIn, java.util.Date checkOut) throws SQLException {
        String sql = "SELECT 1 FROM Booking_Rooms WHERE room_id = ? AND status IN ('reserved','checked_in') "
                + "AND NOT (check_out_date <= ? OR check_in_date >= ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ps.setDate(2, new java.sql.Date(checkIn.getTime()));
            ps.setDate(3, new java.sql.Date(checkOut.getTime()));
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public void updateRoomStatus(int roomId, String status) throws SQLException {
        // Chỉ dùng 'available', 'reserved', 'occupied', 'maintenance'
        String sql = "UPDATE Rooms SET room_status = ? WHERE room_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, roomId);
            ps.executeUpdate();
        }
    }
}
