package cn.tikey.entity;

import cn.tikey.helper.StadiumState;

import javax.persistence.*;
import java.util.List;

@Entity
public class Stadium {

    private int id;
    private String stadiumCode;
    private String name;
    private String password;
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
    private StadiumState state;
    private List<Performance> performances;

    public Stadium(String name, String password, String province, String city, String address
            , String accountName, int rowOfStall, int rowOfSecondFloor, int rowOfThirdFloor, int rowOfFourthFloor
            , int colOfStall, int colOfSecondFloor, int colOfThirdFloor, int colOfFourthFloor, StadiumState state) {
        this.name = name;
        this.password = password;
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
        this.state = state;
    }

    public Stadium(){

    }

    public void changeInfo(Modification modification){
        name = modification.getName();
        province = modification.getProvince();
        city = modification.getCity();
        address = modification.getAddress();
        accountName = modification.getAccountName();
        rowOfStall = modification.getRowOfStall();
        rowOfSecondFloor = modification.getRowOfSecondFloor();
        rowOfThirdFloor = modification.getRowOfThirdFloor();
        rowOfFourthFloor = modification.getRowOfFourthFloor();
        colOfStall = modification.getColOfStall();
        colOfSecondFloor = modification.getColOfSecondFloor();
        colOfThirdFloor = modification.getColOfThirdFloor();
        colOfFourthFloor = modification.getColOfFourthFloor();
    }

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    public int getRowOfStall() {
        return rowOfStall;
    }

    public void setRowOfStall(int stall) {
        this.rowOfStall = stall;
    }

    public int getRowOfSecondFloor() {
        return rowOfSecondFloor;
    }

    public void setRowOfSecondFloor(int secondFloor) {
        this.rowOfSecondFloor = secondFloor;
    }

    public int getRowOfThirdFloor() {
        return rowOfThirdFloor;
    }

    public void setRowOfThirdFloor(int thirdFloor) {
        this.rowOfThirdFloor = thirdFloor;
    }

    public int getRowOfFourthFloor() {
        return rowOfFourthFloor;
    }

    public void setRowOfFourthFloor(int fourthFloor) {
        this.rowOfFourthFloor = fourthFloor;
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

    @OneToMany(mappedBy = "showPlace", fetch=FetchType.EAGER)
    public List<Performance> getPerformances() {
        return performances;
    }

    public void setPerformances(List<Performance> performances) {
        this.performances = performances;
    }

    public StadiumState getState() {
        return state;
    }

    public void setState(StadiumState state) {
        this.state = state;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getStadiumCode() {
        return stadiumCode;
    }

    public void setStadiumCode(String stadiumId) {
        this.stadiumCode = stadiumId;
    }
}
