package com.tjnu.shop.VO;

import lombok.Data;

import java.util.List;

/**
 * ClassName: EchartsVO
 * date: 2021/6/18/018
 *
 * @author zlk
 */
@Data
public class EchartsVO {
    private Integer code;
    private Object xaxisData;
    private Object detailData;

    public static EchartsVO success(Object xaxisData, Object detailData) {
        EchartsVO echartsVO = new EchartsVO();
        echartsVO.code = 0;
        echartsVO.xaxisData = xaxisData;
        echartsVO.detailData = detailData;
        return echartsVO;
    }

    public static EchartsVO error(Integer code) {
        EchartsVO echartsVO = new EchartsVO();
        echartsVO.code = code;
        return echartsVO;
    }
}
