package com.tjnu.shop.control;

import com.github.pagehelper.PageInfo;
import com.tjnu.shop.VO.LayUiVO;
import com.tjnu.shop.VO.ResponseVO;
import com.tjnu.shop.bean.Order;
import com.tjnu.shop.bean.Product;
import com.tjnu.shop.bean.User;
import com.tjnu.shop.service.Impl.UserServiceImpl;
import com.tjnu.shop.service.OrderService;
import com.tjnu.shop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * ClassName: OrderController
 * date: 2021/6/21/021
 *
 * @author zlk
 */
@Controller
@RequestMapping("/order")
public class OrderController {
    @Autowired
    private OrderService orderService;
    /*查询用户用，列出所有用户*/
    @Autowired
    private UserService userService;
    @GetMapping("/listOrderPage")
    public String listOrderPage(){
        return "order/list";
    }

    @GetMapping("/listOrder")
    @ResponseBody
    public LayUiVO listOrder(@RequestParam(defaultValue = "1") Integer page,
                             @RequestParam(defaultValue = "10")Integer limit){
        PageInfo<Product> productPageInfo = orderService.listAll(page, limit);
        LayUiVO layUiVO = LayUiVO.success(productPageInfo.getTotal(),productPageInfo.getList());
        return layUiVO;
    }

    @GetMapping("/delOrder")
    @ResponseBody
    public ResponseVO delOrder(Integer[] ids){
        if (StringUtils.isEmpty(ids)){
            return ResponseVO.failed(1112,"订单id不能为空");
        }
        return orderService.delOrder(ids);
    }

    @GetMapping("/addOrderPage")
    public String addOrderPage(ModelMap modelMap){
        List<User> data = (List<User>) userService.selectAll(1, 10).getData();
        modelMap.addAttribute("userList",data);
        return "order/add";
    }

    @PostMapping("/addOrder")
    @ResponseBody
    public ResponseVO addOrder(@RequestBody Order order){
        System.out.println(order);
        if (order.getUserId() == null){
            return ResponseVO.failed(1700,"用户id不能为空");
        }
        if (order.getPayment() == null){
            return ResponseVO.failed(1701,"金额不能为空");
        }
        return orderService.addOrder(order);
    }


}
