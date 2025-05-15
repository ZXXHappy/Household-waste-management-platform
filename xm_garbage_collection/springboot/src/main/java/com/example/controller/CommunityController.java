package com.example.controller;

import com.example.common.Result;
import com.example.entity.Community;
import com.example.service.CommunityService;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 前端请求接口
 */
@RestController
@RequestMapping("/community")
public class CommunityController {

    @Resource
    private CommunityService communityService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Community community) {
        communityService.add(community);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result update(@RequestBody Community community) {
        communityService.updateById(community);
        return Result.success();
    }

    /**
     * 单个删除
     */
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        communityService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result delete(@RequestBody List<Integer> ids) {
        communityService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 单个查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Community community = communityService.selectById(id);
        return Result.success(community);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Community community) {
        List<Community> list = communityService.selectAll(community);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Community community,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Community> pageInfo = communityService.selectPage(community, pageNum, pageSize);
        return Result.success(pageInfo);
    }

}
