package com.ruoyi.system.service.impl;

import java.util.List;
import java.util.UUID;

import com.ruoyi.common.utils.IDGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.ShopCategoryMapper;
import com.ruoyi.system.domain.ShopCategory;
import com.ruoyi.system.service.IShopCategoryService;

/**
 * 分类Service业务层处理
 * 
 * @author baq
 * @date 2025-02-16
 */
@Service
public class ShopCategoryServiceImpl implements IShopCategoryService 
{
    @Autowired
    private ShopCategoryMapper shopCategoryMapper;

    /**
     * 查询分类
     * 
     * @param id 分类主键
     * @return 分类
     */
    @Override
    public ShopCategory selectShopCategoryById(Long id)
    {
        return shopCategoryMapper.selectShopCategoryById(id);
    }

    /**
     * 查询分类列表
     * 
     * @param shopCategory 分类
     * @return 分类
     */
    @Override
    public List<ShopCategory> selectShopCategoryList(ShopCategory shopCategory)
    {
        return shopCategoryMapper.selectShopCategoryList(shopCategory);
    }

    /**
     * 新增分类
     * 
     * @param shopCategory 分类
     * @return 结果
     */
    @Override
    public int insertShopCategory(ShopCategory shopCategory)
    {
        shopCategory.setId(IDGenerator.next());
        return shopCategoryMapper.insertShopCategory(shopCategory);
    }

    /**
     * 修改分类
     * 
     * @param shopCategory 分类
     * @return 结果
     */
    @Override
    public int updateShopCategory(ShopCategory shopCategory)
    {
        return shopCategoryMapper.updateShopCategory(shopCategory);
    }

    /**
     * 批量删除分类
     * 
     * @param ids 需要删除的分类主键
     * @return 结果
     */
    @Override
    public int deleteShopCategoryByIds(Long[] ids)
    {
        return shopCategoryMapper.deleteShopCategoryByIds(ids);
    }

    /**
     * 删除分类信息
     * 
     * @param id 分类主键
     * @return 结果
     */
    @Override
    public int deleteShopCategoryById(Long id)
    {
        return shopCategoryMapper.deleteShopCategoryById(id);
    }
}
