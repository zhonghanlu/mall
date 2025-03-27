package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.ShopSkuSpuProduct;

/**
 * 商品Service接口
 * 
 * @author baq
 * @date 2025-02-16
 */
public interface IShopSkuSpuProductService 
{
    /**
     * 查询商品
     * 
     * @param id 商品主键
     * @return 商品
     */
    public ShopSkuSpuProduct selectShopSkuSpuProductById(Long id);

    /**
     * 查询商品列表
     * 
     * @param shopSkuSpuProduct 商品
     * @return 商品集合
     */
    public List<ShopSkuSpuProduct> selectShopSkuSpuProductList(ShopSkuSpuProduct shopSkuSpuProduct);

    /**
     * 新增商品
     * 
     * @param shopSkuSpuProduct 商品
     * @return 结果
     */
    public int insertShopSkuSpuProduct(ShopSkuSpuProduct shopSkuSpuProduct);

    /**
     * 修改商品
     * 
     * @param shopSkuSpuProduct 商品
     * @return 结果
     */
    public int updateShopSkuSpuProduct(ShopSkuSpuProduct shopSkuSpuProduct);

    /**
     * 批量删除商品
     * 
     * @param ids 需要删除的商品主键集合
     * @return 结果
     */
    public int deleteShopSkuSpuProductByIds(Long[] ids);

    /**
     * 删除商品信息
     * 
     * @param id 商品主键
     * @return 结果
     */
    public int deleteShopSkuSpuProductById(Long id);
}
