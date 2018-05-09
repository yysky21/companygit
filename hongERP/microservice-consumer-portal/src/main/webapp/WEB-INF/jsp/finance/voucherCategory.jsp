<%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: voucherCategory.jsp
*
* @author yuanyun
* @Date  2017/11/27
* @version 1.00
*
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- page content -->
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3><c:choose><c:when test="${entity != null}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose>凭证类别</h3>
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
                        <h2>财务 <small>凭证类别</small></h2>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <form class="form-horizontal form-label-left" novalidate id="form">
                            <span class="section">凭证类别信息</span>
                            <div class="item form-group">
                                <label for="voucherWord" class="control-label col-md-3 col-sm-3 col-xs-12">凭证字 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="voucherWord" type="text" name="voucherWord" value="${entity.voucherWord}" data-validate-length="0,10" data-validate-words="0" class="form-control col-md-7 col-xs-12" required>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">凭证类别<span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="name" name="name" class="form-control col-md-7 col-xs-12" value="${entity.name}" data-validate-length="1,16" data-validate-words="1"  required type="text">
                                </div>
                            </div>
                            <div class="ln_solid"></div>
                            <div class="form-group">
                                <div class="col-md-6 col-md-offset-3">
                                    <button id="cancel" type="button" class="btn btn-primary">取消</button>
                                    <c:if test="${entity != null}"><button id="edit" type="button" class="btn btn-primary">编辑</button><button id="delete" type="button" class="btn btn-danger">删除</button></c:if>
                                    <button id="send" type="button" class="btn btn-success"><c:choose><c:when test="${entity != null}">更新</c:when><c:otherwise>保存</c:otherwise></c:choose></button>
                                </div>
                            </div>
                            <c:if test="${entity != null}"><input type="hidden" id="id" name="id" value="${entity.id}"></c:if>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    init(<c:out value="${entity == null}"/>);

    $("#send").click(function(){
        $('#form').submitForm('<%=request.getContextPath()%>/finance/<c:choose><c:when test="${entity != null}">update</c:when><c:otherwise>save</c:otherwise></c:choose>/voucherCategory');
    });

    $("#delete").click(function(){
        if (confirm("确定删除该凭证类别吗？")) {
            $("#form").sendData('<%=request.getContextPath()%>/finance/delete/voucherCategory',
                '{"id":${entity.id}}');
        }
    });

    <c:choose><c:when test="${entity != null}">document.title = "修改凭证类别";</c:when><c:otherwise> document.title = "添加凭证类别";</c:otherwise></c:choose>
</script>