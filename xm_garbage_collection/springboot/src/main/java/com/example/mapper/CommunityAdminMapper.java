package com.example.mapper;

import com.example.entity.CommunityAdmin;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface CommunityAdminMapper {

    int insert(CommunityAdmin community_admin);

    void updateById(CommunityAdmin community_admin);

    void deleteById(Integer id);

    @Select("select * from `community_admin` where id = #{id}")
    CommunityAdmin selectById(Integer id);

    List<CommunityAdmin> selectAll(CommunityAdmin community_admin);

    @Select("select * from `community_admin` where username = #{username}")
    CommunityAdmin selectByUsername(String username);

}
