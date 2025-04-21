package com.example.service;

import cn.hutool.core.date.DateUtil;
import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.entity.ScoreExchange;
import com.example.entity.ScoreGoods;
import com.example.entity.User;
import com.example.exception.CustomException;
import com.example.mapper.ScoreExchangeMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 业务层方法
 */
@Service
public class ScoreExchangeService {

    @Resource
    private ScoreExchangeMapper scoreExchangeMapper;
    @Resource
    private UserService userService;
    @Resource
    private ScoreGoodsService scoreGoodsService;

    @Transactional
    public void add(ScoreExchange scoreExchange) {
        Account currentUser = TokenUtils.getCurrentUser();
        User user = userService.selectById(currentUser.getId());
        Integer score = user.getScore();
        // 如果用户的积分余额小于兑换的物品的积分总数  就提示用户无法兑换
        if (score < scoreExchange.getScore()) {
            throw new CustomException("500", "积分不足");
        }
        // 扣减用户的积分
        user.setScore(user.getScore() - scoreExchange.getScore());
        userService.updateById(user);
        // 扣减商品的库存
        ScoreGoods scoreGoods = scoreGoodsService.selectById(scoreExchange.getGoodsId());
        scoreGoods.setNum(scoreGoods.getNum() - scoreExchange.getNum());
        scoreGoodsService.updateById(scoreGoods);

        scoreExchange.setUserId(user.getId());
        scoreExchange.setTime(DateUtil.now());
        scoreExchange.setStatus("待派送");
        scoreExchangeMapper.insert(scoreExchange);
    }

    @Transactional
    public void updateById(ScoreExchange scoreExchange) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.USER.name().equals(currentUser.getRole())) {
            if ("已取消".equals(scoreExchange.getStatus())) {
                User user = userService.selectById(currentUser.getId());
                // 返还积分
                user.setScore(user.getScore() + scoreExchange.getScore());
                userService.updateById(user);
                // 返还库存
                ScoreGoods scoreGoods = scoreGoodsService.selectById(scoreExchange.getGoodsId());
                scoreGoods.setNum(scoreGoods.getNum() + scoreExchange.getNum());
                scoreGoodsService.updateById(scoreGoods);
            }
        }
        scoreExchangeMapper.updateById(scoreExchange);
    }

    public void deleteById(Integer id) {
        scoreExchangeMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            scoreExchangeMapper.deleteById(id);
        }
    }

    public ScoreExchange selectById(Integer id) {
        return scoreExchangeMapper.selectById(id);
    }

    public List<ScoreExchange> selectAll(ScoreExchange scoreExchange) {
        return scoreExchangeMapper.selectAll(scoreExchange);
    }

    public PageInfo<ScoreExchange> selectPage(ScoreExchange scoreExchange, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.USER.name().equals(currentUser.getRole())) {
            scoreExchange.setUserId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<ScoreExchange> list = scoreExchangeMapper.selectAll(scoreExchange);
        return PageInfo.of(list);
    }

}
