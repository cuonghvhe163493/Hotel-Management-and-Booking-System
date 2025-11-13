/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

public class StayRoom {

    private int roomId;
    private String roomNumber;
    private String roomStatus;
    private String roomType;
    private int capacity;
    private double pricePerNight;
    private int bookingId;
    private int guestCount;
    private String status;
    private Date checkInDate;
    private Date checkOutDate;
    
    private double price;
    private double deposit;
    private int citizenID;
    private String gmail;
    private int phone;
    private String name;
    private int userId;
    private double totalDeposit;
    public StayRoom() {
    }
    //Cho Checkin customer
    public StayRoom(int bookingId,int roomId, String roomNumber, Date checkInDate,double price, double deposit, double totalDeposit,double pricePerNight) {
        this.bookingId = bookingId;
        this.roomId = roomId;
        this.roomNumber = roomNumber;
        this.checkInDate = checkInDate;
        this.price = price;
        this.deposit = deposit;
        this.totalDeposit = totalDeposit;
        this.pricePerNight = pricePerNight;
    }
    //Lấy thông tin khách trong receptionist
    public StayRoom(String gmail, String name, int userId) {
        this.gmail = gmail;
        this.name = name;
        this.userId = userId;
    }

    public StayRoom(int roomId, String roomNumber, int bookingId, String status, Date checkInDate, Date checkOutDate) {
        this.roomId = roomId;
        this.roomNumber = roomNumber;
        this.bookingId = bookingId;
        this.status = status;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        
    }
    
    
    
    public StayRoom(int roomId, String roomNumber, String roomType, double pricePerNight, int bookingId, Date checkInDate) {
        this.roomId = roomId;
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.pricePerNight = pricePerNight;
        this.bookingId = bookingId;
        this.checkInDate = checkInDate;
    }
    
    
    
    public StayRoom(int roomId, String roomNumber, String roomStatus, String roomType) {
        this.roomId = roomId;
        this.roomNumber = roomNumber;
        this.roomStatus = roomStatus;
        this.roomType = roomType;
    }
    

    public StayRoom(int roomId, String roomNumber, String roomStatus, String roomType, int capacity, double pricePerNight, int bookingId, int guestCount, String status, Date checkInDate, Date checkOutDate) {
        this.roomId = roomId;
        this.roomNumber = roomNumber;
        this.roomStatus = roomStatus;
        this.roomType = roomType;
        this.capacity = capacity;
        this.pricePerNight = pricePerNight;
        this.bookingId = bookingId;
        this.guestCount = guestCount;
        this.status = status;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
    }

    public StayRoom(int roomId, String roomNumber, String roomStatus, String roomType, int capacity, double pricePerNight, int bookingId, int guestCount, String status, Date checkInDate, Date checkOutDate, double price,  String gmail, int phone) {
        this.roomId = roomId;
        this.roomNumber = roomNumber;
        this.roomStatus = roomStatus;
        this.roomType = roomType;
        this.capacity = capacity;
        this.pricePerNight = pricePerNight;
        this.bookingId = bookingId;
        this.guestCount = guestCount;
        this.status = status;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.price = price;
        
        
        this.gmail = gmail;
        this.phone = phone;
    }
    public StayRoom(int roomId, String roomNumber, String roomStatus, String roomType, int capacity, double pricePerNight, int bookingId, int guestCount, String status, Date checkInDate, Date checkOutDate, String gmail, int phone, String name) {
        this.roomId = roomId;
        this.roomNumber = roomNumber;
        this.roomStatus = roomStatus;
        this.roomType = roomType;
        this.capacity = capacity;
        this.pricePerNight = pricePerNight;
        this.bookingId = bookingId;
        this.guestCount = guestCount;
        this.status = status;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
//        this.citizenID = citizenID;
        this.gmail = gmail;
        this.phone = phone;
        this.name = name;
    }
    
    
    
    
    
    public StayRoom(int roomId, String roomNumber, String roomType, int bookingId,  Date checkInDate, Date checkOutDate) {
        this.roomId = roomId;
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.bookingId = bookingId;
       
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
    }

    public double getTotalDeposit() {
        return totalDeposit;
    }

    public void setTotalDeposit(double totalDeposit) {
        this.totalDeposit = totalDeposit;
    }
    
    
    
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    
    
    
    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getDeposit() {
        return deposit;
    }

    public void setDeposit(double deposit) {
        this.deposit = deposit;
    }

    public int getCitizenID() {
        return citizenID;
    }

    public void setCitizenID(int citizenID) {
        this.citizenID = citizenID;
    }

    public String getGmail() {
        return gmail;
    }

    public void setGmail(String gmail) {
        this.gmail = gmail;
    }

    public int getPhone() {
        return phone;
    }

    public void setPhone(int phone) {
        this.phone = phone;
    }

    
    
    
    
    
    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getRoomStatus() {
        return roomStatus;
    }

    public void setRoomStatus(String roomStatus) {
        this.roomStatus = roomStatus;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public double getPricePerNight() {
        return pricePerNight;
    }

    public void setPricePerNight(double pricePerNight) {
        this.pricePerNight = pricePerNight;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getGuestCount() {
        return guestCount;
    }

    public void setGuestCount(int guestCount) {
        this.guestCount = guestCount;
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

}
