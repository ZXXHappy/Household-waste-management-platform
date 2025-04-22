package com.example.controller;

import com.example.common.Result;
import com.example.entity.Popularize;
import com.example.service.PopularizeService;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 前端请求接口
 */
@RestController
@RequestMapping("/popularize")
public class PopularizeController {

    @Resource
    private PopularizeService popularizeService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Popularize popularize) {
        popularizeService.add(popularize);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result update(@RequestBody Popularize popularize) {
        popularizeService.updateById(popularize);
        return Result.success();
    }

    /**
     * 更新浏览量
     */
    @PutMapping("/updateViewCount/{id}")
    public Result updateViewCount(@PathVariable Integer id) {
        popularizeService.updateViewCount(id);
        return Result.success();
    }

    /**
     * 单个删除
     */
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        popularizeService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result delete(@RequestBody List<Integer> ids) {
        popularizeService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 单个查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Popularize popularize = popularizeService.selectById(id);
        return Result.success(popularize);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Popularize popularize) {
        List<Popularize> list = popularizeService.selectAll(popularize);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Popularize popularize,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Popularize> pageInfo = popularizeService.selectPage(popularize, pageNum, pageSize);
        return Result.success(pageInfo);
    }

}
