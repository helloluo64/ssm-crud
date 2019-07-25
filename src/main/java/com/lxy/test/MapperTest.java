package com.lxy.test;

import com.lxy.dao.DepartmentMapper;
import com.lxy.dao.EmployeeMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * @ClassName MapperTest
 * @Description TODO
 * @Author hhh
 * Date 2019/7/21 21:58
 * @Version 1.0
 **/
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/applicationContext.xml"})
public class MapperTest {
    @Autowired
    EmployeeMapper employeeMapper;
    @Test
    public void testCRUD(){
        System.out.println(employeeMapper);
    }
}
