package model;

import java.util.Date; // Sử dụng java.util.Date

public class Service {
    private int serviceId;
    private String serviceName;
    private String description;
    private boolean isIncluded; // Ánh xạ tới cột BIT/Boolean trong DB
    private double price;
    private Date createdAt;
    private Date updatedAt;
    
    // Lưu ý: Trường serviceType đã được loại bỏ để khớp với DDL của bạn

    public Service() {
    }

    // Constructor đầy đủ tham số
    public Service(int serviceId, String serviceName, String description, boolean isIncluded, double price, Date createdAt, Date updatedAt) {
        this.serviceId = serviceId;
        this.serviceName = serviceName;
        this.description = description;
        this.isIncluded = isIncluded;
        this.price = price;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // ==== Getters & Setters ====

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isIsIncluded() {
        return isIncluded;
    }

    public void setIsIncluded(boolean isIncluded) {
        this.isIncluded = isIncluded;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
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
}