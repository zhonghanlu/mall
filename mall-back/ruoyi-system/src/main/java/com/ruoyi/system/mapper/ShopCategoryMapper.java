package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.ShopCategory;

/**
 * 分类Mapper接口
 * 
 * @author baq
 * @date 2025-02-16
 */
public interface ShopCategoryMapper 
{
    /**
     * 查询分类
     * 
     * @param id 分类主键
     * @return 分类
     */
    public ShopCategory selectShopCategoryById(Long id);

    /**
     * 查询分类列表
     * 
     * @param shopCategory 分类
     * @return 分类集合
     */
    public List<ShopCategory> selectShopCategoryList(ShopCategory shopCategory);

    /**
     * 新增分类
     * 
     * @param shopCategory 分类
     * @return 结果
     */
    public int insertShopCategory(ShopCategory shopCategory);

    /**
     * 修改分类
     * 
     * @param shopCategory 分类
     * @return 结果
     */
    public int updateShopCategory(ShopCategory shopCategory);

    /**
     * 删除分类
     * 
     * @param id 分类主键
     * @return 结果
     */
    public int deleteShopCategoryById(Long id);

    /**
     * 批量删除分类
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteShopCategoryByIds(Long[] ids);
}
