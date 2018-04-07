/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: productCheck.js
 *
 * @author yuanyun
 * @Date  2017/11/17
 * @version 1.00
 */
var productCheck = (function ($) {
    "use strict";

    // 添加商品盘点
    function addProductCheck(uri, callback) {
        var $form = $("#form");
        if (!validator.checkAll($form)) {
            return;
        }

        var json = JSON.stringify($form.serializeJSON());
        json = json.substring(0, json.length-1) + ',"details":[';


        var trs = $("#table tbody tr");

        for (var i = 0; i < trs.length; i++) {
            var inputs = $(trs[i]).find(":input");
            json += JSON.stringify(inputs.not('[value=""]').serializeJSON()["details"][0]) + ",";
        }

        json = json.substring(0, json.length-1) + ']}';

        $form.sendData(uri, json, function(result){
            if(result.result.indexOf("success") != -1){
                $("table tbody tr").remove();
                if (callback != undefined) {
                    callback(result);
                }
            }
        });
    }

    // 判断是否选择了仓库
    function stockIsSelect(code) {
        if ($("#warehouse").val()==null || $("#warehouse").val()==""){
            alert("请先选择仓库！");
            code.val("");
            $("#warehouse").focus();
            return false;
        }
    }

    // 设置盘点数量
    function setCheckQuantity(uri,code) {
        var json = JSON.stringify({"id":parseInt(code.val())});
        $(this).ajaxPost(uri,json,function (result) {
            if (result.unit != null && result.unit != ""){
                unit = result.unit;
                if(unit == "克" || unit == "克拉"){
                    $(".checkQuantity").css("display","block");
                    $("#checkQuantity").focus();
                    $("#confirm").unbind("click").bind("click",function () {
                        if ($("#checkQuantity").val() == "" || $("#checkQuantity").val() == null){
                            alert("请输入盘点数量！");
                            return false;
                        } else {
                            var reg = /^\d+(\.\d+)?$/;
                            if (reg.test($("#checkQuantity").val()) == false){
                                alert("盘点数量必须为纯数字，包括小数");
                                $("#checkQuantity").val("");
                                $("#checkQuantity").focus();
                                return false;
                            } else {
                                var newTr = $("<tr><td><input name='details[][product[id]]:number' value='"+code.val()+"' readonly /></td>" +
                                    "<td><input name='details[][checkQuantity]:number' value='"+$("#checkQuantity").val()+"' readonly /></td></tr>");
                                $("table tbody").append(newTr);
                                $("#confirm").unbind("click");
                                $("#checkQuantity").val("");
                                code.val("");
                                code.focus();
                                $(".checkQuantity").css("display","none");
                                $("#confirm").unbind("click").bind("click",function () {
                                    if (stockIsSelect($("#code2"))==false){
                                        return false;
                                    }
                                    if ($("#table > tbody > tr:not(.old)").length>=5){
                                        alert("请保存后再继续输入条形码");
                                        $("#code2").val("");
                                        return false;
                                    }else {
                                        if ($("#code2").val() == null || $("#code2").val() == ""){
                                            return false;
                                        } else {
                                            setCheckQuantity(uri,$("#code2"));
                                        }
                                    }
                                })
                            }
                        }
                    })
                    $("#checkQuantity").unbind("keypress").keypress(function (e) {
                        if (e.keyCode == 13) {
                            if ($("#checkQuantity").val() == "" || $("#checkQuantity").val() == null){
                                alert("请输入盘点数量！");
                                return false;
                            } else {
                                var reg = /^\d+(\.\d+)?$/;
                                if (reg.test($("#checkQuantity").val()) == false){
                                    alert("盘点数量必须为纯数字，包括小数");
                                    $("#checkQuantity").val("");
                                    $("#checkQuantity").focus();
                                    return false;
                                } else {
                                    var newTr = $("<tr><td><input name='details[][product[id]]:number' value='"+code.val()+"' readonly /></td>" +
                                        "<td><input name='details[][checkQuantity]:number' value='"+$("#checkQuantity").val()+"' readonly /></td></tr>");
                                    $("table tbody").append(newTr);
                                    $("#checkQuantity").val("");
                                    code.val("");
                                    code.focus();
                                    $(".checkQuantity").css("display","none");
                                    $("#checkQuantity").unbind("keypress").bind("keypress",function () {
                                        if (stockIsSelect($("#code2"))==false){
                                            return false;
                                        }
                                        if ($("#table > tbody > tr:not(.old)").length>=5){
                                            alert("请保存后再继续输入条形码!");
                                            $("#code2").val("");
                                            return false;
                                        }else {
                                            if (e.keyCode == 13) {
                                                if ($("#code2").val() == null || $("#code2").val() == ""){
                                                    return false;
                                                } else {
                                                    setCheckQuantity(uri,$("#code2"));
                                                }
                                            }
                                        }
                                    });
                                    $("#confirm").unbind("click").bind("click",function () {
                                        if (stockIsSelect($("#code2"))==false){
                                            return false;
                                        }
                                        if ($("#table > tbody > tr:not(.old)").length>=5){
                                            alert("请保存后再继续输入条形码");
                                            $("#code2").val("");
                                            return false;
                                        }else {
                                            if ($("#code2").val() == null || $("#code2").val() == ""){
                                                return false;
                                            } else {
                                                setCheckQuantity(uri,$("#code2"));
                                            }
                                        }
                                    })
                                }
                            }
                        }
                    })
                }else {
                    var newTr = $("<tr><td><input name='details[][product[id]]:number' value='"+code.val()+"' readonly /></td>" +
                        "<td><input name='details[][checkQuantity]:number' value='1' readonly /></td></tr>");
                    $("table tbody").append(newTr);
                    code.val("");
                    code.focus();
                }
            }else {
                alert("查不到该商品，请输入商品编码!");
                $(".itemNo").css("display","block");
                $("#itemNo").focus();
                $("#confirm").unbind("click").bind("click",function () {
                    if ($("#itemNo").val() == null || $("#itemNo").val() == ""){
                        alert("请输入商品编码！");
                        return false;
                    } else {
                        var itemNo = $("#itemNo").val();
                        var newTr = $("<tr><td><input name='details[][product[id]]:number' value='"+code.val()+"' readonly /><input type='hidden' name='details[][itemNo]' value='"+itemNo+"'/></td>" +
                            "<td><input name='details[][checkQuantity]:number' value='1' readonly /></td></tr>");
                        $("table tbody").append(newTr);
                        code.val("");
                        code.focus();
                        $("#itemNo").val("");
                        $(".itemNo").css("display","none");
                        $("#confirm").unbind("click").bind("click",function () {
                            if (stockIsSelect($("#code2"))==false){
                                return false;
                            }
                            if ($("#table > tbody > tr:not(.old)").length>=5){
                                alert("请保存后再继续输入条形码");
                                $("#code2").val("");
                                return false;
                            }else {
                                if ($("#code2").val() == null || $("#code2").val() == ""){
                                    return false;
                                } else {
                                    setCheckQuantity(uri,$("#code2"));
                                }
                            }
                        });
                    }
                });
                if ($("#itemNo").css("display")=="block"){
                    $("#itemNo").unbind("keypress").bind("keypress",function (e) {
                        if (e.keyCode == 13) {
                            if ($("#itemNo").val() == null || $("#itemNo").val() == ""){
                                alert("请输入商品编码！");
                                return false;
                            } else {
                                var itemNo = $("#itemNo").val();
                                var newTr = $("<tr><td><input name='details[][product[id]]:number' value='" + code.val() + "' readonly /><input type='hidden' name='details[][itemNo]' value='" + itemNo + "'/></td>" +
                                    "<td><input name='details[][checkQuantity]:number' value='1' readonly /></td></tr>");
                                $("table tbody").append(newTr);
                                code.val("");
                                code.focus();
                                $("#itemNo").val("");
                                $(".itemNo").css("display", "none");
                                $("#itemNo").unbind("keypress");
                                $("#confirm").unbind("click").bind("click",function () {
                                    if (stockIsSelect($("#code2"))==false){
                                        return false;
                                    }
                                    if ($("#table > tbody > tr:not(.old)").length>=5){
                                        alert("请保存后再继续输入条形码");
                                        $("#code2").val("");
                                        return false;
                                    }else {
                                        if ($("#code2").val() == null || $("#code2").val() == ""){
                                            return false;
                                        } else {
                                            setCheckQuantity(uri,$("#code2"));
                                        }
                                    }
                                });
                            }
                        }
                    });
                }
            }
        });
    }

    return {
        setCheckQuantity: setCheckQuantity,
        addProductCheck: addProductCheck,
        stockIsSelect: stockIsSelect
    }

})(jQuery);
