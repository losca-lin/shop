package com.tjnu.shop.test;

import org.junit.Test;

/**
 * ClassName: Substring
 * date: 2021/6/2/002
 *
 * @author zlk
 */
public class Substring {
    @Test
    public void Sub(){
        String str = "a.xml,b.xml";
        String substring = str.substring(str.lastIndexOf("."));
        System.out.println(substring);
    }

}
