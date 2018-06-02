<%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: account.jsp
*
* @author smjie
* @Date  2017/7/5
* @version 1.00
*
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- page content -->
<div class="right_col" role="main">
    <div class="">
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>支付管理 <small>支付记录明细</small></h2>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <form class="form-horizontal form-label-left" novalidate id="form">
                            <span class="section">支付记录明细信息</span>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="no">支付号 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="no" class="form-control col-md-7 col-xs-12" value="${entity.no}" name="no" readonly type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="docType">单据类型 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="docType" class="form-control col-md-7 col-xs-12"
                                           <c:if test="${entity.entity.toLowerCase() == 'purchase'}">value="采购单" </c:if>
                                           <c:if test="${entity.entity.toLowerCase() == 'order'}">value="销售订单" </c:if>
                                           <c:if test="${entity.entity.toLowerCase() == 'changeproduct'}">value="换货单" </c:if>
                                           <c:if test="${entity.entity.toLowerCase() == 'repairproduct'}">value="修补单" </c:if>
                                           name="docType"  required type="text" readonly>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="entityNo">单据编号 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="entityNo" class="form-control col-md-7 col-xs-12" value="${entity.entityNo}" name="entityNo" readonly type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="state">状态 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="state" class="form-control col-md-7 col-xs-12"
                                           <c:if test="${entity.state == 0}">value="未支付" </c:if>
                                           <c:if test="${entity.state == 1}">value="已支付" </c:if>
                                           <c:if test="${entity.state == 2}">value="支付失败" </c:if>
                                           name="state" readonly type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="amount">金额 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="amount" class="form-control col-md-7 col-xs-12" value="${entity.amount}" name="amount" readonly type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="payDate">支付时间 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="payDate" class="form-control col-md-7 col-xs-12" value="${entity.payDate}" name="payDate" readonly type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="payType">支付类型 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="payType" class="form-control col-md-7 col-xs-12"
                                           <c:if test="${entity.payType == 0}">value="现金" </c:if>
                                           <c:if test="${entity.payType == 1}">value="网上支付" </c:if>
                                           <c:if test="${entity.payType == 2}">value="扫描支付" </c:if>
                                           <c:if test="${entity.payType == 3}">value="汇款" </c:if>
                                           <c:if test="${entity.payType == 4}">value="银行转账" </c:if>
                                           <c:if test="${entity.payType == 5}">value="其他" </c:if>
                                           <c:if test="${entity.payType == 6}">value="支付宝转账" </c:if>
                                           <c:if test="${entity.payType == 7}">value="微信转账" </c:if>
                                           name="payType" readonly type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="payAccount">支付账号 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="payAccount" class="form-control col-md-7 col-xs-12" value="${entity.payAccount}" name="payAccount" readonly type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="payBank">支付银行 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="payBank" class="form-control col-md-7 col-xs-12" value="${entity.payBank}" name="payBank" readonly type="text">
                                </div>
                            </div>
                            <c:if test="${entity.balanceType == '1'}">
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="payBranch">支付开户行 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="payBranch" class="form-control col-md-7 col-xs-12" value="${entity.payBranch}" name="payBranch" readonly type="text">
                                </div>
                            </div>
                            </c:if>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="bankBillNo">银行流水号 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="bankBillNo" class="form-control col-md-7 col-xs-12" value="${entity.bankBillNo}" name="bankBillNo" readonly type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="receiptAccount">收款账号 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="receiptAccount" class="form-control col-md-7 col-xs-12" value="${entity.receiptAccount}" name="receiptAccount" readonly type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="receiptBank">收款银行 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="receiptBank" class="form-control col-md-7 col-xs-12" value="${entity.receiptBank}" name="receiptBank" readonly type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="receiptBranch">收款开户行 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="receiptBranch" class="form-control col-md-7 col-xs-12" value="${entity.receiptBranch}" name="receiptBranch" readonly type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="inputDate">支付记录生成时间 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="inputDate" class="form-control col-md-7 col-xs-12" value="${entity.inputDate}" name="inputDate" readonly type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="balanceType">收支类型 </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="balanceType" class="form-control col-md-7 col-xs-12"
                                           <c:if test="${entity.balanceType == 0}">value="收入" </c:if>
                                           <c:if test="${entity.balanceType == 1}">value="支出" </c:if>
                                           name="balanceType" readonly type="text">
                                </div>
                            </div>
                            <div class="ln_solid"></div>
                            <div class="form-group">
                                <div class="col-md-6 col-md-offset-3">
                                    <button id="cancel" type="button" class="btn btn-primary">返回</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /page content -->
<script type="text/javascript">
    init(<c:out value="${entity == null}"/>);
    document.title = "支付记录明细";
</script>