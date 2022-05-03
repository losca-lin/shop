package com.tjnu.shop.VO;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonIncludeProperties;
import lombok.Data;

/**
 * ClassName: ResponseVO
 * date: 2021/5/26/026
 *
 * @author zlk
 */
@Data
public class ResponseVO {
    private Integer code;
    private String msg;
    /*让返回值不为空才显示*/
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Object data;
    public static ResponseVO success(){
        ResponseVO responseVO = new ResponseVO();
        responseVO.code = 0;
        responseVO.msg = "成功";
        return responseVO;
    }
    public static ResponseVO success(Object data){
        ResponseVO responseVO = new ResponseVO();
        responseVO.code = 0;
        responseVO.msg = "成功";
        responseVO.data = data;
        return responseVO;
    }
    public static ResponseVO failed(Integer code, String msg){
        ResponseVO responseVO = new ResponseVO();
        responseVO.code = code;
        responseVO.msg = msg;
        return responseVO;
    }

}
