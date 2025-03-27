package com.ruoyi.system.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * @author baq
 * @date 2025-02-18
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class ShopOrderProduct implements Serializable {

    /**
     * 主键id
     */
    private Long id;

    /**
     * 商品id
     */
    private Long productId;

    /**
     * 订单id
     */
    private Long orderId;

    /**
     * 商品数量
     */
    private Long quantity;

}
