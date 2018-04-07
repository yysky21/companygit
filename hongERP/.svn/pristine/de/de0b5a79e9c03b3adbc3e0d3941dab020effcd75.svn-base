<%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: articleTag.jsp
*
* @author yuanyun
* @Date  2017/10/06
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
                <h3><c:choose><c:when test="${entity != null}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose>文章标签</h3>
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
                        <h2>后台管理 <small>文章标签</small></h2>

                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">

                        <form class="form-horizontal form-label-left" novalidate id="form">
                            <span class="section">文章标签信息</span>

                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">文章标签名称 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="name" name="name" class="form-control col-md-7 col-xs-12" value="${entity.name}" data-validate-length="1,20" data-validate-words="1"  required type="text">
                                </div>
                            </div>
                            <div class="ln_solid"></div>
                            <div class="form-group">
                                <div class="col-md-6 col-md-offset-3">
                                    <button id="cancel" type="button" class="btn btn-primary">返回</button>
                                    <button id="send" type="button" class="btn btn-success"><c:choose><c:when test="${entity != null}">更新</c:when><c:otherwise>保存</c:otherwise></c:choose></button>
                                    <c:if test="${entity != null}"><button id="edit" type="button" class="btn btn-primary">编辑</button></c:if>
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
        $('#form').submitForm('<%=request.getContextPath()%>/sys/<c:choose><c:when test="${entity != null}">update</c:when><c:otherwise>save</c:otherwise></c:choose>/articleTag');
    });

    <c:choose><c:when test="${entity != null}">document.title = "修改文章标签";</c:when><c:otherwise> document.title = "添加文章标签";</c:otherwise></c:choose>
</script>