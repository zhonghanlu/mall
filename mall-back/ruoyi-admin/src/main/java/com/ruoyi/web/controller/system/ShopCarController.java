package com.ruoyi.web.controller.system;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.request.ShopCarRequest;
import com.ruoyi.system.service.IShopCarService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * @author zhl
 * @create 2025/2/20 11:35
 */
@RestController
@RequestMapping("/car")
public class ShopCarController {

    @Resource
    private IShopCarService shopCarService;

    @GetMapping("/getShopCar")
    public AjaxResult getShopCar() {
        Long userId = SecurityUtils.getUserId();
        return AjaxResult.success(shopCarService.getShopCar(userId));
    }

    @GetMapping("/getShopCarSize")
    public AjaxResult getShopCarSize() {
        Long userId = SecurityUtils.getUserId();
        return AjaxResult.success(shopCarService.getShopCarSize(userId));
    }

    @PostMapping("/updateShopCar")
    public AjaxResult updateShopCar(@RequestBody ShopCarRequest request) {
        Long userId = SecurityUtils.getUserId();
        shopCarService.updateShopCar(userId, request.getProductId(), request.getNum());
        return AjaxResult.success();
    }

    @GetMapping("/remove/{productId}")
    public AjaxResult remove(@PathVariable("productId") Long productId) {
        Long userId = SecurityUtils.getUserId();
        shopCarService.remove(userId, productId);
        return AjaxResult.success();
    }


}
