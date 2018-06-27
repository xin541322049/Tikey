package cn.tikey.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Coupon {

    private int id;
    private int useCondition;
    private int discounts;
    private String memberEmail;
    private String couponName;

    public Coupon(int useCondition, int discounts, String memberEmail, String couponName) {
        this.useCondition = useCondition;
        this.discounts = discounts;
        this.memberEmail = memberEmail;
        this.couponName = couponName;
    }

    public Coupon(){}


    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUseCondition() {
        return useCondition;
    }

    public void setUseCondition(int useCondition) {
        this.useCondition = useCondition;
    }

    public int getDiscounts() {
        return discounts;
    }

    public void setDiscounts(int discounts) {
        this.discounts = discounts;
    }

    public String getMemberEmail() {
        return memberEmail;
    }

    public void setMemberEmail(String memberEmail) {
        this.memberEmail = memberEmail;
    }

    public String getCouponName() {
        return couponName;
    }

    public void setCouponName(String couponName) {
        this.couponName = couponName;
    }
}
