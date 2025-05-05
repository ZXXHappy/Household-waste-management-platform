package com.example.controller;

import com.example.common.Result;
import com.example.entity.GarbageLaunch;
import com.example.service.GarbageLaunchService;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 前端请求接口
 */
@RestController
@RequestMapping("/garbageLaunch")
public class GarbageLaunchController {

    @Resource
    private GarbageLaunchService garbageLaunchService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody GarbageLaunch garbageLaunch) {
        garbageLaunchService.add(garbageLaunch);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result update(@RequestBody GarbageLaunch garbageLaunch) {
        garbageLaunchService.updateById(garbageLaunch);
        return Result.success();
    }

    /**
     * 单个删除
     */
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        garbageLaunchService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result delete(@RequestBody List<Integer> ids) {
        garbageLaunchService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 单个查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        GarbageLaunch garbageLaunch = garbageLaunchService.selectById(id);
        return Result.success(garbageLaunch);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(GarbageLaunch garbageLaunch) {
        List<GarbageLaunch> list = garbageLaunchService.selectAll(garbageLaunch);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(GarbageLaunch garbageLaunch,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<GarbageLaunch> pageInfo = garbageLaunchService.selectPage(garbageLaunch, pageNum, pageSize);
        return Result.success(pageInfo);
    }

}
