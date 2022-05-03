package com.tjnu.shop.control;

import com.tjnu.shop.VO.ResponseVO;
import com.tjnu.shop.VO.WangEditorItem;
import com.tjnu.shop.VO.WangEditorVO;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * ClassName: ImgUploadController
 * date: 2021/6/2/002
 *
 * @author zlk
 */
@Controller
@RequestMapping("/img")
public class ImgUploadController {


    @PostMapping("/layuiImg")
    @ResponseBody
    public ResponseVO layuiImg(MultipartFile file, HttpServletRequest request) {
        if (file == null) {
            return ResponseVO.failed(10001,"文件不能为空");
        }
        String realPath = request.getServletContext().getRealPath("/static/img/layuiImg/");
        File fPath = new File(realPath);
        if (!fPath.exists()) {
            fPath.mkdirs();
        }

        /*filename名后缀.jpg*/
        String fileName = UUID.randomUUID().toString().replaceAll("-", "") + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
        File newFile = new File(realPath + fileName);
        try {
            file.transferTo(newFile);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseVO.failed(10002,"磁盘io异常");
        }
        /*把上传的照片文件夹复制到d盘*/
        try {
            FileUtils.copyDirectory(fPath, new File("D:/img/layuiImg/"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return ResponseVO.success(request.getServletContext().getContextPath()+"/static/img/layuiImg/"+fileName);
    }

    @PostMapping("/wangImg")
    @ResponseBody
    public WangEditorVO wangImgImg(MultipartFile[] files, HttpServletRequest request) {
        if (files == null) {
            return WangEditorVO.failed(10001);
        }
        String realPath = request.getServletContext().getRealPath("/static/img/wangImg/");
        File fPath = new File(realPath);
        if (!fPath.exists()) {
            fPath.mkdirs();
        }
        List<WangEditorItem> wangEditorItems = new ArrayList<>();
        for (MultipartFile file : files) {
            /*filename名后缀.jpg*/
            String fileName = UUID.randomUUID().toString().replaceAll("-", "") + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            File newFile = new File(realPath + fileName);
            try {
                file.transferTo(newFile);
                wangEditorItems.add(new WangEditorItem(request.getServletContext().getContextPath()+"/static/img/wangImg/"+fileName,"",""));
            } catch (Exception e) {
                e.printStackTrace();
                return WangEditorVO.failed(10002);
            }
        }
        /*把上传的照片文件夹复制到d盘*/
        try {
            FileUtils.copyDirectory(fPath, new File("D:/img/wangImg/"));
        } catch (IOException e) {
            e.printStackTrace();
        }


        return WangEditorVO.success(wangEditorItems);
    }

}
