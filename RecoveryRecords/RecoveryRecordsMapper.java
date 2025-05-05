package com.example.mapper;

import com.example.entity.RecoveryRecords;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface RecoveryRecordsMapper {

    int insert(RecoveryRecords recovery_records);

    void updateById(RecoveryRecords recovery_records);

    void deleteById(Integer id);

    @Select("select * from `recovery_records` where id = #{id}")
    RecoveryRecords selectById(Integer id);

    List<RecoveryRecords> selectAll(RecoveryRecords recovery_records);

}
