package cn.tikey.service.impl;

import cn.tikey.dao.RecordRepository;
import cn.tikey.entity.Record;
import cn.tikey.service.RecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RecordServiceImpl implements RecordService {

    @Autowired
    private RecordRepository recordRepository;

    public void insertRecord(Record record) {
        recordRepository.save(record);
    }

    public List<Record> getByStadium(String code) {
        return recordRepository.findByCode(code);
    }

    public List<Record> getAll() {
        return recordRepository.findAll();
    }

    public double[] getMonthIncomeByStadium(String code) {
        double[] result = new double[12];
        List<Record> records = recordRepository.findByCode(code);
        for (Record record: records
             ) {
            result[record.getCreateTime().getMonth()] += record.getStadiumIncome();
        }
        return result;
    }

    public double[] getMonthIncome() {
        double[] result = new double[12];
        List<Record> records = recordRepository.findAll();
        for (Record record: records
                ) {
            result[record.getCreateTime().getMonth()] += record.getWebsiteIncome();
        }
        return result;
    }
}
