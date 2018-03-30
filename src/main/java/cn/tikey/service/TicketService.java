package cn.tikey.service;

import cn.tikey.entity.Ticket;
import cn.tikey.helper.TicketState;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface TicketService {
    Ticket check(int performanceId, int ticketId);
    List<Ticket> findByMemberEmailAndState(String email, TicketState state);
    Page<Ticket> findByMemberEmailAndState(Pageable pageable, String memberEmail, TicketState state);
    List<Ticket> findByPerformanceId(int performanceId);
    List<Ticket> findByState(TicketState state);
    List<Ticket> findByMemberEmail(String memberEmail);
}
