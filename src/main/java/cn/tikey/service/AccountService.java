package cn.tikey.service;

import cn.tikey.entity.Account;

public interface AccountService {
    Account verify(String name, String password);
    Account changeRemain(String name, double change);
    boolean checkRemain(String name, double change);
}
