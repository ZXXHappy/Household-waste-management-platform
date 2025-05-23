package com.example.controller;

import com.example.common.Result;
import com.example.entity.ScoreGoods;
import com.example.service.ScoreGoodsService;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 前端请求接口
 */
@RestController
@RequestMapping("/scoreGoods")
public class ScoreGoodsController {

    @Resource
    private ScoreGoodsService scoreGoodsService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody ScoreGoods scoreGoods) {
        scoreGoodsService.add(scoreGoods);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result update(@RequestBody ScoreGoods scoreGoods) {
        scoreGoodsService.updateById(scoreGoods);
        return Result.success();
    }

    /**
     * 单个删除
     */
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        scoreGoodsService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result delete(@RequestBody List<Integer> ids) {
        scoreGoodsService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 单个查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        ScoreGoods scoreGoods = scoreGoodsService.selectById(id);
        return Result.success(scoreGoods);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(ScoreGoods scoreGoods) {
        List<ScoreGoods> list = scoreGoodsService.selectAll(scoreGoods);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(ScoreGoods scoreGoods,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<ScoreGoods> pageInfo = scoreGoodsService.selectPage(scoreGoods, pageNum, pageSize);
        return Result.success(pageInfo);
    }

}
