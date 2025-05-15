package com.example.controller;

import cn.hutool.core.date.DateField;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import com.example.common.Result;
import com.example.common.enums.RoleEnum;
import com.example.entity.*;
import com.example.service.*;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@RestController
public class WebController {

    @Resource
    private AdminService adminService;
    @Resource
    private UserService userService;
    @Resource
    private CommunityAdminService communityAdminService;
    @Resource
    private GarbageLaunchService garbageLaunchService;
    @Resource
    private RecoveryRecordsService recoveryRecordsService;
    @Resource
    private ScoreExchangeService scoreExchangeService;
    @Resource
    private RecoverySiteService recoverySiteService;

    /**
     * 默认请求接口
     */
    @GetMapping("/")
    public Result hello () {
        return Result.success();
    }

    /**
     * 登录
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
     * 注册
     */
    @PostMapping("/register")
    public Result register(@RequestBody User user) {
        userService.add(user);
        return Result.success();
    }

    /**
     * 修改密码
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

    @GetMapping("/count")
    public Result count() {
        List<GarbageLaunch> garbageLaunchList = garbageLaunchService.selectAll(null);
        List<RecoveryRecords> recoveryRecordsList = recoveryRecordsService.selectAll(null).stream().filter(r -> r.getStatus().equals("通过")).toList();
        List<ScoreExchange> scoreExchangeList = scoreExchangeService.selectAll(null).stream().filter(s -> !s.getStatus().equals("已取消")).toList();
        List<RecoverySite> recoverySiteList = recoverySiteService.selectAll(null);

        HashMap<String, Object> map = new HashMap<>();
        map.put("launch", garbageLaunchList.size());
        map.put("recovery", recoveryRecordsList.size());
        map.put("score", scoreExchangeList.size());
        map.put("site", recoverySiteList.size());
        return Result.success(map);
    }

    @GetMapping("/line")
    public Result line() {
        Date today = new Date();
        DateTime start = DateUtil.offsetDay(today, -6);
        List<DateTime> dateTimeList = DateUtil.rangeToList(start, today, DateField.DAY_OF_YEAR);
        List<String> dateStrList = dateTimeList.stream().map(DateUtil::formatDate).toList();
        List<RecoveryRecords> recoveryRecordsList = recoveryRecordsService.selectAll(null).stream().filter(r -> r.getStatus().equals("通过")).toList();
        List<Long> countList = new ArrayList<>();
        for (String dateStr : dateStrList) {
            long count = recoveryRecordsList.stream().filter(r -> r.getTime().contains(dateStr)).count();
            countList.add(count);
        }

        HashMap<String, Object> map = new HashMap<>();
        map.put("x", dateStrList);
        map.put("y", countList);
        return Result.success(map);
    }

    @GetMapping("/pie")
    public Result pie() {
        List<GarbageLaunch> garbageLaunchList = garbageLaunchService.selectAll(null);
        List<String> typeList = garbageLaunchList.stream().map(GarbageLaunch::getType).distinct().toList();

        List<HashMap<String, Object>> list = new ArrayList<>();
        for (String type : typeList) {
            HashMap<String, Object> map = new HashMap<>();
            long count = garbageLaunchList.stream().filter(g -> g.getType().equals(type)).count();
            map.put("name", type);
            map.put("value", count);
            list.add(map);
        }
        return Result.success(list);
    }

}
