package com.example.mapper;

import com.example.entity.GarbageLaunch;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface GarbageLaunchMapper {

    int insert(GarbageLaunch garbage_launch);

    void updateById(GarbageLaunch garbage_launch);

    void deleteById(Integer id);

    @Select("select * from `garbage_launch` where id = #{id}")
    GarbageLaunch selectById(Integer id);

    List<GarbageLaunch> selectAll(GarbageLaunch garbage_launch);

}
