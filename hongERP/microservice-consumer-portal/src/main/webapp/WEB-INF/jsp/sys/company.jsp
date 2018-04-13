<%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: company.jsp
*
* @author smjie
* @Date  2017/4/12
* @version 1.00
*
--%>
<%@ page import="com.hzg.sys.Company" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- page content -->
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3>公司<c:choose><c:when test="${entity != null}">修改</c:when><c:otherwise>注册</c:otherwise></c:choose></h3>
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
                        <h2>后台管理 <small>公司</small></h2>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">

                        <form class="form-horizontal form-label-left" novalidate id="form">
                            <span class="section">公司信息</span>

                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="name">公司名称 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="name" class="form-control col-md-7 col-xs-12" value="${entity.name}" data-validate-length-range="6,30" data-validate-words="1" name="name"  required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="phone">联系电话 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="phone" class="form-control col-md-7 col-xs-12" value="${entity.phone}" data-validate-length-range="5,16" data-validate-words="1" name="phone" required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="postCode">邮编 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="postCode" class="form-control col-md-7 col-xs-12" value="${entity.postCode}" data-validate-length-range="5,16" data-validate-words="1" name="postCode" required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label for="address" class="control-label col-md-3">地址 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="address" class="form-control col-md-7 col-xs-12" type="text" value="${entity.address}" name="address" data-validate-words="1" data-validate-length="6,60" required>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label for="city" class="control-label col-md-3">城市 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="city" class="form-control col-md-7 col-xs-12" type="text" value="${entity.city}" name="city" data-validate-words="1" data-validate-length="6,60" required>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label for="province" class="control-label col-md-3">省份 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="province" class="form-control col-md-7 col-xs-12" type="text" value="${entity.province}" name="province" data-validate-words="1" data-validate-length="6,60" required>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label for="country" class="control-label col-md-3">国家 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="country" class="form-control col-md-7 col-xs-12" type="text" value="${entity.country}" name="country" data-validate-words="1" data-validate-length="6,60" required>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="text1">负责人</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" id="text1" name="text1" value="${entity.charger.name}" class="form-control col-md-7 col-xs-12" style="width:40%" placeholder="输入姓名" />
                                    <input type="hidden" id="charger[id]" name="charger[id]" value="${entity.charger.id}" data-value-type="number" data-skip-falsy="true">
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
<!-- /page content -->
<script type="text/javascript">
    init(<c:out value="${entity == null}"/>);

    $("#send").click(function(){$('#form').submitForm('<%=request.getContextPath()%>/sys/<c:choose><c:when test="${entity != null}">update</c:when><c:otherwise>save</c:otherwise></c:choose>/<%=Company.class.getSimpleName().toLowerCase()%>');});

    $("#text1").coolautosuggest({
        url:"<%=request.getContextPath()%>/sys/suggest/user/name/",
        showProperty: 'name',
        onSelected:function(result){
            if(result!=null){
                $(document.getElementById("charger[id]")).val(result.id);
            }
        }
    });

    <c:choose><c:when test="${entity != null}">document.title = "公司修改";</c:when><c:otherwise> document.title = "公司注册";</c:otherwise></c:choose>
</script>