<%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: borrowProductReturn.jsp
*
* @author smjie
* @Date  2018/4/4
* @version 1.00
*
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--jquery ui--%>
<link type="text/css" href="../../../res/css/jquery-ui-1.10.0.custom.css" rel="stylesheet">
<!-- page content -->
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3>还货</h3>
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
                        <h2>还货</h2>
                        <div class="clearfix"></div>
                    </div>

                    <form class="form-horizontal form-label-left" novalidate id="form">
                    <div class="x_content">
                        <span class="section">还货信息</span>
                        <div class="item form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="no">还货单号 <span class="required">*</span>
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
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">借货单编号<span class="required">*</span></label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" id="text1" name="text1" class="form-control col-md-7 col-xs-12" style="width:40%" placeholder="选择编号添加还货条目" />
                            </div>
                        </div>
                        </c:if>
                        <c:if test="${entity != null}"><input type="hidden" id="id" name="id" value="${entity.id}"></c:if>
                        <input type="hidden" name="sessionId" value="${sessionId}">
                    </div>
                    </form>

                    <div class="x_content" style="overflow: auto;margin-top: 30px">
                        <table id="productList" class="table-sheet" width="100%">
                            <thead><tr><c:if test="${(entity == null) || (entity != null && entity.state == 0)}"><th>选择</th></c:if><th>编号</th><th>还货数量</th><th>单位</th></tr></thead>
                            <tbody id="tbody">
                            <c:if test="${entity != null}">
                                <c:forEach items="${entity.details}" var="detail">
                                 <tr id="tr${detail.id}">
                                     <c:if test="${entity.state == 0}"><td align="center"><input type="checkbox" data-property-name="borrowDetailId" name="details[][borrowProductDetail[id]]" value="${detail.borrowProductDetail.id}" class="flat" checked></td></c:if>
                                     <td><input type="text" name="details[][productNo]:string" value="${detail.productNo}" required readonly></td>
                                     <td><input type="text" name="details[][quantity]:number" value="${detail.quantity}" required></td>
                                     <td><input type="text" name="details[][unit]:string" value="${detail.unit}" required readonly></td>
                                 </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                    </div>


                    <c:if test="${entity != null && !empty entity.actions}">
                    <div class="x_content">
                        <span class="section" style="margin-top: 40px">还货审核记录</span>
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

                    <c:if test="${entity != null && entity.state == 1 && fn:contains(resources, '/erp/doBusiness/borrowProductReturnWarehousingAudit')}">
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
                                    <c:if test="${fn:contains(resources, '/erp/save/borrowProductReturn')}">
                                    <button id="saveBorrowProduct" type="button" class="btn btn-success">保存</button>
                                    </c:if>
                                    </c:if>
                                    <c:if test="${entity != null}">
                                    <c:if test="${entity.state == 0}">
                                    <c:if test="${fn:contains(resources, '/erp/doBusiness/applyBorrowProductReturn')}">
                                    <button id="applyBorrowProduct" type="button" class="btn btn-success">提交申请</button>
                                    </c:if>
                                    <c:if test="${fn:contains(resources, '/erp/update/borrowProductReturn')}">
                                    <button id="updateBorrowProduct" type="button" class="btn btn-success">修改</button>
                                    </c:if>
                                    <c:if test="${fn:contains(resources, '/erp/delete/borrowProductReturn')}">
                                    <button id="cancelBorrowProduct" type="button" class="btn btn-success">取消</button>
                                    </c:if>
                                    </c:if>
                                    <c:if test="${entity.state == 1}">
                                    <c:if test="${fn:contains(resources, '/erp/doBusiness/borrowProductReturnWarehousingAudit')}">
                                    <button id="completeBorrowProduct" type="button" class="btn btn-success">还货完成</button>
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
        <c:if test="${fn:contains(resources, '/erp/save/borrowProductReturn')}">
            $("#saveBorrowProduct").click(function(){
                var json = getData();
                if (json != null) {
                    $('#form').sendData('<%=request.getContextPath()%>/erp/save/borrowProductReturn', json);
                }
            });
        </c:if>
    </c:if>

    <c:if test="${entity != null && entity.state == 0}">
        <c:if test="${fn:contains(resources, '/erp/doBusiness/applyBorrowProductReturn')}">
            $("#applyBorrowProduct").click(function(){
                $('#form').sendData('<%=request.getContextPath()%>/erp/doBusiness/applyBorrowProductReturn', '{"id":${entity.id}}', function(result){
                    if (result.result.indexOf("success") != -1) {
                        $("#updateBorrowProduct").attr('disabled', "true");
                        $("#cancelBorrowProduct").attr('disabled', "true");
                    }
                });
            });

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
            });
        </c:if>

        <c:if test="${fn:contains(resources, '/erp/update/borrowProductReturn')}">
            $("#updateBorrowProduct").click(function(){
                var json = getData();
                if (json != null) {
                    $('#form').sendData('<%=request.getContextPath()%>/erp/update/borrowProductReturn', json);
                }
            });
        </c:if>

        <c:if test="${fn:contains(resources, '/erp/delete/borrowProductReturn')}">
            $("#cancelBorrowProduct").click(function(){
                if (confirm("确定取消还货单吗？")) {
                    $('#form').sendData('<%=request.getContextPath()%>/erp/delete/borrowProductReturn', '{"id":${entity.id}}', function(result){
                        if (result.result.indexOf("success") != -1) {
                            $("#updateBorrowProduct").attr('disabled',"true");
                            $("#applyBorrowProduct").attr('disabled',"true");
                        }
                    });
                }
            });
        </c:if>
    </c:if>

    <c:if test="${entity != null && entity.state == 1}">
        <c:if test="${fn:contains(resources, '/erp/doBusiness/borrowProductReturnWarehousingAudit')}">
            $("#completeBorrowProduct").click(function(){
                $("#auditResult").val('Y');
                $('#actionForm').submitForm('<%=request.getContextPath()%>/erp/doBusiness/borrowProductReturnWarehousingAudit');
            });

            $("#cannotBorrowProduct").click(function(){
                $("#auditResult").val('N');
                $('#actionForm').submitForm('<%=request.getContextPath()%>/erp/doBusiness/borrowProductReturnWarehousingAudit');
            });
        </c:if>
    </c:if>

    $("#text1").coolautosuggest({
        url:"<%=request.getContextPath()%>/erp/suggest/borrowProduct/no/",
        width : 309,
        marginTop : "margin-top:4px",
        showProperty: "no",

        onSelected:function(result){
            if(result!=null){
                addItem($("#tbody"), result);
            }
        }

    });

    function addItem(tbody, item) {
        for (var key in item.details) {
            if (document.getElementById("tr" + item.details[key].id) == null) {
                tbody.append("<tr id='tr" + item.details[key].id + "'>" +
                    "<td align='center'><input type='checkbox' id='ch" + item.details[key].id + "' name='details[][borrowProductDetail[id]]' value='" + item.details[key].id + "' class='flat' checked></td>" +
                    "<td><input type='text' name='details[][productNo]:string' value='" + item.details[key].productNo + "' required readonly></td>" +
                    "<td><input type='text' name='details[][quantity]:number' value='" + item.details[key].quantity + "' required></td>" +
                    "<td><input type='text' name='details[][unit]:string' value='" + item.details[key].unit + "' required readonly></td>" +
                    "</tr>");

                $('#ch' + item.details[key].id).iCheck({
                    checkboxClass: 'icheckbox_flat-green',
                    radioClass: 'iradio_flat-green'
                }).on("ifClicked",function(event){
                    var theICheck = $(this);
                    if(event.target.checked){
                        theICheck.iCheck('uncheck');
                    }else{
                        theICheck.iCheck('check');
                    }
                });
            }
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
                if ($(trs[i]).find('input.flat')[0].checked) {
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
            alert("请输要还货的商品");
            return null;

        } else {
            json = json.substring(0, json.length-1) + ']}';
        }

        return json;
    }

    document.title = "还货";
</script>