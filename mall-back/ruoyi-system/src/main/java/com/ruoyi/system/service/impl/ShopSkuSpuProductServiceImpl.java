package com.ruoyi.system.service.impl;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.IDGenerator;
import com.ruoyi.system.domain.ShopCategory;
import com.ruoyi.system.domain.ShopLabel;
import com.ruoyi.system.domain.ShopProductLabel;
import com.ruoyi.system.domain.ShopSkuSpuProduct;
import com.ruoyi.system.mapper.ShopCategoryMapper;
import com.ruoyi.system.mapper.ShopProductLabelMapper;
import com.ruoyi.system.mapper.ShopSkuSpuProductMapper;
import com.ruoyi.system.service.IShopSkuSpuProductService;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * 商品Service业务层处理
 *
 * @author baq
 * @date 2025-02-16
 */
@Service
public class ShopSkuSpuProductServiceImpl implements IShopSkuSpuProductService {
    @Resource
    private ShopSkuSpuProductMapper shopSkuSpuProductMapper;

    @Resource
    private ShopProductLabelMapper shopProductLabelMapper;

    @Resource
    private ShopCategoryMapper shopCategoryMapper;

    /**
     * 查询商品
     *
     * @param id 商品主键
     * @return 商品
     */
    @Override
    public ShopSkuSpuProduct selectShopSkuSpuProductById(Long id) {
        ShopSkuSpuProduct shopSkuSpuProduct = shopSkuSpuProductMapper.selectShopSkuSpuProductById(id);
        List<Long> labelIdList = shopProductLabelMapper.selectLabelIdList(id);
        shopSkuSpuProduct.setLabelIdList(labelIdList);
        return shopSkuSpuProduct;
    }

    /**
     * 查询商品列表
     *
     * @param shopSkuSpuProduct 商品
     * @return 商品
     */
    @Override
    public List<ShopSkuSpuProduct> selectShopSkuSpuProductList(ShopSkuSpuProduct shopSkuSpuProduct) {
        List<ShopSkuSpuProduct> shopSkuSpuProductList = shopSkuSpuProductMapper.selectProductPage(shopSkuSpuProduct);
        // 解决 mybatis  一对多分页问题，手动映射
        List<Long> productIdList = shopSkuSpuProductList.stream().map(ShopSkuSpuProduct::getId).collect(Collectors.toList());

        if (CollectionUtils.isEmpty(productIdList)) {
            return shopSkuSpuProductList;
        }

        List<ShopProductLabel> shopProductLabelList = shopProductLabelMapper.selectLabelListByProductIdList(productIdList);

        if (CollectionUtils.isEmpty(shopProductLabelList)) {
            return shopSkuSpuProductList;
        }

        Map<Long, List<ShopProductLabel>> productLabelMap = shopProductLabelList.stream().collect(Collectors.groupingBy(ShopProductLabel::getProductId));
        shopSkuSpuProductList.forEach(item -> {
            List<ShopProductLabel> shopProductLabels = productLabelMap.get(item.getId());
            if (CollectionUtils.isNotEmpty(shopProductLabels)) {
                item.setShopLabelList(convertLabel(shopProductLabels));
            }
        });
        return shopSkuSpuProductList;
    }

    /**
     * 转换
     *
     * @param shopProductLabels
     * @return
     */
    private List<ShopLabel> convertLabel(List<ShopProductLabel> shopProductLabels) {
        if (CollectionUtils.isNotEmpty(shopProductLabels)) {
            return shopProductLabels.stream().map(item -> {
                ShopLabel shopLabel = new ShopLabel();
                shopLabel.setId(item.getLabelId());
                shopLabel.setLabelName(item.getLabelName());
                return shopLabel;
            }).collect(Collectors.toList());
        }
        return Collections.emptyList();
    }

    /**
     * 新增商品
     *
     * @param shopSkuSpuProduct 商品
     * @return 结果
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int insertShopSkuSpuProduct(ShopSkuSpuProduct shopSkuSpuProduct) {
        long productId = IDGenerator.next();
        shopSkuSpuProduct.setId(productId);
        shopSkuSpuProduct.setCreateTime(DateUtils.getNowDate());

        // 分类数据
        setCategoryName(shopSkuSpuProduct);

        // 标签
        List<Long> labelIdList = shopSkuSpuProduct.getLabelIdList();
        if (CollectionUtils.isNotEmpty(labelIdList)) {
            saveProductLabel(labelIdList, productId);
        }

        // 默认下架状态
        shopSkuSpuProduct.setDelFlag("0");

        return shopSkuSpuProductMapper.insertShopSkuSpuProduct(shopSkuSpuProduct);
    }

    /**
     * 分类数据校验查询
     *
     * @param shopSkuSpuProduct
     */
    private void setCategoryName(ShopSkuSpuProduct shopSkuSpuProduct) {
        if (Objects.nonNull(shopSkuSpuProduct.getCategoryId())) {
            ShopCategory shopCategory = shopCategoryMapper.selectShopCategoryById(shopSkuSpuProduct.getCategoryId());
            if (Objects.isNull(shopCategory)) {
                throw new ServiceException("分类数据不存在");
            }
            shopSkuSpuProduct.setCategoryName(shopCategory.getCategoryName());
        }
    }

    /**
     * 统一新增商品标签
     *
     * @param labelIdList
     * @param productId
     */
    private void saveProductLabel(List<Long> labelIdList, long productId) {
        List<ShopProductLabel> shopProductLabelList = labelIdList.stream().map(item -> {
            ShopProductLabel productLabel = new ShopProductLabel();
            productLabel.setId(IDGenerator.next());
            productLabel.setProductId(productId);
            productLabel.setLabelId(item);
            return productLabel;
        }).collect(Collectors.toList());

        int i = shopProductLabelMapper.batchInsertShopProductLabel(shopProductLabelList);

        if (i <= 0) {
            throw new ServiceException("标签新增失败");
        }
    }

    /**
     * 修改商品
     *
     * @param shopSkuSpuProduct 商品
     * @return 结果
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int updateShopSkuSpuProduct(ShopSkuSpuProduct shopSkuSpuProduct) {
        // 处理分类数据
        setCategoryName(shopSkuSpuProduct);

        List<Long> labelIdList = shopSkuSpuProduct.getLabelIdList();

        if (CollectionUtils.isNotEmpty(labelIdList)) {
            Long productId = shopSkuSpuProduct.getId();
            // 删除之前的
            shopProductLabelMapper.deleteLabelByProductId(productId);
            // 保存最新的
            saveProductLabel(labelIdList, productId);
        }

        shopSkuSpuProduct.setUpdateTime(DateUtils.getNowDate());
        return shopSkuSpuProductMapper.updateShopSkuSpuProduct(shopSkuSpuProduct);
    }

    /**
     * 批量删除商品
     *
     * @param ids 需要删除的商品主键
     * @return 结果
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteShopSkuSpuProductByIds(Long[] ids) {
        return shopSkuSpuProductMapper.deleteShopSkuSpuProductByIds(ids);
    }

    /**
     * 删除商品信息
     *
     * @param id 商品主键
     * @return 结果
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteShopSkuSpuProductById(Long id) {
        return shopSkuSpuProductMapper.deleteShopSkuSpuProductById(id);
    }
}
