package model;

import java.util.Date;

public class ExtraServiceCartItem {
    private ExtraService service;
    private Date checkInDate;
    private Date checkOutDate;
    private int guestsCount;

    public ExtraServiceCartItem() {
    }

    public ExtraServiceCartItem(ExtraService service, Date checkInDate, Date checkOutDate, int guestsCount) {
        this.service = service;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.guestsCount = guestsCount;
    }

    public ExtraService getService() {
        return service;
    }

    public void setService(ExtraService service) {
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

    public void setCheckOutDate(Date checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public int getGuestsCount() {
        return guestsCount;
    }

    public void setGuestsCount(int guestsCount) {
        this.guestsCount = guestsCount;
    }

    @Override
    public String toString() {
        return "ExtraServiceCartItem{" + "service=" + service + ", checkInDate=" + checkInDate + ", checkOutDate=" + checkOutDate + ", guestsCount=" + guestsCount + '}';
    }
}
