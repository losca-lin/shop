package com.tjnu.shop.VO;

import lombok.Data;

import java.util.List;

/**
 * ClassName: WangEditorVO
 * date: 2021/6/2/002
 *
 * @author zlk
 */
@Data
public class WangEditorVO {
    private Integer errno;
    private List<WangEditorItem> data;
    public static WangEditorVO success(List<WangEditorItem> data) {
        WangEditorVO wangEditorVO = new WangEditorVO();
        wangEditorVO.errno = 0;
        wangEditorVO.data = data;
        return wangEditorVO;
    }
    public static WangEditorVO failed(Integer errno) {
        WangEditorVO wangEditorVO = new WangEditorVO();
        wangEditorVO.errno = errno;
        return wangEditorVO;
    }
}
