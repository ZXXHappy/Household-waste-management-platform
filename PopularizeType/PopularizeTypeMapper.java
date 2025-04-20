package com.example.mapper;

import com.example.entity.PopularizeType;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface PopularizeTypeMapper {

    int insert(PopularizeType popularize_type);

    void updateById(PopularizeType popularize_type);

    void deleteById(Integer id);

    @Select("select * from `popularize_type` where id = #{id}")
    PopularizeType selectById(Integer id);

    List<PopularizeType> selectAll(PopularizeType popularize_type);

}
