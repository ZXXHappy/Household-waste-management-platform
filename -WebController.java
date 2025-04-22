package com.example.controller;

import com.example.common.Result;
import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.entity.User;
import com.example.service.AdminService;
import com.example.service.UserService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

/**
 * 前端门户总控制器：处理用户登录、注册、修改密码等
 */
@RestController
public class WebController {

    @Resource
    private AdminService adminService;
    @Resource
    private UserService userService;
    @Resource
    private CommunityAdminService communityAdminService;

    /**
     * 默认请求接口（健康检查）
     */
    @GetMapping("/")
    public Result hello() {
        return Result.success();
    }

    /**
     * 登录接口
     */
    @PostMapping("/login")
    public Result login(@RequestBody Account account) {
        Account loginAccount = null;
        if (RoleEnum.ADMIN.name().equals(account.getRole())) {
            loginAccount = adminService.login(account);
        } else if (RoleEnum.USER.name().equals(account.getRole())) {
            loginAccount = userService.login(account);
        } else if (RoleEnum.COMMUNITY.name().equals(account.getRole())) {
            loginAccount = communityAdminService.login(account);
        }
        return Result.success(loginAccount);
    }

    /**
     * 注册接口（普通用户）
     */
    @PostMapping("/register")
    public Result register(@RequestBody User user) {
        userService.add(user);
        return Result.success();
    }

    /**
     * 修改密码接口
     */
    @PutMapping("/updatePassword")
    public Result updatePassword(@RequestBody Account account) {
        if (RoleEnum.ADMIN.name().equals(account.getRole())) {
            adminService.updatePassword(account);
        } else if (RoleEnum.COMMUNITY.name().equals(account.getRole())) {
            communityAdminService.updatePassword(account);
        } else if (RoleEnum.USER.name().equals(account.getRole())) {
            userService.updatePassword(account);
        }
        return Result.success();
    }
}
