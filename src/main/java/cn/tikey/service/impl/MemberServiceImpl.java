package cn.tikey.service.impl;

import cn.tikey.dao.MemberRepository;
import cn.tikey.dao.TicketRepository;
import cn.tikey.entity.Member;
import cn.tikey.entity.Ticket;
import cn.tikey.exceptions.NoMemberException;
import cn.tikey.exceptions.WrongPasswordException;
import cn.tikey.helper.MemberState;
import cn.tikey.helper.TicketState;
import cn.tikey.service.MemberService;
import cn.tikey.utils.MailUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import java.util.HashMap;
import java.util.List;

@Service
public class MemberServiceImpl implements MemberService{

    @Autowired
    private MemberRepository memberRepository;
    @Autowired
    private TicketRepository ticketRepository;

    public Member getMemberByEmail(String email) {
        return memberRepository.findByEmail(email);
    }

    public Member register(String email, String password, String name) {
        Member member = new Member(email, password, name);
        memberRepository.save(member);
        try {
            MailUtil.activateMail(email);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return member;
    }

    public Member logIn(String email, String password) {
        Member member = memberRepository.findByEmail(email);
        if(member == null){
            throw new NoMemberException(email);
        }
        if(!password.equals(member.getPassword())){
            throw new WrongPasswordException();
        }
        return member;
    }

    public Member activateMember(Member member) {
        member.setMemberState(MemberState.Active);
        memberRepository.save(member);
        return member;
    }

    public Member changeMemberInfo(Member member) {
        memberRepository.save(member);
        return member;
    }

    public Member cancelMember(Member member) {
        member.setMemberState(MemberState.Invalid);
        memberRepository.save(member);
        return member;
    }

    public Member convertCoupon(String email, int credit) {
        Member member = memberRepository.findByEmail(email);
        member.setValidCredit(member.getValidCredit()-credit);
        memberRepository.save(member);
        return member;
    }

    public double getTotalConsumeAmount(String email) {
        List<Ticket> allTickets = ticketRepository.findByMemberEmail(email);
        double consume = 0;
        for (Ticket ticket: allTickets
                ) {
            consume += ticket.getPrice();
        }
        return consume;
    }

    public double getTotalRefundAmount(String email) {
        List<Ticket> refundedTickets = ticketRepository.findByMemberEmailAndState(email, TicketState.Refunded);
        double consume = 0;
        for (Ticket ticket: refundedTickets
                ) {
            consume += ticket.getRefund();
        }
        return consume;
    }

    public int getTotalTicketNumber(String email) {
        return ticketRepository.findByMemberEmail(email).size();
    }

    public int getTotalUsedTicket(String email) {
        HashMap<Integer, Integer> performanceMap = new HashMap<Integer, Integer>();
        List<Ticket> usedTickets = ticketRepository.findByMemberEmailAndState(email, TicketState.Used);
        double consume = 0;
        for (Ticket ticket: usedTickets
                ) {
            if(!performanceMap.containsKey(ticket.getPerformanceId())){
                performanceMap.put(ticket.getPerformanceId(), 0);
            }
        }
        return performanceMap.size();
    }

    public int[] getMemberRankDistribution() {
        List<Member> members = memberRepository.findAll();
        int[] result = new int[6];
        for (Member member: members
             ) {
            if(member.getMemberState() == MemberState.Invalid){
                result[5]++;
            } else if(member.getMemberState() != MemberState.Inactive){
                result[member.getRank()]++;
            }
        }
        return result;
    }
}
