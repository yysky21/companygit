<%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: Test.java
*
* @author smjie
* @Date  2017/5/18
* @version 1.00
*
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.hzg.sys.Audit" %>
<%@ page import="com.hzg.tools.AuditFlowConstant" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<!-- page content -->
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3><c:choose><c:when test="${entity.state == 1}">办理事宜</c:when><c:otherwise>查看事宜</c:otherwise></c:choose></h3>
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
                        <h2><c:choose><c:when test="${entity.state == 1}">办理事宜</c:when><c:otherwise>查看事宜</c:otherwise></c:choose></h2>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <div class="right_col">
                            <h2 class="h2-margin-bottom">名称: &nbsp;&nbsp;${entity.name}</h2>
                            <h2 class="h2-margin-bottom">内容: &nbsp;&nbsp;${entity.content}</h2>
                            <h2 class="h2-margin-bottom">流转时间: &nbsp;&nbsp;${entity.inputDate}</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="entityDiv"></div>

        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                    <div class="x_title">
                        <h2 class="h2-margin-bottom">节点处理情况</h2>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content" style="font-family:STKaiti ;font-size:18px">
                        <%
                            DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                        %>
                        <c:forEach items="${entities}" var="entity" varStatus="status">
                            <%
                                Audit entity = (Audit) pageContext.getAttribute("entity");
                                if (entity.getState().compareTo(AuditFlowConstant.audit_state_done) == 0) {
                            %>
                        <div style="padding-left:20px;margin-bottom:20px">
                            <div style="float: left;width: 80%">${status.count}.&nbsp;&nbsp;&nbsp;${entity.resultName},&nbsp;&nbsp;&nbsp;&nbsp;${entity.remark}</div>
                            <div style="float: left;">${entity.user.name}&nbsp;&nbsp;&nbsp;&nbsp;<%=sdf.format(entity.getDealDate())%></div>
                            <div class="clearfix"></div>
                        </div>
                            <%
                                }
                            %>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                    <div class="x_content">
                        <form class="form-horizontal form-label-left" novalidate id="dealForm">
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="result">类型<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select id="result" name="result" class="form-control col-md-7 col-xs-12" required>
                                        <option value="">请选择</option>
                                        <option value="<%=AuditFlowConstant.audit_do%>">已办</option>
                                        <option value="<%=AuditFlowConstant.audit_pass%>">审核通过</option>
                                        <c:if test="${refuseUserOptions != null}">
                                        <option value="<%=AuditFlowConstant.audit_deny%>">审核未通过</option>
                                        </c:if>
                                        <option value="<%=AuditFlowConstant.audit_finish%>">不再显示该待办事宜</option>
                                    </select>
                                </div>
                            </div>
                            <div class="item form-group" id="refusePosts" style="display:none">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="result">返回人<span class="required"></span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select name="toRefuseUser[id]" class="form-control col-md-7 col-xs-12">
                                        ${refuseUserOptions}
                                    </select>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="remark">批语 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <textarea id="remark" name="remark" value="${entity.remark}"  class="form-control col-md-7 col-xs-12" data-validate-length-range="6,30" data-validate-words="1"required></textarea>
                                </div>
                            </div>
                            <div class="ln_solid"></div>
                            <div class="form-group">
                                <div class="col-md-6 col-md-offset-3">
                                    <button id="cancel" type="button" class="btn btn-primary">返回</button>
                                    <button id="deal" type="button" class="btn btn-success">办理</button>
                                </div>
                            </div>
                            <input type="hidden" id="id" name="id" value="${entity.id}">
                            <input type="hidden" name="sessionId" value="${sessionId}">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /page content -->
<script type="text/javascript">
    var entity = dataList.entityRelations["${entity.entity}"];
    renderAudit($("#entityDiv"), "<%=request.getContextPath()%>" + dataList.modules[entity] + dataList.viewActions[entity] + "/" + entity + "/${entity.entityId}");

    if (${entity.state == 0}) {
        $("#deal").click(function(){
            $('#dealForm').submitForm('<%=request.getContextPath()%>/sys/<%=Audit.class.getSimpleName().toLowerCase()%>');
            $("#deal").attr("disabled", "disabled");
        });
    } else {
        $("#deal").attr("disabled", "disabled");
    }

    $("#result").change(function(){
        if (this.value == "N") {
            $("#refusePosts").show();
        } else {
            $("#refusePosts").hide();
        }
    });

    <c:choose><c:when test="${entity.state == 1}">document.title = "办理事宜";</c:when><c:otherwise> document.title = "查看事宜";</c:otherwise></c:choose>
</script>