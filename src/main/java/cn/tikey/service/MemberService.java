package cn.tikey.service;

import cn.tikey.entity.Member;

public interface MemberService {
    Member getMemberByEmail(String email);
    Member register(String email, String password, String name);
    Member logIn(String email, String password);
    Member activateMember(Member member);
    Member changeMemberInfo(Member member);
    Member cancelMember(Member member);
    Member convertCoupon(String email, int credit);
    double getTotalConsumeAmount(String email);
    double getTotalRefundAmount(String email);
    int getTotalTicketNumber(String email);
    int getTotalUsedTicket(String email);
    int[] getMemberRankDistribution();
}
