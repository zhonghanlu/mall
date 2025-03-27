package com.ruoyi.system.service.impl;

import java.util.List;

import com.ruoyi.common.utils.IDGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.ShopLabelMapper;
import com.ruoyi.system.domain.ShopLabel;
import com.ruoyi.system.service.IShopLabelService;

/**
 * 商品标签Service业务层处理
 * 
 * @author baq
 * @date 2025-02-16
 */
@Service
public class ShopLabelServiceImpl implements IShopLabelService 
{
    @Autowired
    private ShopLabelMapper shopLabelMapper;

    /**
     * 查询商品标签
     * 
     * @param id 商品标签主键
     * @return 商品标签
     */
    @Override
    public ShopLabel selectShopLabelById(Long id)
    {
        return shopLabelMapper.selectShopLabelById(id);
    }

    /**
     * 查询商品标签列表
     * 
     * @param shopLabel 商品标签
     * @return 商品标签
     */
    @Override
    public List<ShopLabel> selectShopLabelList(ShopLabel shopLabel)
    {
        return shopLabelMapper.selectShopLabelList(shopLabel);
    }

    /**
     * 新增商品标签
     * 
     * @param shopLabel 商品标签
     * @return 结果
     */
    @Override
    public int insertShopLabel(ShopLabel shopLabel)
    {
        shopLabel.setId(IDGenerator.next());
        return shopLabelMapper.insertShopLabel(shopLabel);
    }

    /**
     * 修改商品标签
     * 
     * @param shopLabel 商品标签
     * @return 结果
     */
    @Override
    public int updateShopLabel(ShopLabel shopLabel)
    {
        return shopLabelMapper.updateShopLabel(shopLabel);
    }

    /**
     * 批量删除商品标签
     * 
     * @param ids 需要删除的商品标签主键
     * @return 结果
     */
    @Override
    public int deleteShopLabelByIds(Long[] ids)
    {
        return shopLabelMapper.deleteShopLabelByIds(ids);
    }

    /**
     * 删除商品标签信息
     * 
     * @param id 商品标签主键
     * @return 结果
     */
    @Override
    public int deleteShopLabelById(Long id)
    {
        return shopLabelMapper.deleteShopLabelById(id);
    }
}
