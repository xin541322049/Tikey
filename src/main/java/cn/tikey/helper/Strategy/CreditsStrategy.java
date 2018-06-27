package cn.tikey.helper.Strategy;

import cn.tikey.entity.Member;
import cn.tikey.entity.Ticket;

public class CreditsStrategy implements Strategy {

    private String name = "积分抵现金";
    private double rate = 0.01;

    public double countBill(Member member, Ticket ticket) {
        double sum = ticket.getPrice()-member.getCredits()*rate;
//        ticket.setDiscount(ticket.getPrice()-sum);
//        ticket.setDiscountName(name);
        return sum;
    }
}
