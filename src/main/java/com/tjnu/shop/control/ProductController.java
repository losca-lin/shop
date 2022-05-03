package com.tjnu.shop.control;

import com.github.pagehelper.PageInfo;
import com.tjnu.shop.VO.LayUiVO;
import com.tjnu.shop.VO.ResponseVO;
import com.tjnu.shop.bean.Category;
import com.tjnu.shop.bean.Product;
import com.tjnu.shop.form.ProductForm;
import com.tjnu.shop.mapper.CategoryMapper;
import com.tjnu.shop.service.CategoryService;
import com.tjnu.shop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * ClassName: ProductController
 * date: 2021/5/19/019
 *
 * @author zlk
 */
@Controller
@RequestMapping("/product")
public class ProductController {
    @Autowired
    private ProductService productService;
    @Autowired
    private CategoryService categoryService;
    @GetMapping("/productListPage")
    public String productList(){
        return "product/list";
    }
    @GetMapping("/allProduct")
    @ResponseBody
    public LayUiVO allProduct(@RequestParam(defaultValue = "1") Integer page,
                              @RequestParam(defaultValue = "10")Integer limit,
                              @RequestParam(defaultValue = "-1") Integer categoryId){
        PageInfo<Product> productPageInfo = productService.P_CList(page, limit,categoryId);
        LayUiVO layUiVO = LayUiVO.success(productPageInfo.getTotal(),productPageInfo.getList());
        return layUiVO;
    }
    @PostMapping("/updateProductById")
    @ResponseBody
    public ResponseVO updateProductById(@RequestBody Product product){
       return productService.updateProductById(product);
    }
    @GetMapping("/addProductPage")
    public String addProductPage(ModelMap modelMap){
        List<Category> categoryList = categoryService.listLeafCategory();
        modelMap.put("categoryList",categoryList);
        return "product/add";
    }
    /*数据校验 @vaild 加bindresult*/
    @PostMapping("/addProduct")
    @ResponseBody
    public ResponseVO addProduct(@RequestBody @Valid ProductForm productForm, BindingResult result){
        if (result.getErrorCount() > 0) {
            return ResponseVO.failed(1004,result.getAllErrors().get(0).getDefaultMessage());
        }
        return productService.addProduct(productForm);
    }
    /*做搜索接口*/
    @GetMapping("/searchProduct")
    @ResponseBody
    public LayUiVO searchProduct(@RequestParam(defaultValue = "1") Integer page,
                                  @RequestParam(defaultValue = "10")Integer limit,
                                 String name){
        PageInfo<Product> productPageInfo = productService.selectBySearch(page, limit,name);
        LayUiVO layUiVO = LayUiVO.success(productPageInfo.getTotal(),productPageInfo.getList());
        return layUiVO;
    }
    @GetMapping("/delProduct")
    @ResponseBody
    public ResponseVO delProduct(Integer[] ids){
        if (StringUtils.isEmpty(ids)){
            return ResponseVO.failed(1112,"用户id不能为空");
        }
        return productService.delProduct(ids);
    }
}
