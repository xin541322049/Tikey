package cn.tikey.controller;

import cn.tikey.entity.Performance;
import cn.tikey.helper.PerformanceState;
import cn.tikey.helper.PerformanceType;
import cn.tikey.service.MemberService;
import cn.tikey.service.PerformanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.*;

@Controller
public class HomeController {

    @Autowired
    private PerformanceService performanceService;
    @Autowired
    private MemberService memberService;

    @RequestMapping(value = "/tikey")
    public String getHomePage(ModelMap modelMap,
                              @ModelAttribute("genre") String genre,
                              @ModelAttribute("email") String email) {
        // 用户
        if (!email.equals("")) {
            modelMap.addAttribute("member", memberService.getMemberByEmail(email));
        }

        if (genre.equals("")) {
            List<Performance> hotList = performanceService.findByState(PerformanceState.Sale);
            modelMap.addAttribute("hotList", hotList);
        } else {
            List<Performance> hotList = performanceService.findByStateAndType(PerformanceState.Sale, genre);
            modelMap.addAttribute("hotList", hotList);
        }

        modelMap.addAttribute("curType", genre);

        return "index";
    }

    @RequestMapping(value = "/tikey/search")
    public String searchPerformance(ModelMap modelMap,
                                    @ModelAttribute("term") String term,
                                    @ModelAttribute("email") String email,
                                    @ModelAttribute("page") String page,
                                    @ModelAttribute("sort") int sortType,
                                    @ModelAttribute("genre") String genre) {
        if (!email.equals("")) {
            modelMap.addAttribute("member", memberService.getMemberByEmail(email));
        }
        if (page.equals("")) {
            page = "0";
        }
        List<Performance> result = performanceService.findByNameContaining(term);
        for (Performance performance : performanceService.findByDescriptionContaining(term)
                ) {
            boolean find = false;
            for (Performance addPerformance : result
                    ) {
                if (performance.getId() == addPerformance.getId()) {
                    find = true;
                    break;
                }
            }
            if (!find) {
                result.add(performance);
            }
        }
        if (!genre.equals("")) {
            PerformanceType type = null;
            if (genre.equals("演唱会")) {
                type = PerformanceType.Concert;
            }
            if (genre.equals("体育赛事")) {
                type = PerformanceType.Competition;
            }
            if (genre.equals("音乐会")) {
                type = PerformanceType.Music;
            }
            if (genre.equals("歌剧")) {
                type = PerformanceType.Opera;
            }
            if (genre.equals("话剧")) {
                type = PerformanceType.Drama;
            }
            if (genre.equals("儿童亲子")) {
                type = PerformanceType.ChildPlay;
            }
            if (genre.equals("舞蹈")) {
                type = PerformanceType.Dance;
            }
            if (genre.equals("马戏")) {
                type = PerformanceType.Circus;
            }
            List<Performance> temp = new ArrayList<Performance>();
            for (Performance performance : result
                    ) {
                if (performance.getType() == type) {
                    temp.add(performance);
                }
            }
            result = temp;
        }

        // 按照时间由近到远排序
        if (sortType == 1) {
            Collections.sort(result, new Comparator<Performance>() {
                public int compare(Performance o1, Performance o2) {
                    return o2.getShowTime().compareTo(o1.getShowTime());
                }
            });
        // 按照价格低到高排序
        } else if (sortType == 2) {
            Collections.sort(result, new Comparator<Performance>() {
                public int compare(Performance o1, Performance o2) {
                    return (int)o1.getStallPrice() - (int)o2.getStallPrice();
                }
            });
        // 按照价格高到低排序
        } else if (sortType == 3){
            Collections.sort(result, new Comparator<Performance>() {
                public int compare(Performance o1, Performance o2) {
                    return (int)o2.getStallPrice() - (int)o1.getStallPrice();
                }
            });
        }

        modelMap.addAttribute("result", result);
        modelMap.addAttribute("page", Integer.parseInt(page));
        modelMap.addAttribute("search_term", term);
        modelMap.addAttribute("genre", genre);
        modelMap.addAttribute("sortType", sortType);
        return "performance/search";
    }
}
