/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.OffsetDateTime;

/**
 *
 * @author admin
 */
public class Service {
    private long serviceId;
    private String code;
    private String name;
    private String description;
    private String unit;
    private String taxClass;
    private boolean active;
    private OffsetDateTime createdAt;

    public Service() {
    }

    public Service(long serviceId, String code, String name, String description, String unit, String taxClass, boolean active, OffsetDateTime createdAt) {
        this.serviceId = serviceId;
        this.code = code;
        this.name = name;
        this.description = description;
        this.unit = unit;
        this.taxClass = taxClass;
        this.active = active;
        this.createdAt = createdAt;
    }

    public long getServiceId() {
        return serviceId;
    }

    public void setServiceId(long serviceId) {
        this.serviceId = serviceId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getTaxClass() {
        return taxClass;
    }

    public void setTaxClass(String taxClass) {
        this.taxClass = taxClass;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public OffsetDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(OffsetDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    
}
