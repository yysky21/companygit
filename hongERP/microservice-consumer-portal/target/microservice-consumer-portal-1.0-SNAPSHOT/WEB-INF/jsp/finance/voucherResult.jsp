<%@ page import="com.hzg.tools.FinanceConstant" %>
<%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: productCheck.jsp
*
* @author yuanyun
* @Date  2017/10/25
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
                <h3>生成凭证</h3>
            </div>
            <div class="title_right">
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
                                        <input id="voucherCategory" name="voucherCategory" value="记账凭证" class="form-control col-md-7 col-xs-12" required >
                                        <input type="hidden" id="voucherCategory[id]" name="voucherCategory[id]" value="1">
                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="control-label col-md-7 col-sm-7 col-xs-7"  for="no"><span class="required">*</span>凭证编号：
                                    </label>
                                    <div class="col-md-5 col-sm-5 col-xs-5">
                                        <input id="no" name="no" value="${entities[0].no}" class="form-control col-md-7 col-xs-12" data-validate-length-range="4，10" data-validate-words="1" required>
                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="control-label col-md-6 col-sm-6 col-xs-6"  for="makeDate"><span class="required">*</span>制单日期：
                                    </label>
                                    <div class="col-md-6 col-sm-6 col-xs-6">
                                        <div class="input-prepend input-group" style="margin-bottom:0">
                                            <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                                            <input type="text" name="makeDate" id="makeDate" class="form-control col-md-7 col-xs-12" value="" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="item form-group">
                                    <label class="control-label col-md-7 col-sm-7 col-xs-7"  for="attachDocumentNum">附单据数：
                                    </label>
                                    <div class="col-md-5 col-sm-5 col-xs-5">
                                        <input id="attachDocumentNum" name="attachDocumentNum" data-skip-falsy="true" value="" class="form-control col-md-7 col-xs-12">
                                    </div>
                                </div>
                            </div>
                            <div class="x_content" style="overflow: auto;margin-top: 15px">
                                <table id="voucherList" class="table table-striped table-bordered jambo_table bulk_action" style="margin-bottom: 0px;">
                                    <thead>
                                    <tr><th>摘要</th><th>科目名称</th><th>辅助项</th><th>借方</th><th>贷方</th></tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${entities[0].details}" var="detail">
                                                <tr>
                                                    <td><input type="text" name='details[][voucherItem[summary]]:string' value='${detail.voucherItem.summary}' /></td>
                                                    <td><input type="text" class="text1" name='details[][voucherItem[subject[name]]]:string' value='${detail.voucherItem.subject.name}' /><input type="hidden" name='details[][voucherItem[subject[id]]]:number' value="${detail.voucherItem.subject.id}" /></td>
                                                    <td><input type="text" name='details[][voucherItem[assistant]]:string' value='${detail.voucherItem.assistant}' /></td>
                                                    <td><input type="text" name='details[][voucherItem[debit]]' value='${detail.voucherItem.debit}' /></td>
                                                    <td><input type="text" name='details[][voucherItem[credit]]' value='${detail.voucherItem.credit}' /></td>
                                                </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="x_content" style="overflow: auto; margin-top: 2px">
                                <table id="voucherTotal" class="table table-striped table-bordered  bulk_action" style="margin-bottom: 5px;">
                                    <tbody>
                                        <tr>
                                            <td><input type="text"  value='合计' readonly  /></td>
                                            <td><input type="text"  value='' readonly  /></td>
                                            <td><input type="text" name='totalCapital' data-skip-falsy="true" data-validate-length-range="2，30" data-validate-words="1" value='' readonly /></td>
                                            <td><input type="text" id="debit" name='debit' value='${entities[0].debit}' /></td>
                                            <td><input type="text" id="credit" name='credit' value='${entities[0].credit}' /></td>
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
                                            <input id="bookkeeper" value="" class="form-control col-md-7 col-xs-12" >
                                            <input type="hidden" id="bookkeeper[id]" name="bookkeeper[id]" data-skip-falsy="true" value="" >
                                        </div>
                                    </div>
                                    <div class="item form-group">
                                        <label class="control-label col-md-6 col-sm-6 col-xs-6"  for="auditor">审核人：
                                        </label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input id="auditor" value="" class="form-control col-md-7 col-xs-12" >
                                            <input type="hidden" id="auditor[id]" name="auditor[id]" data-skip-falsy="true" value="" >
                                        </div>
                                    </div>
                                    <div class="item form-group">
                                        <label class="control-label col-md-6 col-sm-6 col-xs-6"  for="cashier">出纳：
                                        </label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input id="cashier" value="" class="form-control col-md-7 col-xs-12" >
                                            <input type="hidden" id="cashier[id]" name="cashier[id]" data-skip-falsy="true" value="" >
                                        </div>
                                    </div>
                                    <div class="item form-group">
                                        <label class="control-label col-md-6 col-sm-6 col-xs-6"  for="chartMaker"><span class="required">*</span>制单人：
                                        </label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input id="chartMaker" value="${userName}" class="form-control col-md-7 col-xs-12" readonly required>
                                            <input type="hidden" id="chartMaker[id]" name="chartMaker[id]" data-skip-falsy="true" value="${userId}" >
                                        </div>
                                    </div>
                                    <div class="item form-group">
                                        <label class="control-label col-md-6 col-sm-6 col-xs-6"  for="attachDocumentNum"><span class="required">*</span>打印次数：
                                        </label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input id="printTimes" name="printTimes:number" value="0" style="width: 100px" class="form-control col-md-7 col-xs-12" readonly required>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" id="state" name="state:number" value="0">
                        </form>
                    </div>
                    <div class="x_content">
                        <div class="form-horizontal form-label-left">
                            <div class="ln_solid"></div>
                            <div class="form-group" id="submitDiv">
                                <div class="col-md-6 col-md-offset-8">
                                    <button id="cancel" type="button" class="btn btn-primary">取消</button>
                                    <button id="previous" type="button" class="btn btn-primary">上一张</button>
                                    <button id="next" type="button" class="btn btn-primary">下一张</button>
                                    <button id="send" type="button" class="btn btn-success">保存</button>
                                    <button id="sendAll" type="button" class="btn btn-success">批量保存</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

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
                            url:"<%=request.getContextPath()%>/finance/suggest/user/name/",
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
                            "<td><input name='details[][voucherItem[summary]]:string' /></td>"+
                            "<td><input class='text1' name='details[][voucherItem[subject[name]]]:string' />"+
                            "<input type='hidden' name='details[][voucherItem[subject[id]]]:number' />"+
                            "</td>"+
                            "<td><input name='details[][voucherItem[assistant]]:string' /></td>"+
                            "<td><input name='details[][voucherItem[debit]]' /></td>"+
                            "<td><input name='details[][voucherItem[credit]]' /></td>"+
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
                                                url:"<%=request.getContextPath()%>/finance/suggest/user/name/",
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
                "<td><input name='details[][voucherItem[summary]]:string' /></td>"+
                "<td><input class='text1' name='details[][voucherItem[subject[name]]]:string' />"+
                "<input type='hidden' name='details[][voucherItem[subject[id]]]:number' />"+
                "</td>"+
                "<td><input name='details[][voucherItem[assistant]]:string' /></td>"+
                "<td><input name='details[][voucherItem[debit]]' /></td>"+
                "<td><input name='details[][voucherItem[credit]]' /></td>"+
                "</tr>"
            $(this).after(tr);
            var subjectInput = $("[class='text1']");
            $(this).next().find(subjectInput).coolautosuggest({
                url:"<%=request.getContextPath()%>/finance/suggest/subject/name/",
                showProperty: 'name',
                onSelected:function(result){
                    if(result!=null){
                        $(this).next().next().val(result.id);
                    }
                }
            });
        }
    });

    var vouchers = ${json};
    // 用来存储已经保存的凭证的标志
    var disabledSaveNo = {};
    var count = 0;
    if (count == 0){
        $("#previous").attr("disabled",true);
    }
    $("#previous").click(function () {
        $("#send").attr("disabled",false);
        $("#next").attr("disabled",false);
        var json = JSON.stringify($("#form").serializeJSON());
        json = json.substring(0, (json.indexOf("details")-2))+json.substring((json.indexOf("]")+1),json.length-1) + ',"details":[';

        var trs = $("#voucherList tbody tr");

        for (var i = 0; i < trs.length; i++) {
            var inputs = $(trs[i]).find(":input");
            json += JSON.stringify(inputs.not('[value=""]').serializeJSON({skipFalsyValuesForFields: ["details[][voucherItem[assistant]]:string", "details[][voucherItem[debit]]","details[][voucherItem[credit]]"]})["details"][0]) + ",";
        }

        json = json.substring(0, json.length-1) + ']';
        json += ',"voucherItemSources":' + JSON.stringify(vouchers[count].voucherItemSources)+"}";
        var jsonn = JSON.parse(json);
        vouchers[count] = jsonn;
        $("#no").val(vouchers[count-1].no);
        $("#debit").val(vouchers[count-1].debit);
        $("#credit").val(vouchers[count-1].credit);
        $("#voucherList tbody").empty();
        var details = vouchers[count-1].details;
        addItem(details);
        count--;
        if (count == 0){
            $("#previous").attr("disabled",true);
        }
        if (count == disabledSaveNo[count] ){
            $("#send").attr("disabled",true);
        }

    });

    $("#next").click(function () {
        $("#send").attr("disabled",false);
        $("#previous").attr("disabled",false);
        var json = JSON.stringify($("#form").serializeJSON());
        json = json.substring(0, (json.indexOf("details")-2))+json.substring((json.indexOf("]")+1),json.length-1) + ',"details":[';

        var trs = $("#voucherList tbody tr");

        for (var i = 0; i < trs.length; i++) {
            var inputs = $(trs[i]).find(":input");
            json += JSON.stringify(inputs.not('[value=""]').serializeJSON({skipFalsyValuesForFields: ["details[][voucherItem[assistant]]:string", "details[][voucherItem[debit]]","details[][voucherItem[credit]]"]})["details"][0]) + ",";
        }

        json = json.substring(0, json.length-1) + ']';
        json += ',"voucherItemSources":' + JSON.stringify(vouchers[count].voucherItemSources)+"}";
        var jsonn = JSON.parse(json);
        vouchers[count] = jsonn;
        $("#no").val(vouchers[count+1].no);
        $("#debit").val(vouchers[count+1].debit);
        $("#credit").val(vouchers[count+1].credit);
        $("#voucherList tbody").empty();
        var details = vouchers[count+1].details;
        addItem(details);
        count++;
        if (count == vouchers.length-1){
            $("#next").attr("disabled",true);
        }
        if (count == disabledSaveNo[count] ){
            $("#send").attr("disabled",true);
        }

    })

    function addItem(details) {
        for (var i in details){
            var assistant = details[i].voucherItem.assistant;
            var debit = details[i].voucherItem.debit;
            var credit = details[i].voucherItem.credit;
            if (assistant == undefined){
                assistant = "";
            }
            if (debit == undefined){
                debit = "";
            }
            if (credit == undefined){
                credit = "";
            }
            var tr = "<tr>"+
                "<td><input type='text' name='details[][voucherItem[summary]]:string' value='"+details[i].voucherItem.summary+"' /></td>"+
                "<td><input type='text' class='text1' name='details[][voucherItem[subject[name]]]:string' value='"+details[i].voucherItem.subject.name+"' /><input type='hidden' name='details[][voucherItem[subject[id]]]:number' value='"+details[i].voucherItem.subject.id+"' /></td>"+
                "<td><input type='text' name='details[][voucherItem[assistant]]:string' value='"+assistant+"' /></td>"+
                "<td><input type='text' name='details[][voucherItem[debit]]' value='"+debit+"' /></td>"+
                "<td><input type='text' name='details[][voucherItem[credit]]' value='"+credit+"' /></td>"+
                "</tr>";
            $("#voucherList tbody").append(tr);
        }
        var subjectInput = $("[class='text1']");
        $("#voucherList tbody tr").find(subjectInput).coolautosuggest({
            url:"<%=request.getContextPath()%>/finance/suggest/subject/name/",
            showProperty: 'name',
            onSelected:function(result){
                if(result!=null){
                    $(this).next().next().val(result.id);
                }
            }
        });
    }

    $("#send").click(function () {
        finance.saveVoucher('<%=request.getContextPath()%>/finance/save/voucher');
    });

    $("#sendAll").click(function () {
        // 将当前页面中的这条凭证序列化后替换这条凭证在vouchers中对应的凭证开始
        var json = JSON.stringify($("#form").serializeJSON());
        json = json.substring(0, (json.indexOf("details")-2))+json.substring((json.indexOf("]")+1),json.length-1) + ',"details":[';

        var trs = $("#voucherList tbody tr");

        for (var i = 0; i < trs.length; i++) {
            var inputs = $(trs[i]).find(":input");
            json += JSON.stringify(inputs.not('[value=""]').serializeJSON({skipFalsyValuesForFields: ["details[][voucherItem[assistant]]:string", "details[][voucherItem[debit]]","details[][voucherItem[credit]]"]})["details"][0]) + ",";
        }
        // 将当前页面中的这条凭证序列化后替换这条凭证在vouchers中对应的凭证结束
        /*之所以要做上面这一步是因为当点击批量保存时当前这条凭证可能被修改过*/

        json = json.substring(0, json.length-1) + ']';
        json += ',"voucherItemSources":' + JSON.stringify(vouchers[count].voucherItemSources)+"}";
        var jsonn = JSON.parse(json);
        vouchers[count] = jsonn;

        for (var i in vouchers){
            // 如果这条凭证中没有凭证类别则加上凭证类别，类别为记账凭证
            if (vouchers[i].voucherCategory == undefined){
                var str = JSON.stringify(vouchers[i]);
                vouchers[i] = JSON.parse(str.substring(0,1)+'"voucherCategory":{"id":"1"},'+str.substring(1,str.length));
            }
            // 如果这条凭证中没有制单日期则加上制单日期，制单日期为当前页面中这条凭证的制单日期
            if (vouchers[i].makeDate == undefined){
                var str = JSON.stringify(vouchers[i]);
                var makeDate = $("#makeDate").val();
                vouchers[i] = JSON.parse(str.substring(0,1)+'"makeDate":"'+makeDate+'",'+str.substring(1,str.length));
            }
            // 如果这条凭证中没有制单人则加上制单人，制单人为当前页面中这条凭证的制单人
            if (vouchers[i].chartMaker == undefined){
                var str = JSON.stringify(vouchers[i]);
                var chartMaker = ${userId};
                vouchers[i] = JSON.parse(str.substring(0,1)+'"chartMaker":{"id":"'+chartMaker+'"},'+str.substring(1,str.length));
            }
            // 如果这条凭证中没有打印次数则加上打印次数，打印次数为0
            if (vouchers[i].printTimes == undefined){
                var str = JSON.stringify(vouchers[i]);
                vouchers[i] = JSON.parse(str.substring(0,1)+'"printTimes":0,'+str.substring(1,str.length));
            }

            // 如果这条凭证中没有状态则加上状态，状态为0，即保存状态
            if (vouchers[i].state == undefined){
                var str = JSON.stringify(vouchers[i]);
                vouchers[i] = JSON.parse(str.substring(0,1)+'"state":0,'+str.substring(1,str.length));
            }
        }
        $("#form").sendData('<%=request.getContextPath()%>/finance/save/voucher', JSON.stringify(vouchers),function (result) {
            if (result.result.indexOf("success") != -1){
                $("#send").attr("disabled",true);
                $("#sendAll").attr("disabled",true);
                // 批量保存成功之后，在点击上一页，下一页之后保存按钮依然为禁用
                for (var i = 0; i < vouchers.length;i++){
                    disabledSaveNo[i] = i;
                }
            }
        });
    });
    document.title = "生成凭证";

</script>