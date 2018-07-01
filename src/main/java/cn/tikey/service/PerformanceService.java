package cn.tikey.service;

import cn.tikey.entity.Performance;
import cn.tikey.entity.Stadium;
import cn.tikey.entity.Ticket;
import cn.tikey.helper.PerformanceState;
import cn.tikey.helper.PerformanceType;
import cn.tikey.helper.TicketType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.sql.Date;
import java.util.List;
import java.util.Map;

public interface PerformanceService {
    Performance apply(Performance performance);
    Performance accept(int id);
    Performance endSale(int id);
    Performance findById(int id);
    Performance distribute(int id);
    Ticket drawTicket(int id, double price, String memberEmail, TicketType type);
    Ticket pickSeat(int performanceId, int ticketId,  int row, int column);
    Ticket refundTicket(int ticketId);
    Ticket checkTicket(int ticketId, int performanceId);
    List<Performance> findByNameContaining(String name);
    List<Performance> findByDescriptionContaining(String description);
    List<Performance> findByShowTime(Date showTime);
    List<Performance> findByState(PerformanceState state);
    List<Performance> findByStateAndType(PerformanceState state, String type);
    Page<Performance> findByType(Pageable pageable, PerformanceType type);
    double checkRefundAmount(int ticketId);
    Map<String, Integer> getStatisticsData(int id);
}
