package cn.tikey.dao;

import cn.tikey.entity.Ticket;
import cn.tikey.helper.TicketState;
import cn.tikey.helper.TicketType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TicketRepository extends JpaRepository<Ticket, Integer> {
    Page<Ticket> findByMemberEmailAndState(Pageable pageable, String memberEmail, TicketState state);
    List<Ticket> findByPerformanceId(int performanceId);
    List<Ticket> findByPerformanceIdAndStateAndType(int performanceId, TicketState state, TicketType type);
    List<Ticket> findByState(TicketState state);
    List<Ticket> findByMemberEmailAndState(String memberEmail, TicketState state);
    List<Ticket> findByMemberEmail(String memberEmail);
}
