package cn.tikey.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.util.Date;

@Entity
public class Record {

    private int id;
    private int performanceId;
    private String code;
    private double stadiumIncome;
    private double websiteIncome;
    private Date createTime;

    public Record(int performanceId, String code, double stadiumIncome, double websiteIncome) {
        this.performanceId = performanceId;
        this.code = code;
        this.stadiumIncome = stadiumIncome;
        this.websiteIncome = websiteIncome;
        this.createTime = new Date();
    }

    public Record(){

    }

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getStadiumIncome() {
        return stadiumIncome;
    }

    public void setStadiumIncome(double change) {
        this.stadiumIncome = change;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public int getPerformanceId() {
        return performanceId;
    }

    public void setPerformanceId(int performanceId) {
        this.performanceId = performanceId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public double getWebsiteIncome() {
        return websiteIncome;
    }

    public void setWebsiteIncome(double websiteIncome) {
        this.websiteIncome = websiteIncome;
    }
}
