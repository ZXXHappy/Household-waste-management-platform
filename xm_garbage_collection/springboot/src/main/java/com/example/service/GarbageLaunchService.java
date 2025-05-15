package com.example.service;

import cn.hutool.core.date.DateUtil;
import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.entity.GarbageLaunch;
import com.example.mapper.CommunityMapper;
import com.example.mapper.GarbageLaunchMapper;
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
public class GarbageLaunchService {

    @Resource
    private GarbageLaunchMapper garbageLaunchMapper;
    @Resource
    private CommunityMapper communityMapper;

    public void add(GarbageLaunch garbageLaunch) {
        Account currentUser = TokenUtils.getCurrentUser();
        garbageLaunch.setUserId(currentUser.getId());
        garbageLaunch.setTime(DateUtil.now());
        garbageLaunchMapper.insert(garbageLaunch);
    }

    public void updateById(GarbageLaunch garbageLaunch) {
        garbageLaunchMapper.updateById(garbageLaunch);
    }

    public void deleteById(Integer id) {
        garbageLaunchMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            garbageLaunchMapper.deleteById(id);
        }
    }

    public GarbageLaunch selectById(Integer id) {
        return garbageLaunchMapper.selectById(id);
    }

    public List<GarbageLaunch> selectAll(GarbageLaunch garbageLaunch) {
        return garbageLaunchMapper.selectAll(garbageLaunch);
    }

    public PageInfo<GarbageLaunch> selectPage(GarbageLaunch garbageLaunch, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.COMMUNITY.name().equals(currentUser.getRole())) {
            // 查出当前的社区管理员管理的所有社区的id
            List<Integer> communityIds = communityMapper.selectIdsBymanagerId(currentUser.getId());
            garbageLaunch.setCommunityIds(communityIds);
        }
        if (RoleEnum.USER.name().equals(currentUser.getRole())) {
            garbageLaunch.setUserId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<GarbageLaunch> list = garbageLaunchMapper.selectAll(garbageLaunch);
        return PageInfo.of(list);
    }

}
