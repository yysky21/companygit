<%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: user.jsp
*
* @author 袁云
* @Date  2018/2/1
* @version 1.00
*
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--jquery ui--%>
<link type="text/css" href="../../../res/css/jquery-ui-1.10.0.custom.css" rel="stylesheet">
<style type="text/css">

    /*关键设置 tbody出现滚动条*/
    table tbody {
        display: block;
        height: 500px;
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
        width: calc( 100% - 17px)
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
                        <h2>财务 <small>生成凭证</small></h2>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <span class="section">查询结果</span>
                        <form class="form-horizontal form-inline" role="form" id="form" >
                            <div>
                                <table id="queryResult" class="table table-bordered table-striped " width="100%" style="margin: 0px">
                                    <thead style="background: rgba(52,73,94,.94);color: #ECF0F1;">
                                    <tr>
                                    <th style="width:60px;"><input type="checkbox" > 全选</th>
                                    <th width="50px">序号</th>
                                    <th>单据类型</th>
                                    <th>业务类型</th>
                                    <th>单据日期</th>
                                    <th width="260px">单据编号</th>
                                    <th>制单人</th>
                                    <th>金额</th>
                                    <th>加工费/修补费</th>
                                    <th>仓库</th>
                                    <th>往来单位名称</th>
                                    <th width="250px">备注</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="entity" items="${entities}" varStatus="varStatus">
                                    <tr>
                                        <td style="width:60px;padding-left: 23px;"><input type="checkbox" ></td>
                                        <td width="50px" style="text-align: center">${varStatus.count}</td>
                                        <td>${entity.docType.name}</td>
                                        <td>${entity.businessType}</td>
                                        <td><fm:formatDate value="${entity.date}" pattern="yyyy-MM-dd" /></td>
                                        <td width="260px">${entity.docNo}</td>
                                        <td>${entity.chartMaker.name}</td>
                                        <td>${entity.amount}</td>
                                        <td>${entity.extend}</td>
                                        <td>${entity.warehouse.name}</td>
                                        <td>${entity.contactUnit}</td>
                                        <td width="250px">${entity.remark}</td>
                                        <input name="voucherItemSource[][id]:number" type="hidden" value="${entity.id}"/>
                                    </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <div style="text-align: right;padding-right: 10px;background-color: lightblue">
                                    <div style="padding: 4px">共 <span class="recordsSum" style="font-weight: bold">${recordsSum}</span> 条记录</div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="x_content">
                        <div class="form-horizontal form-label-left">
                            <div class="ln_solid"></div>
                            <div class="form-group" id="submitDiv">
                                <div class="col-md-6 col-md-offset-10">
                                    <button id="cancel" type="button" class="btn btn-primary">返回</button>
                                    <button id="send" type="button" class="btn btn-success">生成凭证</button>
                                </div>
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
    $("#cancel").unbind("click").click(function(){
        render(getPreUrls());
        returnPage = true;
    });

    $('table').tableCheckbox({ /* options */ });

    if (${recordsSum == 0}){
        $("#queryResult tbody").append('<div class="alert alert-info alert-dismissable" style="font-size: 30px; width: 800px; margin: 200px 380px"> <button type="button" class="close" ' +
            'data-dismiss="alert" aria-hidden="true"> &times; </button>sorry，数据不存在！ </div>')
        $("#send").hide();
    }

    $("#send").click(function () {
        var trs = $("table tbody tr[class='warning']");
        var inputs = $(trs).find(":input");
        var formJson = inputs.serializeJSON().voucherItemSource;
        var json = JSON.stringify(formJson);
        renderQuery("/finance/create/voucher",json);
    })

</script>