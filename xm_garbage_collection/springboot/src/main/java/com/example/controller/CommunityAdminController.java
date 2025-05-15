package com.example.controller;

import com.example.common.Result;
import com.example.entity.CommunityAdmin;
import com.example.service.CommunityAdminService;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 前端请求接口
 */
@RestController
@RequestMapping("/communityAdmin")
public class CommunityAdminController {

    @Resource
    private CommunityAdminService communityAdminService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody CommunityAdmin communityAdmin) {
        communityAdminService.add(communityAdmin);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result update(@RequestBody CommunityAdmin communityAdmin) {
        communityAdminService.updateById(communityAdmin);
        return Result.success();
    }

    /**
     * 单个删除
     */
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        communityAdminService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result delete(@RequestBody List<Integer> ids) {
        communityAdminService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 单个查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        CommunityAdmin communityAdmin = communityAdminService.selectById(id);
        return Result.success(communityAdmin);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(CommunityAdmin communityAdmin) {
        List<CommunityAdmin> list = communityAdminService.selectAll(communityAdmin);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(CommunityAdmin communityAdmin,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<CommunityAdmin> pageInfo = communityAdminService.selectPage(communityAdmin, pageNum, pageSize);
        return Result.success(pageInfo);
    }

}
