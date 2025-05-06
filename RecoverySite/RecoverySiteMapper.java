package com.example.mapper;

import com.example.entity.RecoverySite;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface RecoverySiteMapper {

    int insert(RecoverySite recovery_site);

    void updateById(RecoverySite recovery_site);

    void deleteById(Integer id);

    RecoverySite selectById(Integer id);

    List<RecoverySite> selectAll(RecoverySite recovery_site);

    @Select("select count(*) from recovery_site where community_id = #{communityId}")
    Integer selectCountByCommunityId(Integer communityId);

}
