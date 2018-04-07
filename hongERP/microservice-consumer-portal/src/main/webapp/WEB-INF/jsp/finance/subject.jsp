<%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: user.jsp
*
* @author smjie
* @Date  2017/4/12
* @version 1.00
*
--%>
<%@ page import="com.hzg.sys.User" %>
<%@ page import="com.hzg.sys.Company" %>
<%@ page import="com.hzg.sys.Dept" %>
<%@ page import="com.hzg.sys.Post" %>
<%@ page import="com.hzg.finance.Subject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- page content -->
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3><c:choose><c:when test="${entity != null}">查看</c:when><c:otherwise>新增</c:otherwise></c:choose>科目</h3>
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
                        <h2>财务 <small>科目</small></h2>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">

                        <form class="form-horizontal form-label-left" novalidate id="form">
                            <span class="section">科目信息</span>

                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="no">科目编码 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="no" name="no" class="form-control col-md-7 col-xs-12" value="${entity.no}" data-validate-length-range="4，16" data-validate-words="1" required type="text">
                                </div>
                                <span id="remindNo" style="color: red"></span>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="codeRule">编码规则 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="codeRule" name="codeRule" class="form-control col-md-7 col-xs-12" value="4-2-2-2-2" data-validate-length-range="4，16" data-validate-words="1" required readonly type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">科目名称 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="name" name="name" class="form-control col-md-7 col-xs-12" value="${entity.name}" data-validate-length-range="1，20" data-validate-words="1" required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="type">科目类型 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select id="type" name="type" class="form-control col-md-7 col-xs-12" required>
                                        <c:choose>
                                            <c:when test="${entity != null}">
                                                <option value="1" <c:if test="${entity.type==1}">selected</c:if>>资产</option>
                                                <option value="2" <c:if test="${entity.type==2}">selected</c:if>>负债</option>
                                                <option value="3" <c:if test="${entity.type==3}">selected</c:if>>所有者权益</option>
                                                <option value="4" <c:if test="${entity.type==4}">selected</c:if>>成本</option>
                                                <option value="5" <c:if test="${entity.type==5}">selected</c:if>>损益</option>
                                                <option value="6" <c:if test="${entity.type==6}">selected</c:if>>共同</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="1">资产</option>
                                                <option value="2">负债</option>
                                                <option value="3">所有者权益</option>
                                                <option value="4">成本</option>
                                                <option value="5">损益</option>
                                                <option value="6">共同</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </select>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="direction">余额方向 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select id="direction" name="direction" class="form-control col-md-7 col-xs-12" required>
                                        <c:choose>
                                            <c:when test="${entity != null}">
                                                <option value="1" <c:if test="${entity.direction==1}">selected</c:if>>借方</option>
                                                <option value="2" <c:if test="${entity.direction==2}">selected</c:if>>贷方</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="1">借方</option>
                                                <option value="2">贷方</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </select>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="subjectCategory[id]">科目类别<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select id="subjectCategory[id]" name="subjectCategory[id]" class="form-control col-md-7 col-xs-12" required >
                                    </select>
                                </div>
                                <span id="remindCate" style="color: red"></span>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" > </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <label class="control-label checkbox-inline ">
                                        <input id="info" name="info:number" class="flat" type="checkbox" value="0" <c:if test="${entity != null && entity.info == 0}">checked</c:if>> 填制凭证时录入结算信息
                                    </label>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="paperFormat">账面格式 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select id="paperFormat" name="paperFormat" class="form-control col-md-7 col-xs-12" required>
                                        <c:choose>
                                            <c:when test="${entity != null}">
                                                <option value="1" <c:if test="${entity.paperFormat==1}">selected</c:if>>金额式</option>
                                                <option value="2" <c:if test="${entity.paperFormat==2}">selected</c:if>>数量金额式</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="1">金额式</option>
                                                <option value="2">数量金额式</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </select>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="accountItems[]">辅助核算项 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <div id="accountItems[]" >
                                        <label class="checkbox-inline" >
                                            <input type="checkbox" class="flat" name="accountItems[]:number" value="1" <c:if test="${entity != null && entity.accountItemsStr.contains('1')}">checked</c:if> > 部门
                                        </label>
                                        <label class="checkbox-inline" >
                                            <input type="checkbox" class="flat" name="accountItems[]:number" value="2" <c:if test="${entity != null && entity.accountItemsStr.contains('2')}">checked</c:if> > 个人
                                        </label>
                                        <label class="checkbox-inline" >
                                            <input type="checkbox" class="flat" name="accountItems[]:number" value="3" <c:if test="${entity != null && entity.accountItemsStr.contains('3')}">checked</c:if> > 供应商
                                        </label>
                                        <label class="checkbox-inline" >
                                            <input type="checkbox" class="flat" name="accountItems[]:number" value="4" <c:if test="${entity != null && entity.accountItemsStr.contains('4')}">checked</c:if> > 客户
                                        </label>
                                        <label class="checkbox-inline" >
                                            <input type="checkbox" class="flat" name="accountItems[]:number" value="5" <c:if test="${entity != null && entity.accountItemsStr.contains('5')}">checked</c:if> > 项目
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="ln_solid"></div>
                            <div class="form-group">
                                <div class="col-md-6 col-md-offset-3">
                                    <button id="cancel" type="button" class="btn btn-primary">取消</button>
                                    <c:if test="${entity == null}">
                                    <button id="send" type="button" class="btn btn-success">保存</button>
                                    </c:if>
                                    <c:if test="${entity != null}">
                                        <c:choose>
                                            <c:when test="${entity.state == 0}">
                                                <button id="edit" type="button" class="btn btn-primary">编辑</button>
                                                <button id="send" type="button" class="btn btn-success">修改</button>
                                                <button id="stop" type="button" class="btn btn-danger">停用</button>
                                                <button id="delete" type="button" class="btn btn-danger">删除</button>
                                            </c:when>
                                            <c:otherwise>
                                                <button id="editState" type="button" class="btn btn-primary">编辑</button>
                                                <button id="recover" type="button" class="btn btn-success">置为可用</button>
                                                <button id="delete" type="button" class="btn btn-danger">删除</button>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </div>
                            </div>
                            <c:if test="${entity != null}"><input type="hidden" id="id" name="id" value="${entity.id}"></c:if>
                            <input type="hidden" id="state" name="state:number" value="<c:choose><c:when test="${entity != null}">${entity.state}</c:when><c:otherwise>0</c:otherwise></c:choose>">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /page content -->

<script type="text/javascript">

    init(<c:out value="${entity == null}"/>);

    $('input.flat').iCheck({
        checkboxClass: 'icheckbox_flat-green',
        radioClass: 'iradio_flat-green'
    });

    /*$("#subjectCategory2").on("ifChecked", function() {
        if ($("#subjectCategory2").attr("value") == 2){
            $("#info").iCheck("check");
        }
    });*/

    if (${entity == null}){
        $("#no").blur(function () {
            var no1 = $(this).val();
            var reg = /^[1-9]\d*$/;
            if (reg.test(no1) == true){
                var json1 = JSON.stringify({"no":no1});
                if ($(this).val().length > 4){
                    var no = $(this).val().substring(0,$(this).val().length-2);
                    var json = JSON.stringify({"no":no});
                    $(this).ajaxPost("<%=request.getContextPath()%>/finance/privateQuery/subject",json,function (result) {
                        if (result.flag == "false"){
                            $("#remindNo").show().html("不存在上级科目，请重新输入科目编码！");
                            $("#no").val("");
                        } else {
                            $("#no").ajaxPost("<%=request.getContextPath()%>/finance/privateQuery/subject",json1,function (result){
                                if (result.flag == "true") {
                                    $("#remindNo").show().html("该科目编码已经存在，请重新输入科目编码！");
                                    $("#no").val("");
                                }else{
                                    $("#remindNo").hide();
                                }
                            });
                        }
                    });
                } else if($(this).val().length == 4) {
                    $(this).ajaxPost("<%=request.getContextPath()%>/finance/privateQuery/subject",json1,function (result) {
                        if (result.flag == "true") {
                            $("#remindNo").show().html("该科目编码已经存在，请重新输入科目编码！");
                            $("#no").val("");
                        }else{
                            $("#remindNo").hide();
                        }
                    });
                }else {
                    $("#remindNo").show().html("科目编码至少4位，请重新输入科目编码！");
                    $("#no").val("");
                }
            } else {
                $("#remindNo").show().html("科目必须是不以0开头的纯数字，请重新输入科目编码！");
                $("#no").val("");
            }

        });
    }

    $("#send").click(function(){
        if ($("#info").prop("checked") == false){
            $("#form").append('<input type="hidden" id="info" name="info" value="1">');
        }
        $("#form").submitForm('<%=request.getContextPath()%>/finance/<c:choose><c:when test="${entity != null}">update</c:when><c:otherwise>save</c:otherwise></c:choose>/<%=Subject.class.getSimpleName().toLowerCase()%>');
    });

    $("#stop").click(function(){
        if (confirm("确定停用该科目吗？")) {
            $("#form").sendData('<%=request.getContextPath()%>/finance/update/subject',
                '{"id":${entity.id},"state":1}');
        }
    });

    $("#recover").click(function(){
        if (confirm("确定恢复该科目吗？")) {
            $("#form").sendData('<%=request.getContextPath()%>/finance/update/<%=Subject.class.getSimpleName().toLowerCase()%>',
                '{"id":${entity.id},"state":0}');
        }
    });

    $("#delete").click(function(){
        if (confirm("确定删除该科目吗？")) {
            $("#form").sendData('<%=request.getContextPath()%>/finance/delete/subject',
                '{"id":${entity.id}}');
        }
    });

    selector.setSelect(['subjectCategory[id]'], ['name'], ['id'],
        [<c:if test="${entity != null}">'${entity.subjectCategory.id}'</c:if>],
        ['<%=request.getContextPath()%>/finance/query/subjectCategory'],
        '{}', [], 0);

   <c:choose><c:when test="${entity != null}">document.title = "修改科目";</c:when><c:otherwise> document.title = "新增科目";</c:otherwise></c:choose>
</script>