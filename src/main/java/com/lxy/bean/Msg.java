package com.lxy.bean;

import com.github.pagehelper.PageInfo;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用的返回类
 * @ClassName Msg
 * @Description TODO
 * @Author hhh
 * Date 2019/7/23 23:01
 * @Version 1.0
 **/
public class Msg {
    //状态码
    private int code;
    //提示信息
    private String msg;

    //用户要返回给浏览器的数据
    private Map<String,Object> extend = new HashMap<String, Object>();

    public static Msg success(){
        Msg msg = new Msg();
        msg.setCode(100);
        msg.setMsg("处理成功");
        return msg;
    }

    public static Msg fail(){
        Msg msg1 = new Msg();
        msg1.setCode(200);
        msg1.setMsg("处理失败");
        return msg1;
    }
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }


    public Msg add(String key,Object value) {
        this.getExtend().put(key,value);
        return this;
    }
}
