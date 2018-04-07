<%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: articleCate.jsp
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
                <h3><c:choose><c:when test="${entity != null}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose>文章分类</h3>
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
                        <h2>后台管理 <small>文章分类</small></h2>

                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">

                        <form class="form-horizontal form-label-left" novalidate id="form">
                            <span class="section">文章分类信息</span>

                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="parent[id]">文章父类 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select id="parent[id]" name="parent[id]" class="form-control col-md-7 col-xs-12" ><c:if test="${entity != null}">${entity.parent.name}</c:if>
                                    </select>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">文章分类名称 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="name" name="name" class="form-control col-md-7 col-xs-12" value="${entity.name}" data-validate-length="1,20" data-validate-words="1"  required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label for="nickname" class="control-label col-md-3 col-sm-3 col-xs-12">分类名称简写 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="nickname" type="text" name="nickname" value="${entity.nickname}" data-validate-length="1,20" data-validate-words="1" class="form-control col-md-7 col-xs-12" required>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="articleTitle">文章分类优化标题 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="articleTitle" type="text" name="articleTitle" value="${entity.articleTitle}" data-validate-length="1,50" data-validate-words="1" class="form-control col-md-7 col-xs-12" required>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="articleKeyword">文章分类优化关键词 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="articleKeyword" name="articleKeyword" class="form-control col-md-7 col-xs-12" value="${entity.articleKeyword}" data-validate-length="1,50" data-validate-words="1" required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="articleDesc">文章分类优化描述 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="articleDesc" name="articleDesc" class="form-control col-md-7 col-xs-12" value="${entity.articleDesc}" data-validate-length="5,100" data-validate-words="1" required type="text">
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
        if ($(document.getElementById("parent[id]")).val()==""){
            $(document.getElementById("parent[id]")).attr("disabled","disabled");
        }
        $('#form').submitForm('<%=request.getContextPath()%>/sys/<c:choose><c:when test="${entity != null}">update</c:when><c:otherwise>save</c:otherwise></c:choose>/articleCate');
    });

    selector.setSelect(['parent[id]'], ['name'], ['id'],
        [<c:if test="${entity != null}">'${entity.parent.id}'</c:if>],
        ['<%=request.getContextPath()%>/sys/query/articleCate'],
        '{}', [], 0);

    <c:choose><c:when test="${entity != null}">document.title = "修改文章分类";</c:when><c:otherwise> document.title = "添加文章分类";</c:otherwise></c:choose>
</script>