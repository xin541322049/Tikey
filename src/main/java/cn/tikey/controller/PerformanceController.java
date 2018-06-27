package cn.tikey.controller;

import cn.tikey.entity.*;
import cn.tikey.helper.PerformanceState;
import cn.tikey.helper.PerformanceType;
import cn.tikey.helper.TicketType;
import cn.tikey.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping(value = "/tikey/performance")
public class PerformanceController {

    @Autowired
    private StadiumService stadiumService;
    @Autowired
    private PerformanceService performanceService;
    @Autowired
    private MemberService memberService;
    @Autowired
    private CouponService couponService;
    @Autowired
    private AccountService accountService;

    @RequestMapping(value = "/poster/upload")
    public @ResponseBody  Map<String, Object> uploadPoster(@RequestParam MultipartFile posterFile) throws IOException {
        String oldFileName = posterFile.getOriginalFilename(); // 获取上传文件的原名
//      System.out.println(oldFileName);
        // 存储图片的虚拟本地路径（这里需要配置tomcat的web模块路径，双击猫进行配置）
        String saveFilePath = "/Users/apple/学习/J2EE/Tikey/target/Tikey/posters";
        // 上传图片
        if (posterFile != null && oldFileName != null && oldFileName.length() > 0) {
            // 新的图片名称
            String newFileName = UUID.randomUUID() + oldFileName.substring(oldFileName.lastIndexOf("."));
            // 新图片
            File newFile = new File(saveFilePath + "/" + newFileName);
            // 将内存中的数据写入磁盘
            posterFile.transferTo(newFile);
            // 将新图片名称返回到前端
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("success", "成功啦");
            map.put("url", newFileName);
            return map;
        } else {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("error", "图片不合法");
            return map;
        }
    }

    @RequestMapping("/apply/{code}")
    public String apply(ModelMap modelMap, @ModelAttribute("name") String name,
                        @ModelAttribute("description") String description, @ModelAttribute("actors") String actors,
                        @ModelAttribute("type") String type, @ModelAttribute("showtime") String showTime,
                        @ModelAttribute("stallPrice") double stallPrice, @ModelAttribute("secondPrice") double secondPrice,
                        @ModelAttribute("thirdPrice") double thirdPrice, @ModelAttribute("fourthPrice") double fourthPrice,
                        @ModelAttribute("poster") String poster, @PathVariable("code") String code) throws IOException {

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date showtime = null;
        try {
            showtime = formatter.parse(showTime);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        Stadium stadium = stadiumService.getBycode(code);
        PerformanceType typeOfP = null;
        if(type.equals("演唱会")){
            typeOfP = PerformanceType.Concert;
        }
        if(type.equals("体育比赛")){
            typeOfP = PerformanceType.Competition;
        }
        if(type.equals("歌剧")){
            typeOfP = PerformanceType.Opera;
        }
        if(type.equals("马戏")){
            typeOfP = PerformanceType.Circus;
        }
        if(type.equals("话剧")){
            typeOfP = PerformanceType.Drama;
        }
        if(type.equals("舞蹈")){
            typeOfP = PerformanceType.Dance;
        }
        if(type.equals("儿童亲子")){
            typeOfP = PerformanceType.ChildPlay;
        }
        if(type.equals("音乐会")){
            typeOfP = PerformanceType.Music;
        }
        Performance performance = new Performance(name, description, actors, "/posters/"+poster,
                showtime, stadium, PerformanceState.BeingAccepted, typeOfP, stallPrice, secondPrice, thirdPrice, fourthPrice);
        if(stadium.getPerformances() == null){
            ArrayList<Performance> performances = new ArrayList<Performance>();
            performances.add(performance);
            stadium.setPerformances(performances);
        }
        else{
            stadium.getPerformances().add(performance);
        }
        stadiumService.changeStadiumInfo(stadium);
        performanceService.apply(performance);
//        modelMap.addAttribute("stadium", stadium);
        return "redirect:/tikey/stadium/performanceList?code="+code;
    }

    @RequestMapping(value = "/accept/{id}")
    public String accept(@ModelAttribute("code") String code, @PathVariable("id") int id){
        performanceService.accept(id);
        return "redirect:/tikey/manager/stadium/"+code;
    }

    @RequestMapping(value = "/detail/{id}")
    public String accept(ModelMap modelMap, @ModelAttribute("email") String email,
                         @PathVariable("id") int id){
        Performance performance = performanceService.findById(id);
        if(!email.equals("")){
            modelMap.addAttribute("email", email);
            Member member = memberService.getMemberByEmail(email);
            modelMap.addAttribute("member", member);
            List<Coupon> counponList = couponService.getMemberCoupon(email);
            modelMap.addAttribute("couponList", counponList);
        }
        modelMap.addAttribute("performance", performance);
        return "performance/detail";
    }

    @RequestMapping(value = "/pickSeat")
    public String pickSeat(ModelMap modelMap, @ModelAttribute("id") int id, @ModelAttribute("code") String code,
                           @ModelAttribute("type") String type, @ModelAttribute("price") double price,
                           @ModelAttribute("email") String email){
        Stadium stadium = stadiumService.getBycode(code);
        Performance performance = performanceService.findById(id);
        Member member = memberService.getMemberByEmail(email);
        List<Coupon> couponList = couponService.getMemberCoupon(email);
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
        modelMap.addAttribute("member", member);
        modelMap.addAttribute("couponList", couponList);
        modelMap.addAttribute("type", type);
        modelMap.addAttribute("price", price);
        modelMap.addAttribute("saleMatrix", saleMatrix);
        return "performance/pickSeat";
    }

    @RequestMapping(value = "/purchaseWithSeat")
    public String purchaseAndOrderSeat(ModelMap modelMap, @ModelAttribute("email") String email, @ModelAttribute("id") int id,
                           @ModelAttribute("type") String type,
                           @ModelAttribute("accountName") String accountName, @ModelAttribute("seats") String seats,
                           @ModelAttribute("accountPassword") String password, @ModelAttribute("sum") double sum,
                           @ModelAttribute("couponId") int couponId, @ModelAttribute("number") int number){
        Account account = accountService.verify(accountName, password);
        if(account == null){
            modelMap.addAttribute("email", email);
            modelMap.addAttribute("id", id);
            return "error/accountWrong";
        }
        if(!accountService.checkRemain(accountName, 0-sum)){
            modelMap.addAttribute("email", email);
            modelMap.addAttribute("id", id);
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
        if(couponId != -1){
            couponService.consumeCoupon(couponId);
        }
        int credit = (int)(sum);
        Member member = memberService.getMemberByEmail(email);
        member.setCredits(member.getCredits()+credit);
        member.setValidCredit(member.getValidCredit()+credit);
        memberService.changeMemberInfo(member);
        double singlePrice = sum/number;
        for (int i = 0; i < number; i++) {
            Ticket ticket = performanceService.drawTicket(id, singlePrice, email, TicketType.getType(type));
            performanceService.pickSeat(id, ticket.getId(), seatDetail[i][0], seatDetail[i][1]);
        }
        return "redirect:/tikey/member/tickets?email="+email;
    }

    @RequestMapping(value = "/cancel")
    public String cancel(ModelMap modelMap, @ModelAttribute("id") int id, @ModelAttribute("email") String email){
        modelMap.addAttribute("id", id);
        modelMap.addAttribute("email", email);
        return "error/outTime";
    }

    @RequestMapping(value = "/purchase")
    public String purchase(ModelMap modelMap, @ModelAttribute("email") String email, @ModelAttribute("id") int id,
                           @ModelAttribute("type") String type,
                           @ModelAttribute("accountName") String accountName,
                           @ModelAttribute("accountPassword") String password, @ModelAttribute("sum") double sum,
                           @ModelAttribute("couponId") int couponId, @ModelAttribute("number") int number){
        Performance performance = performanceService.findById(id);
        TicketType t = TicketType.getType(type);
        switch (t){
            case Stall:
                if(number > performance.getStallSeats()){
                    return "error/noTicket";
                } else {
                    break;
                }
            case Second:
                if(number > performance.getSecondSeats()){
                    return "error/noTicket";
                } else {
                    break;
                }
            case Third:
                if(number > performance.getThirdSeats()){
                    return "error/noTicket";
                } else {
                    break;
                }
            case Fourth:
                if(number > performance.getStallSeats()){
                    return "error/noTicket";
                } else {
                    break;
                }
        }
        Account account = accountService.verify(accountName, password);
        if(account == null){
            modelMap.addAttribute("email", email);
            modelMap.addAttribute("id", id);
            return "error/accountWrong";
        }
        accountService.changeRemain(accountName, 0-sum);
        accountService.changeRemain("tikey", sum);
        int credit = (int)(sum);
        Member member = memberService.getMemberByEmail(email);
        member.setCredits(member.getCredits()+credit);
        member.setValidCredit(member.getValidCredit()+credit);
        memberService.changeMemberInfo(member);
        if(couponId != -1){
            couponService.consumeCoupon(couponId);
        }
        double singlePrice = sum/number;
        for (int i = 0; i < number; i++) {
            Ticket ticket = performanceService.drawTicket(id, singlePrice, email, TicketType.getType(type));
        }
        return "redirect:/tikey/member/tickets?email="+email;
    }

    @RequestMapping(value = "/refund/checkAmount")
    public @ResponseBody double checkRefundAmount(@ModelAttribute("id") int id){
        return performanceService.checkRefundAmount(id);
    }

    @RequestMapping(value = "/refund")
    public @ResponseBody String checkRefundAmount(@ModelAttribute("accountName") String accountName,
                                                  @ModelAttribute("accountPassword") String accountPassword,
                                                  @ModelAttribute("id") int id, @ModelAttribute("email") String email){
        Account account = accountService.verify(accountName, accountPassword);
        if(account == null){
            return "fail";
        }
        Ticket ticket = performanceService.refundTicket(id);
        accountService.changeRemain("tikey", 0-ticket.getRefund());
        accountService.changeRemain(accountName, ticket.getRefund());
        int credit = (int)(ticket.getRefund());
        Member member = memberService.getMemberByEmail(email);
        member.setCredits(member.getCredits()-credit);
        member.setValidCredit(member.getValidCredit()-credit);
        memberService.changeMemberInfo(member);
        return "success";
    }
}
