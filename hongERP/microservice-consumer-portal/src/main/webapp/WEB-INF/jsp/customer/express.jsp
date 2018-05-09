<%@ page import="com.hzg.tools.CommonConstant" %>
<%@ page import="com.hzg.customer.Express" %><%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: express.jsp
*
* @author smjie
* @Date  2018/4/24
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
                <h3>收件信息<c:choose><c:when test="${entity != null}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></h3>
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
                        <h2>客户服务 <small>收件信息</small></h2>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <form class="form-horizontal form-label-left" novalidate id="form">
                            <span class="section">收件信息</span>

                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="receiver">收件人 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="receiver" name="receiver" value="${entity.receiver}" class="form-control col-md-7 col-xs-12" data-validate-length-range="1,20" data-validate-words="1" required type="text">
                                </div>
                            </div>
                            <div class="clearfix" style="margin-bottom: 15px"></div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="expressMobile">收件联系手机 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="expressMobile" name="mobile" value="${entity.mobile}" class="form-control col-md-7 col-xs-12" data-validate-length-range="11,20" data-validate-words="1" required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="expressPhone">收件联系电话 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="expressPhone" name="phone" value="${entity.phone}" class="form-control col-md-7 col-xs-12" data-validate-length-range="7,20" data-validate-words="1" required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="expressAddress">收件地址 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="expressAddress" name="address" value="${entity.address}" class="form-control col-md-7 col-xs-12" data-validate-length-range="1,60" data-validate-words="1" required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="expressCity">所在城市 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="expressCity" name="city" value="${entity.city}" class="form-control col-md-7 col-xs-12" data-validate-length-range="1,16" data-validate-words="1" required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="expressProvince">所在省份 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="expressProvince" name="province" value="${entity.province}" class="form-control col-md-7 col-xs-12" data-validate-length-range="1,16" data-validate-words="1" required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="expressCountry">所属国家 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="expressCountry" name="country" value="<c:if test="${entity != null}">${entity.country}</c:if><c:if test="${entity == null}">中国</c:if>" class="form-control col-md-7 col-xs-12" data-validate-length-range="1,16" data-validate-words="1" required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="expressPostCode">邮编 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="expressPostCode" name="postCode" value="${entity.postCode}" class="form-control col-md-7 col-xs-12" data-validate-length-range="4,7" data-validate-words="1" required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="defaultUse">是否默认使用 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select id="defaultUse" name="defaultUse" class="form-control col-md-7 col-xs-12" required>
                                        <%
                                            Express express = (Express) request.getAttribute("entity");
                                            if (express == null) {
                                        %>
                                        <option value="">请选择</option>
                                        <option value="<%=CommonConstant.N%>">否</option>
                                        <option value="<%=CommonConstant.Y%>">是</option>
                                        <%
                                        } else {
                                            String options =
                                                    ("<option value='" + CommonConstant.N + "'>否</option>" +
                                                    "<option value='" + CommonConstant.Y + "'>是</option>")
                                                            .replace("'" + express.getDefaultUse() + "'", "'" + express.getDefaultUse() + "' selected");
                                        %>
                                        <%=options%>
                                        <%
                                            }
                                        %>

                                    </select>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="text1">所属客户 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" id="text1" name="text1" value="${entity.customer.name}" class="form-control col-md-7 col-xs-12" style="width:40%" placeholder="输入姓名" required />
                                    <input type="hidden" id="customer[id]" name="customer[id]" value="${entity.customer.id}">
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
                                        <button id="send" type="button" class="btn btn-success">修改</button>
                                        <button id="edit" type="button" class="btn btn-primary">编辑</button>
                                        <button id="delete" type="button" class="btn btn-danger">注销</button>
                                    </c:if>
                                </div>
                            </div>
                            <c:if test="${entity != null}"><input type="hidden" id="id" name="id" value="${entity.id}"></c:if>
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
    init(<c:out value="${entity == null}"/>);

    $('#birthday').daterangepicker({
        locale: {
            format: 'YYYY-MM-DD',
            applyLabel : '确定',
            cancelLabel : '取消',
            fromLabel : '起始时间',
            toLabel : '结束时间',
            customRangeLabel : '自定义',
            daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
            monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月' ],
            firstDay : 1
        },
        singleDatePicker: true,
        singleClasses: "picker_3"
    }, function(start, end, label) {
        console.log(start.toISOString(), end.toISOString(), label);
    });

    $("#text1").coolautosuggest({
        url:"<%=request.getContextPath()%>/customerManagement/unlimitedSuggest/customer/name/",
        showProperty: 'name',
        onSelected:function(result){
            if(result!=null){
                $(document.getElementById("customer[id]")).val(result.id);
            }
        }
    });

    $("#send").click(function(){
        $("#form").submitForm('<%=request.getContextPath()%>/customerManagement/doBusiness/<c:choose><c:when test="${entity != null}">expressAdminUpdate</c:when><c:otherwise>expressAdminSave</c:otherwise></c:choose>');
    });

   <c:choose><c:when test="${entity != null}">document.title = "收件信息修改";</c:when><c:otherwise> document.title = "收件信息添加";</c:otherwise></c:choose>
</script>