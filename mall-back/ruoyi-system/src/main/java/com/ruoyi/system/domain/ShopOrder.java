package com.ruoyi.system.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.system.domain.vo.ShopSkuSpuProductVo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

/**
 * 订单信息对象 shop_order
 *
 * @author baq
 * @date 2025-02-17
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class ShopOrder extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
    private Long id;

    /**
     * 下单人姓名
     */
    @Excel(name = "下单人姓名")
    private String placeOrderName;

    /**
     * 订单状态
     */
    @Excel(name = "订单状态")
    private Long orderStatus;

    /**
     * 订单地址
     */
    @Excel(name = "订单地址")
    private String orderAddress;

    /**
     * 订单电话
     */
    @Excel(name = "订单电话")
    private String orderPhone;

    /**
     * 订单时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "订单时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date orderTime;

    /**
     * 支付时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss")
    @Excel(name = "支付时间", width = 30, dateFormat = "yyyy-MM-dd hh:mm:ss")
    private Date payTime;

    /**
     * 订单总价
     */
    private String orderTotalPrice;

    /**
     * 支付号
     */
    private String payNo;

    /**
     * 删除标识
     */
    private String delFlag;


    ////////////////////////
    /**
     * 商品总价
     */
    private String productTotalPrice;

    /**
     * 商品信息
     */
    private List<ShopSkuSpuProductVo> shopSkuSpuProductVoList;

}
