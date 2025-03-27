package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.IDGenerator;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.ShopLogistics;
import com.ruoyi.system.domain.ShopOrder;
import com.ruoyi.system.domain.ShopOrderProduct;
import com.ruoyi.system.domain.ShopSkuSpuProduct;
import com.ruoyi.system.domain.request.ShopOrderRequest;
import com.ruoyi.system.domain.vo.ShopSkuSpuProductVo;
import com.ruoyi.system.mapper.*;
import com.ruoyi.system.service.IShopOrderService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

/**
 * 订单信息Service业务层处理
 *
 * @author baq
 * @date 2025-02-17
 */
@Service
public class ShopOrderServiceImpl implements IShopOrderService {

    @Resource
    private ShopOrderMapper shopOrderMapper;

    @Resource
    private ShopLogisticsMapper shopLogisticsMapper;

    @Resource
    private ShopOrderProductMapper shopOrderProductMapper;

    @Resource
    private ShopSkuSpuProductMapper shopSkuSpuProductMapper;

    @Resource
    private SysUserMapper sysUserMapper;

    /**
     * 查询订单信息
     *
     * @param id 订单信息主键
     * @return 订单信息
     */
    @Override
    public ShopOrder selectShopOrderById(Long id) {
        ShopOrder order = shopOrderMapper.selectShopOrderById(id);

        if (Objects.isNull(order)) {
            return null;
        }
        // 获取此订单对应详细商品信息
        List<ShopSkuSpuProductVo> shopSkuSpuProductVoList = shopOrderProductMapper.selectShopProductDetailByOrderId(id);

        order.setShopSkuSpuProductVoList(shopSkuSpuProductVoList);
        return order;
    }

    /**
     * 查询订单信息列表
     *
     * @param shopOrder 订单信息
     * @return 订单信息
     */
    @Override
    public List<ShopOrder> selectShopOrderList(ShopOrder shopOrder) {
        return shopOrderMapper.selectShopOrderList(shopOrder);
    }

    /**
     * 新增订单信息
     *
     * @param shopOrder 订单信息
     * @return 结果
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int insertShopOrder(ShopOrder shopOrder) {
        shopOrder.setId(IDGenerator.next());
        shopOrder.setCreateTime(DateUtils.getNowDate());
        return shopOrderMapper.insertShopOrder(shopOrder);
    }

    /**
     * 修改订单信息
     *
     * @param shopOrder 订单信息
     * @return 结果
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int updateShopOrder(ShopOrder shopOrder) {
        shopOrder.setUpdateTime(DateUtils.getNowDate());
        return shopOrderMapper.updateShopOrder(shopOrder);
    }

    /**
     * 批量删除订单信息
     *
     * @param ids 需要删除的订单信息主键
     * @return 结果
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteShopOrderByIds(Long[] ids) {
        return shopOrderMapper.deleteShopOrderByIds(ids);
    }

    /**
     * 删除订单信息信息
     *
     * @param id 订单信息主键
     * @return 结果
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteShopOrderById(Long id) {
        return shopOrderMapper.deleteShopOrderById(id);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int sendOrder(Long orderId) {
        ShopOrder order = shopOrderMapper.selectShopOrderById(orderId);
        if (Objects.isNull(order)) {
            throw new ServiceException("订单信息不存在");
        }

        if (1L != order.getOrderStatus()) {
            throw new ServiceException("订单状态有误不允许发货");
        }

        // 新增物流信息
        ShopLogistics shopLogistics = new ShopLogistics();
        shopLogistics.setId(IDGenerator.next());
        shopLogistics.setOrderId(order.getId());
        shopLogistics.setLogisticsName("顺丰");
        shopLogistics.setLogisticsTime(new Date());
        shopLogistics.setLogisticsPrice(5L);
        shopLogistics.setLogisticsStatus(0); // 待接单
        shopLogistics.setLogisticsAddress(order.getOrderAddress());
        shopLogistics.setDelFlag("0");
        shopLogisticsMapper.insertShopLogistics(shopLogistics);

        // 修改订单状态
        order.setOrderStatus(3L); // 已发货
        return shopOrderMapper.updateShopOrder(order);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Long addOrder(ShopOrderRequest request) {
        List<ShopOrderRequest.ProductDTO> productDTOList = request.getProductDTOList();

        List<ShopOrderProduct> orderProductList = new ArrayList<>();
        Long userId = SecurityUtils.getUserId();
        SysUser sysUser = sysUserMapper.selectUserById(userId);

        productDTOList.forEach(product -> {
            // 1.检查商品信息
            ShopSkuSpuProduct shopSkuSpuProduct = shopSkuSpuProductMapper.selectShopSkuSpuProductById(product.getProductId());
            if (Objects.isNull(shopSkuSpuProduct)) {
                throw new ServiceException("商品信息不存在");
            }

            if (0 == shopSkuSpuProduct.getProductStatus()) {
                throw new ServiceException("下架商品不可购买");
            }

            // 2.检查商品库存
            Long productInventory = shopSkuSpuProduct.getProductInventory();
            Long quantity = product.getQuantity();
            if (quantity > productInventory) {
                throw new ServiceException(shopSkuSpuProduct.getProductName() + "库存不足");
            }
            // 3.扣减库存
            long resultInventory = productInventory - quantity;
            shopSkuSpuProduct.setProductInventory(resultInventory);

            int i = shopSkuSpuProductMapper.updateShopSkuSpuProduct(shopSkuSpuProduct);

            if (i <= 0) {
                throw new ServiceException("库存扣减失败");
            }
            // 4.创建关联关系
            ShopOrderProduct shopOrderProduct = new ShopOrderProduct();
            shopOrderProduct.setId(IDGenerator.next());
            shopOrderProduct.setProductId(product.getProductId());
            shopOrderProduct.setQuantity(product.getQuantity());
            orderProductList.add(shopOrderProduct);
        });

        // 5.创建订单
        ShopOrder order = saveOrder(sysUser, orderProductList);

        return order.getId();
    }

    /**
     * 保存订单信息
     *
     * @param sysUser
     * @param orderProductList
     * @return
     */
    private ShopOrder saveOrder(SysUser sysUser, List<ShopOrderProduct> orderProductList) {
        ShopOrder order = new ShopOrder();
        order.setId(IDGenerator.next());
        order.setPlaceOrderName(sysUser.getNickName());
        order.setOrderStatus(0L); // 待付款
        order.setOrderAddress("");
        order.setOrderPhone(sysUser.getPhonenumber());
        order.setOrderTime(new Date());
        order.setCreateBy(String.valueOf(sysUser.getUserId()));
        order.setDelFlag("0");
        orderProductList.forEach(item -> item.setOrderId(order.getId()));

        int i1 = shopOrderProductMapper.batchInsertShopOrderProduct(orderProductList);
        if (i1 <= 0) {
            throw new ServiceException("订单关系新增失败");
        }

        int i = shopOrderMapper.insertShopOrder(order);
        if (i <= 0) {
            throw new ServiceException("订单新增失败");
        }
        return order;
    }
}
