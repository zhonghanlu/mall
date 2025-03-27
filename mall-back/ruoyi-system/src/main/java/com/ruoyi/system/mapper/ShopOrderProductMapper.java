package com.ruoyi.system.mapper;

import java.util.List;

import com.ruoyi.system.domain.ShopOrderProduct;
import com.ruoyi.system.domain.vo.ShopSkuSpuProductVo;
import org.apache.ibatis.annotations.Param;

/**
 * 【请填写功能名称】Mapper接口
 *
 * @author ruoyi
 * @date 2025-02-18
 */
public interface ShopOrderProductMapper {
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
     * 删除【请填写功能名称】
     *
     * @param id 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteShopOrderProductById(Long id);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteShopOrderProductByIds(Long[] ids);

    /**
     * 批量新增商品订单关联数据
     */
    int batchInsertShopOrderProduct(@Param("shopOrderProductList") List<ShopOrderProduct> shopOrderProductList);

    /**
     * 根据订单id获取商品信息
     *
     * @param id
     * @return
     */
    List<ShopSkuSpuProductVo> selectShopProductDetailByOrderId(Long id);
}
