package com.tjnu.shop.control;

import com.tjnu.shop.VO.EchartsVO;
import com.tjnu.shop.VO.ResponseVO;
import com.tjnu.shop.bean.Category;
import com.tjnu.shop.service.CategoryService;
import com.tjnu.shop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * ClassName: CategoryController
 * date: 2021/5/31/031
 *
 * @author zlk
 */
@Controller
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @GetMapping("/listLeafCategory")
    @ResponseBody
    public ResponseVO listLeafCategory(){
        return ResponseVO.success(categoryService.listLeafCategory());
    }

    @GetMapping("/categoryShowPage")
    public String categoryShowPage(){
        return "echarts/categoryShow";
    }

    @GetMapping("/categoryShow")
    @ResponseBody
    public EchartsVO categoryShow(){
        List<Category> categories = categoryService.listLeafCategory();
        List<String> xData = new ArrayList<>();
        List<Integer> detailData = new ArrayList<>();
        for (Category category : categories) {
            String cname = category.getName();
            Integer i = productService.countProduct(cname);
            if (i < 0){
                return EchartsVO.error(500);
            }else if (i == 0){

            }else {
                xData.add(cname);
                detailData.add(i);
            }
        }
        return EchartsVO.success(xData,detailData);
    }

}
