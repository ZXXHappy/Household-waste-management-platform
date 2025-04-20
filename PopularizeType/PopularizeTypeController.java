package com.example.controller;

import com.example.common.Result;
import com.example.entity.PopularizeType;
import com.example.service.PopularizeTypeService;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 前端请求接口
 */
@RestController
@RequestMapping("/popularizeType")
public class PopularizeTypeController {

    @Resource
    private PopularizeTypeService popularizeTypeService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody PopularizeType popularizeType) {
        popularizeTypeService.add(popularizeType);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result update(@RequestBody PopularizeType popularizeType) {
        popularizeTypeService.updateById(popularizeType);
        return Result.success();
    }

    /**
     * 单个删除
     */
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        popularizeTypeService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result delete(@RequestBody List<Integer> ids) {
        popularizeTypeService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 单个查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        PopularizeType popularizeType = popularizeTypeService.selectById(id);
        return Result.success(popularizeType);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(PopularizeType popularizeType) {
        List<PopularizeType> list = popularizeTypeService.selectAll(popularizeType);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(PopularizeType popularizeType,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<PopularizeType> pageInfo = popularizeTypeService.selectPage(popularizeType, pageNum, pageSize);
        return Result.success(pageInfo);
    }

}
