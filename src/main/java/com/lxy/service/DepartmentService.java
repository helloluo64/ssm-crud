package com.lxy.service;

import com.lxy.bean.Department;
import com.lxy.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ClassName DepartmentService
 * @Description TODO
 * @Author hhh
 * Date 2019/7/25 15:17
 * @Version 1.0
 **/
@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts() {

        List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }
}
