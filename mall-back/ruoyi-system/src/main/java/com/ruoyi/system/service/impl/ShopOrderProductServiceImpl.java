package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.ShopOrderProductMapper;
import com.ruoyi.system.domain.ShopOrderProduct;
import com.ruoyi.system.service.IShopOrderProductService;

/**
 * 【请填写功能名称】Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-02-18
 */
@Service
public class ShopOrderProductServiceImpl implements IShopOrderProductService 
{
    @Autowired
    private ShopOrderProductMapper shopOrderProductMapper;

    /**
     * 查询【请填写功能名称】
     * 
     * @param id 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public ShopOrderProduct selectShopOrderProductById(Long id)
    {
        return shopOrderProductMapper.selectShopOrderProductById(id);
    }

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param shopOrderProduct 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<ShopOrderProduct> selectShopOrderProductList(ShopOrderProduct shopOrderProduct)
    {
        return shopOrderProductMapper.selectShopOrderProductList(shopOrderProduct);
    }

    /**
     * 新增【请填写功能名称】
     * 
     * @param shopOrderProduct 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertShopOrderProduct(ShopOrderProduct shopOrderProduct)
    {
        return shopOrderProductMapper.insertShopOrderProduct(shopOrderProduct);
    }

    /**
     * 修改【请填写功能名称】
     * 
     * @param shopOrderProduct 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateShopOrderProduct(ShopOrderProduct shopOrderProduct)
    {
        return shopOrderProductMapper.updateShopOrderProduct(shopOrderProduct);
    }

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param ids 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteShopOrderProductByIds(Long[] ids)
    {
        return shopOrderProductMapper.deleteShopOrderProductByIds(ids);
    }

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param id 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteShopOrderProductById(Long id)
    {
        return shopOrderProductMapper.deleteShopOrderProductById(id);
    }
}
