package dao.Authentication;

import java.sql.*;
import model.User;
import utils.DBConnection;

public class UserDAO {

    // 🔹 Login thường: username + password
    public static User getUserByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM dbo.Users WHERE LOWER(username)=LOWER(?) AND password=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            if (conn == null) {
                System.out.println("❌ Không thể kết nối tới Database.");
                return null;
            }

            stmt.setString(1, username.trim());
            stmt.setString(2, password.trim());

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getString("role"));
                u.setAccountStatus(rs.getString("account_status"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setDateOfBirth(rs.getDate("date_of_birth"));

                System.out.println("✅ Login OK: " + u.getUsername() + " | role=" + u.getRole());
                return u;
            } else {
                System.out.println("⚠️ Không tìm thấy user trong database.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 🔹 Lấy user bằng email (Google login)
    public static User getUserByEmail(String email) {
        String query = "SELECT * FROM dbo.Users WHERE LOWER(email)=LOWER(?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email.trim());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setAccountStatus(rs.getString("account_status"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setDateOfBirth(rs.getDate("date_of_birth"));

                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 🔹 Đăng ký user mới (dùng cho cả form register và login Google lần đầu)
    public static boolean registerUser(String username, String password, String email) {
        String sql = "INSERT INTO dbo.Users (username, password, email, role, account_status, created_at, updated_at) "
                + "VALUES (?, ?, ?, 'customer', 'active', GETDATE(), GETDATE())";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            if (conn == null) {
                System.out.println("❌ Không thể kết nối Database khi đăng ký.");
                return false;
            }

            stmt.setString(1, username.trim());
            stmt.setString(2, password.trim());
            stmt.setString(3, email.trim());

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                System.out.println("✅ Đã đăng ký mới user: " + email);
                return true;
            }
        } catch (SQLException e) {
            if (e.getMessage().contains("UNIQUE")) {
                System.out.println("⚠️ Username hoặc Email đã tồn tại: " + email);
            } else {
                System.out.println("❌ Lỗi khi thêm user: " + e.getMessage());
            }
        }
        return false;
    }

    // 🔹 Kiểm tra username đã tồn tại chưa
    public static boolean isUsernameExists(String username) {
        String sql = "SELECT user_id FROM dbo.Users WHERE LOWER(username)=LOWER(?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username.trim());
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("❌ Lỗi khi kiểm tra username: " + e.getMessage());
        }
        return false;
    }

    // 🔹 Kiểm tra email đã tồn tại chưa
    public static boolean isEmailExists(String email) {
        String sql = "SELECT user_id FROM dbo.Users WHERE LOWER(email)=LOWER(?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email.trim());
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("❌ Lỗi khi kiểm tra email: " + e.getMessage());
        }
        return false;
    }

    public static boolean registerUserFull(String username, String password, String email, String phone, String address, String dob) {
        String sql = "INSERT INTO dbo.Users (username, password, email, phone, address, date_of_birth, role, account_status, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, 'customer', 'active', GETDATE(), GETDATE())";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username.trim());
            stmt.setString(2, password.trim());
            stmt.setString(3, email.trim());
            stmt.setString(4, phone.trim());
            stmt.setString(5, address.trim());
            stmt.setString(6, dob);

            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("❌ Lỗi khi đăng ký đầy đủ: " + e.getMessage());
        }
        return false;
    }

    public static boolean resetPassword(String username, String newPassword) {
        String sql = "UPDATE Users SET password = ?, updated_at = GETDATE() WHERE username = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newPassword.trim());
            stmt.setString(2, username.trim());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("❌ Lỗi khi cập nhật mật khẩu: " + e.getMessage());
        }
        return false;
    }

    public static boolean checkUserCredentials(String username, String email, String phone) {
        String sql = "SELECT user_id FROM dbo.Users WHERE LOWER(username) = LOWER(?) AND LOWER(email) = LOWER(?) AND phone = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username.trim());
            stmt.setString(2, email.trim());
            stmt.setString(3, phone.trim());

            ResultSet rs = stmt.executeQuery();
            return rs.next(); // Trả về true nếu tìm thấy 1 user khớp 3 trường
        } catch (SQLException e) {
            System.out.println("❌ Lỗi khi kiểm tra thông tin xác thực: " + e.getMessage());
        }
        return false;
    }

// 🟢 PHƯƠNG THỨC MỚI: Cập nhật mật khẩu bằng Username (Bước 2 - Final)
    public static boolean updatePassword(String username, String newPassword) {
        String sql = "UPDATE dbo.Users SET password = ?, updated_at = GETDATE() WHERE LOWER(username) = LOWER(?)";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newPassword.trim());
            stmt.setString(2, username.trim());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("❌ Lỗi khi cập nhật mật khẩu cuối cùng: " + e.getMessage());
        }
        return false;
    }

    public static boolean updateUserProfile(String username, String email, String phone, String address, String password) {
        String sql = "UPDATE dbo.Users "
                + "SET email = ?, phone = ?, address = ?, password = ?, updated_at = GETDATE() "
                + "WHERE username = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setString(4, password);
            ps.setString(5, username);

            int rows = ps.executeUpdate();
            System.out.println("[UpdateProfile] rows=" + rows + " for user=" + username);
            return rows > 0;

        } catch (SQLException e) {
            System.out.println("❌ Error updating profile: " + e.getMessage());
            return false;
        }
    }

    public boolean hasActiveBooking(int customerId) {
        String sql = "SELECT COUNT(*) \n"
                + "            FROM Bookings b\n"
                + "            JOIN Booking_Rooms br ON b.booking_id = br.booking_id\n"
                + "            WHERE \n"
                + "                b.customer_id = ? \n"
                + "                AND b.status IN ('Confirmed')\n"
                + "                AND CAST(GETDATE() AS DATE) BETWEEN br.check_in_date AND br.check_out_date";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt  = conn.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0;
                }
            }

        } catch (SQLException e) {
            System.out.println("❌ Error Has Active Booking: " + e.getMessage());
            
        }
        return false;
    }

}
