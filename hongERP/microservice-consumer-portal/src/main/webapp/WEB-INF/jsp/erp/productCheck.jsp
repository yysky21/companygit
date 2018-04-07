<%--
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
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3>查看商品盘点</h3>
            </div>

            <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search for...">
                        <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                  </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>

        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>ERP <small>商品盘点</small></h2>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <form class="form-horizontal form-label-left" novalidate id="form">
                            <span class="section">商品盘点信息</span>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="checkNo">盘点单据编号： <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="checkNo" name="checkNo" value="${entity.checkNo}" class="form-control col-md-7 col-xs-12" readonly required>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="warehouse">盘点仓库： <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" id="warehouse" name="warehouse" value="${entity.warehouse.name}" class="form-control col-md-7 col-xs-12" style="width:40%" placeholder="输入仓库名称" required readonly />
                                    <input type="hidden" id="warehouse[id]" name="warehouse[id]" value="${entity.warehouse.id}">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="dept">盘点部门： <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" id="dept" name="dept" value="${entity.dept.name}" class="form-control col-md-7 col-xs-12" style="width:40%" placeholder="输入部门名称" required readonly />
                                    <input type="hidden" id="dept[id]" name="dept[id]" value="${entity.dept.id}">
                                </div>
                            </div>
                            <%--<div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="quantity">盈亏总数量： <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="quantity" name="quantity" value="${entity.quantity}" class="form-control col-md-7 col-xs-12" readonly required>
                                </div>
                            </div>--%>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="amount">盈亏总金额： <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="amount" name="amount" value="${entity.amount}" class="form-control col-md-7 col-xs-12" readonly required>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="chartMaker">制单人： <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" id="chartMaker" name="chartMaker" value="${entity.chartMaker.name}" class="form-control col-md-7 col-xs-12" readonly required />
                                    <input type="hidden" id="chartMaker[id]" name="chartMaker[id]" value="${entity.chartMaker.id}">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="company">公司： <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" id="company" name="company" value="${entity.company.name}" class="form-control col-md-7 col-xs-12" readonly required />
                                    <input type="hidden" id="company[id]" name="company[id]" value="${entity.company.id}">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="remark">备注： <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <textarea id="remark" name="remark" class="form-control col-md-7 col-xs-12" <c:if test="${entity.state == 1}">readonly</c:if>>${entity.remark}</textarea>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="checkDate">盘点日期： <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="checkDate" name="checkDate" class="form-control col-md-7 col-xs-12" value="<fm:formatDate value="${entity.checkDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" class="form-control col-md-7 col-xs-12" readonly required>
                                </div>
                            </div>
                            <div class="x_content" style="overflow: auto">
                                <table id="productList" class="table-sheet" width="100%">
                                    <thead>
                                    <tr><th>存货编码</th><th>存货名称</th><th>计量单位</th><th>单价</th><th>盘点数量</th><th>账面数量</th><th>盈亏数量</th><th>盘点金额</th><th>账面金额</th><th>盈亏金额</th></tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${entity.details != null}">
                                        <c:forEach items="${entity.details}" var="detail">
                                            <c:if test="${detail.checkQuantity != '0.0'}">
                                                <tr>
                                                    <td><input name='details[][itemNo]' value='${detail.itemNo}' readonly /></td>
                                                    <td><input name='details[][itemName]' value='${detail.itemName}' readonly /></td>
                                                    <td><input name='details[][unit]' value='${detail.unit}' readonly /></td>
                                                    <td><input name='details[][unitPrice]:number' value='${detail.unitPrice}' readonly /></td>
                                                    <td><input name='details[][checkQuantity]:number' value='${detail.checkQuantity}' readonly /></td>
                                                    <td><input name='details[][paperQuantity]:number' value='${detail.paperQuantity}' readonly /></td>
                                                    <td><input name='details[][quantity]:number' value='${detail.quantity}' readonly /></td>
                                                    <td><input name='details[][checkAmount]:number' value='${detail.checkAmount}' readonly /></td>
                                                    <td><input name='details[][paperAmount]:number' value='${detail.paperAmount}' readonly /></td>
                                                    <td><input name='details[][amount]:number' value='${detail.amount}' readonly /></td>
                                                    <td><input type="hidden" name='details[][id]:number' value='${detail.id}' readonly /></td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                    </tbody>
                                </table>
                            </div>
                            <input type="hidden" id="state" name="state:number" value="${entity.state}">
                            <input type="hidden" id="id" name="id:number" value="${entity.id}"/>
                        </form>
                    </div>
                    <div class="x_content">
                        <div class="form-horizontal form-label-left">
                            <div class="ln_solid"></div>
                            <div class="form-group" id="submitDiv">
                                <div class="col-md-6 col-md-offset-10">
                                    <button id="cancel" type="button" class="btn btn-primary">返回</button>
                                    <c:if test="${entity.state == 0}">
                                        <button id="send" type="button" class="btn btn-success">修改</button>
                                        <button id="check" type="button" class="btn btn-danger">盘点</button>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
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

    $("#send").click(function () {
        render('<%=request.getContextPath()%>/erp/view/productCheckInput/${entity.id}');
    });

    $("#check").click(function () {
        if (confirm("提交盘点后不能修改，你确定要提交盘点吗！")==false){
            return false;
        };
        $("#state").val(1);
        $('#form').submitForm('<%=request.getContextPath()%>/erp/update/productCheck');
    })
    document.title = "查看商品盘点";
</script>