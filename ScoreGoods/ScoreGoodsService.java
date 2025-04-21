package com.example.service;

import com.example.entity.ScoreGoods;
import com.example.mapper.ScoreGoodsMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 业务层方法
 */
@Service
public class ScoreGoodsService {

    @Resource
    private ScoreGoodsMapper scoreGoodsMapper;

    public void add(ScoreGoods scoreGoods) {
        scoreGoodsMapper.insert(scoreGoods);
    }

    public void updateById(ScoreGoods scoreGoods) {
        scoreGoodsMapper.updateById(scoreGoods);
    }

    public void deleteById(Integer id) {
        scoreGoodsMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            scoreGoodsMapper.deleteById(id);
        }
    }

    public ScoreGoods selectById(Integer id) {
        return scoreGoodsMapper.selectById(id);
    }

    public List<ScoreGoods> selectAll(ScoreGoods scoreGoods) {
        return scoreGoodsMapper.selectAll(scoreGoods);
    }

    public PageInfo<ScoreGoods> selectPage(ScoreGoods scoreGoods, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<ScoreGoods> list = scoreGoodsMapper.selectAll(scoreGoods);
        return PageInfo.of(list);
    }

}
