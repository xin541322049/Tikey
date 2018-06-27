package cn.tikey.dao;

import cn.tikey.entity.Manager;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.ResponseBody;

@ResponseBody
public interface ManagerRepository extends JpaRepository<Manager, String> {
    Manager findByIdAndPassword(String id, String password);
}
