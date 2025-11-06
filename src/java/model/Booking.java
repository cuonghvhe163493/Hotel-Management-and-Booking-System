package model;

import java.util.Date;

public class Booking {
    private int bookingId;
    private int customerId;
    private String status;
    private Date checkInDate;
    private Date checkOutDate;
    private Date holdUntil;
    private String note;
    private double subtotal;
    private double discountTotal;
    private double grandTotal;
    private double paidTotal;
    private Date createdAt;
    private Date updatedAt;

    // Constructor
    public Booking(int bookingId, int customerId, String status, Date checkInDate, Date checkOutDate, Date holdUntil,
                   String note, double subtotal, double discountTotal, double grandTotal, double paidTotal,
                   Date createdAt, Date updatedAt) {
        this.bookingId = bookingId;
        this.customerId = customerId;
        this.status = status;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.holdUntil = holdUntil;
        this.note = note;
        this.subtotal = subtotal;
        this.discountTotal = discountTotal;
        this.grandTotal = grandTotal;
        this.paidTotal = paidTotal;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Booking() {
        
    }

    // Getters and Setters
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(Date checkInDate) {
        this.checkInDate = checkInDate;
    }

    public Date getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(Date checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public Date getHoldUntil() {
        return holdUntil;
    }

    public void setHoldUntil(Date holdUntil) {
        this.holdUntil = holdUntil;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public double getDiscountTotal() {
        return discountTotal;
    }

    public void setDiscountTotal(double discountTotal) {
        this.discountTotal = discountTotal;
    }

    public double getGrandTotal() {
        return grandTotal;
    }

    public void setGrandTotal(double grandTotal) {
        this.grandTotal = grandTotal;
    }

    public double getPaidTotal() {
        return paidTotal;
    }

    public void setPaidTotal(double paidTotal) {
        this.paidTotal = paidTotal;
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
