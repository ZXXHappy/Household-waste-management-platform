package com.example.controller;

import com.example.common.Result;
import com.example.entity.RecoverySite;
import com.example.service.RecoverySiteService;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 前端请求接口
 */
@RestController
@RequestMapping("/recoverySite")
public class RecoverySiteController {

    @Resource
    private RecoverySiteService recoverySiteService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody RecoverySite recoverySite) {
        recoverySiteService.add(recoverySite);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result update(@RequestBody RecoverySite recoverySite) {
        recoverySiteService.updateById(recoverySite);
        return Result.success();
    }

    /**
     * 单个删除
     */
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        recoverySiteService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result delete(@RequestBody List<Integer> ids) {
        recoverySiteService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 单个查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        RecoverySite recoverySite = recoverySiteService.selectById(id);
        return Result.success(recoverySite);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(RecoverySite recoverySite) {
        List<RecoverySite> list = recoverySiteService.selectAll(recoverySite);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(RecoverySite recoverySite,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<RecoverySite> pageInfo = recoverySiteService.selectPage(recoverySite, pageNum, pageSize);
        return Result.success(pageInfo);
    }

}
