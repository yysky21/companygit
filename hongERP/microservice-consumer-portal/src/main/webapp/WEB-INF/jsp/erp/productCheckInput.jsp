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
<%--jquery ui--%>
<link type="text/css" href="../../../res/css/jquery-ui-1.10.0.custom.css" rel="stylesheet">
<!-- page content -->
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3><c:choose><c:when test="${entity != null}">查看</c:when><c:otherwise>添加</c:otherwise></c:choose>商品盘点</h3>
            </div>

            <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                    <div class="input-group">
                        <input type="text" class="form-control" placehold="Search for...">
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
                    <span class="section">商品盘点信息</span>

                    <div class="container">
                        <div class="row form-group">
                            <div class="col-xs-4">
                                <form class="form-horizontal" role="form" id="form">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="item form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="checkNo">盘点单据编号 (<span class="required">*</span>)：
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" id="checkNo" name="checkNo" value="<c:if test="${entity != null}">${entity.checkNo}</c:if>${no}" class="form-control col-md-7 col-xs-12" readonly required />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="item form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="warehouse">选择仓库 (<span class="required">*</span>)：
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" id="warehouse" name="warehouse" value="${entity.warehouse.name}" class="form-control col-md-7 col-xs-12" placeholder="输入仓库名称" required />
                                                    <input type="hidden" id="warehouse[id]" name="warehouse[id]" value="${entity.warehouse.id}">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="item form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="code1">扫描条形码：
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" id="code1" name="code1" value="" class="form-control col-md-7 col-xs-12" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="item form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="code2">输入条形码：
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" id="code2" name="code2" value="" class="form-control col-md-7 col-xs-12" />
                                                </div>
                                                <button class="btn-success" id="confirm" type="button" style="float: left;margin-top: 4px">确定</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row checkQuantity" style="display: none">
                                        <div class="col-xs-12">
                                            <div class="item form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="checkQuantity">请输入盘点数量：
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" id="checkQuantity" name="checkQuantity" class="form-control col-md-7 col-xs-12"  />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row itemNo" style="display: none">
                                        <div class="col-xs-12">
                                            <div class="item form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="itemNo">请输入商品编码：
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" id="itemNo" name="itemNo" class="form-control col-md-7 col-xs-12"  />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <input type="hidden" id="state" name="state:number" value="0">
                                    <input type="hidden" id="chartMaker[id]" name="chartMaker[id]" value="${userId}"  />
                                </form>
                            </div>
                            <div class="col-xs-8">
                                <div class="panel panel-default">
                                    <div class="panel-heading">条形码扫描统计</div>
                                    <table class="table" id="table">
                                        <thead><tr><th>条形码</th><th>盘点数量</th></tr></thead>
                                        <tbody>
                                        <c:if test="${entity != null && entity.details != null}">
                                            <c:forEach var="detail" items="${entity.details}">
                                                <tr class="old">
                                                    <td><input name='details[][product[id]]:number' value='${detail.product.id}' readonly /></td>
                                                    <td><input name='details[][checkQuantity]:number' value='${detail.checkQuantity}' /></td>
                                                    <td><input type="hidden" name="details[][id]:number" value="${detail.id}"/></td>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="x_content">
                        <div class="form-horizontal form-label-left">
                            <div class="ln_solid"></div>
                            <div class="form-group" id="submitDiv">
                                <div class="col-md-6 col-md-offset-10">
                                    <button id="cancel" type="button" class="btn btn-primary">返回</button>
                                    <button id="send" type="button" class="btn btn-success">保存</button>
                                    <button id="entryCheck" type="button" class="btn btn-success">进入盘点</button>
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

    $("#warehouse").coolautosuggest({
        url:"<%=request.getContextPath()%>/erp/suggest/warehouse/name/",
        showProperty: 'name',
        onSelected:function(result){
            if(result!=null){
                $(document.getElementById("warehouse[id]")).val(result.id);
            }
        }
    });

    // 计量单位
    var unit;

    // 为扫描框绑定一个内容改变事件
    $("#code1").bind("input propertychange", function() {
        if (productCheck.stockIsSelect($("#code1"))==false){
            return false;
        }
        if ($("#table > tbody > tr:not(.old)").length>=5){
            alert("请保存后再继续扫描条形码");
            $("#code1").val("");
            return false;
        }else {
            if ($("#code1").val() == null || $("#code1").val() == ""){
                return false;
            } else {
                productCheck.setCheckQuantity("<%=request.getContextPath()%>/erp/privateQuery/productUnit",$("#code1"));
            }
        }
    });

    $("#confirm").bind("click",function () {
        if (productCheck.stockIsSelect($("#code2"))==false){
            return false;
        }
        if ($("#table > tbody > tr:not(.old)").length>=5){
            alert("请保存后再继续输入条形码");
            $("#code2").val("");
            return false;
        }else {
            if ($("#code2").val() == null || $("#code2").val() == ""){
                return false;
            } else {
                productCheck.setCheckQuantity("<%=request.getContextPath()%>/erp/privateQuery/productUnit",$("#code2"));
            }
        }
    })

    $("#code2").keypress(function (e) {
        if (productCheck.stockIsSelect($("#code2"))==false){
            return false;
        }
        if ($("#table > tbody > tr:not(.old)").length>=5){
            alert("请保存后再继续输入条形码!");
            $("#code2").val("");
            return false;
        }else {
            if (e.keyCode == 13) {
                if ($("#code2").val() == null || $("#code2").val() == ""){
                    return false;
                } else {
                    productCheck.setCheckQuantity("<%=request.getContextPath()%>/erp/privateQuery/productUnit",$("#code2"));
                }
            }
        }
    });

    $("#send").click(function () {
        productCheck.addProductCheck('<%=request.getContextPath()%>/erp/save/productCheck');
    });

    $("#entryCheck").click(function () {
        if ($("#table > tbody > tr").length != 0){
            productCheck.addProductCheck('<%=request.getContextPath()%>/erp/save/productCheck',function (result) {
                if(result.result.indexOf("success") != -1){
                    render('<%=request.getContextPath()%>/erp/privateView/productCheck/checkNo/'+$("#checkNo").val());
                }
            });
        } else {
            render('<%=request.getContextPath()%>/erp/privateView/productCheck/checkNo/'+$("#checkNo").val());
        }
    })
    <c:choose><c:when test="${entity != null}">document.title = "修改商品盘点";</c:when><c:otherwise> document.title = "添加商品盘点";</c:otherwise></c:choose>
</script>