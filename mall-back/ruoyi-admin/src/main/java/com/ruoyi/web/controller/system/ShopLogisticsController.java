package com.ruoyi.web.controller.system;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.ShopLogistics;
import com.ruoyi.system.service.IShopLogisticsService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 物流信息Controller
 *
 * @author baq
 * @date 2025-02-17
 */
@RestController
@RequestMapping("/system/logistics")
public class ShopLogisticsController extends BaseController {
    @Resource
    private IShopLogisticsService shopLogisticsService;

    /**
     * 查询物流信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:logistics:list')")
    @GetMapping("/list")
    public TableDataInfo list(ShopLogistics shopLogistics) {
        startPage();
        List<ShopLogistics> list = shopLogisticsService.selectShopLogisticsList(shopLogistics);
        return getDataTable(list);
    }

    /**
     * 导出物流信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:logistics:export')")
    @Log(title = "物流信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ShopLogistics shopLogistics) {
        List<ShopLogistics> list = shopLogisticsService.selectShopLogisticsList(shopLogistics);
        ExcelUtil<ShopLogistics> util = new ExcelUtil<>(ShopLogistics.class);
        util.exportExcel(response, list, "物流信息数据");
    }

    /**
     * 获取物流信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:logistics:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return success(shopLogisticsService.selectShopLogisticsById(id));
    }

    /**
     * 新增物流信息
     */
//    @PreAuthorize("@ss.hasPermi('system:logistics:add')")
    @Log(title = "物流信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ShopLogistics shopLogistics) {
        return toAjax(shopLogisticsService.insertShopLogistics(shopLogistics));
    }

    /**
     * 修改物流信息
     */
    @PreAuthorize("@ss.hasPermi('system:logistics:edit')")
    @Log(title = "物流信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ShopLogistics shopLogistics) {
        return toAjax(shopLogisticsService.updateShopLogistics(shopLogistics));
    }

    /**
     * 接单
     */
    @PreAuthorize("@ss.hasPermi('system:logistics:edit')")
    @Log(title = "接单", businessType = BusinessType.UPDATE)
    @PutMapping("/take/{id}")
    public AjaxResult take(@PathVariable("id") Long id) {
        return toAjax(shopLogisticsService.take(id));
    }

    /**
     * 送达
     */
    @PreAuthorize("@ss.hasPermi('system:logistics:edit')")
    @Log(title = "送达", businessType = BusinessType.UPDATE)
    @PutMapping("/confirm/{id}")
    public AjaxResult confirm(@PathVariable("id") Long id) {
        return toAjax(shopLogisticsService.confirm(id));
    }

    /**
     * 删除物流信息
     */
//    @PreAuthorize("@ss.hasPermi('system:logistics:remove')")
    @Log(title = "物流信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(shopLogisticsService.deleteShopLogisticsByIds(ids));
    }
}
