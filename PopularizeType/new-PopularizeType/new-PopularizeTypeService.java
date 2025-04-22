package com.example.service;

import com.example.entity.PopularizeType;
import com.example.mapper.PopularizeTypeMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 业务层方法
 */
@Service
public class PopularizeTypeService {

    @Resource
    private PopularizeTypeMapper popularizeTypeMapper;

    public void add(PopularizeType popularizeType) {
        popularizeTypeMapper.insert(popularizeType);
    }

    public void updateById(PopularizeType popularizeType) {
        popularizeTypeMapper.updateById(popularizeType);
    }

    public void deleteById(Integer id) {
        popularizeTypeMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            popularizeTypeMapper.deleteById(id);
        }
    }

    public PopularizeType selectById(Integer id) {
        return popularizeTypeMapper.selectById(id);
    }

    public List<PopularizeType> selectAll(PopularizeType popularizeType) {
        return popularizeTypeMapper.selectAll(popularizeType);
    }

    public PageInfo<PopularizeType> selectPage(PopularizeType popularizeType, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<PopularizeType> list = popularizeTypeMapper.selectAll(popularizeType);
        return PageInfo.of(list);
    }

}
