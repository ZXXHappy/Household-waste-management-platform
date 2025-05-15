package com.example.mapper;

import com.example.entity.Community;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface CommunityMapper {

    int insert(Community community);

    void updateById(Community community);

    void deleteById(Integer id);

    @Select("select * from `community` where id = #{id}")
    Community selectById(Integer id);

    List<Community> selectAll(Community community);

    @Select("select id from `community` where manager_id = #{managerId}")
    List<Integer> selectIdsBymanagerId(Integer managerId);
}
