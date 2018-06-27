package cn.tikey.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Modification {

    private int id;
    private String stadiumCode;
    private String name;
    private String province;
    private String city;
    private String address;
    private String accountName;
    private int rowOfStall;
    private int rowOfSecondFloor;
    private int rowOfThirdFloor;
    private int rowOfFourthFloor;
    private int colOfStall;
    private int colOfSecondFloor;
    private int colOfThirdFloor;
    private int colOfFourthFloor;

    public Modification(String stadiumCode, String name, String province, String city, String address, String accountName,
                        int rowOfStall, int rowOfSecondFloor, int rowOfThirdFloor, int rowOfFourthFloor,
                        int colOfStall, int colOfSecondFloor, int colOfThirdFloor, int colOfFourthFloor) {
        this.stadiumCode = stadiumCode;
        this.name = name;
        this.province = province;
        this.city = city;
        this.address = address;
        this.accountName = accountName;
        this.rowOfStall = rowOfStall;
        this.rowOfSecondFloor = rowOfSecondFloor;
        this.rowOfThirdFloor = rowOfThirdFloor;
        this.rowOfFourthFloor = rowOfFourthFloor;
        this.colOfStall = colOfStall;
        this.colOfSecondFloor = colOfSecondFloor;
        this.colOfThirdFloor = colOfThirdFloor;
        this.colOfFourthFloor = colOfFourthFloor;
    }

    public Modification(){}

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStadiumCode() {
        return stadiumCode;
    }

    public void setStadiumCode(String stadiumCode) {
        this.stadiumCode = stadiumCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public int getRowOfStall() {
        return rowOfStall;
    }

    public void setRowOfStall(int rowOfStall) {
        this.rowOfStall = rowOfStall;
    }

    public int getRowOfSecondFloor() {
        return rowOfSecondFloor;
    }

    public void setRowOfSecondFloor(int rowOfSecondFloor) {
        this.rowOfSecondFloor = rowOfSecondFloor;
    }

    public int getRowOfThirdFloor() {
        return rowOfThirdFloor;
    }

    public void setRowOfThirdFloor(int rowOfThirdFloor) {
        this.rowOfThirdFloor = rowOfThirdFloor;
    }

    public int getRowOfFourthFloor() {
        return rowOfFourthFloor;
    }

    public void setRowOfFourthFloor(int rowOfFourthFloor) {
        this.rowOfFourthFloor = rowOfFourthFloor;
    }

    public int getColOfStall() {
        return colOfStall;
    }

    public void setColOfStall(int colOfStall) {
        this.colOfStall = colOfStall;
    }

    public int getColOfSecondFloor() {
        return colOfSecondFloor;
    }

    public void setColOfSecondFloor(int colOfSecondFloor) {
        this.colOfSecondFloor = colOfSecondFloor;
    }

    public int getColOfThirdFloor() {
        return colOfThirdFloor;
    }

    public void setColOfThirdFloor(int colOfThirdFloor) {
        this.colOfThirdFloor = colOfThirdFloor;
    }

    public int getColOfFourthFloor() {
        return colOfFourthFloor;
    }

    public void setColOfFourthFloor(int colOfFourthFloor) {
        this.colOfFourthFloor = colOfFourthFloor;
    }
}
