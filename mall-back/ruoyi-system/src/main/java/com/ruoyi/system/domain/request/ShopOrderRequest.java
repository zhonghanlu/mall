package com.ruoyi.system.domain.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @author zhl
 * @create 2025/2/20 16:25
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ShopOrderRequest {

    private List<ProductDTO> productDTOList;

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class ProductDTO {
        private Long productId;

        private Long quantity;
    }
}
