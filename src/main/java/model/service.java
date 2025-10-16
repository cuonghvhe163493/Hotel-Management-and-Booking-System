package model;

public class Service {
    private int serviceId;
    private String serviceName;
    private String description;
    private boolean included;
    private BigDecimal price;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Serivce() {
    }

    public Serivce(int serviceId, String serviceName, String description, boolean included, BigDecimal price, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.serviceId = serviceId;
        this.serviceName = serviceName;
        this.description = description;
        this.included = included;
        this.price = price;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    public int getServiceId() { return serviceId; }
    public void setServiceId(int serviceId) { this.serviceId = serviceId; }

    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public boolean isIncluded() { return included; }
    public void setIncluded(boolean included) { this.included = included; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}