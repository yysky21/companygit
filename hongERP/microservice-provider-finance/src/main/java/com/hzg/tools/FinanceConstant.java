package com.hzg.tools;


/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: AuditFlowConstant.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/6/22
 */

public class FinanceConstant {

    // 凭证编号
    public final static String no = "no";

    // 采购退货实体
    public final static String returnproduct_purchase = "purchase";

    // 销售退货实体
    public final static String returnproduct_order = "order";

    // 制单人
    public final static String chartMaker = "chartMaker";

    // 岗位实体
    public final static String post = "post";

    // 单据类型
    public final static String purchase = "采购单";
    public final static String stockIn = "入库单";
    public final static String order = "销售订单";
    public final static String stockOut = "出库单";
    public final static String pay = "付款单";
    public final static String receipt = "收款单";
    public final static String transform = "形态转换单";
    public final static String damageStockOut = "报损出库单";

    //业务类型
    public final static String purchase_returnProduct = "采购退货";
    public final static String order_returnProduct = "销售退货";
    public final static String advance_receiptAmount = "预收款";
    public final static String advance_payAmount = "预付款";
    public final static String receiptAmount = "普通收款";
    public final static String payAmount = "普通付款";

    // 科目名称
    public final static String processRepair = "加工费/修补费";

}
