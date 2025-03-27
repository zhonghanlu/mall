package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.ShopOrder;

/**
 * 订单信息Mapper接口
 * 
 * @author baq
 * @date 2025-02-17
 */
public interface ShopOrderMapper 
{
    /**
     * 查询订单信息
     * 
     * @param id 订单信息主键
     * @return 订单信息
     */
    public ShopOrder selectShopOrderById(Long id);

    /**
     * 查询订单信息列表
     * 
     * @param shopOrder 订单信息
     * @return 订单信息集合
     */
    public List<ShopOrder> selectShopOrderList(ShopOrder shopOrder);

    /**
     * 新增订单信息
     * 
     * @param shopOrder 订单信息
     * @return 结果
     */
    public int insertShopOrder(ShopOrder shopOrder);

    /**
     * 修改订单信息
     * 
     * @param shopOrder 订单信息
     * @return 结果
     */
    public int updateShopOrder(ShopOrder shopOrder);

    /**
     * 删除订单信息
     * 
     * @param id 订单信息主键
     * @return 结果
     */
    public int deleteShopOrderById(Long id);

    /**
     * 批量删除订单信息
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteShopOrderByIds(Long[] ids);
}
