package cn.tikey.service.impl;

import cn.tikey.dao.CouponRepository;
import cn.tikey.entity.Coupon;
import cn.tikey.helper.CouponType;
import cn.tikey.service.CouponService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CouponServiceImpl implements CouponService{

    @Autowired
    private CouponRepository couponRepository;

    public List<Coupon> getMemberCoupon(String email) {
        return couponRepository.findByMemberEmail(email);
    }

    public void convertCoupon(String email, CouponType couponType) {
        Coupon coupon = new Coupon(couponType.getCondition(), couponType.getDiscounts(), email, couponType.getName());
        couponRepository.save(coupon);
    }

    public void consumeCoupon(int id) {
        couponRepository.delete(id);
    }

    public List<CouponType> getCouponTypes() {
        List<CouponType> result = new ArrayList<CouponType>();
        for (CouponType type: CouponType.values()
             ) {
            result.add(type);
        }
        return result;
    }
}
