package com.ruoyi.web.controller.system;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.ShopOrder;
import com.ruoyi.system.domain.request.ShopOrderRequest;
import com.ruoyi.system.service.IShopOrderService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 订单信息Controller
 *
 * @author baq
 * @date 2025-02-17
 */
@RestController
@RequestMapping("/system/order")
public class ShopOrderController extends BaseController {

    @Resource
    private IShopOrderService shopOrderService;

    /**
     * 查询订单信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:order:list')")
    @GetMapping("/list")
    public TableDataInfo list(ShopOrder shopOrder) {
        startPage();
        List<ShopOrder> list = shopOrderService.selectShopOrderList(shopOrder);
        return getDataTable(list);
    }

    /**
     * 查询订单信息列表
     */
    @GetMapping("/listBySelf")
    public TableDataInfo listBySelf() {
        startPage();
        Long userId = getUserId();
        ShopOrder order = new ShopOrder();
        order.setCreateBy(String.valueOf(userId));
        List<ShopOrder> list = shopOrderService.selectShopOrderList(order);
        return getDataTable(list);
    }

    /**
     * 导出订单信息列表
     */
//    @PreAuthorize("@ss.hasPermi('system:order:export')")
    @Log(title = "订单信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ShopOrder shopOrder) {
        List<ShopOrder> list = shopOrderService.selectShopOrderList(shopOrder);
        ExcelUtil<ShopOrder> util = new ExcelUtil<>(ShopOrder.class);
        util.exportExcel(response, list, "订单信息数据");
    }

    /**
     * 获取订单信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:order:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return success(shopOrderService.selectShopOrderById(id));
    }

    /**
     * 新增订单信息
     */
//    @PreAuthorize("@ss.hasPermi('system:order:add')")
    @Log(title = "订单信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ShopOrderRequest request) {
        return AjaxResult.success(shopOrderService.addOrder(request));
    }

    /**
     * 修改订单信息
     */
//    @PreAuthorize("@ss.hasPermi('system:order:edit')")
    @Log(title = "订单信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ShopOrder shopOrder) {
        return toAjax(shopOrderService.updateShopOrder(shopOrder));
    }

    /**
     * 修改订单信息
     */
    @PreAuthorize("@ss.hasPermi('system:order:edit')")
    @Log(title = "订单发货", businessType = BusinessType.UPDATE)
    @PutMapping("/send/{orderId}")
    public AjaxResult send(@PathVariable("orderId") Long orderId) {
        return toAjax(shopOrderService.sendOrder(orderId));
    }

    /**
     * 删除订单信息
     */
//    @PreAuthorize("@ss.hasPermi('system:order:remove')")
    @Log(title = "订单信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(shopOrderService.deleteShopOrderByIds(ids));
    }
}
