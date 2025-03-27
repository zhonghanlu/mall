package com.ruoyi.system.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 物流信息对象 shop_logistics
 *
 * @author baq
 * @date 2025-02-17
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class ShopLogistics extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
    private Long id;

    /**
     * 关联订单id
     */
    @Excel(name = "关联订单id")
    private Long orderId;

    /**
     * 物流名称
     */
    @Excel(name = "物流名称")
    private String logisticsName;

    /**
     * 配送时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "配送时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date logisticsTime;

    /**
     * 配送价格
     */
    @Excel(name = "配送价格")
    private Long logisticsPrice;

    /**
     * 配送地址
     */
    @Excel(name = "配送地址")
    private String logisticsAddress;

    /**
     * 物流状态
     */
    @Excel(name = "物流状态")
    private Integer logisticsStatus;

    /**
     * 删除标识
     */
    private String delFlag;

}
