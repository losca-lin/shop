package com.tjnu.shop.listener;

import org.apache.commons.io.FileUtils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

/**
 * ClassName: Listener
 * date: 2021/6/8/008
 *
 * @author zlk
 */
public class Listener implements ServletContextListener {
    /**
     * 监听web项目的创建，在创建时把文件转移到相应的项目目录里
     * @param sce 用来获取项目路径
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
//        String realPath = sce.getServletContext().getRealPath("/static/img/");
//        File mPath = new File(realPath);
//        if (!mPath.exists()){
//            mPath.mkdirs();
//        }
//        try {
//            FileUtils.copyDirectory(new File("D:/img/"),mPath);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        System.out.println("文件转移成功");
    }
}
