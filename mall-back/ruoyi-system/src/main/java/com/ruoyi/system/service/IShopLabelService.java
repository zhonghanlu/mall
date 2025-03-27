package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.ShopLabel;

/**
 * 商品标签Service接口
 * 
 * @author baq
 * @date 2025-02-16
 */
public interface IShopLabelService 
{
    /**
     * 查询商品标签
     * 
     * @param id 商品标签主键
     * @return 商品标签
     */
    public ShopLabel selectShopLabelById(Long id);

    /**
     * 查询商品标签列表
     * 
     * @param shopLabel 商品标签
     * @return 商品标签集合
     */
    public List<ShopLabel> selectShopLabelList(ShopLabel shopLabel);

    /**
     * 新增商品标签
     * 
     * @param shopLabel 商品标签
     * @return 结果
     */
    public int insertShopLabel(ShopLabel shopLabel);

    /**
     * 修改商品标签
     * 
     * @param shopLabel 商品标签
     * @return 结果
     */
    public int updateShopLabel(ShopLabel shopLabel);

    /**
     * 批量删除商品标签
     * 
     * @param ids 需要删除的商品标签主键集合
     * @return 结果
     */
    public int deleteShopLabelByIds(Long[] ids);

    /**
     * 删除商品标签信息
     * 
     * @param id 商品标签主键
     * @return 结果
     */
    public int deleteShopLabelById(Long id);
}
