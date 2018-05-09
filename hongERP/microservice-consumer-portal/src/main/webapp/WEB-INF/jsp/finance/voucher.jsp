<%@ page import="com.hzg.tools.FinanceConstant" %><%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: voucher.jsp
*
* @author yuanyun
* @Date  2017/11/25
* @version 1.00
*
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--jquery ui--%>
<link type="text/css" href="../../../res/css/jquery-ui-1.10.0.custom.css" rel="stylesheet">
<!-- page content -->
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3><c:choose><c:when test="${entity != null}">查看</c:when><c:otherwise>填制</c:otherwise></c:choose>凭证</h3>
            </div>
            <div class="title_right hidden">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                    <div class="input-group">
                        <input type="text" class="form-control" placehold="Search for...">
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
                        <h2>财务 <small>凭证</small></h2>
                        <div class="clearfix"></div>
                    </div>
                    <span class="section">凭证信息</span>
                    <div class="x_content" id="voucher">
                        <h2 class="text-center header"><strong>记账凭证</strong></h2>
                        <form class="form-horizontal form-inline" role="form" id="form" >
                            <div class="row" id="head" style="margin-bottom: -5px">
                                <div class="item form-group">
                                    <label class="control-label col-md-7 col-sm-7 col-xs-7"  for="voucherCategory"><span class="required">*</span>凭证类别：
                                    </label>
                                    <div class="col-md-5 col-sm-5 col-xs-5">
                                        <input id="voucherCategory" name="voucherCategory" value="<c:choose><c:when test="${entity != null}">${entity.voucherCategory.name}</c:when><c:otherwise>记账凭证</c:otherwise></c:choose>" class="form-control col-md-7 col-xs-12" required >
                                        <input type="hidden" id="voucherCategory[id]" name="voucherCategory[id]" value="<c:choose><c:when test="${entity != null}">${entity.voucherCategory.id}</c:when><c:otherwise>1</c:otherwise></c:choose>">
                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="control-label col-md-7 col-sm-7 col-xs-7"  for="no"><span class="required">*</span>凭证编号：
                                    </label>
                                    <div class="col-md-5 col-sm-5 col-xs-5">
                                        <input id="no" name="no" value="<c:if test="${entity != null}">${entity.no}</c:if>${no}" class="form-control col-md-7 col-xs-12" data-validate-length-range="4，10" data-validate-words="1" required>
                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="control-label col-md-6 col-sm-6 col-xs-6"  for="makeDate"><span class="required">*</span>制单日期：
                                    </label>
                                    <div class="col-md-6 col-sm-6 col-xs-6">
                                        <div class="input-prepend input-group" style="margin-bottom:0">
                                            <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                                            <input type="text" name="makeDate" id="makeDate" class="form-control col-md-7 col-xs-12" value="<fm:formatDate value="${entity.makeDate}" pattern="yyyy-MM-dd"/>" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="control-label col-md-7 col-sm-7 col-xs-7"  for="attachDocumentNum">附单据数：
                                    </label>
                                    <div class="col-md-5 col-sm-5 col-xs-5">
                                        <input id="attachDocumentNum" name="attachDocumentNum" data-skip-falsy="true" value="${entity.attachDocumentNum}"  class="form-control col-md-7 col-xs-12">
                                    </div>
                                </div>
                            </div>
                            <div class="x_content" style="overflow: auto;margin-top: 15px">
                                <table id="voucherList" class="table table-striped table-bordered jambo_table bulk_action" style="margin-bottom: 0px;">
                                    <thead>
                                    <tr><th>摘要</th><th>科目名称</th><th>辅助项</th><th>借方</th><th>贷方</th></tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${entity == null}">
                                        <tr>
                                            <td><input type="text" name='details[][voucherItem[summary]]:string' required /></td>
                                            <td><input type="text" class="text1" name='details[][voucherItem[subject[name]]]:string' required />
                                                <input type="hidden" name='details[][voucherItem[subject[id]]]:number' />
                                            </td>
                                            <td><input type="text" class="text2" name='details[][voucherItem[assistant]]:string' /></td>
                                            <td><input type="text" name='details[][voucherItem[debit]]:number' data-debit="debit"/></td>
                                            <td><input type="text" name='details[][voucherItem[credit]]:number' data-credit="credit" /></td>
                                        </tr>
                                    </c:if>
                                    <c:if test="${entity != null &&entity.details != null}">
                                        <c:forEach items="${entity.details}" var="detail">
                                                <tr>
                                                    <td><input type="text" name='details[][voucherItem[summary]]:string' value='${detail.voucherItem.summary}' required /></td>
                                                    <td>
                                                        <input type="text" class="text1" name='details[][voucherItem[subject[name]]]:string' value='${detail.voucherItem.subject.name}' required />
                                                        <input type="hidden" name='details[][voucherItem[subject[id]]]:number'value="${detail.voucherItem.subject.id}" />
                                                    </td>
                                                    <td><input type="text" class="text2" name='details[][voucherItem[assistant]]:string' value='${detail.voucherItem.assistant}' readonly /></td>
                                                    <td><input type="text" name='details[][voucherItem[debit]]:number' data-debit="debit" value='${detail.voucherItem.debit}' /></td>
                                                    <td><input type="text" name='details[][voucherItem[credit]]:number' data-credit="credit" value='${detail.voucherItem.credit}' /></td>
                                                </tr>
                                        </c:forEach>
                                    </c:if>
                                    </tbody>
                                </table>
                            </div>
                            <div class="x_content" style="overflow: auto; margin-top: 2px">
                                <table id="voucherTotal" class="table table-striped table-bordered  bulk_action" style="margin-bottom: 5px;">
                                    <tbody>
                                        <tr>
                                            <td><input type="text"  value='合计' readonly  /></td>
                                            <td><input type="text"  value='<c:if test="${entity != null}">大写合计</c:if>' readonly  /></td>
                                            <td><input type="text" name='totalCapital' data-skip-falsy="true" data-validate-length-range="2，30" data-validate-words="1" value='${entity.totalCapital}' <c:if test="${entity == null}">readonly</c:if> /></td>
                                            <td><input type="text"id="debit" name='debit:number' value='${entity.debit}' required /></td>
                                            <td><input type="text" id="credit" name='credit:number' value='${entity.credit}' required /></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="x_content" style="margin-top: 5px;">
                                <div class="row" id="foot">
                                    <div class="item form-group">
                                        <label class="control-label col-md-6 col-sm-6 col-xs-6"  for="bookkeeper">记账人：
                                        </label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input id="bookkeeper" value="${entity.bookkeeper.name}" class="form-control col-md-7 col-xs-12" >
                                            <input type="hidden" id="bookkeeper[id]" name="bookkeeper[id]" data-skip-falsy="true" value="${entity.bookkeeper.id}" >
                                        </div>
                                    </div>
                                    <div class="item form-group">
                                        <label class="control-label col-md-6 col-sm-6 col-xs-6"  for="auditor">审核人：
                                        </label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input id="auditor" value="${entity.auditor.name}" class="form-control col-md-7 col-xs-12" >
                                            <input type="hidden" id="auditor[id]" name="auditor[id]" data-skip-falsy="true" value="${entity.auditor.id}" >
                                        </div>
                                    </div>
                                    <div class="item form-group">
                                        <label class="control-label col-md-6 col-sm-6 col-xs-6"  for="cashier">出纳：
                                        </label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input id="cashier" value="${entity.cashier.name}" class="form-control col-md-7 col-xs-12" >
                                            <input type="hidden" id="cashier[id]" name="cashier[id]" data-skip-falsy="true" value="${entity.cashier.id}" >
                                        </div>
                                    </div>
                                    <div class="item form-group">
                                        <label class="control-label col-md-6 col-sm-6 col-xs-6"  for="chartMaker"><span class="required">*</span>制单人：
                                        </label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input id="chartMaker" value="<c:choose><c:when test="${entity != null}">${entity.chartMaker.name}</c:when><c:otherwise>${userName}</c:otherwise></c:choose>" class="form-control col-md-7 col-xs-12" readonly required>
                                            <input type="hidden" id="chartMaker[id]" name="chartMaker[id]" data-skip-falsy="true" value="<c:choose><c:when test="${entity != null}">${entity.chartMaker.id}</c:when><c:otherwise>${userId}</c:otherwise></c:choose>" >
                                        </div>
                                    </div>
                                    <div class="item form-group">
                                        <label class="control-label col-md-6 col-sm-6 col-xs-6"  for="attachDocumentNum"><span class="required">*</span>打印次数：
                                        </label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input id="printTimes" name="printTimes:number" value="<c:choose><c:when test="${entity != null}">${entity.printTimes}</c:when><c:otherwise>0</c:otherwise></c:choose>" style="width: 100px" class="form-control col-md-7 col-xs-12" <c:if test="${entity != null}">readonly</c:if> required>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" id="state" name="state:number" value="<c:choose><c:when test="${entity != null}">${entity.state}</c:when><c:otherwise>0</c:otherwise></c:choose>">
                            <c:if test="${entity != null}"><input type="hidden" id="id" name="id" value="${entity.id}"></c:if>
                        </form>
                    </div>
                    <div class="x_content">
                        <div class="form-horizontal form-label-left">
                            <div class="ln_solid"></div>
                            <div class="form-group" id="submitDiv">
                                <div class="col-md-6 col-md-offset-9">
                                    <button id="cancel" type="button" class="btn btn-primary">取消</button>
                                    <c:choose>
                                        <c:when test="${entity != null}">
                                            <c:if test="${entity.state != 1}">
                                                <button id="edit" type="button" class="btn btn-primary">编辑</button>
                                                <button id="send" type="button" class="btn btn-success">修改</button>
                                                <button id="delete" type="button" class="btn btn-danger">删除</button>
                                            </c:if>
                                            <button class="btn btn-default" id="printVoucherBtn"><i class="fa fa-print"></i> 打印凭证</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button id="send" type="button" class="btn btn-success">保存</button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<form id="actionForm" style="display: none">
    <input type="hidden" id="printContent" name="printContent">
</form>
<form id="printForm" method="post" style="display: none" target="_blank">
    <input type="hidden" id="jsonn" name="json">
</form>

<script type="text/javascript">

    init(<c:out value="${entity == null}"/>);

    $("#cancel").unbind("click").click(function(){
        render(getPreUrls());
        returnPage = true;
    });

    $('#makeDate').daterangepicker({
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

    $("#voucherCategory").coolautosuggest({
        url:"<%=request.getContextPath()%>/finance/suggest/voucherCategory/name/",
        showProperty: 'name',
        onSelected:function(result){
            if(result!=null){
                $(document.getElementById("voucherCategory[id]")).val(result.id);
            }
        }
    });

    $(".text1").coolautosuggest({
        url:"<%=request.getContextPath()%>/finance/suggest/subject/name/",
        showProperty: 'name',
        onSelected:function(result){
            if(result!=null){
                $(document.getElementsByName("details[][voucherItem[subject[id]]]:number").item(0)).val(result.id);
                var a = result.accountItems;
                for(var i in a){
                    if(a[i]==3){
                        $(".text2").coolautosuggest({
                            url:"<%=request.getContextPath()%>/finance/suggest/supplier/name/",
                            showProperty: 'name'
                        });
                    }else if (a[i]==4){
                        $(".text2").coolautosuggest({
                            url:"<%=request.getContextPath()%>/finance/suggest/customer/name/",
                            showProperty: 'name'
                        });
                    }
                }
            }
        }
    });



    $("#bookkeeper").coolautosuggest({
        url:"<%=request.getContextPath()%>/finance/suggest/user/name/",
        showProperty: 'name',
        onSelected:function(result){
            if(result!=null){
                $(document.getElementById("bookkeeper[id]")).val(result.id);
            }
        }
    });

    $("#auditor").coolautosuggest({
        url:"<%=request.getContextPath()%>/finance/suggest/user/name/",
        showProperty: 'name',
        onSelected:function(result){
            if(result!=null){
                $(document.getElementById("auditor[id]")).val(result.id);
            }
        }
    });
    $("#cashier").coolautosuggest({
        url:"<%=request.getContextPath()%>/finance/suggest/user/name/",
        showProperty: 'name',
        onSelected:function(result){
            if(result!=null){
                $(document.getElementById("cashier[id]")).val(result.id);
            }
        }
    });
    $("#chartMaker").coolautosuggest({
        url:"<%=request.getContextPath()%>/finance/suggest/user/name/",
        showProperty: 'name',
        onSelected:function(result){
            if(result!=null){
                $(document.getElementById("chartMaker[id]")).val(result.id);
            }
        }
    });

    $("#voucherCategory").coolautosuggest({
        url:"<%=request.getContextPath()%>/finance/suggest/voucherCategory/name/",
        showProperty: 'name',
        onSelected:function(result){
            if(result!=null){
                $(document.getElementById("voucherCategory[id]")).val(result.id);
            }
        }
    });

    $("#voucherList tbody").on("mousedown","tr",function (e) {
        $.smartMenu.remove();//重新加载smartMenu，这很重要，不然会使用html的缓存
        if (e.which == 3) {
            var opertionn = {
                name: "",
                offsetX: 2,
                offsetY: 2,
                textLimit: 10,
                beforeShow: $.noop,
                afterShow: $.noop
            };
            var imageMenuData = [
                [{
                    text: "增行",
                    func: function(){
                        var tr = "<tr>"+
                            "<td><input name='details[][voucherItem[summary]]:string' required /></td>"+
                            "<td><input class='text1' name='details[][voucherItem[subject[name]]]:string' required />"+
                            "<input type='hidden' name='details[][voucherItem[subject[id]]]:number' />"+
                            "</td>"+
                            "<td><input class='text2' name='details[][voucherItem[assistant]]:string' /></td>"+
                            "<td><input name='details[][voucherItem[debit]]:number' data-debit='debit' /></td>"+
                            "<td><input name='details[][voucherItem[credit]]:number' data-credit='credit' /></td>"+
                            "</tr>"
                        $(this).after(tr);
                        $('[data-debit="debit"]').blur(function () {
                            var inputs = $('[data-debit="debit"]');
                            for (var i = 0; i<inputs.length;i++){
                                if (inputs[i].value != ""){
                                    var reg = /^\d+(\.\d+)?$/;
                                    if (reg.test(inputs[i].value) == false){
                                        alert("借方必须为纯数字，包括小数");
                                        $("#debit").val(debitTotal);
                                        debitTotal = 0;
                                        return false;
                                    }
                                    debitTotal += parseInt(inputs[i].value);
                                }
                            }
                            $("#debit").val(debitTotal);
                            debitTotal = 0;
                        })
                        $('[data-credit="credit"]').blur(function () {
                            var inputs = $('[data-credit="credit"]');
                            for (var i = 0; i<inputs.length;i++){
                                if (inputs[i].value != ""){
                                    var reg = /^\d+(\.\d+)?$/;
                                    if (reg.test(inputs[i].value) == false){
                                        alert("贷方必须为纯数字，包括小数");
                                        $("#credit").val(creditTotal);
                                        creditTotal = 0;
                                        return false;
                                    }
                                    creditTotal += parseInt(inputs[i].value);
                                }
                            }
                            $("#credit").val(creditTotal);
                            creditTotal = 0;
                        })
                        var subjectInput = $("[class='text1']");
                        $(this).next().find(subjectInput).coolautosuggest({
                            url:"<%=request.getContextPath()%>/finance/suggest/subject/name/",
                            showProperty: 'name',
                            onSelected:function(result){
                                if(result!=null){
                                    $(this).next().next().val(result.id);
                                    var a = result.accountItems;
                                    for(var i in a){
                                        if(a[i]==3){
                                            $(this).parent().next().find("input").coolautosuggest({
                                                url:"<%=request.getContextPath()%>/finance/suggest/supplier/name/",
                                                showProperty: 'name'
                                            });
                                        }else if (a[i]==4){
                                            $(this).parent().next().find("input").coolautosuggest({
                                                url:"<%=request.getContextPath()%>/finance/suggest/customer/name/",
                                                showProperty: 'name'
                                            });
                                        }
                                    }
                                }
                            }
                        });
                    }
                }, {
                    text: "删行",
                    func: function(){
                        $(this).remove();
                    }
                }]
            ];
            $(this).smartMenu(imageMenuData,opertionn);
        }
    });

    $("#voucherList tbody").on("keypress","tr",function (e) {
        if (e.keyCode == 13) {
            var tr = "<tr>"+
                "<td><input name='details[][voucherItem[summary]]:string' required /></td>"+
                "<td><input class='text1' name='details[][voucherItem[subject[name]]]:string' required />"+
                "<input type='hidden' name='details[][voucherItem[subject[id]]]:number' />"+
                "</td>"+
                "<td><input class='text2' name='details[][voucherItem[assistant]]:string' /></td>"+
                "<td><input name='details[][voucherItem[debit]]:number' data-debit='debit' /></td>"+
                "<td><input name='details[][voucherItem[credit]]:number' data-credit='credit' /></td>"+
                "</tr>"
            $(this).after(tr);
            var subjectInput = $("[class='text1']");
            $(this).next().find(subjectInput).coolautosuggest({
                url:"<%=request.getContextPath()%>/finance/suggest/subject/name/",
                showProperty: 'name',
                onSelected:function(result){
                    if(result!=null){
                        $(this).next().next().val(result.id);
                        var a = result.accountItems;
                        for(var i in a){
                            if(a[i]==3){
                                $(this).parent().next().find("input").coolautosuggest({
                                    url:"<%=request.getContextPath()%>/finance/suggest/supplier/name/",
                                    showProperty: 'name'
                                });
                            }else if (a[i]==4){
                                $(this).parent().next().find("input").coolautosuggest({
                                    url:"<%=request.getContextPath()%>/finance/suggest/customer/name/",
                                    showProperty: 'name'
                                });
                            }
                        }
                    }
                }
            });
            $('[data-debit="debit"]').blur(function () {
                var inputs = $('[data-debit="debit"]');
                for (var i = 0; i<inputs.length;i++){
                    if (inputs[i].value != ""){
                        var reg = /^\d+(\.\d+)?$/;
                        if (reg.test(inputs[i].value) == false){
                            alert("借方必须为纯数字，包括小数");
                            $("#debit").val(debitTotal);
                            debitTotal = 0;
                            return false;
                        }
                        debitTotal += parseInt(inputs[i].value);
                    }
                }
                $("#debit").val(debitTotal);
                debitTotal = 0;
            })
            $('[data-credit="credit"]').blur(function () {
                var inputs = $('[data-credit="credit"]');
                for (var i = 0; i<inputs.length;i++){
                    if (inputs[i].value != ""){
                        var reg = /^\d+(\.\d+)?$/;
                        if (reg.test(inputs[i].value) == false){
                            alert("贷方必须为纯数字，包括小数");
                            $("#credit").val(creditTotal);
                            creditTotal = 0;
                            return false;
                        }
                        creditTotal += parseInt(inputs[i].value);
                    }
                }
                $("#credit").val(creditTotal);
                creditTotal = 0;
            })
        }
    });

    var debitTotal = 0;
    $('[data-debit="debit"]').blur(function () {
        var inputs = $('[data-debit="debit"]');
        for (var i = 0; i<inputs.length;i++){
            if (inputs[i].value != ""){
                var reg = /^\d+(\.\d+)?$/;
                if (reg.test(inputs[i].value) == false){
                    alert("借方必须为纯数字，包括小数");
                    $("#debit").val(debitTotal);
                    debitTotal = 0;
                    return false;
                }
                debitTotal += parseInt(inputs[i].value);
            }
        }
        $("#debit").val(debitTotal);
        debitTotal = 0;
    })

    var creditTotal = 0;
    $('[data-credit="credit"]').blur(function () {
        var inputs = $('[data-credit="credit"]');
        for (var i = 0; i<inputs.length;i++){
            if (inputs[i].value != ""){
                var reg = /^\d+(\.\d+)?$/;
                if (reg.test(inputs[i].value) == false){
                    alert("贷方必须为纯数字，包括小数");
                    $("#credit").val(creditTotal);
                    creditTotal = 0;
                    return false;
                }
                creditTotal += parseInt(inputs[i].value);
            }
        }
        $("#credit").val(creditTotal);
        creditTotal = 0;
    })

    $("#send").click(function () {
        /*因为填制凭证时的保存和生成凭证时的保存用的是同一个方法，
        生成凭证时需要在序列化后的voucheers中加上voucherItemSources，
        而填制凭证时并不需要，所以这里需要将voucher置为undefined*/
        vouchers = undefined;
        finance.saveVoucher('<%=request.getContextPath()%>/finance/<c:choose><c:when test="${entity != null}">update</c:when><c:otherwise>save</c:otherwise></c:choose>/voucher');
    });

    $("#delete").click(function(){
        if (confirm("确定删除该凭证吗？")) {
            $("#form").sendData('<%=request.getContextPath()%>/finance/delete/voucher',
                '{"id":${entity.id}}');
        }
    });

    $("#printVoucherBtn").click(function(){
        $("#printContent").val($("#voucher").html()
            .replace(/\r/ig,"").replace(/\n/ig,""));

        $("#jsonn").val(JSON.stringify($("#actionForm").serializeJSON()));
        $("#printForm").attr("action", "<%=request.getContextPath()%>/finance/print/<%=FinanceConstant.voucher_action_name_print_voucher%>").submit();
    });

    <c:choose><c:when test="${entity != null}">document.title = "查看凭证";</c:when><c:otherwise> document.title = "填制凭证";</c:otherwise></c:choose>

</script>