package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.ShopLogistics;

/**
 * 物流信息Mapper接口
 * 
 * @author baq
 * @date 2025-02-17
 */
public interface ShopLogisticsMapper 
{
    /**
     * 查询物流信息
     * 
     * @param id 物流信息主键
     * @return 物流信息
     */
    public ShopLogistics selectShopLogisticsById(Long id);

    /**
     * 查询物流信息列表
     * 
     * @param shopLogistics 物流信息
     * @return 物流信息集合
     */
    public List<ShopLogistics> selectShopLogisticsList(ShopLogistics shopLogistics);

    /**
     * 新增物流信息
     * 
     * @param shopLogistics 物流信息
     * @return 结果
     */
    public int insertShopLogistics(ShopLogistics shopLogistics);

    /**
     * 修改物流信息
     * 
     * @param shopLogistics 物流信息
     * @return 结果
     */
    public int updateShopLogistics(ShopLogistics shopLogistics);

    /**
     * 删除物流信息
     * 
     * @param id 物流信息主键
     * @return 结果
     */
    public int deleteShopLogisticsById(Long id);

    /**
     * 批量删除物流信息
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteShopLogisticsByIds(Long[] ids);
}
