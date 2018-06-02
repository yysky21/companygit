<%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: borrowProduct.jsp
*
* @author smjie
* @Date  2018/4/2
* @version 1.00
*
--%>
<%@ page import="com.hzg.erp.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- page content -->
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3>借货</h3>
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
                        <h2>借货</h2>
                        <div class="clearfix"></div>
                    </div>

                    <form class="form-horizontal form-label-left" novalidate id="form">
                    <div class="x_content">
                        <span class="section">借货信息</span>
                        <div class="item form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="no">借货单号 <span class="required">*</span>
                            </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input id="no" name="no" value="<c:choose><c:when test="${entity != null}">${entity.no}</c:when><c:otherwise>${no}</c:otherwise></c:choose>" class="form-control col-md-7 col-xs-12" readonly required>
                            </div>
                        </div>
                       <c:if test="${entity != null}">
                        <div class="item form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">状态 <span class="required">*</span></label>
                            <div class="col-md-6 col-sm-6 col-xs-12"><input name="stateName" type="text" value="${entity.stateName}" class="form-control col-md-7 col-xs-12" required></div>
                        </div>
                       </c:if>
                        <div class="item form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="describes">描述 <span class="required">*</span>
                            </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <textarea id="describes" name="describes" class="form-control col-md-7 col-xs-12" data-validate-length-range="6,256" data-validate-words="1"required>${entity.describes}</textarea>
                            </div>
                        </div>
                        <c:if test="${(entity == null) || (entity != null && entity.state == 0)}">
                        <div class="item form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">商品编号<span class="required">*</span></label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" id="text1" name="text1" class="form-control col-md-7 col-xs-12" style="width:40%" placeholder="选择编号添加借货条目" />
                            </div>
                        </div>
                        </c:if>
                        <c:if test="${entity != null}"><input type="hidden" id="id" name="id" value="${entity.id}"></c:if>
                        <input type="hidden" name="sessionId" value="${sessionId}">
                    </div>
                    </form>

                    <div class="x_content" style="overflow: auto;margin-top: 30px">
                        <table id="productList" class="table-sheet" width="100%">
                            <thead><tr><th>商品名称</th><th>编号</th><th>借货数量</th><th>单位</th><c:if test="${entity != null}"><th>状态</th></c:if></tr></thead>
                            <tbody id="tbody">
                            <c:if test="${entity != null}">
                                <c:forEach items="${entity.details}" var="detail">
                                 <tr id="tr${detail.id}">
                                     <td>${detail.product.name}</td>
                                     <td><input type="text" name="details[][productNo]:string" value="${detail.productNo}" required readonly></td>
                                     <td><input type="text" name="details[][quantity]:number" value="${detail.quantity}" required></td>
                                     <td><input type="text" name="details[][unit]:string" value="${detail.unit}" required readonly></td>
                                     <td><input type="text" name="details[][unit]:string" value="${detail.stateName}" required readonly></td>
                                 </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                    </div>


                    <c:if test="${entity != null && !empty entity.actions}">
                    <div class="x_content">
                        <span class="section" style="margin-top: 40px">借货审核记录</span>
                        <div class="item form-group" style="margin-top:20px;">
                            <div class="col-md-6 col-sm-6 col-xs-12" style="width:1400px;margin-left: 150px;margin-top: 10px">
                                <table class="table-sheet">
                                    <thead><tr><th>审核人</th><th>审核时间</th><th>审核结果</th><th>备注</th></tr></thead>
                                    <tbody>
                                    <c:forEach items="${entity.actions}" var="action">
                                        <tr>
                                            <td style="width: 120px">${action.inputer.name}</td>
                                            <td style="width: 120px">${action.inputDate}</td>
                                            <td style="width: 200px">${action.typeName}</td>
                                            <td style="width: 250px">${action.remark}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    </c:if>

                    <c:if test="${(entity == null) || (entity != null && entity.state == 0)}">
                    <div class="x_content">
                        <div id="delDiv" class="form-group">
                            <div class="col-md-6 col-md-offset-0" style="margin-top: 10px">
                                <button id="delItem" type="button" class="btn btn-success">减少条目</button>
                            </div>
                        </div>
                    </div>
                    </c:if>

                    <c:if test="${entity != null && entity.state == 1 && fn:contains(resources, '/erp/doBusiness/borrowProductWarehousingAudit')}">
                        <div class="x_content">
                            <span class="section" style="margin-top: 40px">审核</span>
                            <div class="item form-group" style="margin-top:20px;">
                                <div class="col-md-6 col-sm-6 col-xs-12" style="margin-left: 150px;margin-top: 10px">
                                    <form id="actionForm">
                                        <div class="item form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" style="width: 80px" for="remark">批语 <span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12"><textarea class="form-control col-md-7 col-xs-12" style="width: 600px" id="remark" name="remark" required></textarea></div>
                                        </div>
                                        <input type="hidden" name="auditResult" id="auditResult">
                                        <input type="hidden" name="entityId:number" id="entityId" value="${entity.id}">
                                        <input type="hidden" name="sessionId" value="${sessionId}">
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <div class="x_content">
                        <div class="form-horizontal form-label-left">

                            <div class="ln_solid"></div>
                            <div class="form-group" id="submitDiv">
                                <div class="col-md-3 col-md-offset-9">
                                    <button id="return" type="button" class="btn btn-primary">返回</button>
                                    <c:if test="${entity == null}">
                                    <c:if test="${fn:contains(resources, '/erp/save/borrowProduct')}">
                                    <button id="saveBorrowProduct" type="button" class="btn btn-success">保存</button>
                                    </c:if>
                                    <c:if test="${fn:contains(resources, '/erp/doBusiness/applyBorrowProduct')}">
                                    <button id="applyBorrowProduct" type="button" class="btn btn-success">提交申请</button>
                                    </c:if>
                                    </c:if>
                                    <c:if test="${entity != null}">
                                    <c:if test="${entity.state == 0}">
                                    <c:if test="${fn:contains(resources, '/erp/doBusiness/applyBorrowProduct')}">
                                    <button id="applyBorrowProduct" type="button" class="btn btn-success">提交申请</button>
                                    </c:if>
                                    <c:if test="${fn:contains(resources, '/erp/update/borrowProduct')}">
                                    <button id="updateBorrowProduct" type="button" class="btn btn-success">修改</button>
                                    <button id="edit" type="button" class="btn btn-primary">编辑</button>
                                    </c:if>
                                    <c:if test="${fn:contains(resources, '/erp/delete/borrowProduct')}">
                                    <button id="cancelBorrowProduct" type="button" class="btn btn-success">取消</button>
                                    </c:if>
                                    </c:if>
                                    <c:if test="${entity.state == 1}">
                                    <c:if test="${fn:contains(resources, '/erp/doBusiness/borrowProductWarehousingAudit')}">
                                    <button id="completeBorrowProduct" type="button" class="btn btn-success">借货完成</button>
                                    <button id="cannotBorrowProduct" type="button" class="btn btn-danger">不可借</button>
                                    </c:if>
                                    </c:if>
                                    </c:if>
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
    init(<c:out value="${entity == null}"/>);

    <c:if test="${entity == null}">
        <c:if test="${fn:contains(resources, '/erp/doBusiness/applyBorrowProduct')}">
            $("#applyBorrowProduct").click(function(){
                var json = '{"id":' + $("#id").val() +'}';
                $('#form').sendData('<%=request.getContextPath()%>/erp/doBusiness/applyBorrowProduct', json, function(result){
                    if (result.result.indexOf("success") != -1) {
                        $("#saveBorrowProduct").attr('disabled', true);
                    }
                });
            }).hide();
        </c:if>

        <c:if test="${fn:contains(resources, '/erp/save/borrowProduct')}">
            $("#saveBorrowProduct").click(function(){
                var json = getData();
                if (json != null) {
                    $('#form').sendData('<%=request.getContextPath()%>/erp/save/borrowProduct', json, function(result){
                        $("#form").append("<input type='hidden' name='id' id='id' value='" + result.id + "'>");
                        $("#applyBorrowProduct").show();
                    });
                }
            });
        </c:if>
    </c:if>

    <c:if test="${entity != null && entity.state == 0}">
        <c:if test="${fn:contains(resources, '/erp/doBusiness/applyBorrowProduct')}">
            $("#applyBorrowProduct").click(function(){
                $('#form').sendData('<%=request.getContextPath()%>/erp/doBusiness/applyBorrowProduct', '{"id":${entity.id}}', function(result){
                    if (result.result.indexOf("success") != -1) {
                        $("#updateBorrowProduct").attr('disabled', true);
                        $("#cancelBorrowProduct").attr('disabled', true);
                    }
                });
            });
        </c:if>

        <c:if test="${fn:contains(resources, '/erp/update/borrowProduct')}">
            $("#updateBorrowProduct").click(function(){
                var json = getData();
                if (json != null) {
                    $('#form').sendData('<%=request.getContextPath()%>/erp/update/borrowProduct', json);
                }
            });

            $("#edit").click(function(){
                $("#updateBorrowProduct").attr('disabled', false);
                $("#cancelBorrowProduct").attr('disabled', false);
                $("#applyBorrowProduct").attr('disabled', false);
            });
        </c:if>

        <c:if test="${fn:contains(resources, '/erp/delete/borrowProduct')}">
            $("#cancelBorrowProduct").click(function(){
                if (confirm("确定取消借货单吗？")) {
                    $('#form').sendData('<%=request.getContextPath()%>/erp/delete/borrowProduct', '{"id":${entity.id}}', function(result){
                        if (result.result.indexOf("success") != -1) {
                            $("#updateBorrowProduct").attr('disabled',true);
                            $("#applyBorrowProduct").attr('disabled',true);
                        }
                    });
                }
            });
        </c:if>

        $("#updateBorrowProduct").attr('disabled', true);
        $("#cancelBorrowProduct").attr('disabled', true);
        $("#applyBorrowProduct").attr('disabled', true);
    </c:if>

    <c:if test="${entity != null && entity.state == 1}">
        <c:if test="${fn:contains(resources, '/erp/doBusiness/borrowProductWarehousingAudit')}">
            $("#completeBorrowProduct").click(function(){
                $("#auditResult").val('Y');
                $('#actionForm').submitForm('<%=request.getContextPath()%>/erp/doBusiness/borrowProductWarehousingAudit');
            });

            $("#cannotBorrowProduct").click(function(){
                $("#auditResult").val('N');
                $('#actionForm').submitForm('<%=request.getContextPath()%>/erp/doBusiness/borrowProductWarehousingAudit');
            });
        </c:if>
    </c:if>

    $("#text1").coolautosuggestm({
        url:"<%=request.getContextPath()%>/erp/privateQuery/<%=Product.class.getSimpleName().toLowerCase()%>",
        width : 309,
        marginTop : "margin-top:34px",
        showProperty: "no",
        relateShowProperty: {"no" : ["id"]},

        getQueryData: function(paramName){
            var queryJson = {};

            var suggestWord = $.trim(this.value);
            if (suggestWord != "") {
                queryJson["no"] = suggestWord;
            }

            return queryJson;
        },

        onSelected:function(result){
            if(result!=null){
                addItem($("#tbody"), result);
            }
        }

    });

    function addItem(tbody, item) {
        if (document.getElementById("tr" + item.id) == null) {
            tbody.append("<tr id='tr" + item.id + "'><td>" + item.name + "</td>" +
                "<td><input type='text' name='details[][productNo]:string' value='" + item.no + "' required readonly></td>" +
                "<td><input type='text' name='details[][quantity]:number' value='1' required></td>" +
                "<td><input type='text' name='details[][unit]:string' value='" + item.unit + "' required readonly></td>" +
                "</tr>");
        }
    }

    $("#delItem").click(function(){
        var lastTr = $("#productList tbody tr:last-child");

        if (lastTr.html().indexOf('<td>') != -1) {
            var idSuffix = lastTr.attr("id").substring(2);
            document.getElementById("tbody").removeChild(document.getElementById("tr"+idSuffix));
        }
    });

    function getData() {
        var $form = $("#form");
        if (!validator.checkAll($form)) {
            return null;
        }

        var json = JSON.stringify($form.serializeJSON());
        json = json.substring(0, json.length-1) + ',"details":[';

        var trs = $("#productList tbody tr");
        for (var i = 0; i < trs.length; i++) {
            var textInputs = $(trs[i]).find("input");
            var tds = $(trs[i]).find("td");

            if (tds.length > 0) {
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

        if (json.substring(json.length-1) == "[") {
            alert("请输要借货的商品");
            return null;

        } else {
            json = json.substring(0, json.length-1) + ']}';
        }

        return json;
    }

    document.title = "借货";
</script>