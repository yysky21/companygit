<%@ page import="com.hzg.tools.FinanceConstant" %>
<%@ page import="com.hzg.finance.SubjectRelate" %>
<%@ page import="com.hzg.finance.BankSubjectExtend" %><%--
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
    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>财务 <small>${entity.name}扩展设置</small></h2>
                    <div class="clearfix"></div>
                </div>
                <span class="section"></span>
                <div class="x_content" >
                    <form role="form" id="form" >
                        <table id="extendSet" class="table table-striped table-bordered jambo_table bulk_action" style="width: 50%;" >
                            <thead>
                            <tr>
                                <c:forEach var="entityy" items="${entities}">
                                    <th>${entityy.fieldName}</th>
                                </c:forEach>
                                <th>科目编码</th><th>科目名称</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${entities2 == null }">
                                <tr>
                                    <c:forEach var="entityy" items="${entities}" varStatus="varStatus">
                                        <td><input type="text" class="text${varStatus.index+1}" name='${entityy.entity}' />
                                            <input type="hidden" name='${entityy.entity}[id]' value="" />
                                        </td>
                                    </c:forEach>
                                    <td><input type="text" class="textt2" name='subjectNo' /></td>
                                    <td><input type="text" class="textt3" name='subjectName'  /></td>
                                    <input type="hidden" name='subject[id]' value="" />
                                </tr>
                            </c:if>
                            <c:if test="${entities2 != null && !entities2.isEmpty()}">
                                <c:forEach var="entityyy" items="${entities2}" varStatus="varStatus" >
                                    <tr>
                                        <c:if test="${entityyy.getClass().getSimpleName().equalsIgnoreCase('BankSubjectExtend')}">
                                            <td><input type="text" class="text1" name='account' value='${entityyy.account.name}' />
                                                <input type="hidden" name='account[id]' value='${entityyy.account.id}' />
                                            </td>
                                        </c:if>
                                        <c:if test="${entityyy.getClass().getSimpleName().equalsIgnoreCase('PurchaseSubjectExtend')}">
                                            <td><input type="text" class="text1" name='supplier' value='${entityyy.supplier.address}' /></td>
                                            <td><input type="text" class="text2" name='supplier' value='${entityyy.supplier.name}' /></td>
                                            <input type="hidden" name='supplier[id]' value='${entityyy.supplier.id}' />
                                        </c:if>
                                        <td><input type="text" name='subjectNo' class="textt2" value="${entityyy.subject.no}" /></td>
                                        <td><input type="text" name='subjectName' class="textt3" value="${entityyy.subject.name}" /></td>
                                        <input type="hidden" name='subject[id]' value="${entityyy.subject.id}" />
                                        <input type="hidden" id="id" name="id" value="${entityyy.id}"/>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                    </form>
                </div>
                <div class="x_content">
                    <div class="form-horizontal form-label-left">
                        <div class="ln_solid"></div>
                        <div class="form-group" id="submitDiv">
                            <div class="col-md-6 col-md-offset-5">
                                <button id="cancel" type="button" class="btn btn-primary">取消</button>
                                <button id="send" type="button" class="btn btn-success">保存</button>
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

    <c:forEach items="${entities}" var="entityy" varStatus="varStatus">
        $(".text${varStatus.index+1}").coolautosuggest({
            url:"<%=request.getContextPath()%>/finance/suggest/${entityy.entity}/${entityy.field}/",
            showProperty: '${entityy.field}',
            onSelected:function(result){
                if(result!=null){
                    // 是银行科目扩展
                    if(${entity.id == 2}) {
                        $(this).next().next().val(result.id);
                    }
                    //采购科目扩展
                    if (${entity.id == 6}){
                        // 进入扩展时有记录
                        if (${entities2 != null && !entities2.isEmpty()}){
                            if (${entityy.field=="address"}) {
                                $(this).parent().next().find("input").val(result.name);
                                $(this).parent().next().next().val(result.id);
                            }else if (${entityy.field=="name"}){
                                $(this).parent().prev().find("input").val(result.address);
                                $(this).parent().next().val(result.id);
                            }
                        } else {
                            if (${entityy.field=="address"}) {
                                $(this).next().next().val(result.id);
                                $(this).parent().next().find("input[type='text']").val(result.name);
                                $(this).parent().next().find("input[type='hidden']").val(result.id);
                            }else if (${entityy.field=="name"}){
                                $(this).next().next().val(result.id);
                                $(this).parent().prev().find("input[type='text']").val(result.address);
                                $(this).parent().prev().find("input[type='hidden']").val(result.id);
                            }
                        }
                    }
                }
            }
        });
        $(".text${varStatus.index+1}").blur(function () {
            if ($(this).val()=="") {
                // 是银行科目扩展
                if(${entity.id == 2}) {
                    $(this).next().next().val("");
                }
                //采购科目扩展
                if (${entity.id == 6}){
                    // 进入扩展时有记录
                    if (${entities2 != null && !entities2.isEmpty()}){
                        if (${entityy.field=="address"}) {
                            $(this).parent().next().find("input").val("");
                            $(this).parent().next().next().val("");
                        }else if (${entityy.field=="name"}){
                            $(this).parent().prev().find("input").val("");
                            $(this).parent().next().val("");
                        }
                    } else {
                        if (${entityy.field=="address"}) {
                            $(this).next().next().val("");
                            $(this).parent().next().find("input[type='text']").val("");
                            $(this).parent().next().find("input[type='hidden']").val("");
                        }else if (${entityy.field=="name"}){
                            $(this).next().next().val("");
                            $(this).parent().prev().find("input[type='text']").val("");
                            $(this).parent().prev().find("input[type='hidden']").val("");
                        }
                    }
                }
            }
        })
    </c:forEach>

    $(".textt2").coolautosuggest({
        url:"<%=request.getContextPath()%>/finance/suggest/subject/no/",
        showProperty: 'no',
        onSelected:function(result){
            if(result!=null){
                $(this).parent().parent().find("input[name='subject[id]']").val(result.id);
                $(this).parent().parent().find("input[name='subjectName']").val(result.name);
            }
        }
    });

    // 科目编码失焦时，如果为空，则设置对应的科目名称也为空
    $(".textt2").blur(function () {
        if ($(this).val()==""){
            $(this).parent().parent().find("input[name='subject[id]']").val("");
            $(this).parent().parent().find("input[name='subjectName']").val("");
        }
    })

    $(".textt3").coolautosuggest({
        url:"<%=request.getContextPath()%>/finance/suggest/subject/name/",
        showProperty: 'name',
        onSelected:function(result){
            if(result!=null){
                $(this).parent().parent().find("input[name='subject[id]']").val(result.id);
                $(this).parent().parent().find("input[name='subjectNo']").val(result.no);
            }
        }
    });
    // 科目名称失焦时，如果为空，则设置对应的科目编码也为空
    $(".textt3").blur(function () {
        if ($(this).val()==""){
            $(this).parent().parent().find("input[name='subject[id]']").val("");
            $(this).parent().parent().find("input[name='subjectNo']").val("");
        }
    })

    $("#extendSet tbody").on("mousedown","tr",function (e) {
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
                        <c:if test="${entity.id==2}">
                        var tr = "<tr>"+
                            "<td><input type='text' class='text1' name='account' /><input type='hidden' name='account[id]' value='' /></td>"+
                            "<td><input type='text' class='text2' name='subjectNo' /></td>"+
                            "<td><input type='text' class='text3' name='subjectName'  /></td>"+
                            "<input type='hidden' name='subject[id]' value='' />"+
                            "</tr>"
                        $(this).after(tr);
                        var accountInput = $("[class='text1']");
                        var subjectNoInput = $("[class='text2']");
                        var subjectNameInput = $("[class='text3']");
                        $(this).next().find(accountInput).coolautosuggest({
                            url:"<%=request.getContextPath()%>/finance/suggest/account/name/",
                            showProperty: 'name',
                            onSelected:function(result){
                                if(result!=null){
                                    $(this).next().next().val(result.id);
                                }
                            }
                        });

                        $(this).next().find(accountInput).blur(function () {
                            if($(this).val()==""){
                                $(this).next().next().val("");
                            }
                        })

                        $(this).next().find(subjectNoInput).coolautosuggest({
                            url:"<%=request.getContextPath()%>/finance/suggest/subject/no/",
                            showProperty: 'no',
                            onSelected:function(result){
                                if(result!=null){
                                    $(this).parent().next().next().val(result.id);
                                    $(this).parent().next().find("input").val(result.name);
                                }
                            }
                        });
                        // 科目编码失焦时，如果为空，则设置对应的科目名称也为空
                        $(this).next().find(subjectNoInput).blur(function () {
                            if ($(this).val() == ""){
                                $(this).parent().next().next().val("");
                                $(this).parent().next().find("input").val("");
                            }
                        })
                        $(this).next().find(subjectNameInput).coolautosuggest({
                            url:"<%=request.getContextPath()%>/finance/suggest/subject/name/",
                            showProperty: 'name',
                            onSelected:function(result){
                                if(result!=null){
                                    $(this).parent().next().val(result.id);
                                    $(this).parent().prev().find("input").val(result.no);
                                }
                            }
                        });
                        // 科目名称失焦时，如果为空，则设置对应的科目编码也为空
                        $(this).next().find(subjectNameInput).blur(function () {
                            if ($(this).val() == ""){
                                $(this).parent().next().val("");
                                $(this).parent().prev().find("input").val("");
                            }
                        })
                        </c:if>

                        <c:if test="${entity.id==6}">
                            var tr = "<tr>"+
                                "<td><input type='text' class='text1' name='supplierAddress' /></td>"+
                                "<td><input type='text' class='text2' name='supplierName' /></td>"+
                                "<td><input type='text' class='textt2' name='subjectNo' /></td>"+
                                "<td><input type='text' class='textt3' name='subjectName'  /></td>"+
                                "<input type='hidden' name='supplier[id]' value='' />"+
                                "<input type='hidden' name='subject[id]' value='' />"+
                                "</tr>"
                            $(this).after(tr);
                            var supplierAddressInput = $("[class='text1']");
                            var supplierNameInput = $("[class='text2']");
                            var subjectNoInput = $("[class='textt2']");
                            var subjectNameInput = $("[class='textt3']");
                            $(this).next().find(supplierAddressInput).coolautosuggest({
                                url:"<%=request.getContextPath()%>/finance/suggest/supplier/address/",
                                showProperty: 'address',
                                onSelected:function(result){
                                    if(result!=null){
                                        $(this).parent().parent().find("[name='supplier[id]']").val(result.id);
                                        $(this).parent().next().find("input").val(result.name);
                                    }
                                }
                            });

                            $(this).next().find(supplierAddressInput).blur(function () {
                                if ($(this).val()==""){
                                    $(this).parent().parent().find("[name='supplier[id]']").val("");
                                    $(this).parent().next().find("input").val("");
                                }
                            })

                            $(this).next().find(supplierNameInput).coolautosuggest({
                                url:"<%=request.getContextPath()%>/finance/suggest/supplier/name/",
                                showProperty: 'name',
                                onSelected:function(result){
                                    if(result!=null){
                                        $(this).parent().parent().find("[name='supplier[id]']").val(result.id);
                                        $(this).parent().prev().find("input").val(result.address);
                                    }
                                }
                            });

                            $(this).next().find(supplierNameInput).blur(function () {
                                if ($(this).val()==""){
                                    $(this).parent().parent().find("[name='supplier[id]']").val("");
                                    $(this).parent().prev().find("input").val("");
                                }
                            })

                            $(this).next().find(subjectNoInput).coolautosuggest({
                                url:"<%=request.getContextPath()%>/finance/suggest/subject/no/",
                                showProperty: 'no',
                                onSelected:function(result){
                                    if(result!=null){
                                        $(this).parent().siblings("input[name='subject[id]']").val(result.id);
                                        $(this).parent().next().find("input").val(result.name);
                                    }
                                }
                            });
                            // 科目编码失焦时，如果为空，则设置对应的科目名称也为空
                            $(this).next().find(subjectNoInput).blur(function () {
                                if ($(this).val() == ""){
                                    $(this).parent().siblings("input[name='subject[id]']").val("");
                                    $(this).parent().next().find("input").val("");
                                }
                            })
                            $(this).next().find(subjectNameInput).coolautosuggest({
                                url:"<%=request.getContextPath()%>/finance/suggest/subject/name/",
                                showProperty: 'name',
                                onSelected:function(result){
                                    if(result!=null){
                                        $(this).parent().siblings("input[name='subject[id]']").val(result.id);
                                        $(this).parent().prev().find("input").val(result.no);
                                    }
                                }
                            });
                        // 科目名称失焦时，如果为空，则设置对应的科目编码也为空
                        $(this).next().find(subjectNameInput).blur(function () {
                            if ($(this).val() == ""){
                                $(this).parent().siblings("input[name='subject[id]']").val("");
                                $(this).parent().prev().find("input").val("");
                            }
                        })
                        </c:if>
                    }
                }, {
                    text: "删行",
                    func: function(){
                        // 如果只剩下一行就不删除改行，而是将这行的数据清空
                        if ($(this).parent().find("tr").length == 1){
                            var inputs = $(this).parent().find("tr").find("input");
                            inputs.val("");
                        } else {
                            $(this).remove();
                        }
                    }
                }]
            ];
            $(this).smartMenu(imageMenuData,opertionn);
        }
    });

    $("#extendSet tbody").on("keypress","tr",function (e) {
        if (e.keyCode == 13) {
            <c:if test="${entity.id==2}">
            var tr = "<tr>"+
                "<td><input type='text' class='text1' name='account' /><input type='hidden' name='account[id]' value='' /></td>"+
                "<td><input type='text' class='text2' name='subjectNo' /></td>"+
                "<td><input type='text' class='text3' name='subjectName'  /></td>"+
                "<input type='hidden' name='subject[id]' value='' />"+
                "</tr>"
            $(this).after(tr);
            var accountInput = $("[class='text1']");
            var subjectNoInput = $("[class='text2']");
            var subjectNameInput = $("[class='text3']");
            $(this).next().find(accountInput).coolautosuggest({
                url:"<%=request.getContextPath()%>/finance/suggest/account/name/",
                showProperty: 'name',
                onSelected:function(result){
                    if(result!=null){
                        $(this).next().next().val(result.id);
                    }
                }
            });

            $(this).next().find(accountInput).blur(function () {
                if($(this).val()==""){
                    $(this).next().next().val("");
                }
            })

            $(this).next().find(subjectNoInput).coolautosuggest({
                url:"<%=request.getContextPath()%>/finance/suggest/subject/no/",
                showProperty: 'no',
                onSelected:function(result){
                    if(result!=null){
                        $(this).parent().next().next().val(result.id);
                        $(this).parent().next().find("input").val(result.name);
                    }
                }
            });
            // 科目编码失焦时，如果为空，则设置对应的科目名称也为空
            $(this).next().find(subjectNoInput).blur(function () {
                if ($(this).val() == ""){
                    $(this).parent().next().next().val("");
                    $(this).parent().next().find("input").val("");
                }
            })

            $(this).next().find(subjectNameInput).coolautosuggest({
                url:"<%=request.getContextPath()%>/finance/suggest/subject/name/",
                showProperty: 'name',
                onSelected:function(result){
                    if(result!=null){
                        $(this).parent().next().val(result.id);
                        $(this).parent().prev().find("input").val(result.no);
                    }
                }
            });
            // 科目名称失焦时，如果为空，则设置对应的科目编码也为空
            $(this).next().find(subjectNameInput).blur(function () {
                if ($(this).val() == ""){
                    $(this).parent().next().val("");
                    $(this).parent().prev().find("input").val("");
                }
            })
            </c:if>

            <c:if test="${entity.id==6}">
            var tr = "<tr>"+
                "<td><input type='text' class='text1' name='supplierAddress' /></td>"+
                "<td><input type='text' class='text2' name='supplierName' /></td>"+
                "<td><input type='text' class='textt2' name='subjectNo' /></td>"+
                "<td><input type='text' class='textt3' name='subjectName'  /></td>"+
                "<input type='hidden' name='supplier[id]' value='' />"+
                "<input type='hidden' name='subject[id]' value='' />"+
                "</tr>"
            $(this).after(tr);
            var supplierAddressInput = $("[class='text1']");
            var supplierNameInput = $("[class='text2']");
            var subjectNoInput = $("[class='textt2']");
            var subjectNameInput = $("[class='textt3']");
            $(this).next().find(supplierAddressInput).coolautosuggest({
                url:"<%=request.getContextPath()%>/finance/suggest/supplier/address/",
                showProperty: 'address',
                onSelected:function(result){
                    if(result!=null){
                        $(this).parent().parent().find("[name='supplier[id]']").val(result.id);
                        $(this).parent().next().find("input").val(result.name);
                    }
                }
            });

            $(this).next().find(supplierAddressInput).blur(function () {
                if ($(this).val()==""){
                    $(this).parent().parent().find("[name='supplier[id]']").val("");
                    $(this).parent().next().find("input").val("");
                }
            })

            $(this).next().find(supplierNameInput).coolautosuggest({
                url:"<%=request.getContextPath()%>/finance/suggest/supplier/name/",
                showProperty: 'name',
                onSelected:function(result){
                    if(result!=null){
                        $(this).parent().parent().find("[name='supplier[id]']").val(result.id);
                        $(this).parent().prev().find("input").val(result.address);
                    }
                }
            });

            $(this).next().find(supplierNameInput).blur(function () {
                if ($(this).val()==""){
                    $(this).parent().parent().find("[name='supplier[id]']").val("");
                    $(this).parent().prev().find("input").val("");
                }
            })

            $(this).next().find(subjectNoInput).coolautosuggest({
                url:"<%=request.getContextPath()%>/finance/suggest/subject/no/",
                showProperty: 'no',
                onSelected:function(result){
                    if(result!=null){
                        $(this).parent().siblings("input[name='subject[id]']").val(result.id);
                        $(this).parent().next().find("input").val(result.name);
                    }
                }
            });
            // 科目编码失焦时，如果为空，则设置对应的科目名称也为空
            $(this).next().find(subjectNoInput).blur(function () {
                if ($(this).val() == ""){
                    $(this).parent().siblings("input[name='subject[id]']").val("");
                    $(this).parent().next().find("input").val("");
                }
            })
            $(this).next().find(subjectNameInput).coolautosuggest({
                url:"<%=request.getContextPath()%>/finance/suggest/subject/name/",
                showProperty: 'name',
                onSelected:function(result){
                    if(result!=null){
                        $(this).parent().siblings("input[name='subject[id]']").val(result.id);
                        $(this).parent().prev().find("input").val(result.no);
                    }
                }
            });
            // 科目名称失焦时，如果为空，则设置对应的科目编码也为空
            $(this).next().find(subjectNameInput).blur(function () {
                if ($(this).val() == ""){
                    $(this).parent().siblings("input[name='subject[id]']").val("");
                    $(this).parent().prev().find("input").val("");
                }
            })
            </c:if>
        }
    });

    $("#send").click(function () {
        var json = '[';

        var trs = $("#extendSet tbody tr");

        for (var i = 0; i < trs.length; i++) {
            var inputs = $(trs[i]).find("input[type='hidden']:not([name='json'])");
            json += JSON.stringify(inputs.not('[value=""]').serializeJSON()) + ",";
        }

        json = json.substring(0, json.length-1) + ']';
        $('#form').sendData('<%=request.getContextPath()%>/finance/save/<c:if test="${entity.id==2}">bankSubjectExtend</c:if><c:if test="${entity.id==6}">purchaseSubjectExtend</c:if>',json);
    });

    document.title = "${entity.name}"+"扩展设置";
</script>