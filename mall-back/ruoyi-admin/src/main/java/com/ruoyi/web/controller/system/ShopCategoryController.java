package com.ruoyi.web.controller.system;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.ShopCategory;
import com.ruoyi.system.service.IShopCategoryService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 分类Controller
 *
 * @author baq
 * @date 2025-02-16
 */
@RestController
@RequestMapping("/system/category")
public class ShopCategoryController extends BaseController {

    @Resource
    private IShopCategoryService shopCategoryService;

    /**
     * 查询分类列表
     */
    @PreAuthorize("@ss.hasPermi('system:category:list')")
    @GetMapping("/list")
    public TableDataInfo list(ShopCategory shopCategory) {
        startPage();
        List<ShopCategory> list = shopCategoryService.selectShopCategoryList(shopCategory);
        return getDataTable(list);
    }

    /**
     * 查询分类列表
     */
    @GetMapping("/list/all")
    public AjaxResult listAll(ShopCategory shopCategory) {
        List<ShopCategory> list = shopCategoryService.selectShopCategoryList(shopCategory);
        return success(list);
    }

    /**
     * 导出分类列表
     */
    @PreAuthorize("@ss.hasPermi('system:category:export')")
    @Log(title = "分类", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ShopCategory shopCategory) {
        List<ShopCategory> list = shopCategoryService.selectShopCategoryList(shopCategory);
        ExcelUtil<ShopCategory> util = new ExcelUtil<>(ShopCategory.class);
        util.exportExcel(response, list, "分类数据");
    }

    /**
     * 获取分类详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:category:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return success(shopCategoryService.selectShopCategoryById(id));
    }

    /**
     * 新增分类
     */
    @PreAuthorize("@ss.hasPermi('system:category:add')")
    @Log(title = "分类", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ShopCategory shopCategory) {
        return toAjax(shopCategoryService.insertShopCategory(shopCategory));
    }

    /**
     * 修改分类
     */
    @PreAuthorize("@ss.hasPermi('system:category:edit')")
    @Log(title = "分类", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ShopCategory shopCategory) {
        return toAjax(shopCategoryService.updateShopCategory(shopCategory));
    }

    /**
     * 删除分类
     */
    @PreAuthorize("@ss.hasPermi('system:category:remove')")
    @Log(title = "分类", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(shopCategoryService.deleteShopCategoryByIds(ids));
    }
}
