package com.ruoyi.system.domain.request;

import lombok.Data;

/**
 * @author zhl
 * @create 2025/2/20 11:37
 */
@Data
public class ShopCarRequest {

    /**
     * 商品id
     */
    private Long productId;

    /**
     * 商品数量 操作数量
     */
    private Integer num;

}
