package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.ShopOrderProduct;

/**
 * 【请填写功能名称】Service接口
 * 
 * @author ruoyi
 * @date 2025-02-18
 */
public interface IShopOrderProductService 
{
    /**
     * 查询【请填写功能名称】
     * 
     * @param id 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public ShopOrderProduct selectShopOrderProductById(Long id);

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param shopOrderProduct 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<ShopOrderProduct> selectShopOrderProductList(ShopOrderProduct shopOrderProduct);

    /**
     * 新增【请填写功能名称】
     * 
     * @param shopOrderProduct 【请填写功能名称】
     * @return 结果
     */
    public int insertShopOrderProduct(ShopOrderProduct shopOrderProduct);

    /**
     * 修改【请填写功能名称】
     * 
     * @param shopOrderProduct 【请填写功能名称】
     * @return 结果
     */
    public int updateShopOrderProduct(ShopOrderProduct shopOrderProduct);

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param ids 需要删除的【请填写功能名称】主键集合
     * @return 结果
     */
    public int deleteShopOrderProductByIds(Long[] ids);

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param id 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteShopOrderProductById(Long id);
}
