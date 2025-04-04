package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.ShopSkuSpuProduct;
import com.ruoyi.system.domain.vo.ShopCarProductVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Set;

/**
 * 商品Mapper接口
 *
 * @author baq
 * @date 2025-02-16
 */
public interface ShopSkuSpuProductMapper {
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
     * 删除商品
     *
     * @param id 商品主键
     * @return 结果
     */
    public int deleteShopSkuSpuProductById(Long id);

    /**
     * 批量删除商品
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteShopSkuSpuProductByIds(Long[] ids);

    /**
     * 根据idList查询商品信息
     */
    List<ShopCarProductVo> selectShopSkuSpuProductByIdList(@Param("idList") Set<Long> productIdList);

    /**
     * 商品分页
     */
    List<ShopSkuSpuProduct> selectProductPage(ShopSkuSpuProduct shopSkuSpuProduct);
}
