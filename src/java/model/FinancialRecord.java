package model;

import java.util.Date;

public class FinancialRecord {
    private int recordId;
    private Date monthYear;
    private double totalRevenue;
    private double serviceCosts;
    private double salaries;
    private double netIncome;
    private Date createdAt;
    private Date updatedAt;

    public FinancialRecord(int recordId, Date monthYear, double totalRevenue,
                           double serviceCosts, double salaries, double netIncome,
                           Date createdAt, Date updatedAt) {
        this.recordId = recordId;
        this.monthYear = monthYear;
        this.totalRevenue = totalRevenue;
        this.serviceCosts = serviceCosts;
        this.salaries = salaries;
        this.netIncome = netIncome;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters & Setters
    public int getRecordId() {
        return recordId;
    }

    public void setRecordId(int recordId) {
        this.recordId = recordId;
    }

    public Date getMonthYear() {
        return monthYear;
    }

    public void setMonthYear(Date monthYear) {
        this.monthYear = monthYear;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public double getServiceCosts() {
        return serviceCosts;
    }

    public void setServiceCosts(double serviceCosts) {
        this.serviceCosts = serviceCosts;
    }

    public double getSalaries() {
        return salaries;
    }

    public void setSalaries(double salaries) {
        this.salaries = salaries;
    }

    public double getNetIncome() {
        return netIncome;
    }

    public void setNetIncome(double netIncome) {
        this.netIncome = netIncome;
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
