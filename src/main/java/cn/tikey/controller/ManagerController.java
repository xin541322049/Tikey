package cn.tikey.controller;

import cn.tikey.entity.*;
import cn.tikey.helper.PerformanceState;
import cn.tikey.helper.StadiumState;
import cn.tikey.helper.TicketState;
import cn.tikey.helper.XYChartStatistics;
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
@RequestMapping(value = "/tikey/manager")
public class ManagerController {

    @Autowired
    private ManagerService managerService;
    @Autowired
    private StadiumService stadiumService;
    @Autowired
    private TicketService ticketService;
    @Autowired
    private AccountService accountService;
    @Autowired
    private PerformanceService performanceService;
    @Autowired
    private RecordService recordService;
    @Autowired
    private MemberService memberService;


    @RequestMapping(value = "/login/check")
    public @ResponseBody String passwordCheck(@ModelAttribute("id") String id,
                                              @ModelAttribute("password") String password){
        Manager manager = managerService.logIn(id, password);
        if(manager == null){
            return "fail";
        }
        else{
            return "success";
        }
    }

    @RequestMapping(value = "/login")
    public String logIn(ModelMap modelMap){
        List<Stadium> valid = stadiumService.findByState(StadiumState.Valid);
        List<Stadium> invalid = stadiumService.findByState(StadiumState.Invalid);
        modelMap.addAttribute("validList", valid);
        modelMap.addAttribute("invalidList", invalid);
        return "manager/stadium_list";
    }

    @RequestMapping(value = "/application")
    public String handleApplication(ModelMap modelMap){
        List<Stadium> apply = stadiumService.findByState(StadiumState.unAccepted);
        modelMap.addAttribute("applyList", apply);
        return "manager/application_list";
    }

    @RequestMapping(value = "/accept/{code}")
    public String acceptStadium(@PathVariable("code") String code){
        Stadium stadium = stadiumService.getBycode(code);
        stadium.setState(StadiumState.Valid);
        stadiumService.changeStadiumInfo(stadium);
        return "redirect:/tikey/manager/application";
    }

    @RequestMapping("/stadium/{code}")
    public String getStadium(ModelMap modelMap, @ModelAttribute("code") String code){
        Stadium stadium = stadiumService.getBycode(code);
        ArrayList<Performance> applying = new ArrayList<Performance>();
        ArrayList<Performance> sale = new ArrayList<Performance>();
        ArrayList<Performance> completed = new ArrayList<Performance>();
        ArrayList<Performance> settled = new ArrayList<Performance>();
        for (Performance performance: stadium.getPerformances()
                ) {
            if(performance.getState() == PerformanceState.Sale){
                sale.add(performance);
            }
            if(performance.getState() == PerformanceState.Completed){
                completed.add(performance);
            }
            if(performance.getState() == PerformanceState.BeingAccepted){
                applying.add(performance);
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
        return "manager/stadium";
    }

    @RequestMapping(value = "/modifications")
    public String handleModification(ModelMap modelMap){
        List<Modification> modifications = managerService.getAllModification();
        modelMap.addAttribute("modificationList", modifications);
        return "manager/modification_list";
    }

    @RequestMapping(value = "/modification/accept/{id}")
    public String acceptModification(@PathVariable("id") int id){
        Stadium stadium = managerService.acceptModification(id);
        return "redirect:/tikey/manager/modifications";
    }

    @RequestMapping(value = "/stadium/settle")
    public @ResponseBody double settle(@ModelAttribute("id") int id){
        double totalAmount = 0;
        List<Ticket> tickets = ticketService.findByPerformanceId(id);
        for (Ticket ticket: tickets
             ) {
            if(ticket.getState()==TicketState.Refunded){
                continue;
            }
            else{
                totalAmount += ticket.getPrice();
            }
        }
        return totalAmount;
    }

    @RequestMapping(value = "/stadium/transport")
    public @ResponseBody String transport(@ModelAttribute("id") int id, @ModelAttribute("code") String code){
        double totalAmount = settle(id)*0.95;
        double remain = settle(id)*0.05;
        Performance performance = performanceService.findById(id);
        performance.setState(PerformanceState.Settled);
        performanceService.apply(performance);
        accountService.changeRemain("tikey", 0-totalAmount);
        Stadium stadium = stadiumService.getBycode(code);
        accountService.changeRemain(stadium.getAccountName(), totalAmount);
        Record record = new Record(id, code, totalAmount, remain);
        recordService.insertRecord(record);
        return "success";
    }

    @RequestMapping(value = "/finance")
    public String finance(ModelMap modelMap){
        double[] statistic = recordService.getMonthIncome();
        modelMap.addAttribute("statistic", statistic);
        return "manager/finance";
    }

    @RequestMapping(value = "/statistics/member")
    public String memberStatistics(ModelMap modelMap){
        int[] statistic = memberService.getMemberRankDistribution();
        modelMap.addAttribute("statistic", statistic);
        return "manager/member_statistics";
    }

    @RequestMapping(value = "/statistics/stadium")
    public String stadiumStatistics(ModelMap modelMap){
        List<XYChartStatistics<String, Integer>> statistic = stadiumService.performanceDistribution();
        modelMap.addAttribute("statistic", statistic);
        return "manager/stadium_statistics";
    }
}
