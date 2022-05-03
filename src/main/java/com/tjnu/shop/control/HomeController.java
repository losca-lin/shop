package com.tjnu.shop.control;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * ClassName: HomeController
 * date: 2021/5/19/019
 *
 * @author zlk
 */
@Controller
@RequestMapping("/home")
public class HomeController {
    @GetMapping("/console")
    public String console(){
        return "home/console";
    }
}
