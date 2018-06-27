package cn.tikey.entity;

import cn.tikey.helper.PerformanceState;
import cn.tikey.helper.PerformanceType;

import javax.persistence.*;
import java.util.Date;

@Entity
public class Performance {

    private int id;
    private String name;
    private String description;
    private String actors;
    private String saleMatrix;
    private String posterUrl;
    private Date showTime;
    private Stadium showPlace;
    private PerformanceState state;
    private PerformanceType type;
    private double stallPrice;
    private double secondPrice;
    private double thirdPrice;
    private double fourthPrice;
    private int stallSeats;
    private int secondSeats;
    private int thirdSeats;
    private int fourthSeats;
    private boolean distributed;

    public Performance(String name, String description, String actors, String posterUrl, Date showTime, Stadium showPlace, PerformanceState state,
                       PerformanceType type, double stallPrice, double secondPrice, double thirdPrice, double fourthPrice) {
        this.name = name;
        this.description = description;
        this.actors = actors;
        this.posterUrl = posterUrl;
        this.showTime = showTime;
        this.showPlace = showPlace;
        this.state = state;
        this.type = type;
        this.stallPrice = stallPrice;
        this.secondPrice = secondPrice;
        this.thirdPrice = thirdPrice;
        this.fourthPrice = fourthPrice;
        stallSeats = showPlace.getRowOfStall()*showPlace.getColOfStall();
        secondSeats = showPlace.getRowOfSecondFloor()*showPlace.getColOfSecondFloor();
        thirdSeats = showPlace.getRowOfThirdFloor()*showPlace.getColOfThirdFloor();
        fourthSeats = showPlace.getRowOfFourthFloor()*showPlace.getColOfFourthFloor();
        int sum = stallSeats + secondSeats + thirdSeats + fourthSeats;
        saleMatrix = "";
        for (int i = 0; i < sum; i++) {
            saleMatrix += "0";
        }
        distributed = false;
    }

    public Performance(){

    }

//    public boolean orderSeat(int row, int col){
//        if(row<showPlace.getRowOfStall()){
//            saleMatrix = saleMatrix.substring(0, row*showPlace.getColOfStall()+col)+'1'
//                    +saleMatrix.substring(row*showPlace.getColOfStall()+col+1);
//        }
//    }

    public char[][] transSaleMatrix(){
        int rows = showPlace.getRowOfStall()+showPlace.getRowOfSecondFloor()
                +showPlace.getRowOfThirdFloor()+showPlace.getRowOfFourthFloor();
        char[][] result = new char[rows][];
        int i = 0;
        for (int j = 0; j < showPlace.getRowOfStall(); j++) {
            result[j] = new char[showPlace.getColOfStall()];
            for (int k = 0; k < showPlace.getColOfStall(); k++) {
                result[j][k]=saleMatrix.charAt(i);
                i++;
            }
        }
        for (int j = showPlace.getRowOfStall(); j < showPlace.getRowOfStall() + showPlace.getRowOfSecondFloor(); j++) {
            result[j] = new char[showPlace.getColOfSecondFloor()];
            for (int k = 0; k < showPlace.getColOfSecondFloor(); k++) {
                result[j][k]=saleMatrix.charAt(i);
                i++;
            }
        }
        for (int j = showPlace.getRowOfStall() + showPlace.getRowOfSecondFloor();
             j < showPlace.getRowOfStall() + showPlace.getRowOfSecondFloor()+showPlace.getRowOfThirdFloor(); j++) {
            result[j] = new char[showPlace.getColOfThirdFloor()];
            for (int k = 0; k < showPlace.getColOfThirdFloor(); k++) {
                result[j][k]=saleMatrix.charAt(i);
                i++;
            }
        }
        for (int j = showPlace.getRowOfStall() + showPlace.getRowOfSecondFloor()+showPlace.getRowOfThirdFloor();
             j < showPlace.getRowOfStall()+showPlace.getRowOfSecondFloor()+showPlace.getRowOfThirdFloor()
                     +showPlace.getRowOfFourthFloor(); j++) {
            result[j] = new char[showPlace.getColOfFourthFloor()];
            for (int k = 0; k < showPlace.getColOfFourthFloor(); k++) {
                result[j][k]=saleMatrix.charAt(i);
                i++;
            }
        }
        return result;
    }

    public void changeSaleMatrix(char[][] matrix){
        saleMatrix = "";
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                saleMatrix += matrix[i][j];
            }
        }
    }

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Column(length = 100)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(nullable = false, length = 2048)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getShowTime() {
        return showTime;
    }

    public void setShowTime(Date showTime) {
        this.showTime = showTime;
    }

    @ManyToOne
    @JoinColumn(referencedColumnName = "id")
    public Stadium getShowPlace() {
        return showPlace;
    }

    public void setShowPlace(Stadium showPlace) {
        this.showPlace = showPlace;
    }

    public PerformanceState getState() {
        return state;
    }

    public void setState(PerformanceState state) {
        this.state = state;
    }

    public double getStallPrice() {
        return stallPrice;
    }

    public void setStallPrice(double stallPrice) {
        this.stallPrice = stallPrice;
    }

    public double getSecondPrice() {
        return secondPrice;
    }

    public void setSecondPrice(double secondPrice) {
        this.secondPrice = secondPrice;
    }

    public double getThirdPrice() {
        return thirdPrice;
    }

    public void setThirdPrice(double thirdPrice) {
        this.thirdPrice = thirdPrice;
    }

    public double getFourthPrice() {
        return fourthPrice;
    }

    public void setFourthPrice(double fourthPrice) {
        this.fourthPrice = fourthPrice;
    }

    public String getSaleMatrix() {
        return saleMatrix;
    }

    public void setSaleMatrix(String saleMatrix) {
        this.saleMatrix = saleMatrix;
    }

    public PerformanceType getType() {
        return type;
    }

    public void setType(PerformanceType type) {
        this.type = type;
    }

    @Column(nullable = false, length = 1024)
    public String getActors() {
        return actors;
    }

    public void setActors(String actors) {
        this.actors = actors;
    }

    public String getPosterUrl() {
        return posterUrl;
    }

    public void setPosterUrl(String posterUrl) {
        this.posterUrl = posterUrl;
    }

    public int getStallSeats() {
        return stallSeats;
    }

    public void setStallSeats(int stallSeats) {
        this.stallSeats = stallSeats;
    }

    public int getSecondSeats() {
        return secondSeats;
    }

    public void setSecondSeats(int secondSeats) {
        this.secondSeats = secondSeats;
    }

    public int getThirdSeats() {
        return thirdSeats;
    }

    public void setThirdSeats(int thirdSeats) {
        this.thirdSeats = thirdSeats;
    }

    public int getFourthSeats() {
        return fourthSeats;
    }

    public void setFourthSeats(int fourthSeats) {
        this.fourthSeats = fourthSeats;
    }

    public boolean isDistributed() {
        return distributed;
    }

    public void setDistributed(boolean distributed) {
        this.distributed = distributed;
    }
}
