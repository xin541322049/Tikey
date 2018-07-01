package cn.tikey.service.impl;

import cn.tikey.dao.AccountRepository;
import cn.tikey.dao.MemberRepository;
import cn.tikey.dao.PerformanceRepository;
import cn.tikey.dao.TicketRepository;
import cn.tikey.entity.Performance;
import cn.tikey.entity.Stadium;
import cn.tikey.entity.Ticket;
import cn.tikey.exceptions.NoTicketException;
import cn.tikey.helper.PerformanceState;
import cn.tikey.helper.PerformanceType;
import cn.tikey.helper.TicketState;
import cn.tikey.helper.TicketType;
import cn.tikey.service.PerformanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PerformanceServiceImpl implements PerformanceService{

    @Autowired
    private PerformanceRepository performanceRepository;
    @Autowired
    private TicketRepository ticketRepository;

    public Performance apply(Performance performance) {
        performanceRepository.save(performance);
        return performance;
    }

    public Performance accept(int id) {
        Performance performance = performanceRepository.findOne(id);
        performance.setState(PerformanceState.Sale);
        performanceRepository.save(performance);
        return performance;
    }

    public Performance endSale(int id) {
        Performance performance = performanceRepository.findOne(id);
        performance.setState(PerformanceState.Completed);
        List<Ticket> tickets = ticketRepository.findByPerformanceId(id);
        for (Ticket ticket : tickets
                ) {
            if(ticket.getState()==TicketState.Unused){
                ticket.setState(TicketState.Used);
            }
        }
        ticketRepository.save(tickets);
        performanceRepository.save(performance);
        return performance;
    }

    public Performance findById(int id) {
        return performanceRepository.findOne(id);
    }

    public Performance distribute(int id) {
        List<Ticket> unseatedStallList = ticketRepository.findByPerformanceIdAndStateAndType(id, TicketState.Unseated, TicketType.Stall);
        List<Ticket> unseatedSecondList = ticketRepository.findByPerformanceIdAndStateAndType(id, TicketState.Unseated, TicketType.Second);
        List<Ticket> unseatedThirdList = ticketRepository.findByPerformanceIdAndStateAndType(id, TicketState.Unseated, TicketType.Third);
        List<Ticket> unseatedFourthList = ticketRepository.findByPerformanceIdAndStateAndType(id, TicketState.Unseated, TicketType.Fourth);
        Performance performance = performanceRepository.findOne(id);
        Stadium showPlace = performance.getShowPlace();
        char[][] seatMap = performance.transSaleMatrix();
        int i = 0;
        for (int j = 0; j < showPlace.getRowOfStall(); j++) {
            if(i==unseatedStallList.size()){
                break;
            }
            for (int k = 0; k < showPlace.getColOfStall(); k++) {
                if(i==unseatedStallList.size()){
                    break;
                }
                if(seatMap[j][k]=='0'){
                    unseatedStallList.get(i).setTheRow(j+1);
                    unseatedStallList.get(i).setTheColumn(k+1);
                    unseatedStallList.get(i).setState(TicketState.Unused);
                    seatMap[j][k] = '1';
                    i++;
                }
            }
        }
        i=0;
        for (int j = showPlace.getRowOfStall(); j < showPlace.getRowOfStall() + showPlace.getRowOfSecondFloor(); j++) {
            if(i==unseatedStallList.size()){
                break;
            }
            for (int k = 0; k < showPlace.getColOfSecondFloor(); k++) {
                if(i==unseatedSecondList.size()){
                    break;
                }
                if(seatMap[j][k]=='0'){
                    unseatedSecondList.get(i).setTheRow(j+1);
                    unseatedSecondList.get(i).setTheColumn(k+1);
                    unseatedSecondList.get(i).setState(TicketState.Unused);
                    seatMap[j][k] = '1';
                    i++;
                }
            }
        }
        i=0;
        for (int j = showPlace.getRowOfStall() + showPlace.getRowOfSecondFloor();
             j < showPlace.getRowOfStall() + showPlace.getRowOfSecondFloor()+showPlace.getRowOfThirdFloor(); j++) {
            if(i==unseatedStallList.size()){
                break;
            }
            for (int k = 0; k < showPlace.getColOfThirdFloor(); k++) {
                if(i==unseatedThirdList.size()){
                    break;
                }
                if(seatMap[j][k]=='0'){
                    unseatedThirdList.get(i).setTheRow(j+1);
                    unseatedThirdList.get(i).setTheColumn(k+1);
                    unseatedThirdList.get(i).setState(TicketState.Unused);
                    seatMap[j][k] = '1';
                    i++;
                }
            }
        }
        i=0;
        for (int j = showPlace.getRowOfStall() + showPlace.getRowOfSecondFloor()+showPlace.getRowOfThirdFloor();
             j < showPlace.getRowOfStall()+showPlace.getRowOfSecondFloor()+showPlace.getRowOfThirdFloor()
                     +showPlace.getRowOfFourthFloor(); j++) {
            if(i==unseatedStallList.size()){
                break;
            }
            for (int k = 0; k < showPlace.getColOfFourthFloor(); k++) {
                if(i==unseatedFourthList.size()){
                    break;
                }
                if(seatMap[j][k]=='0'){
                    unseatedFourthList.get(i).setTheRow(j+1);
                    unseatedFourthList.get(i).setTheColumn(k+1);
                    unseatedFourthList.get(i).setState(TicketState.Unused);
                    seatMap[j][k] = '1';
                    i++;
                }
            }
        }
        performance.changeSaleMatrix(seatMap);
        performance.setDistributed(true);
        performanceRepository.save(performance);
        ticketRepository.save(unseatedStallList);
        ticketRepository.save(unseatedSecondList);
        ticketRepository.save(unseatedThirdList);
        ticketRepository.save(unseatedFourthList);
        return performance;
    }

    public Ticket drawTicket(int id, double price, String memberEmail, TicketType type) {
        Performance performance = performanceRepository.findOne(id);
        switch (type){
            case Stall:
                if(performance.getStallSeats()==0){
                    throw new NoTicketException();
                }
                performance.setStallSeats(performance.getStallSeats()-1);
                break;
            case Second:
                if(performance.getSecondSeats()==0){
                    throw new NoTicketException();
                }
                performance.setSecondSeats(performance.getSecondSeats()-1);
                break;
            case Third:
                if(performance.getThirdSeats()==0){
                    throw new NoTicketException();
                }
                performance.setThirdSeats(performance.getThirdSeats()-1);
                break;
            case Fourth:
                if(performance.getFourthSeats()==0){
                    throw new NoTicketException();
                }
                performance.setFourthSeats(performance.getFourthSeats()-1);
                break;
        }
        performanceRepository.save(performance);
        Ticket ticket = new Ticket(price, TicketState.Unseated, type, memberEmail, performance.getName(),
                performance.getPosterUrl(), performance.getId());
        ticketRepository.save(ticket);
        return ticket;
    }

    public Ticket pickSeat(int performanceId, int ticketId, int row, int column) {
        Performance performance = performanceRepository.findOne(performanceId);
        char[][] seatMap = performance.transSaleMatrix();
        seatMap[row-1][column-1] = '1';
        performance.changeSaleMatrix(seatMap);
        performanceRepository.save(performance);
        Ticket ticket = ticketRepository.findOne(ticketId);
        ticket.setTheRow(row);
        ticket.setTheColumn(column);
        ticket.setState(TicketState.Unused);
        ticketRepository.save(ticket);
        return ticket;
    }

//    public Ticket cancelTicket(int performanceId, int ticketId) {
//        Performance performance = performanceRepository.findOne(performanceId);
////        performance.refundTicket();
//        Ticket ticket = ticketRepository.findOne(ticketId);
//        if(ticket.getTheRow() != -1){
//            char[][] seatMap = performance.transSaleMatrix();
//            seatMap[ticket.getTheRow()][ticket.getTheColumn()] = '0';
//            performance.changeSaleMatrix(seatMap);
//            performanceRepository.save(performance);
//        }
//        switch (ticket.getType()){
//            case Stall:
//                performance.setStallSeats(performance.getStallSeats()+1);
//                break;
//            case Second:
//                performance.setSecondSeats(performance.getSecondSeats()+1);
//                break;
//            case Third:
//                performance.setThirdSeats(performance.getThirdSeats()+1);
//                break;
//            case Fourth:
//                performance.setFourthSeats(performance.getFourthSeats()+1);
//                break;
//        }
//        ticket.setState(TicketState.Canceled);
//        ticketRepository.save(ticket);
//        return ticket;
//    }

    public Ticket refundTicket(int ticketId) {
        Ticket ticket = ticketRepository.findOne(ticketId);
        ticket.setState(TicketState.Refunded);
        long now = new java.util.Date().getTime();
        long saleTime = ticket.getSaleTime().getTime();
        long days = now-saleTime/1000*60*60*24;
        if(days>180){
            ticket.setRefund(ticket.getPrice()*0.8);
        }
        if(days<=180&&days>60){
            ticket.setRefund(ticket.getPrice()*0.6);
        }
        if(days<=60){
            ticket.setRefund(ticket.getPrice()*0.4);
        }
        ticketRepository.save(ticket);
        Performance performance = performanceRepository.findOne(ticket.getPerformanceId());
        switch (ticket.getType()){
            case Stall:
                performance.setStallSeats(performance.getStallSeats()+1);
                break;
            case Second:
                performance.setSecondSeats(performance.getSecondSeats()+1);
                break;
            case Third:
                performance.setThirdSeats(performance.getThirdSeats()+1);
                break;
            case Fourth:
                performance.setFourthSeats(performance.getFourthSeats()+1);
                break;
                default:
        }
        if(ticket.getTheRow() != -1){
            char[][] seatMap = performance.transSaleMatrix();
            seatMap[ticket.getTheRow()-1][ticket.getTheColumn()-1] = '0';
            performance.changeSaleMatrix(seatMap);
        }
        performanceRepository.save(performance);
        return ticket;
    }

    public Ticket checkTicket(int ticketId, int performanceId) {
        Ticket ticket = ticketRepository.findOne(ticketId);
        if(ticket.getPerformanceId() == performanceId && (ticket.getState()==TicketState.Unused)){
            ticket.setState(TicketState.Used);
            ticketRepository.save(ticket);
            return ticket;
        }
        return null;
    }

    public List<Performance> findByNameContaining(String name) {
        return performanceRepository.findByNameContainingAndState(name, PerformanceState.Sale);
    }

    public List<Performance> findByDescriptionContaining(String description) {
        return performanceRepository.findByDescriptionContainingAndState(description, PerformanceState.Sale);
    }

    public List<Performance> findByShowTime(Date showTime) {
        return performanceRepository.findByShowTime(showTime);
    }

    public List<Performance> findByState(PerformanceState state) {
        return performanceRepository.findByState(state);
    }

    public List<Performance> findByStateAndType(PerformanceState state, String type) {
        List<Performance> hotList = null;
        if(type.equals("演唱会")){
            hotList = performanceRepository.findByStateAndType(PerformanceState.Sale, PerformanceType.Concert);
        }
        if(type.equals("体育赛事")){
            hotList = performanceRepository.findByStateAndType(PerformanceState.Sale, PerformanceType.Competition);
        }
        if(type.equals("音乐会")){
            hotList = performanceRepository.findByStateAndType(PerformanceState.Sale, PerformanceType.Music);
        }
        if(type.equals("歌剧")){
            hotList = performanceRepository.findByStateAndType(PerformanceState.Sale, PerformanceType.Opera);
        }
        if(type.equals("话剧")){
            hotList = performanceRepository.findByStateAndType(PerformanceState.Sale, PerformanceType.Drama);
        }
        if(type.equals("儿童亲子")){
            hotList = performanceRepository.findByStateAndType(PerformanceState.Sale, PerformanceType.ChildPlay);
        }
        if(type.equals("舞蹈")){
            hotList = performanceRepository.findByStateAndType(PerformanceState.Sale, PerformanceType.Dance);
        }
        if(type.equals("马戏")){
            hotList = performanceRepository.findByStateAndType(PerformanceState.Sale, PerformanceType.Circus);
        }
        return hotList;
    }

    public Page<Performance> findByType(Pageable pageable, PerformanceType type) {
        return performanceRepository.findByType(pageable, type);
    }

    public double checkRefundAmount(int ticketId) {
        Ticket ticket = ticketRepository.findOne(ticketId);
        long now = new java.util.Date().getTime();
        long saleTime = ticket.getSaleTime().getTime();
        long days = now-saleTime/1000*60*60*24;
        if(days>180){
            return (ticket.getPrice()*0.8);
        }
        if(days<=180&&days>60){
            return (ticket.getPrice()*0.6);
        }
        if(days<=60){
            return (ticket.getPrice()*0.4);
        }
        return 0;
    }

    public Map<String, Integer> getStatisticsData(int id) {
        Performance performance = performanceRepository.findOne(id);
        int empty = performance.getStallSeats()+performance.getSecondSeats()+performance.getThirdSeats()+performance.getFourthSeats();
        List<Ticket> tickets = ticketRepository.findByPerformanceId(id);
        HashMap<String, Integer> result = new HashMap<String, Integer>();
        result.put(TicketState.Unused.toString(), 0);
        result.put(TicketState.Unseated.toString(), 0);
        result.put(TicketState.Refunded.toString(), 0);
        result.put(TicketState.Used.toString(), 0);
        for (Ticket ticket: tickets
             ) {
            String key = ticket.getState().toString();
            result.put(key, result.get(key)+1);
        }
        result.put("Empty", empty);
        return result;
    }
}
