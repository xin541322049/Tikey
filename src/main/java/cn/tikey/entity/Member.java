package cn.tikey.entity;

import cn.tikey.helper.MemberState;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Member {

    private String email;
    private String password;
    private String name;
    private int rank;
    private int credits;
    private int validCredit;
    private MemberState memberState;

    public Member(){

    }

    public Member(String email, String password, String name) {
        this.email = email;
        this.password = password;
        this.name = name;
        rank = 0;
        credits = 0;
        memberState = MemberState.Inactive;
    }

    @Id
    @Column(nullable = false, length = 40)
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Column(nullable = false, length = 40)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Column(length = 100)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }

    public int getCredits() {
        return credits;
    }

    public void setCredits(int credits) {
        this.credits = credits;
        if(credits<200){
            rank = 0;
        } else if (credits<1000){
            rank = 1;
        } else if (credits<5000){
            rank = 2;
        } else if (credits<10000){
            rank = 3;
        } else {
            rank = 4;
        }
    }

    public MemberState getMemberState() {
        return memberState;
    }

    public void setMemberState(MemberState memberState) {
        this.memberState = memberState;
    }

    public int getValidCredit() {
        return validCredit;
    }

    public void setValidCredit(int validCredit) {
        this.validCredit = validCredit;
    }
}
