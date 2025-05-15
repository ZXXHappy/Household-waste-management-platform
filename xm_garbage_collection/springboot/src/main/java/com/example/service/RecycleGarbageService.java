package com.example.service;

import com.example.entity.RecycleGarbage;
import com.example.mapper.RecycleGarbageMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 业务层方法
 */
@Service
public class RecycleGarbageService {

    @Resource
    private RecycleGarbageMapper recycleGarbageMapper;

    public void add(RecycleGarbage recycleGarbage) {
        recycleGarbageMapper.insert(recycleGarbage);
    }

    public void updateById(RecycleGarbage recycleGarbage) {
        recycleGarbageMapper.updateById(recycleGarbage);
    }

    public void deleteById(Integer id) {
        recycleGarbageMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            recycleGarbageMapper.deleteById(id);
        }
    }

    public RecycleGarbage selectById(Integer id) {
        return recycleGarbageMapper.selectById(id);
    }

    public List<RecycleGarbage> selectAll(RecycleGarbage recycleGarbage) {
        return recycleGarbageMapper.selectAll(recycleGarbage);
    }

    public PageInfo<RecycleGarbage> selectPage(RecycleGarbage recycleGarbage, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<RecycleGarbage> list = recycleGarbageMapper.selectAll(recycleGarbage);
        return PageInfo.of(list);
    }

}
