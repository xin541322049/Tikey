package cn.tikey.dao;

import cn.tikey.entity.Performance;
import cn.tikey.helper.PerformanceState;
import cn.tikey.helper.PerformanceType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.util.List;

@Repository
public interface PerformanceRepository extends JpaRepository<Performance, Integer> {
    List<Performance> findByNameContainingAndState(String name, PerformanceState state);
    List<Performance> findByDescriptionContainingAndState(String description, PerformanceState state);
    List<Performance> findByShowTime(Date showTime);
    List<Performance> findByState(PerformanceState state);
    List<Performance> findByStateAndType(PerformanceState state, PerformanceType type);
    Page<Performance> findByType(Pageable pageable, PerformanceType type);
    @Modifying
    @Query("update Performance p set p.state = ?1 where p.id = ?2")
    int setStateFor(PerformanceState state, int id);
}
