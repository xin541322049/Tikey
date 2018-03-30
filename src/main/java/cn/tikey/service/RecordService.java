package cn.tikey.service;

import cn.tikey.entity.Record;

import java.util.List;

public interface RecordService {
    void insertRecord(Record record);
    List<Record> getByStadium(String code);
    List<Record> getAll();
    double[] getMonthIncomeByStadium(String code);
    double[] getMonthIncome();
}
