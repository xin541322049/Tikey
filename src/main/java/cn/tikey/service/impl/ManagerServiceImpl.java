package cn.tikey.service.impl;

import cn.tikey.dao.ManagerRepository;
import cn.tikey.dao.ModificationRepository;
import cn.tikey.dao.StadiumRepository;
import cn.tikey.entity.Manager;
import cn.tikey.entity.Modification;
import cn.tikey.entity.Stadium;
import cn.tikey.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ManagerServiceImpl implements ManagerService {

    @Autowired
    private ManagerRepository managerRepository;
    @Autowired
    private StadiumRepository stadiumRepository;
    @Autowired
    private ModificationRepository modificationRepository;

    public Manager logIn(String id, String password) {
        return managerRepository.findByIdAndPassword(id, password);
    }

    public Stadium acceptModification(int id) {
        Modification modification = modificationRepository.findOne(id);
        Stadium stadium = stadiumRepository.findByStadiumCode(modification.getStadiumCode());
        stadium.changeInfo(modification);
        stadiumRepository.save(stadium);
        modificationRepository.delete(id);
        return stadium;
    }

    public List<Modification> getAllModification() {
        return modificationRepository.findAll();
    }
}
