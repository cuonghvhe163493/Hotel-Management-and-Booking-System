package model;

import java.util.Date;

public class BookingRoom {

    private int bookingRoomId;
    private int bookingId;
    private int roomId;
    private String roomNumber;
    private Date checkInDate;
    private Date checkOutDate;
    private int nights;
    private int guestsCount;
    private double ratePerNight;
    private double lineTotal;
    private String status;

    public BookingRoom() {
    }

    public BookingRoom(int bookingRoomId, int bookingId, int roomId, String roomNumber,
            Date checkInDate, Date checkOutDate, int nights,
            int guestsCount, double ratePerNight, double lineTotal, String status) {
        this.bookingRoomId = bookingRoomId;
        this.bookingId = bookingId;
        this.roomId = roomId;
        this.roomNumber = roomNumber;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.nights = nights;
        this.guestsCount = guestsCount;
        this.ratePerNight = ratePerNight;
        this.lineTotal = lineTotal;
        this.status = status;
    }

    public int getBookingRoomId() {
        return bookingRoomId;
    }

    public void setBookingRoomId(int bookingRoomId) {
        this.bookingRoomId = bookingRoomId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
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

    public int getGuestsCount() {
        return guestsCount;
    }

    public void setGuestsCount(int guestsCount) {
        this.guestsCount = guestsCount;
    }

    public double getRatePerNight() {
        return ratePerNight;
    }

    public void setRatePerNight(double ratePerNight) {
        this.ratePerNight = ratePerNight;
    }

    public double getLineTotal() {
        return lineTotal;
    }

    public void setLineTotal(double lineTotal) {
        this.lineTotal = lineTotal;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public int getNights() {
        return nights;
    }

    public void setNights(int nights) {
        this.nights = nights;
    }
}
