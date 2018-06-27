package cn.tikey.helper.Strategy;

import cn.tikey.entity.Member;
import cn.tikey.entity.Ticket;

public interface Strategy {
    double countBill(Member member, Ticket ticket);
}
