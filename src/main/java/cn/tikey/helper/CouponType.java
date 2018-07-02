package cn.tikey.helper;

public enum CouponType {
    Little("10元优惠券",10, 100, 1000), Middle("20元优惠券", 20, 200, 800), Senior("30元优惠券", 30, 500, 600), Senior_1("50元优惠券", 50, 600, 800),
    Senior_2("100元优惠券", 100, 800, 1000), Senior_3("150元优惠券", 150, 1000, 1200);

    private String name;
    private int discounts;
    private int value;
    private int condition;

    CouponType(String name, int discounts, int value, int condition){
        this.name = name;
        this.discounts = discounts;
        this.value = value;
        this.condition = condition;
    }

    public static CouponType getCouponType(String name) {
        for (CouponType type : CouponType.values()) {
            if (type.getName().equals(name)) {
                return type;
            }
        }
        return null;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getDiscounts() {
        return discounts;
    }

    public void setDiscounts(int discounts) {
        this.discounts = discounts;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public int getCondition() {
        return condition;
    }

    public void setCondition(int condition) {
        this.condition = condition;
    }
}
