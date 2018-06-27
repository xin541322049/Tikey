package cn.tikey.service;

import cn.tikey.entity.Manager;
import cn.tikey.entity.Modification;
import cn.tikey.entity.Stadium;

import java.util.List;

public interface ManagerService {
    Manager logIn(String id, String password);
    Stadium acceptModification(int id);
    List<Modification> getAllModification();
}
