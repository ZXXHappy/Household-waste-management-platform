package com.example.controller;

import com.example.common.Result;
import com.example.entity.ScoreExchange;
import com.example.service.ScoreExchangeService;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 前端请求接口
 */
@RestController
@RequestMapping("/scoreExchange")
public class ScoreExchangeController {

    @Resource
    private ScoreExchangeService scoreExchangeService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody ScoreExchange scoreExchange) {
        scoreExchangeService.add(scoreExchange);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result update(@RequestBody ScoreExchange scoreExchange) {
        scoreExchangeService.updateById(scoreExchange);
        return Result.success();
    }

    /**
     * 单个删除
     */
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        scoreExchangeService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result delete(@RequestBody List<Integer> ids) {
        scoreExchangeService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 单个查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        ScoreExchange scoreExchange = scoreExchangeService.selectById(id);
        return Result.success(scoreExchange);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(ScoreExchange scoreExchange) {
        List<ScoreExchange> list = scoreExchangeService.selectAll(scoreExchange);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(ScoreExchange scoreExchange,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<ScoreExchange> pageInfo = scoreExchangeService.selectPage(scoreExchange, pageNum, pageSize);
        return Result.success(pageInfo);
    }

}
