package com.example.mapper;

import com.example.entity.Popularize;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface PopularizeMapper {

    int insert(Popularize popularize);

    void updateById(Popularize popularize);

    void deleteById(Integer id);

    @Select("select * from `popularize` where id = #{id}")
    Popularize selectById(Integer id);

    List<Popularize> selectAll(Popularize popularize);

    @Update("update popularize set view_count = view_count+1 where id = #{id}")
    void updateViewCount(Integer id);
}
