<%@ page import="com.hzg.afterSaleService.ReturnProduct" %>
<%@ page import="com.hzg.tools.AfterSaleServiceConstant" %>
<%@ page import="com.hzg.afterSaleService.RepairProduct" %><%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: repairProduct.jsp
*
* @author smjie
* @Date  2018/3/22
* @version 1.00
*
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--jquery ui--%>
<link type="text/css" href="../../../res/css/jquery-ui-1.10.0.custom.css" rel="stylesheet">
<style>
    .table-sheet > thead > tr > th{
        width: 80px;
        padding: 4px;
    }
    .table-sheet > tbody > tr > td{
        width: 80px;
        padding: 4px;
    }
</style>
<!-- page content -->
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3>查看修补货品单</h3>
            </div>

            <div class="title_right hidden">
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
                        <h2>修补货品 <small>信息</small></h2>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <form class="form-horizontal form-label-left" novalidate id="form">
                            <span class="section">修补货品信息</span>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="no">修补单号 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12"><input id="no" type="text" name="no" value="${entity.no}" class="form-control col-md-7 col-xs-12" readonly></div>
                            </div>
                            <c:if test="${entity.state != null}">
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="stateName">状态 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12"><input id="stateName" type="text" value="${entity.stateName}" class="form-control col-md-7 col-xs-12" readonly></div>
                            </div>
                            </c:if>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">修补关联单 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <a data-entity-no-a="entityNoA" data-entity-no="${entity.entityNo}" data-entity-id="${entity.entityId}" href="#">${entity.entityNo}</a>
                                    <input type="hidden" name="entity" value="${entity.entity}" />
                                    <input type="hidden" name="entityId" value="${entity.entityId}" />
                                </div>
                            </div>
                            <c:if test="${(entity.amount != null) || (entity.state != null && entity.state == 4)}">
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="amount">修补金额<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12"><input id="amount" type="text" value="${entity.amount}" class="form-control col-md-7 col-xs-12"></div>
                            </div>
                            </c:if>
                            <c:if test="${entity.user != null}">
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="username">修补人 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12"><input type="text" id="username" value="${entity.user.name}" class="form-control col-md-7 col-xs-12" readonly></div>
                            </div>
                            </c:if>
                            <c:if test="${entity.inputDate != null}">
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="inputDate">修补申请时间 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12"><input id="inputDate" type="text" value="${entity.inputDate}" class="form-control col-md-7 col-xs-12" readonly></div>
                            </div>
                            </c:if>
                            <c:if test="${entity.date != null}">
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="date">修补完成时间 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12"><input id="date" type="text" value="${entity.date}" class="form-control col-md-7 col-xs-12" readonly></div>
                            </div>
                            </c:if>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="describes">描述 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12"><textarea class="form-control col-md-7 col-xs-12" id="describes" name="describes" <c:if test="${entity.describes != null}">readonly</c:if> required>${entity.describes}</textarea></div>
                            </div>
                            <input name="sessionId" type="hidden" value="${sessionId}">
                        </form>

                        <span class="section" style="margin-top: 40px">修补明细</span>
                        <div class="item form-group" style="margin-top:20px;">
                            <div class="col-md-6 col-sm-6 col-xs-12" style="width:1400px;margin-left: 150px;margin-top: 10px">
                                <table id="productList" class="table-sheet">
                                    <thead><tr><c:if test="${entity.state == null}"><th>选择</th></c:if><th>商品编号</th><th>商品名称</th><c:if test="${entity.state != null}"><th>状态</th></c:if><th>修补数量</th><th>修补单位</th><c:if test="${(entity.amount != null) || (entity.state != null && entity.state == 4)}"><th>修补单价</th><th>修补金额</th></c:if></tr></thead>
                                    <tbody>
                                    <c:forEach items="${entity.details}" var="detail">
                                        <tr>
                                            <c:if test="${entity.state == null}"><td align="center"><input type="checkbox" data-property-name="productNo" name="details[][productNo]" value="${detail.productNo}" class="flat" checked></td></c:if>
                                            <td style="width: 120px"><a href="#<%=request.getContextPath()%>/erp/view/product/${detail.product.id}" onclick="render('<%=request.getContextPath()%>/erp/view/product/${detail.product.id}')">${detail.productNo}</a></td>
                                            <td style="width:200px"><input type="text" value="${detail.product.name}" readonly></td>
                                            <c:if test="${entity.state != null}"><td><input type="text" value="${detail.stateName}"></td></c:if>
                                            <td><input type="text" data-property-name="quantity" name="details[][quantity]:number" value="${detail.quantity}" <c:if test="${entity.state != null && entity.state != 0}">readonly</c:if> required></td>
                                            <td><input type="text" value="${detail.unit}" readonly></td>
                                            <c:if test="${(entity.amount != null) || (entity.state != null && entity.state == 4)}">
                                            <td><input type="text" data-property-name="price" name="details[][price]:number" value="${detail.price}" required></td>
                                            <td><input type="text" name="details[][amount]:number" value="${detail.amount}" readonly></td>
                                                <input type="hidden" name="details[][id]:number" value="${detail.id}">
                                            </c:if>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <c:if test="${entity.pays != null}">
                    <div class="x_content">
                        <span class="section" style="margin-top: 40px">支付记录</span>
                        <div class="item form-group" style="margin-top:20px;">
                            <div class="col-md-6 col-sm-6 col-xs-12" style="width:1400px;margin-left: 150px;margin-top: 10px">
                                <table class="table-sheet">
                                    <thead><tr><th>支付号</th><th>支付状态</th><th>支付方式</th><th>支付金额</th><th>支付时间</th><th>支付账户</th><th>收款账户</th></tr></thead>
                                    <tbody>
                                    <c:forEach items="${entity.pays}" var="pay">
                                        <tr>
                                            <td style="width: 240px"><a href="#<%=request.getContextPath()%>/pay/view/pay/${pay.id}" onclick="render('<%=request.getContextPath()%>/pay/view/pay/${pay.id}')">${pay.no}</a></td>
                                            <td>${pay.stateName}</td>
                                            <td>${pay.payTypeName}</td>
                                            <td>${pay.amount}</td>
                                            <td style="width: 160px">${pay.payDate}</td>
                                            <td style="width: 200px">${pay.payBank}<c:if test="${pay.payBranch != null}"><br/>${pay.payBranch}</c:if><c:if test="${pay.payAccount != null}"><br/>${pay.payAccount}</c:if></td>
                                            <td style="width: 200px">${pay.receiptBank}<c:if test="${pay.receiptBranch != null}"><br/>${pay.receiptBranch}</c:if><c:if test="${pay.receiptAccount != null}"><br/>${pay.receiptAccount}</c:if></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    </c:if>

                    <div class="x_content">
                        <c:if test="${entity.state != null}">
                        <span class="section" style="margin-top: 40px">修补审核记录</span>
                        <div class="item form-group" style="margin-top:20px;">
                            <div class="col-md-6 col-sm-6 col-xs-12" style="width:1400px;margin-left: 150px;margin-top: 10px">
                                <table class="table-sheet">
                                    <thead><tr><th>审核人</th><th>审核时间</th><th>审核结果</th><th>备注</th></tr></thead>
                                    <tbody>
                                    <c:forEach items="${entity.actions}" var="action">
                                        <tr>
                                            <td style="width: 120px">${action.inputer.name}</td>
                                            <td style="width: 120px">${action.inputDate}</td>
                                            <td style="width: 200px">${action.typeName}</td>
                                            <td style="width: 250px">${action.remark}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        </c:if>
                    </div>

                    <c:if test="${(fn:contains(resources, '/afterSaleService/doBusiness/repairProductSaleAudit') && entity.state == 0) ||
                    (fn:contains(resources, '/afterSaleService/doBusiness/repairProductDirectorAudit') && entity.state == 3) ||
                    (fn:contains(resources, '/afterSaleService/doBusiness/repairProductWarehousingAudit') && entity.state == 4) ||
                    (fn:contains(resources, '/afterSaleService/doBusiness/repairProductPaid') && entity.state == 5) ||
                    (fn:contains(resources, '/afterSaleService/doBusiness/repairProductComplete') && entity.state == 1) ||
                    entity.state == null}">
                    <div class="x_content">
                        <span class="section" style="margin-top: 40px">审核</span>
                        <div class="item form-group" style="margin-top:20px;">
                            <div class="col-md-6 col-sm-6 col-xs-12" style="margin-left: 150px;margin-top: 10px">
                                <form id="actionForm">
                                    <div class="item form-group">
                                        <label class="control-label col-md-3 col-sm-3 col-xs-12" style="width: 80px" for="remark">批语 <span class="required">*</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-12"><textarea class="form-control col-md-7 col-xs-12" style="width: 600px" id="remark" name="remark" required></textarea></div>
                                    </div>
                                    <input type="hidden" name="auditResult" id="auditResult">
                                    <input type="hidden" name="entity"  value="<%=RepairProduct.class.getSimpleName()%>">
                                    <input type="hidden" name="entityId:number" id="entityId" value="${entity.id}">
                                    <input type="hidden" name="sessionId" value="${sessionId}">
                                </form>
                            </div>
                        </div>
                    </div>
                    </c:if>

                    <c:if test="${fn:contains(resources, '/afterSaleService/doBusiness/returnProductWarehousingAudit') && entity.state == 51}">
                        <form id="printForm" method="post" action="<%=request.getContextPath()%><%=AfterSaleServiceConstant.privilege_resource_uri_print_expressWaybill%>" target="_blank">
                            <input type="hidden" name="json" value='{"entity":"<%=RepairProduct.class.getSimpleName()%>","entityId":${entity.id},"sessionId":"${sessionId}"}'>
                        </form>
                    </c:if>

                    <div class="x_content">
                        <div class="form-horizontal form-label-left">
                            <div class="ln_solid"></div>
                            <div class="col-md-12 col-md-offset-1" id="submitDiv">
                                <button id="cancel" type="button" style="margin-right: 10%" class="btn btn-primary">返回</button>
                                <c:if test="${entity.state == null}">
                                <c:if test="${fn:contains(resources, '/afterSaleService/save/repairProduct')}">
                                <button id="repairProduct" type="button" class="btn btn-success">提交修补申请</button>
                                </c:if>
                                </c:if>

                                <c:if test="${entity.state != null}">
                                <c:if test="${entity.state == 0}">
                                <c:if test="${fn:contains(resources, '/afterSaleService/doBusiness/repairProductSaleAudit')}">
                                <button id="saleAuditPass" type="button" style="margin-right: 2%" class="btn btn-success">可以修补</button>
                                <button id="saleAuditNotPass" type="button" class="btn btn-danger">不可以修补</button>
                                </c:if>
                                </c:if>
                                <c:if test="${entity.state == 3}">
                                <c:if test="${fn:contains(resources, '/afterSaleService/doBusiness/repairProductDirectorAudit')}">
                                <button id="directorAuditPass" type="button" style="margin-right: 2%" class="btn btn-success">可以修补</button>
                                <button id="directorAuditNotPass" type="button" class="btn btn-danger">不可以修补</button>
                                </c:if>
                                </c:if>
                                <c:if test="${entity.state == 4}">
                                <c:if test="${fn:contains(resources, '/afterSaleService/doBusiness/repairProductWarehousingAudit')}">
                                <button id="warehousingAuditPass" type="button" style="margin-right: 2%" class="btn btn-success">可以修补及确定金额</button>
                                <button id="warehousingAuditNotPass" type="button" class="btn btn-danger">不可以修补</button>
                                </c:if>
                                </c:if>
                                <button id="printExpress" type="button" class="btn btn-success" style="display: none">打印修补货品快递单</button>
                                <c:if test="${entity.state == 5}">
                                <c:if test="${fn:contains(resources, '/afterSaleService/doBusiness/repairProductPaid')}">
                                <button id="repairProductPaid" type="button" class="btn btn-success">确认收款</button>
                                </c:if>
                                </c:if>
                                <c:if test="${entity.state == 1}">
                                <c:if test="${fn:contains(resources, '/afterSaleService/doBusiness/repairProductComplete')}">
                                <button id="complete" type="button" class="btn btn-success">修补完成</button>
                                </c:if>
                                </c:if>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    init(<c:out value="${entity == null}"/>);

    repairProduct.init(<c:out value="${entity.state == null}"/>, "<%=request.getContextPath()%>");

    <c:if test="${entity.state == null}">
        <c:if test="${fn:contains(resources, '/afterSaleService/save/repairProduct')}">
            $("#repairProduct").click(function(){
                if (!validator.checkAll($("#actionForm"))) {
                    return;
                }
                returnProduct.save('<%=request.getContextPath()%>/afterSaleService/save/repairProduct',
                    '<%=request.getContextPath()%>/afterSaleService/doBusiness/repairProductSaleAudit');
            });
        </c:if>
    </c:if>

    <c:if test="${entity.state != null}">
        <c:if test="${entity.state == 0}">
            <c:if test="${fn:contains(resources, '/afterSaleService/doBusiness/repairProductSaleAudit')}">
                $("#saleAuditPass").click(function(){
                    repairProduct.audit('Y', '<%=request.getContextPath()%>/afterSaleService/doBusiness/repairProductSaleAudit');
                });

                $("#saleAuditNotPass").click(function(){
                    repairProduct.audit('N', '<%=request.getContextPath()%>/afterSaleService/doBusiness/repairProductSaleAudit');
                });
            </c:if>
        </c:if>

        <c:if test="${entity.state == 3}">
            <c:if test="${fn:contains(resources, '/afterSaleService/doBusiness/repairProductDirectorAudit')}">
                $("#directorAuditPass").click(function(){
                    repairProduct.audit('Y', '<%=request.getContextPath()%>/afterSaleService/doBusiness/repairProductDirectorAudit');
                });

                $("#directorAuditNotPass").click(function(){
                    repairProduct.audit('N', '<%=request.getContextPath()%>/afterSaleService/doBusiness/repairProductDirectorAudit');
                });
            </c:if>
        </c:if>

        <c:if test="${entity.state == 4}">
            <c:if test="${fn:contains(resources, '/afterSaleService/doBusiness/repairProductWarehousingAudit')}">
                $("#warehousingAuditPass").click(function(){
                    $("#auditResult").val('Y');
                    var $form = $("#actionForm");
                    if (!validator.checkAll($form)) {
                        return;
                    }

                    var json = JSON.stringify($form.serializeJSON());
                    json = json.substring(0, json.length-1) + ',"details":[';

                    var trs = $("#productList tbody tr");
                    for (var i = 0; i < trs.length; i++) {
                        var textInputs = $(trs[i]).find("input");
                        var tds = $(trs[i]).find("td");

                        if (tds.length > 0) {
                            for (var j = 0; j < textInputs.length; j++) {
                                if ($.trim(textInputs[j].value) == "" && $(textInputs[j]).attr("required") != undefined) {
                                    alert("请输入值");
                                    $(textInputs[j]).focus();
                                    return false;
                                }
                            }

                            json += JSON.stringify($(trs[i]).find(":input").serializeJSON()["details"][0]) + ',';
                        }
                    }

                    if (json.substring(json.length-1) == "[") {
                        alert("请输入修补商品明细");
                        return false;
                    } else {
                        json = json.substring(0, json.length-1) + ']}';
                    }


                    $form.sendData('<%=request.getContextPath()%>/afterSaleService/doBusiness/repairProductWarehousingAudit', json);
                });

                $("#warehousingAuditNotPass").click(function(){
                    $("#auditResult").val('N');
                    $("#actionForm").submitForm('<%=request.getContextPath()%>/afterSaleService/doBusiness/repairProductWarehousingAudit', function(result){
                        if (result.result.indexOf("success") != -1) {
                            $("#printExpress").show();
                        }
                    });
                });
            </c:if>
        </c:if>

        <c:if test="${entity.state == 51}">
            <c:if test="${fn:contains(resources, '/afterSaleService/doBusiness/repairProductWarehousingAudit')}">
                $("#printExpress").show().click(function(){
                    $("#printForm").submit();
                });
            </c:if>
        </c:if>

        <c:if test="${entity.state == 5}">
            <c:if test="${fn:contains(resources, '/afterSaleService/doBusiness/repairProductPaid')}">
                $("#repairProductPaid").click(function(){
                    repairProduct.audit('Y', '<%=request.getContextPath()%>/afterSaleService/doBusiness/repairProductPaid');
                });
            </c:if>
        </c:if>

        <c:if test="${entity.state == 1}">
            <c:if test="${fn:contains(resources, '/afterSaleService/doBusiness/repairProductComplete')}">
                $("#complete").click(function(){
                    repairProduct.audit('Y', '<%=request.getContextPath()%>/afterSaleService/doBusiness/repairProductComplete');
                });
            </c:if>
        </c:if>
    </c:if>
</script>