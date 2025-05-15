package com.example.service;

import cn.hutool.core.date.DateUtil;
import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.entity.RecoveryRecords;
import com.example.entity.User;
import com.example.mapper.RecoveryRecordsMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 业务层方法
 */
@Service
public class RecoveryRecordsService {

    @Resource
    private RecoveryRecordsMapper recoveryRecordsMapper;
    @Resource
    UserService userService;

    public void add(RecoveryRecords recoveryRecords) {
        recoveryRecords.setStatus("待审核");
        recoveryRecords.setTime(DateUtil.now());
        Account currentUser = TokenUtils.getCurrentUser();
        recoveryRecords.setUserId(currentUser.getId());
        recoveryRecordsMapper.insert(recoveryRecords);
    }

    @Transactional
    public void updateById(RecoveryRecords recoveryRecords) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.COMMUNITY.name().equals(currentUser.getRole())) {
            // 审批通过   发放积分
            if ("通过".equals(recoveryRecords.getStatus())) {
                Integer userId = recoveryRecords.getUserId();
                User user = userService.selectById(userId);
                user.setScore(user.getScore() + recoveryRecords.getScore());
                userService.updateById(user);
            }
        }
        recoveryRecordsMapper.updateById(recoveryRecords);
    }

    public void deleteById(Integer id) {
        recoveryRecordsMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            recoveryRecordsMapper.deleteById(id);
        }
    }

    public RecoveryRecords selectById(Integer id) {
        return recoveryRecordsMapper.selectById(id);
    }

    public List<RecoveryRecords> selectAll(RecoveryRecords recoveryRecords) {
        return recoveryRecordsMapper.selectAll(recoveryRecords);
    }

    public PageInfo<RecoveryRecords> selectPage(RecoveryRecords recoveryRecords, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.USER.name().equals(currentUser.getRole())) {
            recoveryRecords.setUserId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<RecoveryRecords> list = recoveryRecordsMapper.selectAll(recoveryRecords);
        return PageInfo.of(list);
    }

}
