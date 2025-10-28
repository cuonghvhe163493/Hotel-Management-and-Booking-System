/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author taqua
 */

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
        this.ratePerNight = room.getPricePerNight().doubleValue();

        long days = (checkOutDate.getTime() - checkInDate.getTime()) / (1000 * 60 * 60 * 24);
        this.lineTotal = ratePerNight * days;
    }

    public Room getRoom() { return room; }
    public Date getCheckInDate() { return checkInDate; }
    public Date getCheckOutDate() { return checkOutDate; }
    public int getGuestsCount() { return guestsCount; }
    public double getRatePerNight() { return ratePerNight; }
    public double getLineTotal() { return lineTotal; }
}

