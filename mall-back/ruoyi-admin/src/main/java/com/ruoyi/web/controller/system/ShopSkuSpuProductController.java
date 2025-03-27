package com.ruoyi.web.controller.system;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.ShopSkuSpuProduct;
import com.ruoyi.system.service.IShopSkuSpuProductService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 商品Controller
 *
 * @author baq
 * @date 2025-02-16
 */
@RestController
@RequestMapping("/system/product")
public class ShopSkuSpuProductController extends BaseController {
    @Resource
    private IShopSkuSpuProductService shopSkuSpuProductService;

    /**
     * 查询商品列表
     */
//    @PreAuthorize("@ss.hasPermi('system:product:list')")
    @GetMapping("/list")
    public TableDataInfo list(ShopSkuSpuProduct shopSkuSpuProduct) {
        startPage();
        List<ShopSkuSpuProduct> list = shopSkuSpuProductService.selectShopSkuSpuProductList(shopSkuSpuProduct);
        return getDataTable(list);
    }

    /**
     * 导出商品列表
     */
//    @PreAuthorize("@ss.hasPermi('system:product:export')")
    @Log(title = "商品", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ShopSkuSpuProduct shopSkuSpuProduct) {
        List<ShopSkuSpuProduct> list = shopSkuSpuProductService.selectShopSkuSpuProductList(shopSkuSpuProduct);
        ExcelUtil<ShopSkuSpuProduct> util = new ExcelUtil<>(ShopSkuSpuProduct.class);
        util.exportExcel(response, list, "商品数据");
    }

    /**
     * 获取商品详细信息
     */
//    @PreAuthorize("@ss.hasPermi('system:product:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return success(shopSkuSpuProductService.selectShopSkuSpuProductById(id));
    }

    /**
     * 新增商品
     */
//    @PreAuthorize("@ss.hasPermi('system:product:add')")
    @Log(title = "商品", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ShopSkuSpuProduct shopSkuSpuProduct) {
        return toAjax(shopSkuSpuProductService.insertShopSkuSpuProduct(shopSkuSpuProduct));
    }

    /**
     * 修改商品
     */
//    @PreAuthorize("@ss.hasPermi('system:product:edit')")
    @Log(title = "商品", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ShopSkuSpuProduct shopSkuSpuProduct) {
        return toAjax(shopSkuSpuProductService.updateShopSkuSpuProduct(shopSkuSpuProduct));
    }

    /**
     * 删除商品
     */
//    @PreAuthorize("@ss.hasPermi('system:product:remove')")
    @Log(title = "商品", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(shopSkuSpuProductService.deleteShopSkuSpuProductByIds(ids));
    }
}
