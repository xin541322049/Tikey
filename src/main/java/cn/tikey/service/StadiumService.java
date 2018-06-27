package cn.tikey.service;

import cn.tikey.entity.Modification;
import cn.tikey.entity.Performance;
import cn.tikey.entity.Stadium;
import cn.tikey.helper.StadiumState;
import cn.tikey.helper.XYChartStatistics;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

public interface StadiumService {
    Stadium logIn(String id, String password);
    Stadium register(String name, String password, String province, String city, String address
            , String accountName
            , int rowOfStall, int rowOfSecondFloor, int rowOfThirdFloor, int rowOfFourthFloor
            , int colOfStall, int colOfSecondFloor, int colOfThirdFloor, int colOfFourthFloor);
    Stadium getBycode(String code);
    Stadium changeStadiumInfo(Stadium stadium);
    List<Stadium> findByNameContaining(String name);
    List<Stadium> findByAddressContaining(String address);
    List<Stadium> findByProvinceAndCity(String province, String city);
    List<Stadium> findByState(StadiumState stadiumState);
    Page<Performance> findByState(Pageable pageable, StadiumState state);
    void applyToChangeInfo(Modification change);
    List<XYChartStatistics<String, Integer>> performanceDistribution();
}