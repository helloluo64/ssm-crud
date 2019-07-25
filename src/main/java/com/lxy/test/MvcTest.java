package com.lxy.test;

import com.github.pagehelper.PageInfo;
import com.lxy.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;


/**
 * spring提供的测试模块
 * @ClassName MvcTest
 * @Description TODO
 * @Author hhh
 * Date 2019/7/22 16:45
 * @Version 1.0
 **/
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:spring/applicationContext.xml","classpath:spring/spring-mvc.xml"})
public class MvcTest {

    @Autowired
    WebApplicationContext context;
    // 虚拟的mvc请求
    MockMvc mockMvc;

    @Before
    public void initMock(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();

    }
    @Test
    public void testPage() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1"))
                .andReturn();

        MockHttpServletRequest request = result.getRequest();
        PageInfo attribute = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码："+attribute.getPageNum());
        System.out.println("总页码："+attribute.getPages());
        System.out.println("总记录数："+attribute.getTotal());
        System.out.println("页面需要连续显示的页码");
        int[] nums = attribute.getNavigatepageNums();
        for (int num : nums) {
            System.out.println(num);
        }
        //获取员工数据
        List<Employee> list = attribute.getList();
        for (Employee employee : list) {
            System.out.println(employee.getdId()+""+employee.getEmpId()+employee.getEmpName()+employee.getEmail()+employee.getGender()
            +employee.getDepartment().getDeptName());
        }
    }
}
