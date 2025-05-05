package com.example.controller;

import com.example.common.Result;
import com.example.entity.RecoveryRecords;
import com.example.service.RecoveryRecordsService;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 前端请求接口
 */
@RestController
@RequestMapping("/recoveryRecords")
public class RecoveryRecordsController {

    @Resource
    private RecoveryRecordsService recoveryRecordsService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody RecoveryRecords recoveryRecords) {
        recoveryRecordsService.add(recoveryRecords);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result update(@RequestBody RecoveryRecords recoveryRecords) {
        recoveryRecordsService.updateById(recoveryRecords);
        return Result.success();
    }

    /**
     * 单个删除
     */
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        recoveryRecordsService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result delete(@RequestBody List<Integer> ids) {
        recoveryRecordsService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 单个查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        RecoveryRecords recoveryRecords = recoveryRecordsService.selectById(id);
        return Result.success(recoveryRecords);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(RecoveryRecords recoveryRecords) {
        List<RecoveryRecords> list = recoveryRecordsService.selectAll(recoveryRecords);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(RecoveryRecords recoveryRecords,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<RecoveryRecords> pageInfo = recoveryRecordsService.selectPage(recoveryRecords, pageNum, pageSize);
        return Result.success(pageInfo);
    }

}
