package com.example.controller;

import com.example.common.Result;
import com.example.entity.RecycleGarbage;
import com.example.service.RecycleGarbageService;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 前端请求接口
 */
@RestController
@RequestMapping("/recycleGarbage")
public class RecycleGarbageController {

    @Resource
    private RecycleGarbageService recycleGarbageService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody RecycleGarbage recycleGarbage) {
        recycleGarbageService.add(recycleGarbage);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result update(@RequestBody RecycleGarbage recycleGarbage) {
        recycleGarbageService.updateById(recycleGarbage);
        return Result.success();
    }

    /**
     * 单个删除
     */
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        recycleGarbageService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result delete(@RequestBody List<Integer> ids) {
        recycleGarbageService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 单个查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        RecycleGarbage recycleGarbage = recycleGarbageService.selectById(id);
        return Result.success(recycleGarbage);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(RecycleGarbage recycleGarbage) {
        List<RecycleGarbage> list = recycleGarbageService.selectAll(recycleGarbage);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(RecycleGarbage recycleGarbage,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<RecycleGarbage> pageInfo = recycleGarbageService.selectPage(recycleGarbage, pageNum, pageSize);
        return Result.success(pageInfo);
    }

}
