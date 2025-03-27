package com.ruoyi.system.service.impl;

import com.ruoyi.system.domain.vo.ShopCarProductVo;
import com.ruoyi.system.mapper.ShopSkuSpuProductMapper;
import com.ruoyi.system.service.IShopCarService;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.collections4.MapUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author zhl
 * @create 2025/2/20 10:44
 */
@Service
public class ShopCarServiceImpl implements IShopCarService {

    private final Map<Long, Map<Long, Integer>> shopCar = new HashMap<>();

    @Resource
    private ShopSkuSpuProductMapper shopSkuSpuProductMapper;

    @Override
    public void updateShopCar(Long userId, Long productId, Integer num) {
        shopCar.computeIfAbsent(userId, k -> new HashMap<>()).merge(productId, num, Integer::sum);
    }

    @Override
    public List<ShopCarProductVo> getShopCar(Long userId) {
        if (!shopCar.containsKey(userId)) {
            return Collections.emptyList();
        }
        Map<Long, Integer> productMap = shopCar.get(userId);

        Set<Long> productIdList = productMap.keySet();
        if (CollectionUtils.isNotEmpty(productIdList)) {
            List<ShopCarProductVo> shopCarProductVoList = shopSkuSpuProductMapper.selectShopSkuSpuProductByIdList(productIdList);
            shopCarProductVoList.forEach(item -> {
                Long id = item.getId();
                if (productMap.containsKey(id)) {
                    item.setQuantity(Long.valueOf(productMap.get(id)));
                }
            });

            // 根据商品id进行去重，数量进行sum
            Map<Long, ShopCarProductVo> productVoMap = shopCarProductVoList.stream()
                    .collect(Collectors.toMap(
                            ShopCarProductVo::getId,
                            vo -> vo,
                            (existing, replacement) -> {
                                existing.setQuantity(existing.getQuantity() + replacement.getQuantity());
                                return existing;
                            }
                    ));

            return new ArrayList<>(productVoMap.values());
        }
        return Collections.emptyList();
    }

    @Override
    public int getShopCarSize(Long userId) {
        if (!shopCar.containsKey(userId)) {
            return 0;
        }
        Map<Long, Integer> productMap = shopCar.get(userId);
        if (MapUtils.isNotEmpty(productMap)) {
            return productMap.values().stream().mapToInt(Integer::intValue).sum();
        }
        return 0;
    }

    @Override
    public void remove(Long userId, Long productId) {
        shopCar.computeIfPresent(userId, (k, v) -> {
            v.remove(productId);
            return v;
        });
    }
}
