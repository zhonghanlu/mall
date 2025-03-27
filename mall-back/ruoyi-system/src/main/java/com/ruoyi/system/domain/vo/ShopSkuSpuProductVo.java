package com.ruoyi.system.domain.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author zhl
 * @create 2025/2/18 15:35
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ShopSkuSpuProductVo {

    /**
     * 商品id
     */
    private Long id;

    /**
     * 商品名称
     */
    private String productName;

    /**
     * 商品实际价格
     */
    private String productActualPrice;

    /**
     * 购买数量
     */
    private Long quantity;
}
