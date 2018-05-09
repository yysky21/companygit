<%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: createVoucher.jsp
*
* @author yuanyun
* @Date  2018/1/23
* @version 1.00
*
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--jquery ui--%>
<link type="text/css" href="../../../res/css/jquery-ui-1.10.0.custom.css" rel="stylesheet">
<style type="text/css">

    /*关键设置 tbody出现滚动条*/
    table tbody {
        display: block;
        height: 520px;
        overflow: scroll;
    }

    table thead ,
    tbody tr {
        display: table;
        width: 100%;
        table-layout: fixed;
    }

    /*关键设置：滚动条默认宽度是17px 将thead的宽度减17px*/
    table thead {
        width: calc( 100% - 17px);
        background: rgba(52,73,94,.94);
        color: #ECF0F1;
    }

    .table tbody tr td {
        padding: 4px;
        vertical-align: middle;
        border-top: 0px;
    }

    table thead tr th,table thead tr th input {
        text-align: center;
        vertical-align: middle;
    }

    #payTypeChooseDiv table tbody tr td:first-child {
        width:60px;
        padding-left: 23px;
    }
    #payTypeChooseDiv table tbody tr td:nth-child(2) {
        width: 50px;
        text-align: center
    }

</style>
<!-- page content -->
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3>生成凭证</h3>
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
                        <h2>财务 <small>生成凭证</small></h2>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">

                        <form class="form-horizontal form-label-left" novalidate id="form">
                            <span class="section">查询条件选择</span>

                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="docType[name]">单据类型 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12 ">
                                    <div class="input-prepend input-group" >
                                        <input type="text" id="docType[name]" name="docType[name]" value="" class="form-control col-md-7 col-xs-12" required readonly/>
                                        <span id="docType" class="add-on input-group-addon"><i class="glyphicon glyphicon-zoom-in"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="voucherItemSource[date]" id="timeLabel">单据日期 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <div class="input-prepend input-group" >
                                        <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                                        <input type="text" id="voucherItemSource[date]" name="voucherItemSource[date]" class="form-control " value="" required />
                                        <span id="caret" class="add-on input-group-addon"><i class="glyphicon glyphicon-triangle-bottom"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="voucherItemSource[docNo]">单据编号 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" id="voucherItemSource[docNo]" name="voucherItemSource[docNo]" value="" class="form-control col-md-7 col-xs-12" style="width:40%" placeholder="输入单据编号" />
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="chartMaker[name]">制单人 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <div class="input-prepend input-group" >
                                        <input type="text" id="chartMaker[name]" name="chartMaker[name]" value="" class="form-control col-md-7 col-xs-12" readonly />
                                        <span id="chartMaker" class="add-on input-group-addon"><i class="glyphicon glyphicon-zoom-in"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="warehouse[name]">仓库 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <div class="input-prepend input-group" >
                                        <input type="text" id="warehouse[name]" name="warehouse[name]" value="" class="form-control col-md-7 col-xs-12" readonly />
                                        <span id="warehouse" class="add-on input-group-addon"><i class="glyphicon glyphicon-zoom-in"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="productType">商品分类 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <div class="input-prepend input-group" >
                                        <input type="hidden" name="voucherItemSourceDetail[][entity]" value="productType" class="form-control col-md-7 col-xs-12" />
                                        <input type="hidden" id="productType1" name="voucherItemSourceDetail[][entityId]" value="" class="form-control col-md-7 col-xs-12" />
                                        <input type="text" id="productType" name="productType" value="" class="form-control col-md-7 col-xs-12" readonly />
                                        <span id="productType2" class="add-on input-group-addon"><i class="glyphicon glyphicon-zoom-in"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="payType">支付方式 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <div class="input-prepend input-group" >
                                        <input type="hidden" name="voucherItemSourceDetail[][entity]" value="payType" class="form-control col-md-7 col-xs-12" />
                                        <input type="hidden" id="payType1" name="voucherItemSourceDetail[][entityId]" value="" class="form-control col-md-7 col-xs-12" />
                                        <input type="text" id="payType" name="payType" value="" class="form-control col-md-7 col-xs-12" readonly />
                                        <span id="payType2"  class="add-on input-group-addon"><i class="glyphicon glyphicon-zoom-in"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="account">账号 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <div class="input-prepend input-group" >
                                        <input type="hidden" name="voucherItemSourceDetail[][entity]" value="account" class="form-control col-md-7 col-xs-12" />
                                        <input type="hidden" id="account1" name="voucherItemSourceDetail[][entityId]" value="" class="form-control col-md-7 col-xs-12" />
                                        <input type="text" id="account" name="account" value="" class="form-control col-md-7 col-xs-12" readonly />
                                        <span id="account2"  class="add-on input-group-addon"><i class="glyphicon glyphicon-zoom-in"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="item form-group">
                                <div class="col-md-6 col-md-offset-3">
                                    <button id="send" type="button" class="btn btn-success">查询</button>
                                </div>
                            </div>
                            <input type="hidden" name="voucherItemSource[state]" value="1">
                            <div class="ln_solid"></div>
                        </form>
                        <div id="docTypeChooseDiv">
                            <br>
                            <table class="table table-bordered table-striped " width="100%" style="margin: 0px">
                                <thead>
                                <tr>
                                <th style="width:60px;"><input type="checkbox" > 全选</th>
                                <th width="50px">序号</th>
                                <th>单据类型名称</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            <div style="text-align: right;padding-right: 10px;background-color: lightblue">
                                <div style="padding: 4px">共 <span class="recordsSum" style="font-weight: bold"></span> 条记录,已加载 <span class="loadSum" style="font-weight: bold"></span> 条记录</div>
                            </div>
                        </div>
                        <div id="chartMakerChooseDiv">
                            <br>
                            <table class="table table-bordered table-striped" width="100%" style="margin: 0px">
                                <thead>
                                <tr>
                                <th style="width:60px;"><input type="checkbox"> 全选</th>
                                <th width="50px">序号</th>
                                <th>制单人名称</th>
                                <th>岗位</th>
                                <th>所属部门</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            <div style="text-align: right;padding-right: 10px;background-color: lightblue">
                                <div style="padding: 4px">共 <span class="recordsSum" style="font-weight: bold"></span> 条记录,已加载 <span class="loadSum" style="font-weight: bold"></span> 条记录</div>
                            </div>
                        </div>
                        <div id="warehouseChooseDiv">
                            <br>
                            <table class="table table-bordered table-striped" width="100%" style="margin: 0px">
                                <thead>
                                <tr>
                                <th style="width:60px;"><input type="checkbox" > 全选</th>
                                <th width="50px">序号</th>
                                <th>仓库编号</th>
                                <th>仓库名称</th>
                                <th>仓库地址</th>
                                <th>所属公司</th>
                                <th>库管人</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            <div style="text-align: right;padding-right: 10px;background-color: lightblue">
                                <div style="padding: 4px">共 <span class="recordsSum" style="font-weight: bold"></span> 条记录,已加载 <span class="loadSum" style="font-weight: bold"></span> 条记录</div>
                            </div>
                        </div>
                        <div id="productTypeChooseDiv">
                            <br>
                            <table class="table table-bordered table-striped" width="100%" style="margin: 0px">
                                <thead>
                                <tr>
                                    <th style="width:60px;"><input type="checkbox" > 全选</th>
                                    <th width="50px">序号</th>
                                    <th>商品分类名称</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            <div style="text-align: right;padding-right: 10px;background-color: lightblue">
                                <div style="padding: 4px">共 <span class="recordsSum" style="font-weight: bold"></span> 条记录,已加载 <span class="loadSum" style="font-weight: bold"></span> 条记录</div>
                            </div>
                        </div>
                        <div id="payTypeChooseDiv">
                            <br>
                            <table class="table table-bordered table-striped" width="100%" style="margin: 0px">
                                <thead>
                                <tr>
                                    <th style="width:60px;"><input type="checkbox" > 全选</th>
                                    <th width="50px">序号</th>
                                    <th>支付方式名称</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        <div id="accountChooseDiv">
                            <br>
                            <table class="table table-bordered table-striped" width="100%" style="margin: 0px">
                                <thead>
                                <tr>
                                    <th style="width:60px;"><input type="checkbox" > 全选</th>
                                    <th width="50px">序号</th>
                                    <th>账号名称</th>
                                    <th>账号</th>
                                    <th>开户人</th>
                                    <th>开户行</th>
                                    <th>账号金额</th>
                                    <th>开户日期</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            <div style="text-align: right;padding-right: 10px;background-color: lightblue">
                                <div style="padding: 4px">共 <span class="recordsSum" style="font-weight: bold"></span> 条记录,已加载 <span class="loadSum" style="font-weight: bold"></span> 条记录</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /page content -->

<script type="text/javascript">

    $(document.getElementById("voucherItemSource[date]")).daterangepicker({
        startDate: moment().startOf('month'),
        endDate: moment().endOf('month'),
        ranges : {
            '今天': [moment(), moment()],
            '昨天': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            '本周': [moment().startOf('week'), moment().endOf('week')],
            '上周': [moment().subtract(1,'weeks').startOf('week'), moment().subtract(1,'weeks').endOf('week')],
            '最近7日': [moment().subtract(6, 'days'), moment()],
            '最近30日': [moment().subtract(29, 'days'), moment()],
            '本月': [moment().startOf('month'), moment().endOf('month')],
            '上月': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
            '本季度': [moment().startOf('quarter'), moment().endOf('quarter')],
            '本年': [moment().startOf('year'), moment().endOf('year')]
        },
        opens : 'left',
        locale:{
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

    $("#caret").click(function () {
        $(document.getElementById("voucherItemSource[date]")).focus();
    });

    $(".ui-dialog").remove();
    finance.init();

    $("#send").click(function () {
        if (!validator.checkAll($("#form"))) {
            return;
        }

        var json = "{}";
        var skipString = "payType,productType,account";

        if($(document.getElementById("chartMaker[name]")).val() == ""){
            skipString += ",chartMaker[name]";
        }
        if ($(document.getElementById("warehouse[name]")).val() == ""){
            skipString += ",warehouse[name]";
        }
        if ($("#productType").val()=="" && $("#payType").val()=="" && $("#account").val()==""){
            $(document.getElementsByName("voucherItemSourceDetail[][entity]")).val("");
            skipString += ",voucherItemSourceDetail[][entity],voucherItemSourceDetail[][entityId]";
        }
        $("#payType").val("");
        $("#productType").val("");
        $("#account").val("");
        var formJson = $("#form").serializeJSON({skipFalsyValuesForFields: skipString.split(",")});
        json = JSON.stringify(formJson);
        renderQuery("/finance/specialQuery/voucherItemSource",json);
    })

</script>