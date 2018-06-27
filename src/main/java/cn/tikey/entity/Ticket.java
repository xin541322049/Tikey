package cn.tikey.entity;

import cn.tikey.helper.TicketState;
import cn.tikey.helper.TicketType;

import javax.persistence.*;
import java.util.Date;

@Entity
public class Ticket {

    private int id;
    private double price;
    private double refund;
    private Date saleTime;
    private TicketState state;
    private TicketType type;
    private String memberEmail;
    private String performanceName;
    private String posterUrl;
    private int performanceId;
    private int theRow;
    private int theColumn;

    public Ticket(double price, TicketState state, TicketType type, String memberEmail, String performanceName,
                  String posterUrl, int performanceId) {
        this.price = price;
        this.state = state;
        this.type = type;
        this.memberEmail = memberEmail;
        this.performanceName = performanceName;
        this.posterUrl = posterUrl;
        this.performanceId = performanceId;
        saleTime = new Date();
        theRow = -1;
        theColumn = -1;
        refund = 0;
    }

    public Ticket(){

    }

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Date getSaleTime() {
        return saleTime;
    }

    public void setSaleTime(Date saleTime) {
        this.saleTime = saleTime;
    }

    public TicketState getState() {
        return state;
    }

    public void setState(TicketState state) {
        this.state = state;
    }

    @Column(length = 40)
    public String getMemberEmail() {
        return memberEmail;
    }

    public void setMemberEmail(String memberEmail) {
        this.memberEmail = memberEmail;
    }

    @Column(nullable = false, length = 100)
    public String getPerformanceName() {
        return performanceName;
    }

    public void setPerformanceName(String performanceName) {
        this.performanceName = performanceName;
    }

    public int getPerformanceId() {
        return performanceId;
    }

    public void setPerformanceId(int performanceId) {
        this.performanceId = performanceId;
    }

    public int getTheRow() {
        return theRow;
    }

    public void setTheRow(int row) {
        this.theRow = row;
    }

    public int getTheColumn() {
        return theColumn;
    }

    public void setTheColumn(int column) {
        this.theColumn = column;
    }

    public double getRefund() {
        return refund;
    }

    public void setRefund(double refund) {
        this.refund = refund;
    }

    public TicketType getType() {
        return type;
    }

    public void setType(TicketType type) {
        this.type = type;
    }

    public String getPosterUrl() {
        return posterUrl;
    }

    public void setPosterUrl(String posterUrl) {
        this.posterUrl = posterUrl;
    }
}
