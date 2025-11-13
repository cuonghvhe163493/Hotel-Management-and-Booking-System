package model;

import java.util.Date;

public class Room {
    private int roomId;
    private String roomNumber;
    private String roomStatus;
    private String roomType;
    private int capacity;
    private double pricePerNight;   // chuyển từ BigDecimal sang double
    private Date createdAt;         // chuyển từ LocalDateTime sang Date
    private Date updatedAt;         // chuyển từ LocalDateTime sang Date

    // Constructor không tham số
    public Room() {
    }

    // Constructor có tham số
    public Room(int roomId, String roomNumber, String roomStatus, String roomType,
                int capacity, double pricePerNight, Date createdAt, Date updatedAt) {
        this.roomId = roomId;
        this.roomNumber = roomNumber;
        this.roomStatus = roomStatus;
        this.roomType = roomType;
        this.capacity = capacity;
        this.pricePerNight = pricePerNight;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters và Setters
    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getRoomStatus() {
        return roomStatus;
    }

    public void setRoomStatus(String roomStatus) {
        this.roomStatus = roomStatus;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public double getPricePerNight() {
        return pricePerNight;
    }

    public void setPricePerNight(double pricePerNight) {
        this.pricePerNight = pricePerNight;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Room{" +
                "roomId=" + roomId +
                ", roomNumber='" + roomNumber + '\'' +
                ", roomStatus='" + roomStatus + '\'' +
                ", roomType='" + roomType + '\'' +
                ", capacity=" + capacity +
                ", pricePerNight=" + pricePerNight +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
