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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- page content -->
<link type="text/css" href="../../../res/css/jquery-ui-1.10.0.custom.css" rel="stylesheet">
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3>后台用户<c:choose><c:when test="${entity != null}">修改</c:when><c:otherwise>注册</c:otherwise></c:choose></h3>
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
                        <h2>后台管理 <small>用户</small></h2>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">

                        <form class="form-horizontal form-label-left" novalidate id="form">
                            <span class="section">用户信息</span>

                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">姓名 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="name" name="name" class="form-control col-md-7 col-xs-12" value="${entity.name}" data-validate-length-range="6，20" data-validate-words="1" required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="company[id]">公司 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select id="company[id]" name="company[id]" class="form-control col-md-7 col-xs-12" required>
                                    </select>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="dept[id]">部门 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select id="dept[id]" name="dept[id]" class="form-control col-md-7 col-xs-12" required>
                                    </select>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="posts[][id]">岗位 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select id="posts[][id]" name="posts[][id]" class="form-control col-md-7 col-xs-12" multiple required>
                                    </select>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label for="username" class="control-label col-md-3">用户名 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="username" type="text" name="username" value="${entity.username}" data-validate-length="4,20" class="form-control col-md-7 col-xs-12" required>
                                </div>
                            </div>
                            <c:if test="${entity == null}">
                            <div class="item form-group">
                                <label for="password1" class="control-label col-md-3">密码 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="password1" type="password" name="password1" data-validate-length="6,32" class="form-control col-md-7 col-xs-12" required>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label for="password2" class="control-label col-md-3 col-sm-3 col-xs-12">确认密码 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="password2" type="password" name="password2" data-validate-linked="password1" class="form-control col-md-7 col-xs-12" required>
                                </div>
                            </div>
                            <input type="hidden" id="password" name="password">
                            </c:if>
                            <c:if test="${entity != null}">
                            <div class="item form-group">
                                <label for="password3" class="control-label col-md-3">密码 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="password3" type="password" name="password3" value="*********" data-validate-length="6,32" class="form-control col-md-7 col-xs-12" disabled readonly>
                                    <a id="modifyPasswordA" style="cursor:pointer">修改密码</a>&nbsp;&nbsp;&nbsp;&nbsp;<a id="resetPasswordA" style="cursor:pointer">重置密码</a>
                                </div>
                            </div>
                            </c:if>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="gender">性别 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <div id="gender" class="btn-group" data-toggle="buttons">
                                        <label class="btn btn-default" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default">
                                            <input type="radio" name="gender" value="male" <c:if test="${entity != null && entity.gender == 'male'}">checked</c:if>> &nbsp;男&nbsp;
                                        </label>
                                        <label class="btn btn-default" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default">
                                            <input type="radio" name="gender" value="female" <c:if test="${entity != null && entity.gender == 'female'}">checked</c:if>> &nbsp;女&nbsp;
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="email">Email <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="email" id="email" name="email" value="${entity.email}" data-validate-length="6,30" required class="form-control col-md-7 col-xs-12">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="mobile">手机号 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="phone" id="mobile" name="mobile" value="${entity.mobile}" data-validate-length="6,30" required class="form-control col-md-7 col-xs-12">
                                </div>
                            </div>
                            <div class="ln_solid"></div>
                            <div class="form-group">
                                <div class="col-md-6 col-md-offset-3">
                                    <button id="cancel" type="button" class="btn btn-primary">返回</button>
                                    <c:if test="${entity == null}">
                                    <button id="send" type="button" class="btn btn-success">保存</button>
                                    </c:if>
                                    <c:if test="${entity != null}">
                                    <c:choose>
                                        <c:when test="${entity.state == 0}">
                                            <button id="send" type="button" class="btn btn-success">修改</button>
                                            <button id="edit" type="button" class="btn btn-primary">编辑</button>
                                            <button id="delete" type="button" class="btn btn-danger">注销</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button id="editState" type="button" class="btn btn-primary">编辑</button>
                                            <button id="recover" type="button" class="btn btn-success">置为可用</button>
                                        </c:otherwise>
                                    </c:choose>
                                    </c:if>
                                </div>
                            </div>
                            <c:if test="${entity != null}"><input type="hidden" id="id" name="id" value="${entity.id}"></c:if>
                            <input type="hidden" id="state" name="state:number" value="<c:choose><c:when test="${entity != null}">${entity.state}</c:when><c:otherwise>0</c:otherwise></c:choose>">
                        </form>
                    </div>

                    <c:if test="${entity != null}">
                        <div id="modifyPasswordDiv">
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="oldPassword1">旧密码 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="oldPassword1" type="password"  data-validate-length="6,32" class="form-control col-md-7 col-xs-12" required>
                                </div>
                            </div>
                            <div class="clearfix" style="margin-bottom: 15px"></div>
                            <div class="item form-group">
                                <label for="newPassword1" class="control-label col-md-3">新密码 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="newPassword1" type="password" name="newPassword1" data-validate-length="6,32" class="form-control col-md-7 col-xs-12" required>
                                </div>
                            </div>
                            <div class="clearfix" style="margin-bottom: 15px"></div>
                            <div class="item form-group">
                                <label for="confirmNewPassword1" class="control-label col-md-3 col-sm-3 col-xs-12">确认密码 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="confirmNewPassword1" type="password"  data-validate-linked="newPassword1" class="form-control col-md-7 col-xs-12" required>
                                </div>
                            </div>
                            <form id="modifyPasswordForm">
                                <input type="hidden" name="entityId" value="${entity.id}">
                                <input type="hidden" id="oldPassword" name="oldPassword">
                                <input type="hidden" id="newPassword" name="newPassword">
                                <input type="hidden" name="sessionId" value="${sessionId}">
                            </form>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /page content -->

<script type="text/javascript">
    init(<c:out value="${entity == null}"/>);

    $("#send").click(function(){
        <c:if test="${entity == null}">
        if ($("#form").isFullSet()) {
            var password1 = $("#password1");
            $("#password").val(faultylabs.MD5(jQuery.trim(password1.val())));
            password1.attr("disabled","disabled");
            $("#password2").attr("disabled","disabled");
        }
        </c:if>

        $("#form").submitForm('<%=request.getContextPath()%>/sys/<c:choose><c:when test="${entity != null}">update</c:when><c:otherwise>save</c:otherwise></c:choose>/<%=User.class.getSimpleName().toLowerCase()%>');
    });

    <c:if test="${entity != null}">
        $("#modifyPasswordA").click(function(){
            $('#modifyPasswordDiv').dialog('open');
            return false;
        });

        $("#modifyPasswordDiv").dialog({
            title: "修改",
            autoOpen: false,
            width: 400,
            height:310,
            buttons: {
                "确定": function () {
                    var modifyPasswordForm = $("#modifyPasswordForm");
                    if (!modifyPasswordForm.isFullSet()) {
                        return false;
                    }

                    var oldPassword1 = $("#oldPassword1");
                    $("#oldPassword").val(faultylabs.MD5(jQuery.trim(oldPassword1.val())));
                    var newPassword1 = $("#newPassword1");
                    $("#newPassword").val(faultylabs.MD5(jQuery.trim(newPassword1.val())));

                    modifyPasswordForm.submitForm('<%=request.getContextPath()%>/sys/doBusiness/modifyPassword');
                },

                "取消": function () {
                    $(this).dialog("close");
                }
            }
        });

        $("#resetPasswordA").click(function(){
            $("#modifyPasswordForm").sendData('<%=request.getContextPath()%>/sys/doBusiness/resetPassword',
                '{"entityId":"${entity.id}","sessionId":"${sessionId}", "random":"' + Math.random() + '"}',
                function(result){
                    if (result.newPassword != undefined) {
                        alert("重置成功，新密码：" + result.newPassword);
                    }
                },
                false);
        });
    </c:if>

    $("#delete").click(function(){
        if (confirm("确定注销该用户吗？")) {
            $("#form").sendData('<%=request.getContextPath()%>/sys/update/<%=User.class.getSimpleName().toLowerCase()%>',
                '{"id":${entity.id},"state":1}');
        }
    });

    $("#recover").click(function(){
        if (confirm("确定设置该用户为可用吗？")) {
            $("#form").sendData('<%=request.getContextPath()%>/sys/update/<%=User.class.getSimpleName().toLowerCase()%>',
                '{"id":${entity.id},"state":0}');
        }
    });

    <c:set var="postIds" value="" />
    <c:set var="deptId" value="" />
    <c:if test="${entity != null}">
        <c:forEach var="post" items="${entity.posts}" varStatus="status">
            <c:set var="postIds" value="${postIds}${post.id}," />
            <c:set var="deptId" value="${post.dept.id}" />
        </c:forEach>
    </c:if>

    var companyId = "${companyId}", deptId = "${deptId}", postId = "${postIds}".substr(0, "${postIds}".length-1);

    if (postId != "") {
        $.ajax({
            type: "get",
            url: '<%=request.getContextPath()%>/sys/query/<%=Dept.class.getSimpleName().toLowerCase()%>',
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: {json: '{"id":"' + deptId + '"}'},
            dataType: "json",

            success: function(items){
                companyId = items[0].company.id;

                selector.setSelect(['company[id]', 'dept[id]', 'posts[][id]'], ['name', 'name', 'name'], ['id', 'id', 'id'],
                    [companyId, deptId, postId],
                    ['<%=request.getContextPath()%>/sys/query/<%=Company.class.getSimpleName().toLowerCase()%>',
                        '<%=request.getContextPath()%>/sys/query/<%=Dept.class.getSimpleName().toLowerCase()%>',
                        '<%=request.getContextPath()%>/sys/query/<%=Post.class.getSimpleName().toLowerCase()%>'],
                    '{}', ['company[id]', 'dept[id]'], 0);
            }
        });
    } else {
        selector.setSelect(['company[id]', 'dept[id]', 'posts[][id]'], ['name', 'name', 'name'], ['id', 'id', 'id'], [],
            ['<%=request.getContextPath()%>/sys/query/<%=Company.class.getSimpleName().toLowerCase()%>',
                '<%=request.getContextPath()%>/sys/query/<%=Dept.class.getSimpleName().toLowerCase()%>',
                '<%=request.getContextPath()%>/sys/query/<%=Post.class.getSimpleName().toLowerCase()%>'],
            '{}', ['company[id]', 'dept[id]'], 0);
    }

   <c:choose><c:when test="${entity != null}">document.title = "后台用户修改";</c:when><c:otherwise> document.title = "后台用户注册";</c:otherwise></c:choose>
</script>