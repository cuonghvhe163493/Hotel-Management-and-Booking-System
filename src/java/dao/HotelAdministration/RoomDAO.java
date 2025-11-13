package dao.HotelAdministration;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Room; 
import utils.DBConnection;

public class RoomDAO {

 
    private Room extractRoomFromResultSet(ResultSet rs) throws SQLException {
        Room room = new Room(
            rs.getInt("room_id"),
            rs.getString("room_number"),
            rs.getString("room_status"),
            rs.getString("room_type"),
            rs.getInt("capacity"),
            rs.getDouble("price_per_night"),
            rs.getTimestamp("created_at"), 
            rs.getTimestamp("updated_at")
        );
        return room;
    }

    //  1. Lấy tất cả các phòng (giữ nguyên)
    public List<Room> getAllRooms() {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM dbo.Rooms ORDER BY room_number ASC";
        // ... (Logic đã có)
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                rooms.add(extractRoomFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in getAllRooms: " + e.getMessage());
        }
        return rooms;
    }
    
    //  2. Lấy phòng theo ID 
    public Room getRoomById(int roomId) {
        Room room = null;
        String sql = "SELECT * FROM dbo.Rooms WHERE room_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    room = extractRoomFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in getRoomById: " + e.getMessage());
        }
        return room;
    }

    //  3. Thêm phòng mới
    public boolean createRoom(String roomNumber, String roomType, double pricePerNight, int capacity) {
        String sql = "INSERT INTO dbo.Rooms (room_number, room_status, room_type, capacity, price_per_night, created_at, updated_at) "
                   + "VALUES (?, 'available', ?, ?, ?, GETDATE(), GETDATE())";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
          
            ps.setString(1, roomNumber);
            ps.setString(2, roomType); 
            ps.setInt(3, capacity);
            ps.setDouble(4, pricePerNight);

            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in createRoom: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    //  Cập nhật phòng (UPDATE)
    // fields: RoomNumber, Price, Status, RoomType, Room Description
    public boolean updateRoom(int roomId, String roomNumber, String roomType, int capacity, double pricePerNight, String roomStatus) {
        String sql = "UPDATE dbo.Rooms SET room_number=?, room_type=?, capacity=?, price_per_night=?, room_status=?, updated_at=GETDATE() WHERE room_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, roomNumber);
            ps.setString(2, roomType); 
            ps.setInt(3, capacity);
            ps.setDouble(4, pricePerNight);
            ps.setString(5, roomStatus);
            ps.setInt(6, roomId);

            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in updateRoom: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // . Xóa phòng 
    public boolean deleteRoom(int roomId) {
        String sql = "DELETE FROM dbo.Rooms WHERE room_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, roomId);
            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                return true;
            } else {
                // Trường hợp không tìm thấy ID để xóa
                return false;
            }
        } catch (SQLException e) {
            System.err.println(" SQL Error in deleteRoom: " + e.getMessage());
            e.printStackTrace();
            
            // Xử lý lỗi Khóa Ngoại
            // Kiểm tra mã lỗi SQL Server cho lỗi khóa ngoại (thường là 547)
            if (e.getErrorCode() == 547 || e.getMessage().contains("REFERENCE constraint")) { 
                throw new RuntimeException("FK_VIOLATION"); // Ném một ngoại lệ đặc biệt để Controller bắt
            }
            return false;
        }
    }
}