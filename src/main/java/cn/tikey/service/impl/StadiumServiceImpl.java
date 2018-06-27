package cn.tikey.service.impl;

import cn.tikey.dao.ModificationRepository;
import cn.tikey.dao.PerformanceRepository;
import cn.tikey.dao.StadiumRepository;
import cn.tikey.entity.Modification;
import cn.tikey.entity.Performance;
import cn.tikey.entity.Stadium;
import cn.tikey.helper.StadiumState;
import cn.tikey.helper.XYChartStatistics;
import cn.tikey.service.StadiumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class StadiumServiceImpl implements StadiumService {

    @Autowired
    private StadiumRepository stadiumRepository;
    @Autowired
    private ModificationRepository modificationRepository;
    @Autowired
    private PerformanceRepository performanceRepository;

    public Stadium logIn(String id, String password) {
        return stadiumRepository.findByStadiumCodeAndPassword(id, password);
    }

    public Stadium register(String name, String password, String province, String city, String address
            , String accountName
            , int rowOfStall, int rowOfSecondFloor, int rowOfThirdFloor, int rowOfFourthFloor
            , int colOfStall, int colOfSecondFloor, int colOfThirdFloor, int colOfFourthFloor) {
        Stadium stadium = new Stadium(name, password, province, city, address
                , accountName, rowOfStall, rowOfSecondFloor, rowOfThirdFloor, rowOfFourthFloor
                , colOfStall, colOfSecondFloor, colOfThirdFloor, colOfFourthFloor, StadiumState.unAccepted);
        stadium.setStadiumCode(" ");
        stadiumRepository.save(stadium);
        String stadiumId = stadium.getId()+"";
        Random random = new Random();
        for (int i = stadiumId.length(); i < 8; i++) {
            char c = (char)('A'+Math.abs(random.nextInt())%26);
            stadiumId = c+stadiumId;
        }
        stadium.setStadiumCode(stadiumId);
        stadiumRepository.save(stadium);
        return stadium;
    }

    public Stadium getBycode(String code) {
        return stadiumRepository.findByStadiumCode(code);
    }

    public Stadium changeStadiumInfo(Stadium stadium) {
        stadiumRepository.save(stadium);
        return stadium;
    }

    public List<Stadium> findByNameContaining(String name) {
        return stadiumRepository.findByNameContaining(name);
    }

    public List<Stadium> findByAddressContaining(String address) {
        return stadiumRepository.findByAddressContaining(address);
    }

    public List<Stadium> findByProvinceAndCity(String province, String city) {
        return stadiumRepository.findByProvinceAndCity(province, city);
    }

    public List<Stadium> findByState(StadiumState stadiumState) {
        return stadiumRepository.findByState(stadiumState);
    }

    public Page<Performance> findByState(Pageable pageable,StadiumState state) {
        return stadiumRepository.findByState(pageable, state);
    }

    public void applyToChangeInfo(Modification modification) {
        modificationRepository.save(modification);
    }

    public List<XYChartStatistics<String, Integer>> performanceDistribution() {
        List<Performance> performances = performanceRepository.findAll();
        HashMap<String, Integer> result = new HashMap<String, Integer>();
        for (Performance performance: performances
             ) {
            if(result.containsKey(performance.getShowPlace().getName())){
                result.put(performance.getShowPlace().getName(), result.get(performance.getShowPlace().getName())+1);
            }
            else {
                result.put(performance.getShowPlace().getName(), 1);
            }
        }
        List<XYChartStatistics<String, Integer>> statistic = new ArrayList<XYChartStatistics<String, Integer>>();
        for (String key: result.keySet()
             ) {
            statistic.add(new XYChartStatistics<String, Integer>(key, result.get(key)));
        }
        return statistic;
    }
}
