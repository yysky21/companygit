/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: returnProduct.js
 *类的详细说明
 *
 * @author smjie
 * @Date  2018/3/22
 * @version 1.00
 */
var repairProduct = (function ($) {
    "use strict";


    var contextPath = "";

    function init(isSave, rootPath) {
        contextPath = rootPath;

        $('[data-entity-no-a="entityNoA"]').click(function(){
            if (this.dataset.entityNo.indexOf("FR") == 0) {
                render(contextPath + "/orderManagement/view/order/" + this.dataset.entityId);
            }
        });

        if (isSave) {
            $('input.flat').iCheck({
                checkboxClass: 'icheckbox_flat-green',
                radioClass: 'iradio_flat-green'

            }).on("ifClicked",function(event){
                var theICheck = $(this);
                if(event.target.checked){
                    theICheck.iCheck('uncheck');
                }else{
                    theICheck.iCheck('check');
                }

                calculateRepairProductAmounts(theICheck.parent());
            });

            $("#describes").attr("readonly",false).css("border", "1px solid #ccc");
        }

        $('[data-property-name="price"]').blur(function(){
            var quantityObj = $(this);
            calculateRepairProductDetailAmount(quantityObj);
            calculateRepairProductAmount(quantityObj);
        });
    }

    function calculateRepairProductAmounts(tdChild) {
        calculateRepairProductDetailAmount(tdChild);
        calculateRepairProductAmount(tdChild);
    }

    function calculateRepairProductDetailAmount(tdChild) {
        var amount, price, quantity;
        var inputs = tdChild.parent().parent().find(":input");

        for (var x = 0; x < inputs.length; x++) {
            var name = $(inputs[x]).attr("name");

            if (name != undefined) {
                if (name == "details[][amount]:number") {
                    amount = inputs[x];
                }

                if (name == "details[][price]:number") {
                    price = inputs[x];
                }

                if (name == "details[][quantity]:number") {
                    quantity = inputs[x];
                }
            }
        }

        if ($.trim(quantity.value) != "") {
            amount.value = Math.formatFloat(parseFloat(price.value) * parseFloat(quantity.value), 2);
        }
    }

    function calculateRepairProductAmount(tdChild) {
        var amount = 0;

        var trs = tdChild.parent().parent().parent().find("tr");

        $.each(trs, function(ci, tr){
            var quantity = "", price = "";

            $.each($(tr).find(":input"), function(cii, item){
                var name = $(item).attr("name");

                if (name != undefined) {
                    if (name == "details[][quantity]:number") {
                        quantity = item.value;
                    }

                    if (name == "details[][price]:number") {
                        price = item.value;
                    }
                }
            });

            if ($.trim(quantity) != "" && $.trim(price) != "") {
                amount = Math.formatFloat(amount + parseFloat(price) * parseFloat(quantity), 2);
            }
        });

        $("#amount").val(amount);
    }

    function audit(auditResult, url) {
        $("#auditResult").val(auditResult);
        $("#actionForm").submitForm(url);
    }

    function save(url, auditUrl) {
        var $form = $("#form");
        if (!validator.checkAll($form)) {
            return;
        }

        var json = JSON.stringify($form.serializeJSON());
        json = json.substring(0, json.length-1) + ',"details":[';

        var trs = $("#productList tbody tr");
        for (var i = 0; i < trs.length; i++) {
            var textInputs = $(trs[i]).find("input");
            var tds = $(trs[i]).find("td");

            if (tds.length > 0) {
                if ($.trim($(trs[i]).find('[data-property-name="productNo"]')[0].value) != "" &&
                    $(trs[i]).find('input.flat')[0].checked) {

                    for (var j = 0; j < textInputs.length; j++) {
                        if ($.trim(textInputs[j].value) == "" && $(textInputs[j]).attr("required") != undefined) {
                            alert("请输入值");
                            $(textInputs[j]).focus();
                            return false;
                        }
                    }

                    json += JSON.stringify($(trs[i]).find(":input").not('[value=""]').serializeJSON()["details"][0]) + ",";
                }
            }
        }

        if (json.substring(json.length-1) == "[") {
            alert("请输要修补的商品");
            return false;

        } else {
            json = json.substring(0, json.length-1) + ']}';
        }

        $form.sendData(url, json, function(result){
            if (result.result.indexOf("success") != -1) {
                $("#entityId").val(result.id);
                audit('Y', auditUrl);
            }
        }, false);
    }

    return {
        calculateRepairProductAmounts: calculateRepairProductAmounts,
        calculateRepairProductDetailAmount: calculateRepairProductDetailAmount,
        calculateRepairProductAmount: calculateRepairProductAmount,
        save: save,
        audit: audit,
        init: init
    }
})(jQuery);
