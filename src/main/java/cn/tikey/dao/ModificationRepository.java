package cn.tikey.dao;

import cn.tikey.entity.Modification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ModificationRepository extends JpaRepository<Modification, Integer> {
}
