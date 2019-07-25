package com.lxy.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lxy.bean.Employee;
import com.lxy.bean.Msg;
import com.lxy.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理员工crud请求
 * @ClassName EmployeeController
 * @Description TODO
 * @Author hhh
 * Date 2019/7/22 16:08
 * @Version 1.0
 **/
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1  ")Integer pn){
        //引入PageHepler分页插件
        //查询前调用,传入页码，以及每页大小
        PageHelper.startPage(pn,5);
        //startPage后面跟的这个查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //pageinfo封装了很多详细分页信息,连续显示页数
        PageInfo page = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);
    }



    /**
     * 查询员工数据（分页查询）
     * @return
     */
    //@RequestMapping("/emps")
    //默认显示第一页
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1  ")Integer pn
            , Model model){
        //引入PageHepler分页插件
        //查询前调用,传入页码，以及每页大小
        PageHelper.startPage(pn,5);
        //startPage后面跟的这个查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //pageinfo封装了很多详细分页信息,连续显示页数
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);
        return "list";
    }
}
