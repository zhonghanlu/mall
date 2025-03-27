package com.ruoyi.system.service.impl;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.IDGenerator;
import com.ruoyi.system.domain.ShopLogistics;
import com.ruoyi.system.domain.ShopOrder;
import com.ruoyi.system.mapper.ShopLogisticsMapper;
import com.ruoyi.system.mapper.ShopOrderMapper;
import com.ruoyi.system.service.IShopLogisticsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;

/**
 * 物流信息Service业务层处理
 *
 * @author baq
 * @date 2025-02-17
 */
@Service
public class ShopLogisticsServiceImpl implements IShopLogisticsService {
    @Resource
    private ShopLogisticsMapper shopLogisticsMapper;

    @Resource
    private ShopOrderMapper shopOrderMapper;

    /**
     * 查询物流信息
     *
     * @param id 物流信息主键
     * @return 物流信息
     */
    @Override
    public ShopLogistics selectShopLogisticsById(Long id) {
        return shopLogisticsMapper.selectShopLogisticsById(id);
    }

    /**
     * 查询物流信息列表
     *
     * @param shopLogistics 物流信息
     * @return 物流信息
     */
    @Override
    public List<ShopLogistics> selectShopLogisticsList(ShopLogistics shopLogistics) {
        return shopLogisticsMapper.selectShopLogisticsList(shopLogistics);
    }

    /**
     * 新增物流信息
     *
     * @param shopLogistics 物流信息
     * @return 结果
     */
    @Override
    public int insertShopLogistics(ShopLogistics shopLogistics) {
        shopLogistics.setId(IDGenerator.next());
        shopLogistics.setCreateTime(DateUtils.getNowDate());
        return shopLogisticsMapper.insertShopLogistics(shopLogistics);
    }

    /**
     * 修改物流信息
     *
     * @param shopLogistics 物流信息
     * @return 结果
     */
    @Override
    public int updateShopLogistics(ShopLogistics shopLogistics) {
        shopLogistics.setUpdateTime(DateUtils.getNowDate());
        return shopLogisticsMapper.updateShopLogistics(shopLogistics);
    }

    /**
     * 批量删除物流信息
     *
     * @param ids 需要删除的物流信息主键
     * @return 结果
     */
    @Override
    public int deleteShopLogisticsByIds(Long[] ids) {
        return shopLogisticsMapper.deleteShopLogisticsByIds(ids);
    }

    /**
     * 删除物流信息信息
     *
     * @param id 物流信息主键
     * @return 结果
     */
    @Override
    public int deleteShopLogisticsById(Long id) {
        return shopLogisticsMapper.deleteShopLogisticsById(id);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int take(Long id) {
        ShopLogistics shopLogistics = shopLogisticsMapper.selectShopLogisticsById(id);

        if (Objects.isNull(shopLogistics)) {
            throw new ServiceException("接单数据不存在");
        }

        if (shopLogistics.getLogisticsStatus() != 0) {
            throw new ServiceException("接单数据状态错误");
        }

        shopLogistics.setLogisticsStatus(1);// 已接单
        return shopLogisticsMapper.updateShopLogistics(shopLogistics);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int confirm(Long id) {
        ShopLogistics shopLogistics = shopLogisticsMapper.selectShopLogisticsById(id);
        if (Objects.isNull(shopLogistics)) {
            throw new ServiceException("送达数据不存在");
        }
        if (shopLogistics.getLogisticsStatus() != 1) {
            throw new ServiceException("数据状态不为待送货");
        }

        shopLogistics.setLogisticsStatus(3); // 送达

        Long orderId = shopLogistics.getOrderId();
        if (Objects.nonNull(orderId)) {
            // 更新订单状态
            ShopOrder shopOrder = shopOrderMapper.selectShopOrderById(orderId);
            shopOrder.setOrderStatus(4L);
            shopOrderMapper.updateShopOrder(shopOrder);
        }

        return shopLogisticsMapper.updateShopLogistics(shopLogistics);
    }
}
