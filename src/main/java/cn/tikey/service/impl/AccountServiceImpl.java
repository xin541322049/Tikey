package cn.tikey.service.impl;

import cn.tikey.dao.AccountRepository;
import cn.tikey.entity.Account;
import cn.tikey.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AccountServiceImpl implements AccountService{

    @Autowired
    private AccountRepository accountRepository;

    public Account verify(String name, String password) {
        return accountRepository.findByNameAndPassword(name, password);
    }

    public Account changeRemain(String name, double change) {
        Account account = accountRepository.findOne(name);
        account.setRemains(account.getRemains()+change);
        accountRepository.save(account);
        return account;
    }

    public boolean checkRemain(String name, double change) {
        Account account = accountRepository.findOne(name);
        if((account.getRemains()+change)>0){
            return true;
        }
        return false;
    }
}
