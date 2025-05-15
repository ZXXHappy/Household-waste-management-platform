package com.example.service;

import cn.hutool.core.util.ObjectUtil;
import com.example.common.Constants;
import com.example.common.enums.ResultCodeEnum;
import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.entity.CommunityAdmin;
import com.example.exception.CustomException;
import com.example.mapper.CommunityAdminMapper;
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
public class CommunityAdminService {

    @Resource
    private CommunityAdminMapper communityAdminMapper;

    public void add(CommunityAdmin communityAdmin) {
        CommunityAdmin dbCommunityAdmin = communityAdminMapper.selectByUsername(communityAdmin.getUsername());
        if (ObjectUtil.isNotNull(dbCommunityAdmin)) {
            throw new CustomException(ResultCodeEnum.USER_EXIST_ERROR);
        }
        if (ObjectUtil.isEmpty(communityAdmin.getPassword())) {
            communityAdmin.setPassword(Constants.USER_DEFAULT_PASSWORD);
        }
        if (ObjectUtil.isEmpty(communityAdmin.getName())) {
            communityAdmin.setName(dbCommunityAdmin.getUsername());
        }
        communityAdmin.setRole(RoleEnum.COMMUNITY.name());
        communityAdminMapper.insert(communityAdmin);
    }

    public void updateById(CommunityAdmin communityAdmin) {
        communityAdminMapper.updateById(communityAdmin);
    }

    public void deleteById(Integer id) {
        communityAdminMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            communityAdminMapper.deleteById(id);
        }
    }

    public CommunityAdmin selectById(Integer id) {
        return communityAdminMapper.selectById(id);
    }

    public List<CommunityAdmin> selectAll(CommunityAdmin communityAdmin) {
        return communityAdminMapper.selectAll(communityAdmin);
    }

    public PageInfo<CommunityAdmin> selectPage(CommunityAdmin communityAdmin, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<CommunityAdmin> list = communityAdminMapper.selectAll(communityAdmin);
        return PageInfo.of(list);
    }

    /**
     * 登录
     */
    public CommunityAdmin login(Account account) {
        CommunityAdmin dbCommunityAdmin = communityAdminMapper.selectByUsername(account.getUsername());
        if (ObjectUtil.isNull(dbCommunityAdmin)) {
            throw new CustomException(ResultCodeEnum.USER_NOT_EXIST_ERROR);
        }
        if (!dbCommunityAdmin.getPassword().equals(account.getPassword())) {
            throw new CustomException(ResultCodeEnum.USER_ACCOUNT_ERROR);
        }
        // 生成token
        String token = TokenUtils.createToken(dbCommunityAdmin.getId() + "-" + dbCommunityAdmin.getRole(), dbCommunityAdmin.getPassword());
        dbCommunityAdmin.setToken(token);
        return dbCommunityAdmin;
    }

    /**
     * 修改密码
     */
    public void updatePassword(Account account) {
        CommunityAdmin dbCommunityAdmin = communityAdminMapper.selectByUsername(account.getUsername());
        if (ObjectUtil.isNull(dbCommunityAdmin)) {
            throw new CustomException(ResultCodeEnum.USER_NOT_EXIST_ERROR);
        }
        if (!account.getPassword().equals(dbCommunityAdmin.getPassword())) {
            throw new CustomException(ResultCodeEnum.PARAM_PASSWORD_ERROR);
        }
        dbCommunityAdmin.setPassword(account.getNewPassword());
        communityAdminMapper.updateById(dbCommunityAdmin);
    }


}
