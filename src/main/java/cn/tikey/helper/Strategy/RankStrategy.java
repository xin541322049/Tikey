package cn.tikey.helper.Strategy;

import cn.tikey.entity.Member;
import cn.tikey.entity.Ticket;

public class RankStrategy implements Strategy {

    private String name = "会员等级优惠";
    private double[] rankSaleMap = {0.95, 0.9, 0.85, 0.8, 0.7};

    public double countBill(Member member, Ticket ticket) {
        double sum = ticket.getPrice()*rankSaleMap[member.getRank()];
//        ticket.setDiscount(ticket.getPrice()-sum);
//        ticket.setDiscountName(name);
        return sum;
    }
}
