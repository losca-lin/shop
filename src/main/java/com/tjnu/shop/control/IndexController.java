package com.tjnu.shop.control;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * ClassName: indexController
 * date: 2021/5/19/019
 *
 * @author zlk
 */
@Controller
@RequestMapping("/index")
public class IndexController {
    @GetMapping("/index")
    public String index(){
        return "index";
    }
}
