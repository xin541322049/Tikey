package cn.tikey.service;

import cn.tikey.entity.Coupon;
import cn.tikey.helper.CouponType;

import java.util.List;

public interface CouponService {
    List<Coupon> getMemberCoupon(String email);
    void convertCoupon(String email, CouponType couponType);
    void consumeCoupon(int id);
    List<CouponType> getCouponTypes();
}
