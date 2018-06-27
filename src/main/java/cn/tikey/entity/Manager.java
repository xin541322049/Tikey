package cn.tikey.entity;

import org.springframework.stereotype.Controller;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Manager {

    private String id;
    private String password;

    public Manager(String id, String password) {
        this.id = id;
        this.password = password;
    }

    public Manager(){

    }

    @Id
    @Column(length = 20)
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
