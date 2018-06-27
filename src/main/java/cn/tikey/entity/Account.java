package cn.tikey.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Account {

    private String name;
    private String password;
    private double remains;

    public Account(String name, String password) {
        this.name = name;
        this.password = password;
    }

    public Account(){

    }


    @Id
    @Column(length = 160)
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

    public double getRemains() {
        return remains;
    }

    public void setRemains(double remains) {
        this.remains = remains;
    }
}
