package model;

import java.util.Date;

public class Customer {
    private int customerId;
    private int bookingCount;
    private boolean discountEligible;
    private Date createdAt;
    private Date updatedAt;

    // Constructor
    public Customer(int customerId, int bookingCount, boolean discountEligible, Date createdAt, Date updatedAt) {
        this.customerId = customerId;
        this.bookingCount = bookingCount;
        this.discountEligible = discountEligible;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getBookingCount() {
        return bookingCount;
    }

    public void setBookingCount(int bookingCount) {
        this.bookingCount = bookingCount;
    }

    public boolean isDiscountEligible() {
        return discountEligible;
    }

    public void setDiscountEligible(boolean discountEligible) {
        this.discountEligible = discountEligible;
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
