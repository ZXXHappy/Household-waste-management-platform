package com.example.mapper;

import com.example.entity.ScoreGoods;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface ScoreGoodsMapper {

    int insert(ScoreGoods score_goods);

    void updateById(ScoreGoods score_goods);

    void deleteById(Integer id);

    @Select("select * from `score_goods` where id = #{id}")
    ScoreGoods selectById(Integer id);

    List<ScoreGoods> selectAll(ScoreGoods score_goods);

}
