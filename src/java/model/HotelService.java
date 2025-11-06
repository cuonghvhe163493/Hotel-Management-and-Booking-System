/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author Legion
 */
public class HotelService {
    private int serviceId;
    private String serviceName;
    private String description;
    private boolean isIncluded;
    private double price;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String serviceType;

    public HotelService() {
    }

    public HotelService(int serviceId, String serviceName, String description, boolean isIncluded, double price, LocalDateTime createdAt, LocalDateTime updatedAt, String serviceType) {
        this.serviceId = serviceId;
        this.serviceName = serviceName;
        this.description = description;
        this.isIncluded = isIncluded;
        this.price = price;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.serviceType = serviceType;
    }

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

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getServiceType() {
        return serviceType;
    }

    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }
    
    
    
    

}
