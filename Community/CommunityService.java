package com.example.service;

import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.entity.Community;
import com.example.mapper.CommunityMapper;
import com.example.mapper.RecoverySiteMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 业务层方法
 */
@Service
public class CommunityService {

    @Resource
    private CommunityMapper communityMapper;
    @Resource
    private RecoverySiteMapper recoverySiteMapper;

    public void add(Community community) {
        communityMapper.insert(community);
    }

    public void updateById(Community community) {
        communityMapper.updateById(community);
    }

    public void deleteById(Integer id) {
        communityMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            communityMapper.deleteById(id);
        }
    }

    public Community selectById(Integer id) {
        return communityMapper.selectById(id);
    }

    public List<Community> selectAll(Community community) {
        List<Community> list = communityMapper.selectAll(community);
        for (Community c : list) {
            Integer communityId = c.getId();
            Integer count = recoverySiteMapper.selectCountByCommunityId(communityId);
            c.setRecoverySiteCount(count);
        }
        return list;
    }

    public PageInfo<Community> selectPage(Community community, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.COMMUNITY.name().equals(currentUser.getRole())) {
            community.setManagerId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Community> list = communityMapper.selectAll(community);
        return PageInfo.of(list);
    }

}
