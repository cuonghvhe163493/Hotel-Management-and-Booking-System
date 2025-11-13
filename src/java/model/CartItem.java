package model;

import java.util.Date;

public class CartItem {
    private Room room;
    private Date checkInDate;
    private Date checkOutDate;
    private int guestsCount;
    private double ratePerNight;
    private double lineTotal;

    public CartItem(Room room, Date checkInDate, Date checkOutDate, int guestsCount) {
        this.room = room;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.guestsCount = guestsCount;
        this.ratePerNight = room.getPricePerNight(); // đã là double

        long diffInMillis = checkOutDate.getTime() - checkInDate.getTime();
        long days = Math.max(diffInMillis / (1000 * 60 * 60 * 24), 1); // ít nhất 1 ngày
        this.lineTotal = ratePerNight * days;
    }

    // Getters
    public Room getRoom() { return room; }
    public Date getCheckInDate() { return checkInDate; }
    public Date getCheckOutDate() { return checkOutDate; }
    public int getGuestsCount() { return guestsCount; }
    public double getRatePerNight() { return ratePerNight; }
    public double getLineTotal() { return lineTotal; }
}
