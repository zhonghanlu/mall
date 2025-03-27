package com.ruoyi.system.domain;

import com.ruoyi.common.annotation.Excel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 分类对象 shop_category
 *
 * @author baq
 * @date 2025-02-16
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class ShopCategory implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 主键 id
     */
    private Long id;

    /**
     * 分类名称
     */
    @Excel(name = "分类名称")
    private String categoryName;

}
