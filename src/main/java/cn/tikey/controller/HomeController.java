package cn.tikey.controller;

import cn.tikey.entity.Performance;
import cn.tikey.helper.PerformanceState;
import cn.tikey.service.MemberService;
import cn.tikey.service.PerformanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private PerformanceService performanceService;
    @Autowired
    private MemberService memberService;

    @RequestMapping(value = "/tikey")
    public String getHomePage(ModelMap modelMap, @ModelAttribute("genre") String genre,
                              @ModelAttribute("email") String email){
        if(genre.equals("")){
            List<Performance> hotList = performanceService.findByState(PerformanceState.Sale);
            modelMap.addAttribute("hotList", hotList);
        }
        else {
            List<Performance> hotList = performanceService.findByStateAndType(PerformanceState.Sale, genre);
            modelMap.addAttribute("hotList", hotList);
        }
        if(!email.equals("")){
            modelMap.addAttribute("member", memberService.getMemberByEmail(email));
        }
        return "index";
    }

    @RequestMapping(value = "/tikey/search")
    public String searchPerformance(ModelMap modelMap, @ModelAttribute("term") String term,
                                    @ModelAttribute("email") String email, @ModelAttribute("page") String page){
        if(!email.equals("")){
            modelMap.addAttribute("member", memberService.getMemberByEmail(email));
        }
        if(page.equals("")){
            page = "0";
        }
        List<Performance> result = performanceService.findByNameContaining(term);
        modelMap.addAttribute("result", result);
        modelMap.addAttribute("page", Integer.parseInt(page));
        modelMap.addAttribute("search_term", term);
        return "performance/search";
    }
}
