package model;

import java.util.Date;

public class ServiceCartItems {

    private HotelService service;
    private Date checkInDate;
    private Date checkOutDate;
    private int guestsCount;

    public ServiceCartItems() {
    }

    public ServiceCartItems(HotelService service, Date checkInDate, Date checkoutDate, int guestsCount) {
        this.service = service;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkoutDate;
        this.guestsCount = guestsCount;
    }

    public HotelService getService() {
        return service;
    }

    public void setService(HotelService service) {
        this.service = service;
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

    public void setCheckOutDate(Date checkoutDate) {
        this.checkOutDate = checkoutDate;
    }

    public int getGuestsCount() {
        return guestsCount;
    }

    public void setGuestsCount(int guestsCount) {
        this.guestsCount = guestsCount;
    }

    @Override
    public String toString() {
        return "ServiceCartItems{" + "service=" + service + ", checkInDate=" + checkInDate + ", checkoutDate=" + checkOutDate + ", guestsCount=" + guestsCount + '}';
    }

}
