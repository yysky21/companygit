/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: productCheck.js
 *
 * @author yuanyun
 * @Date  2017/11/30
 * @version 1.00
 */
var article = (function ($) {
    "use strict";

    var position = 0;
    var json = "{}";
    var recordsSum = 0;
    var size = 0;

    function initArticleTag() {
        $("#tagChooseDiv").dialog({
            title: "选择文章标签",
            autoOpen: false,
            width: 800,
            height: 760,
            buttons: {
                "确定": function () {
                    var trs = $("#tagChooseDiv tbody tr[class='warning']");
                    console.log(trs.length);
                    var tdValue = "";
                    var inputValue = "";
                    console.log(tdValue);
                    console.log(inputValue);
                    for (var i = 0; i < trs.length; i++) {
                        var td = $(trs[i]).find("td:last");
                        var input = $(trs[i]).find("input:last");
                        console.log($(document.getElementById("tag[name]")).val());
                        tdValue += td.html() + ";";
                        inputValue +="{'id':" + input.val() + "},";

                    }
                    console.log(tdValue);
                    console.log(inputValue);
                    $(document.getElementById("tag[name]")).val(tdValue);
                    $("#articleTags").val(inputValue);
                    $("#tagChooseDiv tbody tr").remove();
                    $(this).dialog("close");
                    position = 0;
                    recordsSum = 0;
                    $("#tagChooseDiv table tbody").unbind("scroll");
                    size = 0;
                },
                "取消": function () {
                    $("#tagChooseDiv tbody tr").remove();
                    $(this).dialog("close");
                    position = 0;
                    recordsSum = 0;
                    $("#tagChooseDiv table tbody").unbind("scroll");
                    size = 0;
                }
            }
        });

        $("#tag").unbind('click').click(function () {
            $("#tagChooseDiv").dialog("open");
            $("#tagChooseDiv").ajaxPost1("/sys/specialQuery/articleTag", json, position, function (result) {
                recordsSum = result.recordsSum;
                $(".recordsSum").html(result.recordsSum);
                $(".loadSum").html(result.entities.length);
                $.each(result.entities, function (i, item) {  //遍历出来json里边的内容；i，表示当前遍历到第几条内容；item，表示当前遍历的对象；
                    $("#tagChooseDiv tbody").append(
                        '<tr>' +
                        '<td style="width:60px;padding-left: 23px"><input type="checkbox"></td>' +
                        '<td width="50px" style="text-align: center">' + (size + 1) + '</td>' +
                        '<td>' + item.name + '</td>' +
                        '<input type="hidden" class="id" name="id" value="'+item.id+'">'+
                        '</tr>'
                    );
                    if ($(document.getElementById("tag[name]")).val().indexOf(item.name + ";") != -1) {
                        $("#tagChooseDiv tbody").find("tr:last").find("td:first").find("input").attr("checked","checked");
                        $("#tagChooseDiv tbody").find("tr:last").attr("class","warning");
                    }
                    size += 1;
                });
                $('table').tableCheckbox({/* options */});

                $("#tagChooseDiv table tbody").unbind("scroll").scroll(function () {
                    //$("#tagChooseDiv table tbody").scrollTop()    滚动条位置距离body顶部的距离；
                    //$("#tagChooseDiv table tbody tr").height() * $("#docTypeChooseDiv table tbody tr").size()    tbody中tr的总高度；
                    //$("#tagChooseDiv table tbody").height()+17    tbody中可视窗口的高度；
                    if ($("#tagChooseDiv table tbody").scrollTop() >= $("#tagChooseDiv table tbody tr").height() * size - $("#tagChooseDiv table tbody").height() + 17) {   //判断是否已经滚动到页面底部；
                        position += 30;
                        if (recordsSum > position) {
                            $("#tagChooseDiv").ajaxPost1("/sys/specialQuery/articleTag", json, position, function (result) {
                                $(".loadSum").html(position + result.entities.length);
                                $.each(result.entities, function (i, item) {  //遍历出来json里边的内容；i，表示当前遍历到第几条内容；item，表示当前遍历的对象；
                                    $("#tagChooseDiv tbody").append(
                                        '<tr>' +
                                        '<td style="width:60px;padding-left: 23px;"><input type="checkbox"</td>' +
                                        '<td width="50px" style="text-align: center">' + (size + 1) + '</td>' +
                                        '<td>' + item.name + '</td>' +
                                        '<input type="hidden" class="id" name="id" value="'+item.id+'">'+
                                        '</tr>'
                                    )
                                    if ($(document.getElementById("tag[name]")).val().indexOf(item.name + ";") != -1) {
                                        $("#tagChooseDiv tbody").find("tr:last").find("td:first").find("input").attr("checked","checked");
                                        $("#tagChooseDiv tbody").find("tr:last").attr("class","warning");
                                    }
                                    size += 1;
                                });
                                $('table').tableCheckbox({/* options */});
                            });
                            $('table').tableCheckbox({/* options */});
                        }
                    }
                });
            });
        });
    }
    return {
        initArticleTag: initArticleTag
    }

})(jQuery);