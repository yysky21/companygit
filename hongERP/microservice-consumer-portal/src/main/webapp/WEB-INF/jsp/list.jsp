<%@ page import="com.hzg.tools.FileServerInfo" %><%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: entities.jsp
*
* @author smjie
* @Date  2017/4/12
* @version 1.00
*
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style type="text/css">

    /*关键设置 tbody出现滚动条*/
    #chartMakerChooseDiv table tbody {
        display: block;
        height: 520px;
        overflow: scroll;
    }

    #chartMakerChooseDiv table thead ,
    #chartMakerChooseDiv tbody tr {
        display: table;
        width: 100%;
        table-layout: fixed;
    }

    /*关键设置：滚动条默认宽度是17px 将thead的宽度减17px*/
    #chartMakerChooseDiv table thead {
        width: calc( 100% - 17px);
        background: rgba(52,73,94,.94);
        color: #ECF0F1;
    }

    #chartMakerChooseDiv .table tbody tr td {
        padding: 4px;
        vertical-align: middle;
        border-top: 0px;
    }

    #chartMakerChooseDiv table thead tr th,#chartMakerChooseDiv table thead tr th input {
        text-align: center;
        vertical-align: middle;
    }

    /* Layout helpers
----------------------------------*/
    .ui-helper-hidden { display: none; }
    .ui-helper-hidden-accessible {
        border: 0; clip: rect(0 0 0 0);
        height: 1px;
        margin: -1px;
        overflow: hidden;
        padding: 0;
        position: absolute;
        width: 1px;
    }
    .ui-helper-reset {
        margin: 0;
        padding: 0;
        border: 0;
        outline: 0;
        line-height: 1.3;
        text-decoration: none;
        font-size: 100%;
        list-style: none;
    }
    .ui-helper-clearfix:before,
    .ui-helper-clearfix:after {
        content: "";
        display: table;
    }
    .ui-helper-clearfix:after {
        content: ".";
        display: block;
        height: 0;
        clear: both;
        visibility: hidden;
    }
    .ui-helper-clearfix {
        /*display: inline-block; */
        display:block;
        min-height: 0; /* support: IE7 */
    }
    /* required comment for clearfix to work in Opera \*/
    * html .ui-helper-clearfix {
        height:1%;
    }

    /* end clearfix */
    .ui-helper-zfix {
        width: 100%;
        height: 100%;
        top: 0;
        left: 0;
        position: absolute;
        opacity: 0;
        filter:Alpha(Opacity=0);
    }


    /*
 * jQuery UI Dialog 1.10.0
 *
 * Copyright 2013, AUTHORS.txt (http://jqueryui.com/about)
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * http://docs.jquery.com/UI/Dialog#theming
 */
    .ui-dialog {
        position: absolute;
        top: 0;
        left: 0;
        padding: .2em;
        width: 300px;
        overflow: hidden;
        outline: 0;
        background-clip: padding-box;
        background-color: #FFFFFF;
        border: 1px solid rgba(0, 0, 0, 0.3);
        border-radius: 6px 6px 6px 6px;
        box-shadow: 0 3px 7px rgba(0, 0, 0, 0.3);
        /*left: 50%;
        margin-left: -280px;*/
        outline: medium none;
        position: fixed;
        /*top: 10%;
        width: 560px;*/
        z-index: 1050;
    }
    .ui-dialog .ui-dialog-titlebar { /*padding: .4em 1em;*/
        position: relative;
        padding:5px 15px;
        border:0px 0px 0px 1px solid;
        border-color: white;
        padding: 5px 15px;
        font-size: 18px;
        text-decoration:none;
        background:none;
        -moz-border-radius-bottomright: 0px;
        -webkit-border-bottom-right-radius: 0px;
        -khtml-border-bottom-right-radius: 0px;

        -moz-border-radius-bottomleft: 0px;
        -webkit-border-bottom-left-radius: 0px;
        -khtml-border-bottom-left-radius: 0px;
        border-bottom-left-radius: 0px;
        border-bottom:1px solid #ccc;
    }
    .ui-dialog .ui-dialog-title {
        float: left;
        color:#404040;
        font-weight:bold;
        margin-top:5px;
        margin-bottom:5px;
        padding:5px;
        text-overflow: ellipsis;
        overflow: hidden;
    }
    .ui-dialog .ui-dialog-titlebar-close {
        position: absolute;
        right: .3em;
        top: 50%;
        width: 19px;
        margin: -20px 0 0 0;
        padding: 1px;
        height: 18px;
        font-size: 20px;
        font-weight: bold;
        line-height: 13.5px;
        text-shadow: 0 1px 0 #ffffff;
        filter: alpha(opacity=25);
        -khtml-opacity: 0.25;
        -moz-opacity: 0.25;
        opacity: 0.25;
        background:none;
        border-width: 0;
        border:none;
        box-shadow: none;
    }

    .ui-dialog .ui-dialog-titlebar-close span {
        display: block;
        margin: 1px;
        text-indent: 9999px;
    }

    .ui-dialog .ui-dialog-titlebar-close:hover, .ui-dialog .ui-dialog-titlebar-close:focus { padding: 1px;   filter: alpha(opacity=90);
        -khtml-opacity: 0.90;
        -moz-opacity: 0.90;
        opacity: 0.90;
    }

    .ui-dialog .ui-dialog-content { position: relative; border: 0; padding: .5em 1em; background: none; overflow: auto; zoom: 1; }

    .ui-dialog .ui-dialog-buttonpane {
        text-align: left;
        border-width: 1px 0 0 0;
        background-image: none;
        margin: .5em 0 0 0;
        background-color: #f5f5f5;
        padding: 5px 15px 5px;
        border-top: 1px solid #ddd;
        -webkit-border-radius: 0 0 6px 6px;
        -moz-border-radius: 0 0 6px 6px;
        border-radius: 0 0 6px 6px;
        -webkit-box-shadow: inset 0 1px 0 #ffffff;
        -moz-box-shadow: inset 0 1px 0 #ffffff;
        box-shadow: inset 0 1px 0 #ffffff;
        zoom: 1;
        margin-bottom: 0;

    }
    .ui-dialog .ui-dialog-buttonpane .ui-dialog-buttonset { float: right; }
    .ui-dialog .ui-dialog-buttonpane button { margin: .5em .4em .5em 0; cursor: pointer; }
    .ui-dialog .ui-resizable-se { width: 14px; height: 14px; right: 3px; bottom: 3px; }
    .ui-draggable .ui-dialog-titlebar { cursor: move; }

    .ui-dialog-buttonpane .ui-dialog-buttonset .ui-button{
        color: #ffffff;
        background-color: #0064cd;
        background-repeat: repeat-x;
        background-image: -khtml-gradient(linear, left top, left bottom, from(#049cdb), to(#0064cd));
        background-image: -moz-linear-gradient(top, #049cdb, #0064cd);
        background-image: -ms-linear-gradient(top, #049cdb, #0064cd);
        background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #049cdb), color-stop(100%, #0064cd));
        background-image: -webkit-linear-gradient(top, #049cdb, #0064cd);
        background-image: -o-linear-gradient(top, #049cdb, #0064cd);
        background-image: linear-gradient(top, #049cdb, #0064cd);
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#049cdb', endColorstr='#0064cd', GradientType=0);
        text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
        border-color: #0064cd #0064cd #003f81;
        border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25);
    }

    .ui-dialog .ui-button {

        cursor: pointer;
        display: inline-block;
        background-color: #e6e6e6;
        background-repeat: no-repeat;
        background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#ffffff), color-stop(25%, #ffffff), to(#e6e6e6));
        background-image: -webkit-linear-gradient(#ffffff, #ffffff 25%, #e6e6e6);
        background-image: -moz-linear-gradient(top, #ffffff, #ffffff 25%, #e6e6e6);
        background-image: -ms-linear-gradient(#ffffff, #ffffff 25%, #e6e6e6);
        background-image: -o-linear-gradient(#ffffff, #ffffff 25%, #e6e6e6);
        background-image: linear-gradient(#ffffff, #ffffff 25%, #e6e6e6);
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#e6e6e6', GradientType=0);
        padding: 5px 14px 6px;
        margin: 0;
        text-shadow: 0 1px 1px rgba(255, 255, 255, 0.75);
        color: #333;
        font-size: 13px;
        line-height: normal;
        border: 1px solid #ccc;
        border-bottom-color: #bbb;

        -webkit-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05);
        -moz-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05);
        box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05);
        -webkit-transition: 0.1s linear background-image;
        -moz-transition: 0.1s linear background-image;
        -ms-transition: 0.1s linear background-image;
        -o-transition: 0.1s linear background-image;
        transition: 0.1s linear background-image;
        overflow: visible;
    } /* the overflow property removes extra width in IE */


    /* Corner radius */
    .ui-corner-all,
    .ui-corner-top,
    .ui-corner-left,
    .ui-corner-tl {
        -moz-border-radius-topleft: 4px;
        -webkit-border-top-left-radius: 4px;
        -khtml-border-top-left-radius: 4px;
        border-top-left-radius: 4px;
    }
    .ui-corner-all,
    .ui-corner-top,
    .ui-corner-right,
    .ui-corner-tr {
        -moz-border-radius-topright: 4px;
        -webkit-border-top-right-radius: 4px;
        -khtml-border-top-right-radius: 4px;
        border-top-right-radius: 4px;
    }
    .ui-corner-all,
    .ui-corner-bottom,
    .ui-corner-left,
    .ui-corner-bl {
        -moz-border-radius-bottomleft: 4px;
        -webkit-border-bottom-left-radius: 4px;
        -khtml-border-bottom-left-radius: 4px;
        border-bottom-left-radius: 4px;
    }
    .ui-corner-all,
    .ui-corner-bottom,
    .ui-corner-right,
    .ui-corner-br {
        -moz-border-radius-bottomright: 4px;
        -webkit-border-bottom-right-radius: 4px;
        -khtml-border-bottom-right-radius: 4px;
        border-bottom-right-radius: 4px;
    }

    /***Dialog fixes**/

    .ui-dialog-buttonset .ui-button:nth-child(2){
        cursor: pointer;
        display: inline-block;
        background-color: #e6e6e6;
        background-repeat: no-repeat;
        background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#ffffff), color-stop(25%, #ffffff), to(#e6e6e6));
        background-image: -webkit-linear-gradient(#ffffff, #ffffff 25%, #e6e6e6);
        background-image: -moz-linear-gradient(top, #ffffff, #ffffff 25%, #e6e6e6);
        background-image: -ms-linear-gradient(#ffffff, #ffffff 25%, #e6e6e6);
        background-image: -o-linear-gradient(#ffffff, #ffffff 25%, #e6e6e6);
        background-image: linear-gradient(#ffffff, #ffffff 25%, #e6e6e6);
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#e6e6e6', GradientType=0);
        padding: 5px 14px 6px;
        text-shadow: 0 1px 1px rgba(255, 255, 255, 0.75);
        color: #333;
        font-size: 13px;
        line-height: normal;
        border: 1px solid #ccc;
        border-bottom-color: #bbb;
        -webkit-border-radius: 4px;
        -moz-border-radius: 4px;
        border-radius: 4px;
        -webkit-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05);
        -moz-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05);
        box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05);
        -webkit-transition: 0.1s linear all;
        -moz-transition: 0.1s linear all;
        -ms-transition: 0.1s linear all;
        -o-transition: 0.1s linear all;
        transition: 0.1s linear all;
        overflow: visible;
    }
</style>
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3 id="htitle">列表</h3>
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
                        <h2>查询 <small id="stitle"></small></h2>
                        <ul class="nav navbar-right panel_toolbox">
                            <li><button id="add" type="button" class="btn btn-success"></button></li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <form class="form-horizontal form-label-left" novalidate id="form">
                            <div class="item form-group">
                                <label id="selectTitle" class="control-label col-md-3 col-sm-3 col-xs-12"  for="entity">类别<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select id="entity" name="entity" class="form-control col-md-7 col-xs-12" required>
                                    </select>
                                </div>
                            </div>
                            <div id="dateItems">
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="inputDate" id="timeLabel">时间</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <div class="input-prepend input-group" style="margin-bottom:0">
                                        <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                                        <input type="text" name="inputDate" id="inputDate" class="form-control" value="" />
                                    </div>
                                </div>
                            </div>
                            </div>
                            <div id="inputItems">
                                <div class="item form-group">
                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">名称</label>
                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                        <input type="text" id="name" name="name" class="form-control col-md-7 col-xs-12" placeholder="输入名称" />
                                    </div>
                                </div>
                            </div>
                            <div class="item form-group">
                                <div class="col-md-6 col-md-offset-3">
                                    <button id="send" type="button" class="btn btn-success">查询</button>
                                </div>
                            </div>
                        </form>
                        <div class="ln_solid"></div>
                    </div>
                    <div class="x_content">
                        <table id="dataList" class="table table-striped table-bordered jambo_table bulk_action"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /page content -->
<script type="text/javascript">
    $('#inputDate').daterangepicker({locale:{
        format: 'YYYY/MM/DD',
        applyLabel : '确定',
        cancelLabel : '取消',
        fromLabel : '起始时间',
        toLabel : '结束时间',
        customRangeLabel : '自定义',
        daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
        monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月' ],
        firstDay : 1
    }}, function(start, end, label) {
        console.log(start.toISOString(), end.toISOString(), label);
    });

    var visitEntitiesOptions = {};
    <c:if test="${resources != null}">

    <c:if test="${fn:contains(resources, '/product')}">
    visitEntitiesOptions["product"] = '<option value="product">商品</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/productDescribe')}">
    visitEntitiesOptions["productDescribe"] = '<option value="productDescribe">商品描述</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/productType/')}">
    visitEntitiesOptions["productType"] = '<option value="productType">商品类型</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/productPriceChange/')}">
    visitEntitiesOptions["productPriceChange"] = '<option value="productPriceChange">商品调价</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/productCheck/')}">
    visitEntitiesOptions["productCheck"] = '<option value="productCheck">商品盘点</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/supplier')}">
    visitEntitiesOptions["supplier"] = '<option value="supplier">供应商</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/stock')}">
    visitEntitiesOptions["stockInOut"] = '<option value="stockInOut">出库/入库</option>';
    visitEntitiesOptions["stock"] = '<option value="stock">库存</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/warehouse')}">
    visitEntitiesOptions["warehouse"] = '<option value="warehouse">仓库</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/purchase')}">
    visitEntitiesOptions["purchase"] = '<option value="purchase">采购</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/borrowProduct')}">
    visitEntitiesOptions["borrowProduct"] = '<option value="borrowProduct">借货</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/borrowProductReturn')}">
    visitEntitiesOptions["borrowProductReturn"] = '<option value="borrowProductReturn">还货</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/order')}">
    visitEntitiesOptions["order"] = '<option value="order">订单</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/orderPrivate')}">
    visitEntitiesOptions["orderPrivate"] = '<option value="orderPrivate">商品加工，私人订制</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/returnProduct')}">
    visitEntitiesOptions["returnProduct"] = '<option value="returnProduct">退货</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/changeProduct')}">
    visitEntitiesOptions["changeProduct"] = '<option value="changeProduct">换货</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/repairProduct')}">
    visitEntitiesOptions["repairProduct"] = '<option value="repairProduct">修补货品</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/pay')}">
    visitEntitiesOptions["pay"] = '<option value="pay">支付</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/refund')}">
    visitEntitiesOptions["refund"] = '<option value="refund">退款</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/account')}">
    visitEntitiesOptions["account"] = '<option value="account">银行账户</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/customer')}">
    visitEntitiesOptions["customer"] = '<option value="customer">客户</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/customerManagement/unlimitedComplexQuery/user')}">
    visitEntitiesOptions["customerUser"] = '<option value="customerUser">用户</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/sys/save/user')}">
    visitEntitiesOptions["user"] = '<option value="user">后台用户</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/privilegeResource')}">
    visitEntitiesOptions["privilegeResource"] = '<option value="privilegeResource">权限</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/auditFlow')}">
    visitEntitiesOptions["auditFlow"] = '<option value="auditFlow">流程</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/post')}">
    visitEntitiesOptions["post"] = '<option value="post">岗位</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/dept')}">
    visitEntitiesOptions["dept"] = '<option value="dept">部门</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/company')}">
    visitEntitiesOptions["company"] = '<option value="company">公司</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/article')}">
    visitEntitiesOptions["article"] = '<option value="article">文章</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/articleCate')}">
    visitEntitiesOptions["articleCate"] = '<option value="articleCate">文章分类</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/articleTag')}">
    visitEntitiesOptions["articleTag"] = '<option value="articleTag">文章标签</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/voucher')}">
    visitEntitiesOptions["voucher"] = '<option value="voucher">凭证</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/voucherCategory')}">
    visitEntitiesOptions["voucherCategory"] = '<option value="voucherCategory">凭证类别</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/subject')}">
    visitEntitiesOptions["subject"] = '<option value="subject">科目</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/grossProfit')}">
    visitEntitiesOptions["grossProfit"] = '<option value="grossProfit">销售毛利分析表</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/supplierContact')}">
    visitEntitiesOptions["supplierContact"] = '<option value="supplierContact">供应商往来对账表</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/customerContact')}">
    visitEntitiesOptions["customerContact"] = '<option value="customerContact">客户往来对账表</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/inOutDetail')}">
    visitEntitiesOptions["inOutDetail"] = '<option value="inOutDetail">进销存明细账</option>';
    </c:if>
    <c:if test="${fn:contains(resources, '/capitalFlowMeter')}">
    visitEntitiesOptions["capitalFlowMeter"] = '<option value="capitalFlowMeter">资金流水表</option>';
    </c:if>
    </c:if>
    visitEntitiesOptions["audit"] = '<option value="audit">事宜</option>';

    $("#entity").change(function(){dataList.setQuery("<%=request.getContextPath()%>", "<%=FileServerInfo.imageServerUrl%>", $("#entity").val(), visitEntitiesOptions);});
    $("#send").click(function(){
        dataListQueryEntity = $("#entity").val();
        var formJson = $("#form").serializeJSON();
        delete formJson["entity"];
        dataListQueryJson = JSON.stringify(formJson);
        dataList.query($("#dataList"),"<%=request.getContextPath()%>", "<%=FileServerInfo.imageServerUrl%>", dataListQueryJson, dataListQueryEntity);
    });

   <c:if test="${entity != null}">
    if (!returnPage) {
        dataListQueryEntity = "${entity}";
        dataListQueryJson = '${json}';
    } else {
        returnPage = false;
    }
    </c:if>

    dataList.setQuery("<%=request.getContextPath()%>", "<%=FileServerInfo.imageServerUrl%>", dataListQueryEntity, visitEntitiesOptions);
    setSelect(document.getElementById("entity"), dataListQueryEntity);
    dataList.query($("#dataList"), "<%=request.getContextPath()%>", "<%=FileServerInfo.imageServerUrl%>", dataListQueryJson, dataListQueryEntity);

    <c:set var="saveEntity" value="/save/${entity}" />
    <c:if test="${!fn:contains(resources, saveEntity)}">
    $("#add").hide();
    </c:if>
</script>
