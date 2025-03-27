package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.ShopProductLabel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 【请填写功能名称】Mapper接口
 *
 * @author ruoyi
 * @date 2025-02-17
 */
public interface ShopProductLabelMapper {
    /**
     * 查询【请填写功能名称】
     *
     * @param id 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public ShopProductLabel selectShopProductLabelById(Long id);

    /**
     * 查询【请填写功能名称】列表
     *
     * @param shopProductLabel 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<ShopProductLabel> selectShopProductLabelList(ShopProductLabel shopProductLabel);

    /**
     * 新增【请填写功能名称】
     *
     * @param shopProductLabel 【请填写功能名称】
     * @return 结果
     */
    public int insertShopProductLabel(ShopProductLabel shopProductLabel);

    /**
     * 新增【请填写功能名称】
     *
     * @param shopProductLabelList 【请填写功能名称】
     * @return 结果
     */
    public int batchInsertShopProductLabel(@Param("shopProductLabelList") List<ShopProductLabel> shopProductLabelList);

    /**
     * 修改【请填写功能名称】
     *
     * @param shopProductLabel 【请填写功能名称】
     * @return 结果
     */
    public int updateShopProductLabel(ShopProductLabel shopProductLabel);

    /**
     * 删除【请填写功能名称】
     *
     * @param id 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteShopProductLabelById(Long id);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteShopProductLabelByIds(Long[] ids);

    List<Long> selectLabelIdList(Long id);

    void deleteLabelByProductId(Long productId);

    /**
     * 根据商品id查询标签
     *
     * @param productIdList
     * @return
     */
    List<ShopProductLabel> selectLabelListByProductIdList(@Param("productIdList") List<Long> productIdList);
}
