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

    // Thêm phòng mới
    public boolean addRoom(Room room) {
        String sql = "INSERT INTO Rooms(room_number, room_status, room_type, capacity, price_per_night, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, room.getRoomNumber());
            ps.setString(2, room.getRoomStatus());
            ps.setString(3, room.getRoomType());
            ps.setInt(4, room.getCapacity());
            ps.setBigDecimal(5, room.getPricePerNight());
            ps.setTimestamp(6, room.getCreatedAt() != null ? Timestamp.valueOf(room.getCreatedAt()) : null);
            ps.setTimestamp(7, room.getUpdatedAt() != null ? Timestamp.valueOf(room.getUpdatedAt()) : null);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật phòng
    public boolean updateRoom(Room room) {
        String sql = "UPDATE Rooms SET room_number=?, room_status=?, room_type=?, capacity=?, price_per_night=?, updated_at=? "
                + "WHERE room_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, room.getRoomNumber());
            ps.setString(2, room.getRoomStatus());
            ps.setString(3, room.getRoomType());
            ps.setInt(4, room.getCapacity());
            ps.setBigDecimal(5, room.getPricePerNight());
            ps.setTimestamp(6, room.getUpdatedAt() != null ? Timestamp.valueOf(room.getUpdatedAt()) : null);
            ps.setInt(7, room.getRoomId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa phòng theo ID
    public boolean deleteRoom(int roomId) {
        String sql = "DELETE FROM Rooms WHERE room_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Map ResultSet -> Room
    private Room mapResultSetToRoom(ResultSet rs) throws SQLException {
        Room room = new Room();
        room.setRoomId(rs.getInt("room_id"));
        room.setRoomNumber(rs.getString("room_number"));
        room.setRoomStatus(rs.getString("room_status"));
        room.setRoomType(rs.getString("room_type"));
        room.setCapacity(rs.getInt("capacity"));
        room.setPricePerNight(rs.getBigDecimal("price_per_night"));

        Timestamp created = rs.getTimestamp("created_at");
        room.setCreatedAt(created != null ? created.toLocalDateTime() : null);

        Timestamp updated = rs.getTimestamp("updated_at");
        room.setUpdatedAt(updated != null ? updated.toLocalDateTime() : null);

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

}
