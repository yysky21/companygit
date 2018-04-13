/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: productCheck.js
 *
 * @author yuanyun
 * @Date  2017/11/30
 * @version 1.00
 */
var finance = (function ($) {
    "use strict";

    // 保存凭证
    function saveVoucher(uri) {
        var $form = $("#form");
        if (!validator.checkAll($form)) {
            return;
        }

        var json = JSON.stringify($form.serializeJSON());
        json = "["+json.substring(0, (json.indexOf("details")-2))+json.substring((json.indexOf("]")+1),json.length-1) + ',"details":[';

        var trs = $("#voucherList tbody tr");

        for (var i = 0; i < trs.length; i++) {
            var inputs = $(trs[i]).find(":input");
            json += JSON.stringify(inputs.not('[value=""]').serializeJSON({skipFalsyValuesForFields: ["details[][voucherItem[assistant]]:string", "details[][voucherItem[debit]]","details[][voucherItem[credit]]"]})["details"][0]) + ",";
        }

        json = json.substring(0, json.length-1) + ']';
        if (typeof vouchers == 'undefined'){
            json += "}]";
            $form.sendData(uri, json);
        } else {
            json += ',"voucherItemSources":' + JSON.stringify(vouchers[count].voucherItemSources) + '}]';
            $form.sendData(uri, json,function (result) {
                if (result.result.indexOf("success") != -1){
                    add(disabledSaveNo,count);
                    if (count == disabledSaveNo[count]){
                        $("#send").attr("disabled",true);
                    }
                }
            });
        }
    }

    function add(disabledSaveNo,count) {
        disabledSaveNo[count] = count;
    }

    function init() {
        initDocType();
        initChartMaker();
        initWarehouse();
        initProductType();
        initPayType();
        initAccount();
    }
    var position = 0;
    var json = "{}";
    var recordsSum = 0;
    var size = 0;
    function initDocType() {
        $("#docTypeChooseDiv").dialog({
            title: "选择单据类型",
            autoOpen: false,
            width: 800,
            height:760,
            buttons: {
                "确定":function () {
                    var trs = $("#docTypeChooseDiv tbody tr[class='warning']");
                    var tdValue ="";
                    for (var i = 0; i < trs.length; i++) {
                        var td = $(trs[i]).find("td:last");
                        tdValue += td.html()+";";
                    }
                    $(document.getElementById("docType[name]")).val(tdValue);
                    $("#docTypeChooseDiv tbody tr").remove();
                    $(this).dialog("close");
                    position = 0;
                    recordsSum = 0;
                    $("#docTypeChooseDiv table tbody").unbind("scroll");
                    size = 0;
                },
                "取消": function () {
                    $("#docTypeChooseDiv tbody tr").remove();
                    $(this).dialog("close");
                    position = 0;
                    recordsSum = 0;
                    $("#docTypeChooseDiv table tbody").unbind("scroll");
                    size = 0;
                }
            }
        });

        $("#docType").unbind('click').click(function () {
            $("#docTypeChooseDiv").dialog("open");
            $("#docTypeChooseDiv").ajaxPost1("/finance/privateQuery/docType",json,position,function (result) {
                recordsSum = result.recordsSum;
                $(".recordsSum").html(result.recordsSum);
                $(".loadSum").html(result.entities.length);
                $.each(result.entities, function(i, item) {  //遍历出来json里边的内容；i，表示当前遍历到第几条内容；item，表示当前遍历的对象；
                    $("#docTypeChooseDiv tbody").append(
                        '<tr>'+
                            '<td style="width:60px;padding-left: 23px"><input type="checkbox"></td>'+
                            '<td width="50px" style="text-align: center">'+(size+1)+'</td>'+
                            '<td>'+item.name+'</td>'+
                        '</tr>'
                    );
                    if ($(document.getElementById("docType[name]")).val().indexOf(item.name + ";") != -1) {
                        $("#docTypeChooseDiv tbody").find("tr:last").find("td:first").find("input").attr("checked","checked");
                        $("#docTypeChooseDiv tbody").find("tr:last").attr("class","warning");
                    }
                    size += 1;
                });
                $('table').tableCheckbox({ /* options */ });

                $("#docTypeChooseDiv table tbody").unbind("scroll").scroll(function() {
                    //$("#docTypeChooseDiv table tbody").scrollTop()    滚动条位置距离body顶部的距离；
                    //$("#docTypeChooseDiv table tbody tr").height() * $("#docTypeChooseDiv table tbody tr").size()    tbody中tr的总高度；
                    //$("#docTypeChooseDiv table tbody").height()+17    tbody中可视窗口的高度；
                    if ($("#docTypeChooseDiv table tbody").scrollTop() >=$("#docTypeChooseDiv table tbody tr").height() * size - $("#docTypeChooseDiv table tbody").height()+17) {   //判断是否已经滚动到页面底部；
                        position += 30;
                        if (recordsSum > position){
                            $("#docTypeChooseDiv").ajaxPost1("/finance/privateQuery/docType",json,position,function (result) {
                                $(".loadSum").html(position + result.entities.length);
                                $.each(result.entities, function(i, item) {  //遍历出来json里边的内容；i，表示当前遍历到第几条内容；item，表示当前遍历的对象；
                                    $("#docTypeChooseDiv tbody").append(
                                        '<tr>'+
                                        '<td style="width:60px;padding-left: 23px;"><input type="checkbox"</td>'+
                                        '<td width="50px" style="text-align: center">'+(size+1)+'</td>'+
                                        '<td>'+item.name+'</td>'+
                                        '</tr>'
                                    )
                                    if ($(document.getElementById("docType[name]")).val().indexOf(item.name + ";") != -1) {
                                        $("#docTypeChooseDiv tbody").find("tr:last").find("td:first").find("input").attr("checked","checked");
                                        $("#docTypeChooseDiv tbody").find("tr:last").attr("class","warning");
                                    }
                                    size += 1;
                                });
                                $('table').tableCheckbox({ /* options */ });
                            });
                            $('table').tableCheckbox({ /* options */ });
                        }
                    }
                });
            });
        });
    }

    function initChartMaker() {
        $("#chartMakerChooseDiv").dialog({
            title: "选择制单人",
            autoOpen: false,
            width: 800,
            height:760,
            buttons: {
                "确定":function () {
                    var trs = $("#chartMakerChooseDiv tbody tr[class='warning']");
                    var tdValue ="";
                    for (var i = 0; i < trs.length; i++) {
                        var td = $(trs[i]).find("td:eq(2)");
                        tdValue += td.html()+";";
                    }
                    $(document.getElementById("chartMaker[name]")).val(tdValue);
                    $("#chartMakerChooseDiv tbody tr").remove();
                    $(this).dialog("close");
                    position = 0;
                    recordsSum = 0;
                    $("#chartMakerChooseDiv table tbody").unbind("scroll");
                    size = 0;
                },
                "取消": function () {
                    $("#chartMakerChooseDiv tbody tr").remove();
                    $(this).dialog("close");
                    position = 0;
                    recordsSum = 0;
                    $("#chartMakerChooseDiv table tbody").unbind("scroll");
                    size = 0;
                }
            }
        });

        $("#chartMaker").unbind('click').click(function () {
            $("#chartMakerChooseDiv").dialog("open");
            $("#chartMakerChooseDiv").ajaxPost1("/finance/privateQuery/chartMaker",json,position,function (result) {
                recordsSum = result.recordsSum;
                $(".recordsSum").html(result.recordsSum);
                $(".loadSum").html(result.entities.length);
                $.each(result.entities, function(i, item) {  //遍历出来json里边的内容；i，表示当前遍历到第几条内容；item，表示当前遍历的对象；
                    var tr = '<tr>'+
                        '<td style="width:60px;padding-left: 23px"><input type="checkbox"></td>'+
                        '<td width="50px" style="text-align: center">'+(size+1)+'</td>'+
                        '<td>'+item.name+'</td><td>';
                    $.each(item.posts,function (j,item1) {
                        tr += item1.name+'&nbsp&nbsp'
                    });
                    tr += '</td><td>'+item.posts[0].dept.name+'</td>'+
                    '</tr>';
                    $("#chartMakerChooseDiv tbody").append(tr);
                    if ($(document.getElementById("chartMaker[name]")).val().indexOf(item.name + ";") != -1) {
                        $("#chartMakerChooseDiv tbody").find("tr:last").find("td:first").find("input").attr("checked","checked");
                        $("#chartMakerChooseDiv tbody").find("tr:last").attr("class","warning");
                    }
                    size += 1;
                });
                $('table').tableCheckbox({ /* options */ });

                $("#chartMakerChooseDiv table tbody").unbind("scroll").scroll(function() {
                    //$("#chartMakerChooseDiv table tbody").scrollTop()    滚动条位置距离body顶部的距离；
                    //$("#chartMakerChooseDiv table tbody tr").height() * $("#docTypeChooseDiv table tbody tr").size()    tbody中tr的总高度；
                    //$("#chartMakerChooseDiv table tbody").height()+17    tbody中可视窗口的高度；
                    if ($("#chartMakerChooseDiv table tbody").scrollTop() >=$("#chartMakerChooseDiv table tbody tr").height() * size - $("#chartMakerChooseDiv table tbody").height()+17) {   //判断是否已经滚动到页面底部；
                        position += 30;
                        if (recordsSum > position){
                            $("#chartMakerChooseDiv").ajaxPost1("/finance/privateQuery/chartMaker",json,position,function (result) {
                                $(".loadSum").html(position + result.entities.length);
                                $.each(result.entities, function(i, item) {  //遍历出来json里边的内容；i，表示当前遍历到第几条内容；item，表示当前遍历的对象；
                                    var tr = '<tr>'+
                                        '<td style="width:60px;padding-left: 23px"><input type="checkbox"></td>'+
                                        '<td width="50px" style="text-align: center">'+(size+1)+'</td>'+
                                        '<td>'+item.name+'</td><td>';
                                    $.each(item.posts,function (j,item1) {
                                        tr += item1.name+'&nbsp&nbsp'
                                    });
                                    tr += '</td><td>'+item.posts[0].dept.name+'</td>'+
                                        '</tr>';
                                    $("#chartMakerChooseDiv tbody").append(tr);
                                    if ($(document.getElementById("chartMaker[name]")).val().indexOf(item.name + ";") != -1) {
                                        $("#chartMakerChooseDiv tbody").find("tr:last").find("td:first").find("input").attr("checked","checked");
                                        $("#chartMakerChooseDiv tbody").find("tr:last").attr("class","warning");
                                    }
                                    size += 1;
                                });
                                $('table').tableCheckbox({ /* options */ });
                            });
                            $('table').tableCheckbox({ /* options */ });
                        }
                    }
                });
            });
        });
    }

    function initWarehouse() {
        $("#warehouseChooseDiv").dialog({
            title: "选择仓库",
            autoOpen: false,
            width: 800,
            height: 760,
            buttons: {
                "确定": function () {
                    var trs = $("#warehouseChooseDiv tbody tr[class='warning']");
                    var tdValue ="";
                    for (var i = 0; i < trs.length; i++) {
                        var td = $(trs[i]).find("td:eq(3)");
                        tdValue += td.html()+";";
                    }
                    $(document.getElementById("warehouse[name]")).val(tdValue);
                    $("#warehouseChooseDiv tbody tr").remove();
                    $(this).dialog("close");
                    position = 0;
                    recordsSum = 0;
                    $("#warehouseChooseDiv table tbody").unbind("scroll");
                    size = 0;
                },
                "取消": function () {
                    $("#warehouseChooseDiv tbody tr").remove();
                    $(this).dialog("close");
                    position = 0;
                    recordsSum = 0;
                    $("#warehouseChooseDiv table tbody").unbind("scroll");
                    size = 0;
                }
            }
        });

        $("#warehouse").unbind('click').click(function () {
            $("#warehouseChooseDiv").dialog("open");
            $("#warehouseChooseDiv").ajaxPost1("/finance/privateQuery/warehouse", json, position, function (result) {
                recordsSum = result.recordsSum;
                $(".recordsSum").html(result.recordsSum);
                $(".loadSum").html(result.entities.length);
                $.each(result.entities, function (i, item) {  //遍历出来json里边的内容；i，表示当前遍历到第几条内容；item，表示当前遍历的对象；
                    $("#warehouseChooseDiv tbody").append(
                        '<tr>' +
                        '<td style="width:60px;padding-left: 23px"><input type="checkbox"></td>' +
                        '<td width="50px" style="text-align: center">' + (size + 1) + '</td>' +
                        '<td>' + item.no + '</td>' +
                        '<td>' + item.name + '</td>' +
                        '<td>' + item.address + '</td>' +
                        '<td>' + item.company.name + '</td>' +
                        '<td>' + item.charger.name + '</td>' +
                        '</tr>'
                    );
                    if ($(document.getElementById("warehouse[name]")).val().indexOf(item.name + ";") != -1) {
                        $("#warehouseChooseDiv tbody").find("tr:last").find("td:first").find("input").attr("checked","checked");
                        $("#warehouseChooseDiv tbody").find("tr:last").attr("class","warning");
                    }
                    size += 1;
                });
                $('table').tableCheckbox({/* options */});

                $("#warehouseChooseDiv table tbody").unbind("scroll").scroll(function () {
                    //$("#warehouseChooseDiv table tbody").scrollTop()    滚动条位置距离body顶部的距离；
                    //$("#warehouseChooseDiv table tbody tr").height() * $("#docTypeChooseDiv table tbody tr").size()    tbody中tr的总高度；
                    //$("#warehouseChooseDiv table tbody").height()+17    tbody中可视窗口的高度；
                    if ($("#warehouseChooseDiv table tbody").scrollTop() >= $("#warehouseChooseDiv table tbody tr").height() * size - $("#warehouseChooseDiv table tbody").height() + 17) {   //判断是否已经滚动到页面底部；
                        position += 30;
                        if (recordsSum > position) {
                            $("#warehouseChooseDiv").ajaxPost1("/finance/privateQuery/warehouse", json, position, function (result) {
                                $(".loadSum").html(position + result.entities.length);
                                $.each(result.entities, function (i, item) {  //遍历出来json里边的内容；i，表示当前遍历到第几条内容；item，表示当前遍历的对象；
                                    $("#warehouseChooseDiv tbody").append(
                                        '<tr>' +
                                        '<td style="width:60px;padding-left: 23px"><input type="checkbox"></td>' +
                                        '<td width="50px" style="text-align: center">' + (size + 1) + '</td>' +
                                        '<td>' + item.no + '</td>' +
                                        '<td>' + item.name + '</td>' +
                                        '<td>' + item.address + '</td>' +
                                        '<td>' + item.company.name + '</td>' +
                                        '<td>' + item.charger.name + '</td>' +
                                        '</tr>'
                                    );
                                    if ($(document.getElementById("warehouse[name]")).val().indexOf(item.name + ";") != -1) {
                                        $("#warehouseChooseDiv tbody").find("tr:last").find("td:first").find("input").attr("checked","checked");
                                        $("#warehouseChooseDiv tbody").find("tr:last").attr("class","warning");
                                    }
                                    size += 1;
                                });
                                $('table').tableCheckbox({/* options */});
                            });
                            $('table').tableCheckbox({ /* options */ });
                        }
                    }
                });
            });
        });
    }

    function initProductType() {
        $("#productTypeChooseDiv").dialog({
            title: "选择商品分类",
            autoOpen: false,
            width: 800,
            height:760,
            buttons: {
                "确定":function () {
                    var trs = $("#productTypeChooseDiv tbody tr[class='warning']");
                    var tdValue ="";
                    var inputValue = "";
                    for (var i = 0; i < trs.length; i++) {
                        var td = $(trs[i]).find("td:eq(2)");
                        tdValue += td.html()+";";
                        var input = $(trs[i]).find("input:eq(1)");
                        inputValue += input.val()+";";
                    }
                    $("#productType").val(tdValue);
                    $("#productType1").val(inputValue);
                    $("#productTypeChooseDiv tbody tr").remove();
                    $(this).dialog("close");
                    position = 0;
                    recordsSum = 0;
                    $("#productTypeChooseDiv table tbody").unbind("scroll");
                    size = 0;
                },
                "取消": function () {
                    $("#productTypeChooseDiv tbody tr").remove();
                    $(this).dialog("close");
                    position = 0;
                    recordsSum = 0;
                    $("#productTypeChooseDiv table tbody").unbind("scroll");
                    size = 0;
                }
            }
        });

        $("#productType2").unbind('click').click(function () {
            $("#productTypeChooseDiv").dialog("open");
            $("#productTypeChooseDiv").ajaxPost1("/finance/privateQuery/productType",json,position,function (result) {
                recordsSum = result.recordsSum;
                $(".recordsSum").html(result.recordsSum);
                $(".loadSum").html(result.entities.length);
                $.each(result.entities, function(i, item) {  //遍历出来json里边的内容；i，表示当前遍历到第几条内容；item，表示当前遍历的对象；
                    $("#productTypeChooseDiv tbody").append(
                        '<tr>'+
                        '<td style="width:60px;padding-left: 23px"><input type="checkbox"></td>'+
                        '<td width="50px" style="text-align: center">'+(size+1)+'</td>'+
                        '<td>'+item.name+'</td>'+
                        '<input type="hidden" value="'+item.id+'">'+
                        '</tr>'
                    );
                    if ($("#productType").val().indexOf(item.name + ";") != -1) {
                        $("#productTypeChooseDiv tbody").find("tr:last").find("td:first").find("input").attr("checked","checked");
                        $("#productTypeChooseDiv tbody").find("tr:last").attr("class","warning");
                    }
                    size += 1;
                });
                $('table').tableCheckbox({ /* options */ });

                $("#productTypeChooseDiv table tbody").unbind("scroll").scroll(function() {
                    //$("#productTypeChooseDiv table tbody").scrollTop()    滚动条位置距离body顶部的距离；
                    //$("#productTypeChooseDiv table tbody tr").height() * $("#docTypeChooseDiv table tbody tr").size()    tbody中tr的总高度；
                    //$("#productTypeChooseDiv table tbody").height()+17    tbody中可视窗口的高度；
                    if ($("#productTypeChooseDiv table tbody").scrollTop() >=$("#productTypeChooseDiv table tbody tr").height() * size - $("#productTypeChooseDiv table tbody").height()+17) {   //判断是否已经滚动到页面底部；
                        position += 30;
                        if (recordsSum > position){
                            $("#productTypeChooseDiv").ajaxPost1("/finance/privateQuery/productType",json,position,function (result) {
                                $(".loadSum").html(position + result.entities.length);
                                $.each(result.entities, function(i, item) {  //遍历出来json里边的内容；i，表示当前遍历到第几条内容；item，表示当前遍历的对象；
                                    $("#productTypeChooseDiv tbody").append(
                                        '<tr>'+
                                        '<td style="width:60px;padding-left: 23px"><input type="checkbox"></td>'+
                                        '<td width="50px" style="text-align: center">'+(size+1)+'</td>'+
                                        '<td>'+item.name+'</td>'+
                                        '<input type="hidden" value="'+item.id+'">'+
                                        '</tr>'
                                    );
                                    if ($("#productType").val().indexOf(item.name + ";") != -1) {
                                        $("#productTypeChooseDiv tbody").find("tr:last").find("td:first").find("input").attr("checked","checked");
                                        $("#productTypeChooseDiv tbody").find("tr:last").attr("class","warning");
                                    }
                                    size += 1;
                                });
                                $('table').tableCheckbox({ /* options */ });
                            });
                            $('table').tableCheckbox({ /* options */ });
                        }
                    }
                });
            });
        });
    }

    function initPayType() {
        var tbody = '<tr><td><input type="checkbox"></td><td>1</td><td>现金</td><input type="hidden" value="0"></tr>'+
            '<tr><td><input type="checkbox"></td><td>2</td><td>网上支付</td><input type="hidden" value="1"></tr>'+
            '<tr><td><input type="checkbox"></td><td>3</td><td>扫描支付</td><input type="hidden" value="2"></tr>'+
            '<tr><td><input type="checkbox"></td><td>4</td><td>汇款</td><input type="hidden" value="3"></tr>'+
            '<tr><td><input type="checkbox"></td><td>5</td><td>转账</td><input type="hidden" value="4"></tr>'+
            '<tr><td><input type="checkbox"></td><td>6</td><td>支付宝转账</td><input type="hidden" value="6"></tr>'+
            '<tr><td><input type="checkbox"></td><td>7</td><td>微信转账</td><input type="hidden" value="7"></tr>'+
            '<tr><td><input type="checkbox"></td><td>8</td><td>其他</td><input type="hidden" value="5"></tr>'
        $("#payTypeChooseDiv").dialog({
            title: "选择商品分类",
            autoOpen: false,
            width: 800,
            height:760,
            buttons: {
                "确定":function () {
                    var trs = $("#payTypeChooseDiv tbody tr[class='warning']");
                    var tdValue ="";
                    var inputValue = "";
                    for (var i = 0; i < trs.length; i++) {
                        var td = $(trs[i]).find("td:eq(2)");
                        tdValue += td.html()+";";
                        var input = $(trs[i]).find("input:eq(1)");
                        inputValue += input.val()+";";
                    }
                    $("#payType").val(tdValue);
                    $("#payType1").val(inputValue);
                    $("#payTypeChooseDiv tbody tr").remove();
                    $(this).dialog("close");
                },
                "取消": function () {
                    $("#payTypeChooseDiv tbody tr").remove();
                    $(this).dialog("close");
                }
            }
        });

        $("#payType2").unbind('click').click(function () {
            $("#payTypeChooseDiv").dialog("open");
            $("#payTypeChooseDiv tbody").append(tbody);
            var trs = $("#payTypeChooseDiv tbody tr");
            var tdValue = "";
            for (var i = 0; i < trs.length; i++) {
                tdValue = $(trs[i]).find("td:eq(2)").html();
                console.log(tdValue);
                console.log($("#payType").val());
                if ($("#payType").val().indexOf(tdValue + ";") != -1) {
                    $(trs[i]).find("td:first").find("input").attr("checked","checked");
                    $(trs[i]).attr("class","warning");
                }
            }
            $('table').tableCheckbox({ /* options */ });
        });
    }

    function initAccount() {
        $("#accountChooseDiv").dialog({
            title: "选择商品分类",
            autoOpen: false,
            width: 800,
            height:760,
            buttons: {
                "确定":function () {
                    var trs = $("#accountChooseDiv tbody tr[class='warning']");
                    var tdValue ="";
                    var inputValue = "";
                    for (var i = 0; i < trs.length; i++) {
                        var td = $(trs[i]).find("td:eq(2)");
                        tdValue += td.html()+";";
                        var input = $(trs[i]).find("input:eq(1)");
                        inputValue += input.val()+";";
                    }
                    $("#account").val(tdValue);
                    $("#account1").val(inputValue);
                    $("#accountChooseDiv tbody tr").remove();
                    $(this).dialog("close");
                    position = 0;
                    recordsSum = 0;
                    $("#accountChooseDiv table tbody").unbind("scroll");
                    size = 0;
                },
                "取消": function () {
                    $("#accountChooseDiv tbody tr").remove();
                    $(this).dialog("close");
                    position = 0;
                    recordsSum = 0;
                    $("#accountChooseDiv table tbody").unbind("scroll");
                    size = 0;
                }
            }
        });

        $("#account2").unbind('click').click(function () {
            $("#accountChooseDiv").dialog("open");
            $("#accountChooseDiv").ajaxPost1("/finance/privateQuery/account",json,position,function (result) {
                recordsSum = result.recordsSum;
                $(".recordsSum").html(result.recordsSum);
                $(".loadSum").html(result.entities.length);
                $.each(result.entities, function(i, item) {  //遍历出来json里边的内容；i，表示当前遍历到第几条内容；item，表示当前遍历的对象；
                    $("#accountChooseDiv tbody").append(
                        '<tr>'+
                        '<td style="width:60px;padding-left: 23px"><input type="checkbox"></td>'+
                        '<td width="50px" style="text-align: center">'+(size+1)+'</td>'+
                        '<td>'+item.name+'</td>'+
                        '<td>'+item.account+'</td>'+
                        '<td>'+item.owner.name+'</td>'+
                        '<td>'+item.branch+'</td>'+
                        '<td>'+item.amount+'</td>'+
                        '<td>'+item.inputDate+'</td>'+
                        '<input type="hidden" value="'+item.id+'">'+
                        '</tr>'
                    );
                    if ($("#account").val().indexOf(item.name + ";") != -1) {
                        $("#accountChooseDiv tbody").find("tr:last").find("td:first").find("input").attr("checked","checked");
                        $("#accountChooseDiv tbody").find("tr:last").attr("class","warning");
                    }
                    size += 1;
                });
                $('table').tableCheckbox({ /* options */ });

                $("#accountChooseDiv table tbody").unbind("scroll").scroll(function() {
                    //$("#productTypeChooseDiv table tbody").scrollTop()    滚动条位置距离body顶部的距离；
                    //$("#productTypeChooseDiv table tbody tr").height() * $("#docTypeChooseDiv table tbody tr").size()    tbody中tr的总高度；
                    //$("#productTypeChooseDiv table tbody").height()+17    tbody中可视窗口的高度；
                    if ($("#accountChooseDiv table tbody").scrollTop() >=$("#accountChooseDiv table tbody tr").height() * size - $("#accountChooseDiv table tbody").height()+17) {   //判断是否已经滚动到页面底部；
                        position += 30;
                        if (recordsSum > position){
                            $("#accountChooseDiv").ajaxPost1("/finance/privateQuery/account",json,position,function (result) {
                                $(".loadSum").html(position + result.entities.length);
                                $.each(result.entities, function(i, item) {  //遍历出来json里边的内容；i，表示当前遍历到第几条内容；item，表示当前遍历的对象；
                                    $("#accountChooseDiv tbody").append(
                                        '<tr>'+
                                        '<td style="width:60px;padding-left: 23px"><input type="checkbox"></td>'+
                                        '<td width="50px" style="text-align: center">'+(size+1)+'</td>'+
                                        '<td>'+item.name+'</td>'+
                                        '<input type="hidden" value="'+item.id+'">'+
                                        '</tr>'
                                    );
                                    if ($("#account").val().indexOf(item.name + ";") != -1) {
                                        $("#accountChooseDiv tbody").find("tr:last").find("td:first").find("input").attr("checked","checked");
                                        $("#accountChooseDiv tbody").find("tr:last").attr("class","warning");
                                    }
                                    size += 1;
                                });
                                $('table').tableCheckbox({ /* options */ });
                            });
                            $('table').tableCheckbox({ /* options */ });
                        }
                    }
                });
            });
        });
    }

    return {
        saveVoucher: saveVoucher,
        init: init,
        initChartMaker: initChartMaker
    }

})(jQuery);
