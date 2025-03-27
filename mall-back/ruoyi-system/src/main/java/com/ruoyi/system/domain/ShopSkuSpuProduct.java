package com.ruoyi.system.domain;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 商品对象 shop_sku_spu_product
 *
 * @author baq
 * @date 2025-02-16
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class ShopSkuSpuProduct extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 主键 id
     */
    private Long id;

    /**
     * 商品名称
     */
    @Excel(name = "商品名称")
    private String productName;

    /**
     * 图片实际地址
     */
    @Excel(name = "图片实际地址")
    private String fileUrl;

    /**
     * 分类 id
     */
    @Excel(name = "分类 id")
    private Long categoryId;

    /**
     * 分类名称
     */
    @Excel(name = "分类名称")
    private String categoryName;

    /**
     * 标签名称
     */
    @Excel(name = "标签名称")
    private String labelName;

    /**
     * 商品优惠价格
     */
    @Excel(name = "商品优惠价格")
    private String productPrice;

    /**
     * 商品实际价格
     */
    @Excel(name = "商品实际价格")
    private String productActualPrice;

    /**
     * 商品状态
     * 0 下架 1 上架
     */
    @Excel(name = "商品状态")
    private Integer productStatus;

    /**
     * 商品库存
     */
    @Excel(name = "商品库存")
    private Long productInventory;

    /**
     * 商品简介
     */
    @Excel(name = "商品简介")
    private String productIntro;

    /**
     * 删除标识
     * 删除标志（0代表存在 2代表删除）
     */
    private String delFlag;

    ///////////////////////////////////

    /**
     * 标签 idList
     */
    private List<Long> labelIdList;

    ///////////////////////////////////

    /**
     * 标签信息
     */
    private List<ShopLabel> shopLabelList;
}
