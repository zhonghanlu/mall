package com.ruoyi.system.domain.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * @author zhl
 * @create 2025/2/20 11:11
 */
@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
public class ShopCarProductVo {

    /**
     * 主键 id
     */
    private Long id;

    /**
     * 商品名称
     */
    private String productName;

    /**
     * 图片实际地址
     */
    private String fileUrl;

    /**
     * 分类 id
     */
    private Long categoryId;

    /**
     * 分类名称
     */
    private String categoryName;

    /**
     * 标签名称
     */
    private String labelName;

    /**
     * 商品优惠价格
     */
    private String productPrice;

    /**
     * 商品实际价格
     */
    private String productActualPrice;

    /**
     * 商品状态
     * 0 下架 1 上架
     */
    private Integer productStatus;

    /**
     * 商品库存
     */
    private Long productInventory;

    /**
     * 商品简介
     */
    private String productIntro;

    /**
     * 购买数量
     */
    private Long quantity;
}
