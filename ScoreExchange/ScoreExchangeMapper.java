package com.example.mapper;

import com.example.entity.ScoreExchange;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface ScoreExchangeMapper {

    int insert(ScoreExchange score_exchange);

    void updateById(ScoreExchange score_exchange);

    void deleteById(Integer id);

    @Select("select * from `score_exchange` where id = #{id}")
    ScoreExchange selectById(Integer id);

    List<ScoreExchange> selectAll(ScoreExchange score_exchange);

}
