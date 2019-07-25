package com.lxy.controller;

import com.lxy.bean.Department;
import com.lxy.bean.Msg;
import com.lxy.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @ClassName DepartmentController
 * @Description TODO
 * @Author hhh
 * Date 2019/7/25 11:41
 * @Version 1.0
 * 处理和部门有关的请求
 **/
@Controller
public class DepartmentController {
    @Autowired
    private DepartmentService departmentService;

    /**
     * 返回所有部门信息
     */
    @RequestMapping("/depts")
    //返回json数据
    @ResponseBody
    public Msg getDepts(){
        /**
         * 查询的部门信息
         */
        List<Department> list = departmentService.getDepts();
        return Msg.success().add("depts",list);
    }
}
