package cn.tikey.controller;

import cn.tikey.entity.*;
import cn.tikey.helper.PerformanceState;
import cn.tikey.helper.TicketState;
import cn.tikey.helper.TicketType;
import cn.tikey.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/tikey/stadium")
public class StadiumController {

    @Autowired
    private StadiumService stadiumService;
    @Autowired
    private PerformanceService performanceService;
    @Autowired
    private MemberService memberService;
    @Autowired
    private AccountService accountService;
    @Autowired
    private RecordService recordService;

    @RequestMapping(value = "/register")
    public String register(ModelMap modelMap, @ModelAttribute("name") String name,
                           @ModelAttribute("province") String province, @ModelAttribute("city") String city,
                           @ModelAttribute("address") String address, @ModelAttribute("stallRow") int stallRow,
                           @ModelAttribute("stallCol") int stallCol, @ModelAttribute("secondRow") int secondRow,
                           @ModelAttribute("secondCol") int secondCol, @ModelAttribute("thirdRow") int thirdRow,
                           @ModelAttribute("thirdCol") int thirdCol, @ModelAttribute("fourthRow") int fourthRow,
                           @ModelAttribute("fourthCol") int fourthCol, @ModelAttribute("password") String password,
                           @ModelAttribute("account") String account) {
        Stadium stadium = stadiumService.register(name,password, province, city, address, account, stallRow, secondRow,
                thirdRow, fourthRow, stallCol, secondCol, thirdCol, fourthCol);
        modelMap.addAttribute("stadium", stadium);
        return "stadium/register";
    }

    @RequestMapping(value = "/login/check")
    public @ResponseBody String logInCheck(@ModelAttribute("code") String code,
                                           @ModelAttribute("password") String password){
        Stadium stadium = stadiumService.logIn(code, password);
        if(stadium == null){
            return "fail";
        }
        else{
            return "success";
        }
    }

    @RequestMapping(value = "/login")
    public String logIn(ModelMap modelMap, @ModelAttribute("code") String code){
        Stadium stadium = stadiumService.getBycode(code);
        modelMap.addAttribute("stadium", stadium);
        return "stadium/information";
    }

    @RequestMapping(value = "/changeInfo")
    public String changeInfo(@ModelAttribute("name") String name, @ModelAttribute("code") String code,
                           @ModelAttribute("province") String province, @ModelAttribute("city") String city,
                           @ModelAttribute("address") String address, @ModelAttribute("stallRow") int stallRow,
                           @ModelAttribute("stallCol") int stallCol, @ModelAttribute("secondRow") int secondRow,
                           @ModelAttribute("secondCol") int secondCol, @ModelAttribute("thirdRow") int thirdRow,
                           @ModelAttribute("thirdCol") int thirdCol, @ModelAttribute("fourthRow") int fourthRow,
                           @ModelAttribute("fourthCol") int fourthCol, @ModelAttribute("account") String account) {
        Modification modification = new Modification(code, name, province, city, address, account,
                stallRow, secondRow, thirdRow, fourthRow, stallCol, secondCol, thirdCol, fourthCol);
        stadiumService.applyToChangeInfo(modification);
//        Stadium stadium = stadiumService.getBycode(code);
//        modelMap.addAttribute("stadium", stadium);
//        modelMap.addAttribute("changeApplied", 1);
        return "redirect:/tikey/stadium/login";
    }

    @RequestMapping(value = "/changePassword")
    public @ResponseBody String changePassword(ModelMap modelMap,
                                               @ModelAttribute("code") String code,
                                               @ModelAttribute("oldPassword") String oldPassword,
                                               @ModelAttribute("newPassword") String newPassword){
        Stadium stadium = stadiumService.logIn(code, oldPassword);
        if(stadium != null){
            stadium.setPassword(newPassword);
            stadiumService.changeStadiumInfo(stadium);
            modelMap.addAttribute("stadium", stadium);
            return "success";
        }
        else{
            return "fail";
        }
    }

    @RequestMapping(value = "/performanceList")
    public String getPerformanceList(ModelMap modelMap, @ModelAttribute("code") String code){
        Stadium stadium = stadiumService.getBycode(code);
        ArrayList<Performance> applying = new ArrayList<Performance>();
        ArrayList<Performance> sale = new ArrayList<Performance>();
        ArrayList<Performance> completed = new ArrayList<Performance>();
        ArrayList<Performance> settled = new ArrayList<Performance>();
        for (Performance performance: stadium.getPerformances()
             ) {
            if(performance.getState() == PerformanceState.BeingAccepted){
                applying.add(performance);
            }
            if(performance.getState() == PerformanceState.Sale){
                sale.add(performance);
            }
            if(performance.getState() == PerformanceState.Completed){
                completed.add(performance);
            }
            if(performance.getState() == PerformanceState.Settled){
                settled.add(performance);
            }
        }
        modelMap.addAttribute("stadium", stadium);
        modelMap.addAttribute("applyingList", applying);
        modelMap.addAttribute("saleList", sale);
        modelMap.addAttribute("completedList", completed);
        modelMap.addAttribute("settledList", settled);
        return "stadium/performance_list";
    }

    @RequestMapping(value = "/performance/{code}/{id}")
    public String getDetail(ModelMap modelMap, @PathVariable("code") String code, @PathVariable("id") int id){
        Performance performance = performanceService.findById(id);
        modelMap.addAttribute("performance", performance);
        Stadium stadium = stadiumService.getBycode(code);
        modelMap.addAttribute("stadium", stadium);
        return "stadium/performance";
    }

    @RequestMapping(value = "/performance/pickSeat")
    public String pickSeat(ModelMap modelMap, @ModelAttribute("id") int id, @ModelAttribute("code") String code,
                           @ModelAttribute("type") String type, @ModelAttribute("price") double price){
        Stadium stadium = stadiumService.getBycode(code);
        Performance performance = performanceService.findById(id);
        String saleMatrix = "";
        int stall = stadium.getRowOfStall()*stadium.getColOfStall();
        int second = stall+stadium.getRowOfSecondFloor()*stadium.getColOfSecondFloor();
        int third = second+stadium.getRowOfThirdFloor()*stadium.getColOfThirdFloor();
        int fourth = third+stadium.getRowOfFourthFloor()*stadium.getColOfFourthFloor();
        if(type.equals("stall")){
            saleMatrix = performance.getSaleMatrix().substring(0, stall);
        }
        if(type.equals("second")){
            saleMatrix = performance.getSaleMatrix().substring(stall, second);
        }
        if(type.equals("third")){
            saleMatrix = performance.getSaleMatrix().substring(second, third);
        }
        if(type.equals("fourth")){
            saleMatrix = performance.getSaleMatrix().substring(third, fourth);
        }
        modelMap.addAttribute("stadium", stadium);
        modelMap.addAttribute("performance", performance);
        modelMap.addAttribute("type", type);
        modelMap.addAttribute("price", price);
        modelMap.addAttribute("saleMatrix", saleMatrix);
        return "stadium/pickSeat";
    }

    @RequestMapping(value = "/performance/checkTicket")
    public String checkTicket(ModelMap modelMap, @ModelAttribute("id") int id, @ModelAttribute("code") String code,
                              @ModelAttribute("ticketId") int ticketId){
        Stadium stadium = stadiumService.getBycode(code);
        Performance performance = performanceService.findById(id);
        modelMap.addAttribute("stadium", stadium);
        modelMap.addAttribute("performance", performance);
        if(ticketId>0){
            Ticket ticket = performanceService.checkTicket(ticketId, id);
            if(ticket == null){
                modelMap.addAttribute("wrongPerformance", "wrongPerformance");
                return "stadium/checkTicket";
            }

            modelMap.addAttribute("correct", "correct");
            modelMap.addAttribute("ticket", ticket);
            return "stadium/checkTicket";
        }
        modelMap.addAttribute("correct", "correct");
        return "stadium/checkTicket";
    }

    @RequestMapping(value = "/performance/memberCheck")
    public @ResponseBody int memberCheck(@ModelAttribute("email") String email){
        Member member = memberService.getMemberByEmail(email);
        if (member == null) {
            return -1;
        }
        return member.getRank();
    }

    @RequestMapping(value = "/purchaseWithSeat")
    public String purchaseAndOrderSeat(ModelMap modelMap, @ModelAttribute("email") String email, @ModelAttribute("id") int id,
                                       @ModelAttribute("type") String type, @ModelAttribute("code") String code,
                                       @ModelAttribute("accountName") String accountName, @ModelAttribute("seats") String seats,
                                       @ModelAttribute("accountPassword") String password, @ModelAttribute("sum") double sum,
                                       @ModelAttribute("number") int number){
        Account account = accountService.verify(accountName, password);
        if(account == null){
            modelMap.addAttribute("id", id);
            modelMap.addAttribute("code", code);
            return "error/accountWrong";
        }
        if(!accountService.checkRemain(accountName, 0-sum)){
            modelMap.addAttribute("id", id);
            modelMap.addAttribute("code", code);
            return "error/remainNotEnough";
        }
        accountService.changeRemain(accountName, 0-sum);
        accountService.changeRemain("tikey", sum);
        String[] seatInfo = seats.split(",");
        int[][] seatDetail = new int[6][2];
        for (int i = 0; i < seatInfo.length; i++) {
            String[] temp = seatInfo[i].split("排");
            seatDetail[i][0] = Integer.parseInt(temp[0]);
            seatDetail[i][1] = Integer.parseInt(temp[1].split("座")[0]);
        }
        double singlePrice = sum/number;
        List<Ticket> drawList = new ArrayList<Ticket>();
        for (int i = 0; i < number; i++) {
            Ticket ticket = performanceService.drawTicket(id, singlePrice, email, TicketType.getType(type));
            ticket = performanceService.pickSeat(id, ticket.getId(), seatDetail[i][0], seatDetail[i][1]);
            drawList.add(ticket);
        }
        Stadium stadium = stadiumService.getBycode(code);
        modelMap.addAttribute("id", id);
        modelMap.addAttribute("stadium", stadium);
        modelMap.addAttribute("drawList", drawList);
        return "stadium/drawTickets";
    }

    @RequestMapping(value = "/performance/complete")
    public @ResponseBody String completePerformance(@ModelAttribute("code") String code, @ModelAttribute("id") int id){
        performanceService.endSale(id);
        return "success";
    }

    @RequestMapping(value = "/performance/distribute")
    public @ResponseBody String distribute(@ModelAttribute("id") int id){
        performanceService.distribute(id);
        return "success";
    }

    @RequestMapping(value = "/finance")
    public String finance(ModelMap modelMap, @ModelAttribute("code") String code){
        Stadium stadium = stadiumService.getBycode(code);
        double[] statistic = recordService.getMonthIncomeByStadium(code);
        modelMap.addAttribute("stadium", stadium);
        modelMap.addAttribute("statistic", statistic);
        return "stadium/finance";
    }

    @RequestMapping(value = "/performance/statistics")
    public String statistics(ModelMap modelMap, @ModelAttribute("code") String code, @ModelAttribute("id") int id){
        Stadium stadium = stadiumService.getBycode(code);
        Map<String, Integer> result = performanceService.getStatisticsData(id);
        modelMap.addAttribute("unseated", result.get(TicketState.Unseated.toString()));
        modelMap.addAttribute("unused", result.get(TicketState.Unused.toString()));
        modelMap.addAttribute("refunded", result.get(TicketState.Refunded.toString()));
        modelMap.addAttribute("used", result.get(TicketState.Used.toString()));
        modelMap.addAttribute("emptys", result.get("Empty"));
        modelMap.addAttribute("stadium", stadium);
        return "stadium/performance_statistic";
    }
}
