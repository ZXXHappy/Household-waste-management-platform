package com.example.service;

import com.example.entity.Popularize;
import com.example.mapper.PopularizeMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 业务层方法
 */
@Service
public class PopularizeService {

    @Resource
    private PopularizeMapper popularizeMapper;

    public void add(Popularize popularize) {
        popularize.setViewCount(0);
        popularizeMapper.insert(popularize);
    }

    public void updateById(Popularize popularize) {
        popularizeMapper.updateById(popularize);
    }

    public void deleteById(Integer id) {
        popularizeMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            popularizeMapper.deleteById(id);
        }
    }

    public Popularize selectById(Integer id) {
        return popularizeMapper.selectById(id);
    }

    public List<Popularize> selectAll(Popularize popularize) {
        return popularizeMapper.selectAll(popularize);
    }

    public PageInfo<Popularize> selectPage(Popularize popularize, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Popularize> list = popularizeMapper.selectAll(popularize);
        return PageInfo.of(list);
    }

    public void updateViewCount(Integer id) {
        popularizeMapper.updateViewCount(id);
    }

}
