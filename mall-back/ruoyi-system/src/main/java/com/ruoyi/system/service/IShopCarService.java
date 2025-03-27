package com.ruoyi.system.service;

import com.ruoyi.system.domain.vo.ShopCarProductVo;

import java.util.List;

/**
 * @author zhl
 * @create 2025/2/20 10:43
 */
public interface IShopCarService {
    /**
     * 添加购物车
     */
    void updateShopCar(Long userId, Long productId, Integer quantity);

    /**
     * 添加购物车
     */
    List<ShopCarProductVo> getShopCar(Long userId);

    /**
     * 获取购物车数量
     */
    int getShopCarSize(Long userId);

    /**
     * 删除商品信息
     */
    void remove(Long userId, Long productId);
}
