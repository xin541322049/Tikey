package cn.tikey.controller;

import cn.tikey.entity.Coupon;
import cn.tikey.entity.Member;
import cn.tikey.entity.Ticket;
import cn.tikey.exceptions.NoMemberException;
import cn.tikey.exceptions.WrongPasswordException;
import cn.tikey.helper.CouponType;
import cn.tikey.helper.Coupons;
import cn.tikey.helper.MemberState;
import cn.tikey.helper.TicketState;
import cn.tikey.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
@RequestMapping(value = "/tikey/member")
public class MemberController {

    @Autowired
    private MemberService memberService;
    @Autowired
    private CouponService couponService;
    @Autowired
    private TicketService ticketService;

    @RequestMapping(value = "/register/check")
    public @ResponseBody String memberExistenceCheck(@ModelAttribute("email")String email){
        Member existed = memberService.getMemberByEmail(email);
        if(existed == null){
            return "success";
        }
        else{
            return "existed";
        }
    }

    @RequestMapping(value = "/register")
    public String register(@ModelAttribute("email") String email,
                           @ModelAttribute("password") String password, @ModelAttribute("name") String name){
        memberService.register(email, password, name);
        return "member/register";
    }

    @RequestMapping(value = "/activate")
    public String activateMember(@RequestParam(value = "activateTime") String activateTime,
                                 @RequestParam(value = "email") String email){
        Long currTime = System.currentTimeMillis();
        Long actiTime = Long.parseLong(activateTime);
        Member member = memberService.getMemberByEmail(email);
        if(member!=null) {
            if(member.getMemberState() == MemberState.Inactive) {
                if(actiTime > currTime) {
                    memberService.activateMember(member);
                }
                else {
                    return "error/invalid";
                }
            }
            else {
                //已经被激活的重复点链接
                return "error/invalid";
            }
            //u为空
        } else {
            return "error/invalid";
        }
        System.out.println("activated");
        return "member/activate";
    }

    @RequestMapping(value = "/login/check")
    public @ResponseBody String logInCheck(ModelMap modelMap, @ModelAttribute("email") String email,
                                      @ModelAttribute("password") String password){
        Member member = null;
        try {
            member = memberService.logIn(email, password);
        } catch (NoMemberException e) {
            return "no member";
        } catch (WrongPasswordException e) {
            return "wrong password";
        }
        if(member.getMemberState()==MemberState.Invalid){
            return "canceled member";
        }
        modelMap.addAttribute("member", member);
        return "success";
    }

    @RequestMapping(value = "/login")
    public String logIn(ModelMap modelMap, @ModelAttribute("email") String email){
       Member member = memberService.getMemberByEmail(email);
       modelMap.addAttribute("member", member);
       return "index";
    }

    @RequestMapping(value = "/detail")
    public String getMemberDetail(ModelMap modelMap, @ModelAttribute("email") String email){
        Member member = memberService.getMemberByEmail(email);
        if(member.getMemberState()==MemberState.Invalid){
            return "error/invalid";
        }
        modelMap.addAttribute("member", member);
        double[] rankSaleMap = {0.95, 0.9, 0.85, 0.8, 0.7};
        modelMap.addAttribute("discounts", rankSaleMap[member.getRank()]*10);
        return "member/information";
    }

    @RequestMapping(value = "/changeName")
    public @ResponseBody String changeName(ModelMap modelMap, @ModelAttribute("email") String email,
                                           @ModelAttribute("name") String name){
        Member member = memberService.getMemberByEmail(email);
        member.setName(name);
        memberService.changeMemberInfo(member);
        modelMap.addAttribute("member", member);
        return "success";
    }

    @RequestMapping(value = "/changePassword")
    public @ResponseBody String changePassword(ModelMap modelMap,
                                               @ModelAttribute("email") String email,
                                               @ModelAttribute("oldPassword") String oldPassword,
                                               @ModelAttribute("newPassword") String newPassword){
        Member member = memberService.getMemberByEmail(email);
        if(member.getPassword().equals(oldPassword)){
            member.setPassword(newPassword);
            memberService.changeMemberInfo(member);
            modelMap.addAttribute("member", member);
            return "success";
        }
        else{
            return "fail";
        }
    }

    @RequestMapping(value = "/cancel")
    public String cancelMember(ModelMap modelMap, @ModelAttribute("email") String email){
        Member member = memberService.getMemberByEmail(email);
        memberService.cancelMember(member);
        return "index";
    }

    @RequestMapping(value = "/coupons")
    public String coupon(ModelMap modelMap, @ModelAttribute("email") String email){
        List<CouponType> couponTypeList = couponService.getCouponTypes();
        List<Coupon> couponList = couponService.getMemberCoupon(email);
        Member member = memberService.getMemberByEmail(email);
        modelMap.addAttribute("member", member);
//        modelMap.addAttribute("couponList", couponList);
//        modelMap.addAttribute("couponTypeList", couponTypeList);
        Map<String, Integer> map = new HashMap<String, Integer>();
        Map<String, CouponType> values = new HashMap<String, CouponType>();
        for(Coupon coupon : couponList){
            if(map.containsKey(coupon.getCouponName())){
                map.put(coupon.getCouponName(), map.get(coupon.getCouponName()) + 1);
            }else {
                map.put(coupon.getCouponName(), 1);
            }
        }

        for(CouponType couponType : couponTypeList){
            values.put(couponType.getName(),couponType);
        }
        List<Coupons> couponsList = new ArrayList<Coupons>();
        for(String s : values.keySet()){
            couponsList.add(new Coupons(s,values.get(s).getValue(),map.get(s) == null ? 0 : map.get(s), values.get(s).getDiscounts(),values.get(s).getCondition()));
        }
        modelMap.addAttribute("couponList", couponsList);
        return "member/coupon";
    }

    @RequestMapping(value = "/coupon/convert")
    public String couponConvert(ModelMap modelMap, @ModelAttribute("email") String email,
                                @ModelAttribute("name") String name, @ModelAttribute("condition") String condition){
        Member member = memberService.convertCoupon(email, Integer.parseInt(condition));
        couponService.convertCoupon(email, CouponType.getCouponType(name));
        return "redirect:/tikey/member/coupons?email="+email;
    }

    @RequestMapping(value = "/tickets")
    public String getTicketList(ModelMap modelMap, @ModelAttribute("email") String email, @ModelAttribute("page1") String page1,
    @ModelAttribute("page2") String page2, @ModelAttribute("page3") String page3, @ModelAttribute("page4") String page4, @ModelAttribute("index") String index){
        Member member = memberService.getMemberByEmail(email);
        List<Ticket> unusedList = ticketService.findByMemberEmailAndState(email, TicketState.Unused);
        List<Ticket> unseatedList = ticketService.findByMemberEmailAndState(email, TicketState.Unseated);
        List<Ticket> usedList = ticketService.findByMemberEmailAndState(email, TicketState.Used);
        List<Ticket> refundedList = ticketService.findByMemberEmailAndState(email, TicketState.Refunded);
        Collections.sort(unusedList, new Comparator<Ticket>() {
            public int compare(Ticket o1, Ticket o2) {
                return o2.getSaleTime().compareTo(o1.getSaleTime());
            }
        });
        modelMap.addAttribute("member", member);
        modelMap.addAttribute("unusedList", unusedList);
        modelMap.addAttribute("unseatedList", unseatedList);
        modelMap.addAttribute("usedList", usedList);
        modelMap.addAttribute("refundedList", refundedList);
        modelMap.addAttribute("page1",!page1.equals("") ? Integer.parseInt(page1) : 0);
        modelMap.addAttribute("page2",!page2.equals("") ? Integer.parseInt(page2) : 0);
        modelMap.addAttribute("page3",!page3.equals("") ? Integer.parseInt(page3) : 0);
        modelMap.addAttribute("page4",!page4.equals("") ? Integer.parseInt(page4) : 0);
        modelMap.addAttribute("index",!index.equals("") ? Integer.parseInt(index) : 0);
        return "member/ticket_list";
    }

    @RequestMapping(value = "/statistics")
    public String statistics(ModelMap modelMap, @ModelAttribute("email") String email){
        modelMap.addAttribute("totalConsumeAmount", memberService.getTotalConsumeAmount(email));
        modelMap.addAttribute("totalRefundAmount", memberService.getTotalRefundAmount(email));
        modelMap.addAttribute("totalTicketNumber", memberService.getTotalTicketNumber(email));
        modelMap.addAttribute("totalUsedTicket", memberService.getTotalUsedTicket(email));
        return "member/statistics";
    }

}
