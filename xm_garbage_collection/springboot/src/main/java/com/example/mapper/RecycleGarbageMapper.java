package com.example.mapper;

import com.example.entity.RecycleGarbage;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface RecycleGarbageMapper {

    int insert(RecycleGarbage recycle_garbage);

    void updateById(RecycleGarbage recycle_garbage);

    void deleteById(Integer id);

    @Select("select * from `recycle_garbage` where id = #{id}")
    RecycleGarbage selectById(Integer id);

    List<RecycleGarbage> selectAll(RecycleGarbage recycle_garbage);

}
