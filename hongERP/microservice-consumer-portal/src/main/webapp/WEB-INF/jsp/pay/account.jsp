<%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: account.jsp
*
* @author smjie
* @Date  2017/7/5
* @version 1.00
*
--%>
<%@ page import="com.hzg.pay.Pay" %>
<%@ page import="com.hzg.pay.Account" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- page content -->
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3>银行账户注册</h3>
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
                        <h2>支付管理 <small>银行账户</small></h2>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">

                        <form class="form-horizontal form-label-left" novalidate id="form">
                            <span class="section">银行账户信息</span>

                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="account">账户号 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="account" class="form-control col-md-7 col-xs-12" value="${entity.account}" data-validate-length-range="6,30" name="account"  required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="bank">所属银行 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="bank" class="form-control col-md-7 col-xs-12" value="${entity.bank}" data-validate-length-range="4,16" name="bank" required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="text1">开户人</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" id="text1" name="text1" value="${entity.owner.name}" class="form-control col-md-7 col-xs-12" style="width:40%" placeholder="输入姓名" />
                                    <input type="hidden" id="owner[id]" name="owner[id]" value="${entity.owner.id}" data-value-type="number" data-skip-falsy="true">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label for="branch" class="control-label col-md-3">开户行 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="branch" class="form-control col-md-7 col-xs-12" type="text" value="${entity.branch}" name="branch" data-validate-length="4,60" required>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label for="amount" class="control-label col-md-3">账户金额 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="amount" class="form-control col-md-7 col-xs-12" type="text" value="${entity.amount}" name="amount" data-value-type="number" data-skip-falsy="true" required>
                                </div>
                            </div>

                            <div class="ln_solid"></div>
                            <div class="form-group">
                                <div class="col-md-6 col-md-offset-3">
                                    <button id="cancel" type="button" class="btn btn-primary">返回</button>
                                    <c:if test="${entity == null}"><button id="send" type="button" class="btn btn-success">保存</button></c:if>
                                </div>
                            </div>
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

    $("#account").accountInput();

    $("#send").click(function(){$('#form').submitForm('<%=request.getContextPath()%>/pay/save/<%=Account.class.getSimpleName().toLowerCase()%>');});

    $("#text1").coolautosuggest({
        url:"<%=request.getContextPath()%>/sys/suggest/user/name/",
        showProperty: 'name',
        onSelected:function(result){
            if(result!=null){
                $(document.getElementById("owner[id]")).val(result.id);
            }
        }
    });

    document.title = "银行账户注册";
</script>