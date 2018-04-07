<%@ page import="com.hzg.tools.FinanceConstant" %><%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: productCheck.jsp
*
* @author yuanyun
* @Date  2017/10/25
* @version 1.00
*
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--jquery ui--%>
<link type="text/css" href="../../../res/css/jquery-ui-1.10.0.custom.css" rel="stylesheet">
<!-- page content -->
<div class="right_col" role="main">
    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>财务 <small>科目</small></h2>
                    <div class="clearfix"></div>
                </div>
                <span class="section">科目设置</span>
                <div class="x_content" >
                    <table id="subjectSet" class="table table-striped table-bordered jambo_table bulk_action" style="width: 50%;" >
                        <thead>
                        <tr><th>类别</th><th>科目编码</th><th>科目名称</th><th>扩展设置</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="entity" items="${entities}">
                                <tr>
                                    <td>${entity.subjectCategory.name}</td>
                                    <td>${entity.no}</td>
                                    <td>${entity.name}</td>
                                    <td style="text-align: center"><a href="#/finance/view/extendSet/${entity.subjectCategory.id}" style="color: blue" >设置</a></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $("#cancel").unbind("click").click(function(){
        render(getPreUrls());
        returnPage = true;
    });

    $("table a").click(function(){render($(this).attr("href").toString().substring(1));});

    document.title = "科目设置";
</script>