package com.ruoyi.web.controller.system;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.ShopLabel;
import com.ruoyi.system.service.IShopLabelService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 商品标签Controller
 *
 * @author baq
 * @date 2025-02-16
 */
@RestController
@RequestMapping("/system/label")
public class ShopLabelController extends BaseController {
    @Resource
    private IShopLabelService shopLabelService;

    /**
     * 查询商品标签列表
     */
    @PreAuthorize("@ss.hasPermi('system:label:list')")
    @GetMapping("/list")
    public TableDataInfo list(ShopLabel shopLabel) {
        startPage();
        List<ShopLabel> list = shopLabelService.selectShopLabelList(shopLabel);
        return getDataTable(list);
    }

    /**
     * 查询商品标签列表
     */
    @GetMapping("/list/all")
    public AjaxResult listAll(ShopLabel shopLabel) {
        List<ShopLabel> list = shopLabelService.selectShopLabelList(shopLabel);
        return success(list);
    }

    /**
     * 导出商品标签列表
     */
    @PreAuthorize("@ss.hasPermi('system:label:export')")
    @Log(title = "商品标签", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ShopLabel shopLabel) {
        List<ShopLabel> list = shopLabelService.selectShopLabelList(shopLabel);
        ExcelUtil<ShopLabel> util = new ExcelUtil<>(ShopLabel.class);
        util.exportExcel(response, list, "商品标签数据");
    }

    /**
     * 获取商品标签详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:label:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return success(shopLabelService.selectShopLabelById(id));
    }

    /**
     * 新增商品标签
     */
    @PreAuthorize("@ss.hasPermi('system:label:add')")
    @Log(title = "商品标签", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ShopLabel shopLabel) {
        return toAjax(shopLabelService.insertShopLabel(shopLabel));
    }

    /**
     * 修改商品标签
     */
    @PreAuthorize("@ss.hasPermi('system:label:edit')")
    @Log(title = "商品标签", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ShopLabel shopLabel) {
        return toAjax(shopLabelService.updateShopLabel(shopLabel));
    }

    /**
     * 删除商品标签
     */
    @PreAuthorize("@ss.hasPermi('system:label:remove')")
    @Log(title = "商品标签", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(shopLabelService.deleteShopLabelByIds(ids));
    }
}
