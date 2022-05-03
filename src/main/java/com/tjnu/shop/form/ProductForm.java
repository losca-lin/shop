package com.tjnu.shop.form;

import com.tjnu.shop.bean.Category;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;

/**
 * ClassName: ProductForm
 * date: 2021/6/2/002
 *
 * @author zlk
 */
@Data
public class ProductForm {
    private Integer id;
    @NotNull(message = "类别id不能为空")
    private Integer categoryId;
    @NotBlank(message = "商品名称不能为空")
    private String name;
    @NotBlank(message = "商品副标题不能为空")
    private String subtitle;
    @NotBlank(message = "主图不能为空")
    private String mainImage;
    @NotBlank(message = "副图不能为空")
    private String subImages;
    @NotBlank(message = "详情不能为空")
    private String detail;
    @NotNull(message = "价格不能为空")
    private BigDecimal price;
    @NotNull(message = "库存不能为空")
    private Integer stock;
    @NotNull(message = "状态不能为空")
    private Integer status;
}
