package cn.tikey.helper;

public class Coupons {
    private String name;
    private int value;
    private int holdAmount;
    private int discounts;
    private int condition;

    public Coupons(String name, int value, int holdAmount, int discounts, int condition) {
        this.name = name;
        this.value = value;
        this.holdAmount = holdAmount;
        this.discounts = discounts;
        this.condition = condition;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public int getHoldAmount() {
        return holdAmount;
    }

    public void setHoldAmount(int holdAmount) {
        this.holdAmount = holdAmount;
    }

    public int getDiscounts() {
        return discounts;
    }

    public void setDiscounts(int discounts) {
        this.discounts = discounts;
    }

    public int getCondition() {
        return condition;
    }

    public void setCondition(int condition) {
        this.condition = condition;
    }
}
