package cn.tikey.dao;

import cn.tikey.entity.Performance;
import cn.tikey.entity.Stadium;
import cn.tikey.helper.StadiumState;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StadiumRepository extends JpaRepository<Stadium, Integer> {
    List<Stadium> findByNameContaining(String name);
    List<Stadium> findByAddressContaining(String address);
    List<Stadium> findByProvinceAndCity(String province, String city);
    List<Stadium> findByState(StadiumState stadiumState);
    Page<Performance> findByState(Pageable pageable, StadiumState state);
    Stadium findByStadiumCodeAndPassword(String stadiumCode, String password);
    Stadium findByStadiumCode(String stadiumCode);
    @Modifying
    @Query("update Stadium s set s.state = ?1 where s.id = ?2")
    int setStateFor(StadiumState state, int id);
}
