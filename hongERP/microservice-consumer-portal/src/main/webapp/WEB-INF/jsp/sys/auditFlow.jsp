<%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: dept.jsp
*
* @author smjie
* @Date  2017/4/12
* @version 1.00
*
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.hzg.sys.*" %>
<%@ page import="com.hzg.tools.AuditFlowConstant" %>
<%--jquery ui--%>
<link type="text/css" href="../../../res/css/jquery-ui-1.10.0.custom.css" rel="stylesheet">
<!-- page content -->
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3><c:choose><c:when test="${entity != null}">查看</c:when><c:otherwise>添加</c:otherwise></c:choose>流程</h3>
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
                        <h2>后台管理 <small>流程</small></h2>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <form class="form-horizontal form-label-left" novalidate id="form">
                            <span class="section"><c:choose><c:when test="${entity != null}">查看</c:when><c:otherwise>添加</c:otherwise></c:choose>流程</span>

                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="name">流程名称 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="name" name="name" value="${entity.name}" class="form-control col-md-7 col-xs-12" data-validate-length-range="6,30" data-validate-words="1" required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="entity">业务类型 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select id="entity" name="entity" class="form-control col-md-7 col-xs-12" required>
                                        <option value="">请选择类别</option>
                                        <option value="<%=AuditFlowConstant.business_purchase%>">采购审核</option>
                                        <option value="<%=AuditFlowConstant.business_purchaseEmergency%>">应急/现金/押金采购审核</option>
                                        <option value="<%=AuditFlowConstant.business_stockIn_notify%>">提示入库商品</option>
                                        <option value="<%=AuditFlowConstant.business_stockIn_notify_caiwu%>">财务提示入库商品</option>
                                        <option value="<%=AuditFlowConstant.business_stockIn_deposit_cangchu%>">押金入库退还货品</option>
                                        <option value="<%=AuditFlowConstant.business_stockIn_deposit_caiwu%>">押金入库退还押金</option>
                                        <option value="<%=AuditFlowConstant.business_stockOut_breakage%>">报损出库审核</option>
                                        <option value="<%=AuditFlowConstant.business_stockOut_print_expressWaybill_notify%>">提醒打印出库商品的快递单</option>
                                        <option value="<%=AuditFlowConstant.business_product%>">商品上架</option>
                                        <option value="<%=AuditFlowConstant.business_returnProduct%>">退货审核</option>
                                        <option value="<%=AuditFlowConstant.business_changeProduct%>">换货审核</option>
                                        <option value="<%=AuditFlowConstant.business_price_change_saler%>">销售员调价申请</option>
                                        <option value="<%=AuditFlowConstant.business_price_change_charger%>">销售主管调价申请</option>
                                        <option value="<%=AuditFlowConstant.business_price_change_manager%>">销售经理调价申请</option>
                                        <option value="<%=AuditFlowConstant.business_price_change_director%>">销售总监调价申请</option>
                                        <option value="<%=AuditFlowConstant.business_orderPersonal%>">私人订制</option>
                                        <option value="<%=AuditFlowConstant.business_voucherAudit%>">提示审核凭证</option>
                                    </select>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="company[id]">流程所属公司 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select id="company[id]" name="company[id]" class="form-control col-md-7 col-xs-12" required>
                                    </select>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="action">流程结束时动作 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select id="action" name="action" class="form-control col-md-7 col-xs-12" data-value-type="string" data-skip-falsy="true">
                                    </select>
                                </div>
                            </div>
                            <div class="form-group" id="addNodeDiv">
                                <div class="col-md-6 col-md-offset-3">
                                    <button id="addNode" type="button" class="btn btn-success">添加节点</button>
                                </div>
                            </div>

                            <div id="nodesDiv" align="center">
                                <c:forEach items="${auditFlowNodes}" var="node" varStatus="status">
                                    <c:if test="${status.count > 1}">
                                        &nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-long-arrow-right"></i>&nbsp;&nbsp;
                                    </c:if>
                                    <%
                                        AuditFlowNode node = (AuditFlowNode)pageContext.getAttribute("node");
                                    %>
                                    <a class="btn btn-app" style="height: 100px">${node.name}<br/>${node.post.name}<br/>
                                        审核通过调用动作:&nbsp;<%=AuditFlowConstant.action_names.get(node.getAction())%><br/>
                                        被打回时调用动作:&nbsp;<%=AuditFlowConstant.action_names.get(node.getRefusedAction())%></a>
                                </c:forEach>
                            </div>

                            <div class="ln_solid"></div>
                            <div class="form-group" id="submitDiv">
                                <div class="col-md-6 col-md-offset-3">
                                    <button id="cancel" type="button" class="btn btn-primary">返回</button>
                                    <c:if test="${entity == null}">
                                    <button id="send" type="button" class="btn btn-success">保存</button>
                                    </c:if>
                                    <c:if test="${entity != null}">
                                        <button id="editState" type="button" class="btn btn-primary">编辑</button>
                                        <c:choose>
                                            <c:when test="${entity.state == 0}"><button id="delete" type="button" class="btn btn-danger">置为不可用</button></c:when>
                                            <c:otherwise><button id="recover" type="button" class="btn btn-success">置为可用</button></c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </div>
                            </div>
                            <input type="hidden" id="state" name="state:number" value="<c:choose><c:when test="${entity != null}">${entity.state}</c:when><c:otherwise>0</c:otherwise></c:choose>">
                        </form>
                    </div>
                    <div id="subFormDiv">
                        <br>
                        <div class="item form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="nodeName">节点名称 <span class="required">*</span></label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input id="nodeName" name="nodeName" class="form-control col-md-7 col-xs-12" data-validate-length-range="6,30" data-validate-words="1" required type="text">
                            </div>
                        </div>
                        <div class="clearfix"></div><br>
                        <div class="item form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="dept[id]">流程所属部门 <span class="required">*</span></label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <select id="dept[id]" name="dept[id]" class="form-control col-md-7 col-xs-12" required>
                                </select>
                            </div>
                        </div>
                        <div class="clearfix"></div><br>
                        <div class="item form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="post">流程所属岗位 <span class="required">*</span></label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <select id="post" name="post" class="form-control col-md-7 col-xs-12" required>
                                </select>
                            </div>
                        </div>
                        <div class="clearfix"></div><br>
                        <div class="item form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="nodeAction">审核通过调用动作 <span class="required">*</span></label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <select id="nodeAction" name="nodeAction" class="form-control col-md-7 col-xs-12" required>
                                </select>
                            </div>
                        </div>
                        <div class="clearfix"></div><br>
                        <div class="item form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="nodeRefusedAction">被打回时调用动作 <span class="required">*</span></label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <select id="nodeRefusedAction" name="nodeRefusedAction" class="form-control col-md-7 col-xs-12" required>
                                </select>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var businessFlowActionOptions = {
        "<%=AuditFlowConstant.business_purchase%>":"<option value=''>无</option><option value='<%=AuditFlowConstant.business_stockIn_notify%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.business_stockIn_notify)%></option>",
        "<%=AuditFlowConstant.business_purchaseEmergency%>":"<option  value=''>无</option><option value='<%=AuditFlowConstant.business_stockIn_notify_caiwu%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.business_stockIn_notify_caiwu)%></option>",
        "<%=AuditFlowConstant.business_stockIn_notify%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_stockIn_notify_caiwu%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_stockIn_deposit_cangchu%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_stockIn_deposit_caiwu%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_stockOut_breakage%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_stockOut_print_expressWaybill_notify%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_product%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_returnProduct%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_changeProduct%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_price_change_saler%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_price_change_charger%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_price_change_manager%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_price_change_director%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_orderPersonal%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_voucherAudit%>":"<option  value=''>无</option>"
    };

    var businessNodeActionOptions = {
        "<%=AuditFlowConstant.business_purchase%>":"<option value=''>无</option><option value='<%=AuditFlowConstant.action_purchase_product_pass%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_purchase_product_pass)%></option><option value='<%=AuditFlowConstant.action_purchase_close%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_purchase_close)%></option>",
        "<%=AuditFlowConstant.business_purchaseEmergency%>":"<option  value=''>无</option><option value='<%=AuditFlowConstant.action_purchase_emergency_pass%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_purchase_emergency_pass)%></option><option value='<%=AuditFlowConstant.action_purchase_emergency_pay%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_purchase_emergency_pay)%></option>",
        "<%=AuditFlowConstant.business_stockIn_notify%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_stockIn_notify_caiwu%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_stockIn_deposit_cangchu%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_stockIn_deposit_caiwu%>":"<option  value=''>无</option><option value='<%=AuditFlowConstant.action_stockIn_return_deposit%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_stockIn_return_deposit)%></option>",
        "<%=AuditFlowConstant.business_product%>":"<option  value=''>无</option><option value='<%=AuditFlowConstant.action_onSale%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_onSale)%></option>" +
        "<option value='<%=AuditFlowConstant.action_product_onSale%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_product_onSale)%></option>",
        "<%=AuditFlowConstant.business_stockOut_breakage%>":"<option  value=''>无</option><option value='<%=AuditFlowConstant.action_stockOut_product_breakage%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_stockOut_product_breakage)%></option>",
        "<%=AuditFlowConstant.business_stockOut_print_expressWaybill_notify%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_returnProduct%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_changeProduct%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_price_change_saler%>":"<option  value=''>无</option><option value='<%=AuditFlowConstant.action_price_change_set_state_use%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_price_change_set_state_use)%></option>",
        "<%=AuditFlowConstant.business_price_change_charger%>":"<option  value=''>无</option><option value='<%=AuditFlowConstant.action_price_change_set_state_use%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_price_change_set_state_use)%></option>",
        "<%=AuditFlowConstant.business_price_change_manager%>":"<option  value=''>无</option><option value='<%=AuditFlowConstant.action_price_change_set_state_use%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_price_change_set_state_use)%></option>",
        "<%=AuditFlowConstant.business_price_change_director%>":"<option  value=''>无</option><option value='<%=AuditFlowConstant.action_price_change_set_state_use%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_price_change_set_state_use)%></option>",
        "<%=AuditFlowConstant.business_orderPersonal%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_voucherAudit%>":"<option  value=''>无</option>"
    };

    var businessNodeRefusedActionOptions = {
        "<%=AuditFlowConstant.business_purchase%>":"<option value=''>无</option><option value='<%=AuditFlowConstant.action_purchase_modify%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_purchase_modify)%></option>",
        "<%=AuditFlowConstant.business_purchaseEmergency%>":"<option  value=''>无</option><option value='<%=AuditFlowConstant.action_purchase_modify%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_purchase_modify)%></option>",
        "<%=AuditFlowConstant.business_stockIn_notify%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_stockIn_notify_caiwu%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_stockIn_deposit_cangchu%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_stockIn_deposit_caiwu%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_stockOut_breakage%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_stockOut_print_expressWaybill_notify%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_product%>":"<option  value=''>无</option><option value='<%=AuditFlowConstant.action_product_files_upload%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_product_files_upload)%></option>" +
        "<option value='<%=AuditFlowConstant.action_product_stockIn_modify%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_product_stockIn_modify)%></option>",
        "<%=AuditFlowConstant.business_returnProduct%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_changeProduct%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_price_change_saler%>":"<option  value=''>无</option><option value='<%=AuditFlowConstant.action_price_change_modify%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_price_change_modify)%></option>",
        "<%=AuditFlowConstant.business_price_change_charger%>":"<option  value=''>无</option><option value='<%=AuditFlowConstant.action_price_change_modify%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_price_change_modify)%></option>",
        "<%=AuditFlowConstant.business_price_change_manager%>":"<option  value=''>无</option><option value='<%=AuditFlowConstant.action_price_change_modify%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_price_change_modify)%></option>",
        "<%=AuditFlowConstant.business_price_change_director%>":"<option  value=''>无</option><option value='<%=AuditFlowConstant.action_price_change_modify%>'><%=AuditFlowConstant.action_names.get(AuditFlowConstant.action_price_change_modify)%></option>",
        "<%=AuditFlowConstant.business_orderPersonal%>":"<option  value=''>无</option>",
        "<%=AuditFlowConstant.business_voucherAudit%>":"<option  value=''>无</option>"
    };

    init(<c:out value="${entity == null}"/>);

    <c:if test="${entity != null}">
    setSelect(document.getElementById("entity"), "${entity.entity}");

    $("#action").empty().append(businessFlowActionOptions["${entity.entity}"]);
    setSelect(document.getElementById("action"), "${entity.action}");

    $("#nodeAction").empty().append(businessNodeActionOptions["${entity.entity}"]);
    $("#nodeRefusedAction").empty().append(businessNodeRefusedActionOptions["${entity.entity}"]);

    $("#addNodeDiv, #send").css("display", "none");
    </c:if>

    selector.setSelect(['company[id]', 'dept[id]', 'post'], ['name', 'name', 'name'], ['id', 'id', 'id'],
        [<c:if test="${entity != null}">"${entity.company.id}"</c:if>],
        ['<%=request.getContextPath()%>/sys/query/<%=Company.class.getSimpleName().toLowerCase()%>',
            '<%=request.getContextPath()%>/sys/query/<%=Dept.class.getSimpleName().toLowerCase()%>',
            '<%=request.getContextPath()%>/sys/query/<%=Post.class.getSimpleName().toLowerCase()%>'],
        '{}', ['company[id]', 'dept[id]'], 0);


    $("#entity").change(function(){
        $("#action").empty().append(businessFlowActionOptions[$("#entity").val()]);
        $("#nodeAction").empty().append(businessNodeActionOptions[$("#entity").val()]);
        $("#nodeRefusedAction").empty().append(businessNodeRefusedActionOptions[$("#entity").val()]);
    });

    $('#addNode').click(function () {
        $('#subFormDiv').dialog('open');
        return false;
    });


    $("#subFormDiv").dialog({
        title: "添加流程节点",
        autoOpen: false,
        width: 600,
        height:410,
        buttons: {
            "添加": function () {
                var form = $("#form");

                form.append("<input type='hidden' name='auditFlowNodes[][name]' value='" + $("#nodeName").val() + "'>");
                form.append("<input type='hidden' name='auditFlowNodes[][action]' value='" + $("#nodeAction").val() + "' data-value-type='string' data-skip-falsy='true'>");
                form.append("<input type='hidden' name='auditFlowNodes[][refusedAction]' value='" + $("#nodeRefusedAction").val() + "' data-value-type='string' data-skip-falsy='true'>");
                form.append("<input type='hidden' name='auditFlowNodes[][post[id]]' value='" + $("#post").val() + "'>");
                form.append("<input type='hidden' name='auditFlowNodes[][nextPost[id]]' value='0' data-value-type='number' data-skip-falsy='true'>");

                var nextPostIds = document.getElementsByName("auditFlowNodes[][nextPost[id]]");
                if (nextPostIds.length >= 2) {
                    nextPostIds[nextPostIds.length-2].value = $("#post").val();
                }

                var nodesDiv = $("#nodesDiv");
                if (nextPostIds.length > 1) {
                    nodesDiv.append('&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-long-arrow-right"></i>&nbsp;&nbsp;');
                }
                nodesDiv.append('<a class="btn btn-app">' + $("#nodeName").val() + '<br/>' + $("#post").find("option:selected").text() + '</a>');

                $(this).dialog("close");
            },
            "取消": function () {
                $(this).dialog("close");
            }
        }
    });

    $("#send").click(function(){
        if (document.getElementsByName("auditFlowNodes[][name]").length == 0) {
            alert("请添加节点");
            return false;
        }

        $('#form').submitForm('<%=request.getContextPath()%>/sys/save/<%=AuditFlow.class.getSimpleName().toLowerCase().substring(0,1).toLowerCase()+AuditFlow.class.getSimpleName().substring(1)%>');
    });

    $("#delete").click(function(){
        if (confirm("确定设置该流程不可用吗？")) {
            $("#form").sendData('<%=request.getContextPath()%>/sys/update/<%=AuditFlow.class.getSimpleName().toLowerCase().substring(0,1).toLowerCase()+AuditFlow.class.getSimpleName().substring(1)%>',
                '{"id":${entity.id},"state":1}');
        }
    });

    $("#recover").click(function(){
        if (confirm("确定设置该流程为可用吗？")) {
            $("#form").sendData('<%=request.getContextPath()%>/sys/update/<%=AuditFlow.class.getSimpleName().toLowerCase().substring(0,1).toLowerCase()+AuditFlow.class.getSimpleName().substring(1)%>',
                '{"id":${entity.id},"state":0}');
        }
    });
</script>