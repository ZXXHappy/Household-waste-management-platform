package com.example.service;

import cn.hutool.core.util.StrUtil;
import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.entity.RecoverySite;
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
public class RecoverySiteService {

    @Resource
    private RecoverySiteMapper recoverySiteMapper;

    public void add(RecoverySite recoverySite) {
        Account currentUser = TokenUtils.getCurrentUser();
        recoverySite.setManagerId(currentUser.getId());
        if (StrUtil.isBlank(recoverySite.getStatus())) {
            recoverySite.setStatus("运行中");
        }
        recoverySiteMapper.insert(recoverySite);
    }

    public void updateById(RecoverySite recoverySite) {
        recoverySiteMapper.updateById(recoverySite);
    }

    public void deleteById(Integer id) {
        recoverySiteMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            recoverySiteMapper.deleteById(id);
        }
    }

    public RecoverySite selectById(Integer id) {
        return recoverySiteMapper.selectById(id);
    }

    public List<RecoverySite> selectAll(RecoverySite recoverySite) {
        return recoverySiteMapper.selectAll(recoverySite);
    }

    public PageInfo<RecoverySite> selectPage(RecoverySite recoverySite, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.COMMUNITY.name().equals(currentUser.getRole())) {
            recoverySite.setManagerId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<RecoverySite> list = recoverySiteMapper.selectAll(recoverySite);
        return PageInfo.of(list);
    }

}
