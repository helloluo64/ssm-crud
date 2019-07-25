<%--
  Created by IntelliJ IDEA.
  User: hhh
  Date: 2019/7/22
  Time: 16:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <%--引入jQuery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.4.1.js"></script>
    <%--引入样式--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 员工添加 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工入职</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工姓名:</label>
                        <div class="col-sm-10">
                            <input type="text" name="empname" class="form-control" id="inputName_add_input" placeholder="XXX">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工email:</label>
                        <div class="col-sm-10">
                            <input type="text" name="empEmail" class="form-control" id="email_add_input" placeholder="empEmail@xxx.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别:</label>
                        <div class="col-sm-10">
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="gender_add1" value="男" checked="checked"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="gender_add2" value="女"> 女
                        </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门:</label>
                        <div class="col-sm-4">
                        <select class="form-control" name="dId" id="deptsName">

                        </select>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h2>人事平台</h2>
        </div>
        <%--按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-10">
                <button class="btn btn-primary btn-sm" id="emp_add_modal">新增</button>
                <button class="btn btn-danger btn-sm">删除</button>
            </div>
        </div>
        <%--显示表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-bordered" id="emps_table">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>员工姓名</th>
                        <th>性别</th>
                        <th>email</th>
                        <th>部门</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>
        <%--显示分页信息--%>
        <div class="row">
            <%--分页文字信息--%>
            <div class="col-md-6" id="page_info_area">

            </div>

            <%--分页条信息--%>
            <div class="col-md-6" id="page_nav_area">

            </div>
        </div>
    </div>
    <script type="text/javascript">
        <%--页面加载完成后，直接发送ajax请求，要的分页数据--%>
        $(function () {
            to_page(1)
        });
        function to_page(pn) {
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pn="+pn,
                type:"GET",
                success:function (result) {
                    // console.log(result)
                    //1、解析并显示员工信息
                    build_emps_table(result);
                    //2、解析并显示分页信息
                    build_page_info(result);
                    //3、解析并显示分页条信息
                    build_page_nav(result);
                }
            });
        }
        //解析显示表格信息
        function build_emps_table(result) {
            //清空table表格
            $("#emps_table tbody").empty();
            var emps = result.extend.pageInfo.list;
            $.each(emps,function (index,item) {
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender);
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.department.deptName);
                //按钮添加
                var editTd = $("<button></button>").addClass("btn btn-primary btn-sm")
                    .append("<span></span>").addClass("glyphicon glyphicon-pencil").append("  编辑");

                var deletTd = $("<button></button>").addClass("btn btn-danger btn-sm")
                    .append("<span></span>").addClass("glyphicon glyphicon-trash").append("  离职");

                var btnTd = $("<td></td>").append(editTd).append("&nbsp;").append(deletTd)
                //append方法执行完成后还是返回原来的元素
                $("<tr></tr>").append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
            });
        }
        //解析显示分页信息
        function build_page_info(result) {
            //清空分页信息
            $("#page_info_area").empty();
            $("#page_info_area").append("当前页码"+result.extend.pageInfo.pageNum+"页, 总页数"+result.extend.pageInfo.pages+"页, 总记录数"+result.extend.pageInfo.total+"条")
        }

        //解析显示分页条
        function build_page_nav(result) {
            //清空分页条
            $("#page_nav_area").empty();
            var ul = $("<ul></ul>").addClass("pagination");
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var hasPreviousPageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            //判断是否有上一页，没有就不能点击首页和上一页按钮
            if (result.extend.pageInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                hasPreviousPageLi.addClass("disabled");
            }else {
                //首页时点击直接传递第一页
                firstPageLi.click(function () {
                    to_page(1)
                });
                //点击上一页时判断是否有上一页
                hasPreviousPageLi.click(function () {
                    if (result.extend.pageInfo.hasPreviousPage == true){
                        to_page(result.extend.pageInfo.pageNum-1)
                    }
                });
            }
            var hasNextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
            //判断是否有下一页，没有就不能点击尾页和下一页按钮
            if (result.extend.pageInfo.hasNextPage == false){
                hasNextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else {
                //尾页时点击直接传递总页数
                lastPageLi.click(function () {
                    to_page(result.extend.pageInfo.pages)
                });
                hasNextPageLi.click(function () {
                    if (result.extend.pageInfo.hasNextPage == true){
                        to_page(result.extend.pageInfo.pageNum+1)
                    }
                });
            }
            //添加首页和前一页的提示
            ul.append(firstPageLi).append(hasPreviousPageLi);
            //遍历给ul中添加页码提示
            $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
                var numLi = $("<li></li>").append($("<a></a>").append(item));
                if (result.extend.pageInfo.pageNum == item){
                    numLi.addClass("active");
                }
                numLi.click(function () {
                    to_page(item);
                });
                ul.append(numLi);
            });
            //添加下一页和末页提示
            ul.append(hasNextPageLi).append(lastPageLi);
            //把ul加入到nav
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }
        //点击新增按钮弹出模态框
        $("#emp_add_modal").click(function () {
            //ajax发送请求得到下拉列表中的部门信息
            getDepts();
            //弹出模态框
            $("#empAddModal").modal({
                backdrop:"static"
            })
        });
        function getDepts() {
            $.ajax({
                url:"${APP_PATH}/depts",
                type:"GET",
                success:function (result) {
                    //console.log(result)
                    //显示部门信息在下拉列表中
                    // $("#empAddModal select").append("")
                    $("#empAddModal select").empty();
                    $.each(result.extend.depts,function () {
                        var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                        optionEle.appendTo("#empAddModal select");
                    });
                }
            });
        }
    </script>
</body>
</html>
