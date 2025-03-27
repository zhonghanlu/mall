package com.ruoyi.system.domain;

import com.ruoyi.common.annotation.Excel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * @author baq
 * @date 2025-02-17
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class ShopProductLabel implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
    private Long id;

    /**
     * 标签id
     */
    @Excel(name = "标签id")
    private Long labelId;

    /**
     * 商品id
     */
    @Excel(name = "商品id")
    private Long productId;

    ///////////////////////////**/

    /**
     * 标签名称
     */
    private String labelName;

}
