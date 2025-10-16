package model;

public class extraService {
   private int extraServiceId;
    private int reservationId;
    private String serviceName;
    private String serviceDescription;
    private BigDecimal servicePrice;
    private LocalDateTime serviceStartTime;
    private LocalDateTime serviceEndTime;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public extraSerivce() {
        }

        public extraSerivce(int extraServiceId, int reservationId, String serviceName, String serviceDescription, BigDecimal servicePrice, LocalDateTime serviceStartTime, LocalDateTime serviceEndTime, String status, LocalDateTime createdAt, LocalDateTime updatedAt) {
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
        public int getExtraServiceId() {
                return extraServiceId;
            }

            public void setExtraServiceId(int extraServiceId) {
                this.extraServiceId = extraServiceId;
            }

            public int getReservationId() {
                return reservationId;
            }

            public void setReservationId(int reservationId) {
                this.reservationId = reservationId;
            }

            public String getServiceName() {
                return serviceName;
            }

            public void setServiceName(String serviceName) {
                this.serviceName = serviceName;
            }

            public String getServiceDescription() {
                return serviceDescription;
            }

            public void setServiceDescription(String serviceDescription) {
                this.serviceDescription = serviceDescription;
            }

            public BigDecimal getServicePrice() {
                return servicePrice;
            }

            public void setServicePrice(BigDecimal servicePrice) {
                this.servicePrice = servicePrice;
            }

            public LocalDateTime getServiceStartTime() {
                return serviceStartTime;
            }

            public void setServiceStartTime(LocalDateTime serviceStartTime) {
                this.serviceStartTime = serviceStartTime;
            }

            public LocalDateTime getServiceEndTime() {
                return serviceEndTime;
            }

            public void setServiceEndTime(LocalDateTime serviceEndTime) {
                this.serviceEndTime = serviceEndTime;
            }

            public String getStatus() {
                return status;
            }

            public void setStatus(String status) {
                this.status = status;
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

}