/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 *
 * @author admin
 */
public class ExtraService {
    private int extraServiceId;            // ID tự tăng
    private int reservationId;             // Mã đặt phòng (FK)
    private String serviceName;            // Tên dịch vụ
    private String serviceDescription;     // Mô tả dịch vụ
    private BigDecimal servicePrice;       // Giá dịch vụ
    private LocalDateTime serviceStartTime;// Thời gian bắt đầu sử dụng
    private LocalDateTime serviceEndTime;  // Thời gian kết thúc
    private String status;                 // pending / in_progress / completed / cancelled
    private LocalDateTime createdAt;       // Ngày tạo
    private LocalDateTime updatedAt;       // Ngày cập nhật

    // ====== Constructors ======
    public ExtraService() {}

    public ExtraService(int extraServiceId, int reservationId, String serviceName,
                        String serviceDescription, BigDecimal servicePrice,
                        LocalDateTime serviceStartTime, LocalDateTime serviceEndTime,
                        String status, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.extraServiceId = extraServiceId;
        this.reservationId = reservationId;
        this.serviceName = serviceName;
        this.serviceDescription = serviceDescription;
        this.servicePrice = servicePrice;
        this.serviceStartTime = serviceStartTime;
        this.serviceEndTime = serviceEndTime;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // ====== Getters & Setters ======
    public int getExtraServiceId() { return extraServiceId; }
    public void setExtraServiceId(int extraServiceId) { this.extraServiceId = extraServiceId; }

    public int getReservationId() { return reservationId; }
    public void setReservationId(int reservationId) { this.reservationId = reservationId; }

    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }

    public String getServiceDescription() { return serviceDescription; }
    public void setServiceDescription(String serviceDescription) { this.serviceDescription = serviceDescription; }

    public BigDecimal getServicePrice() { return servicePrice; }
    public void setServicePrice(BigDecimal servicePrice) { this.servicePrice = servicePrice; }

    public LocalDateTime getServiceStartTime() { return serviceStartTime; }
    public void setServiceStartTime(LocalDateTime serviceStartTime) { this.serviceStartTime = serviceStartTime; }

    public LocalDateTime getServiceEndTime() { return serviceEndTime; }
    public void setServiceEndTime(LocalDateTime serviceEndTime) { this.serviceEndTime = serviceEndTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    @Override
    public String toString() {
        return "ExtraService{" +
                "extraServiceId=" + extraServiceId +
                ", reservationId=" + reservationId +
                ", serviceName='" + serviceName + '\'' +
                ", servicePrice=" + servicePrice +
                ", status='" + status + '\'' +
                ", serviceStartTime=" + serviceStartTime +
                ", serviceEndTime=" + serviceEndTime +
                '}';
    }
}
