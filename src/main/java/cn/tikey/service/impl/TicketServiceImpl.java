package cn.tikey.service.impl;

import cn.tikey.dao.PerformanceRepository;
import cn.tikey.dao.TicketRepository;
import cn.tikey.entity.Ticket;
import cn.tikey.helper.TicketState;
import cn.tikey.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TicketServiceImpl implements TicketService {

    @Autowired
    private TicketRepository ticketRepository;

    public Ticket check(int performanceId, int ticketId) {
        Ticket ticket = ticketRepository.findOne(ticketId);
        if(ticket.getPerformanceId() != performanceId){
            return null;
        }
        ticket.setState(TicketState.Used);
        ticketRepository.save(ticket);
        return ticket;
    }

    public List<Ticket> findByMemberEmailAndState(String email, TicketState state) {
        return ticketRepository.findByMemberEmailAndState(email, state);
    }

    public Page<Ticket> findByMemberEmailAndState(Pageable pageable, String memberEmail, TicketState state) {
        return ticketRepository.findByMemberEmailAndState(pageable, memberEmail, state);
    }

    public List<Ticket> findByPerformanceId(int performanceId) {
        return ticketRepository.findByPerformanceId(performanceId);
    }

    public List<Ticket> findByState(TicketState state) {
        return ticketRepository.findByState(state);
    }

    public List<Ticket> findByMemberEmail(String memberEmail) {
        return ticketRepository.findByMemberEmail(memberEmail);
    }
}
