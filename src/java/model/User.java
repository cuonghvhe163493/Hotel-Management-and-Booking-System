package model;

import java.util.Date;

public class User {
    private int userId;
    private String username;
    private String password;
    private String email;
    private String role;
    private String profileData;
    private Date createdAt;
    private Date updatedAt;
    private String accountStatus;

    // 🟢 3 trường mới thêm
    private String phone;
    private String address;
    private Date dateOfBirth;

    // ==== Constructors ====

    public User() {
    }

    public User(int userId, String username, String password, String email, String role,
                String profileData, Date createdAt, Date updatedAt, String accountStatus,
                String phone, String address, Date dateOfBirth) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.email = email;
        this.role = role;
        this.profileData = profileData;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.accountStatus = accountStatus;
        this.phone = phone;
        this.address = address;
        this.dateOfBirth = dateOfBirth;
    }

    // ==== Getters & Setters ====

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getProfileData() { return profileData; }
    public void setProfileData(String profileData) { this.profileData = profileData; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    public String getAccountStatus() { return accountStatus; }
    public void setAccountStatus(String accountStatus) { this.accountStatus = accountStatus; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public Date getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(Date dateOfBirth) { this.dateOfBirth = dateOfBirth; }
}
