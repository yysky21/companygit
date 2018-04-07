package com.hzg.tools;


/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: AfterSaleServiceConstant.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/12/7
 */

public class AfterSaleServiceConstant {
    public final static String no_returnProduct_perfix = "RP";
    public final static String no_changeProduct_perfix = "CP";
    public final static String no_repairProduct_perfix = "EP";

    public final static String returnProduct = "returnProduct";

    public final static String returnProduct_action_name_returnProduct = "returnProduct";
    public final static String returnProduct_action_name_saleAudit = "returnProductSaleAudit";
    public final static String returnProduct_action_name_directorAudit = "returnProductDirectorAudit";
    public final static String returnProduct_action_name_warehousingAudit = "returnProductWarehousingAudit";
    public final static String returnProduct_action_name_purchase_returnProduct = "purchaseReturnProduct";
    public final static String returnProduct_action_name_purchase_audit = "purchaseReturnProductAudit";
    public final static String returnProduct_action_name_purchase_warehousingAudit = "purchaseReturnProductWarehouseAudit";
    public final static String returnProduct_action_name_purchase_supplierReceived = "purchaseReturnProductSupplierReceived";
    public final static String returnProduct_action_name_refund = "returnProductRefund";

    public final static Integer returnProduct_action_refund = 1;
    public final static Integer returnProduct_action_salePass = 3;
    public final static Integer returnProduct_action_saleNotPass = 31;
    public final static Integer returnProduct_action_directorPass = 4;
    public final static Integer returnProduct_action_directorNotPass = 41;
    public final static Integer returnProduct_action_warehousingPass = 5;
    public final static Integer returnProduct_action_warehousingNotPass = 51;
    public final static Integer returnProduct_action_purchase_purchasePass = 7;
    public final static Integer returnProduct_action_purchase_purchaseNotPass = 71;
    public final static Integer returnProduct_action_purchase_warehousingPass = 8;
    public final static Integer returnProduct_action_purchase_warehousingNotPass = 81;
    public final static Integer returnProduct_action_purchase_supplierPass = 9;
    public final static Integer returnProduct_action_purchase_supplierNotPass = 91;

    public final static Integer returnProduct_state_apply = 0;
    public final static Integer returnProduct_state_refund = 1;
    public final static Integer returnProduct_state_cancel = 2;
    public final static Integer returnProduct_state_salePass = 3;
    public final static Integer returnProduct_state_saleNotPass = 31;
    public final static Integer returnProduct_state_directorPass = 4;
    public final static Integer returnProduct_state_directorNotPass = 41;
    public final static Integer returnProduct_state_warehousingPass = 5;
    public final static Integer returnProduct_state_warehousingNotPass = 51;
    public final static Integer returnProduct_purchase_state_apply = 6;
    public final static Integer returnProduct_purchase_state_refund = 61;
    public final static Integer returnProduct_purchase_state_cancel = 62;
    public final static Integer returnProduct_state_purchase_purchasePass = 7;
    public final static Integer returnProduct_state_purchase_purchaseNotPass = 71;
    public final static Integer returnProduct_state_purchase_warehousingPass = 8;
    public final static Integer returnProduct_state_purchase_warehousingNotPass = 81;
    public final static Integer returnProduct_state_purchase_supplierPass = 9;
    public final static Integer returnProduct_state_purchase_supplierNotPass = 91;

    public final static Integer returnProduct_detail_state_unReturn = 0;
    public final static Integer returnProduct_detail_state_returned = 1;
    public final static Integer returnProduct_detail_state_cannotReturn = 2;


    public final static String changeProduct = "changeProduct";

    public final static String changeProduct_action_name_changeProduct = "changeProduct";
    public final static String changeProduct_action_name_saleAudit = "changeProductSaleAudit";
    public final static String changeProduct_action_name_directorAudit = "changeProductDirectorAudit";
    public final static String changeProduct_action_name_warehousingAudit = "changeProductWarehousingAudit";
    public final static String changeProduct_action_name_changeProductComplete = "changeProductComplete";

    public final static Integer changeProduct_detail_type_changeProduct = 0;
    public final static Integer changeProduct_detail_type_returnProduct = 1;

    public final static Integer changeProduct_action_complete = 1;
    public final static Integer changeProduct_action_salePass = 3;
    public final static Integer changeProduct_action_saleNotPass = 31;
    public final static Integer changeProduct_action_directorPass = 4;
    public final static Integer changeProduct_action_directorNotPass = 41;
    public final static Integer changeProduct_action_warehousingPass = 5;
    public final static Integer changeProduct_action_warehousingNotPass = 51;

    public final static Integer changeProduct_state_apply = 0;
    public final static Integer changeProduct_state_complete = 1;
    public final static Integer changeProduct_state_cancel = 2;
    public final static Integer changeProduct_state_salePass = 3;
    public final static Integer changeProduct_state_saleNotPass = 31;
    public final static Integer changeProduct_state_directorPass = 4;
    public final static Integer changeProduct_state_directorNotPass = 41;
    public final static Integer changeProduct_state_warehousingPass = 5;
    public final static Integer changeProduct_state_warehousingNotPass = 51;

    public final static Integer changeProduct_detail_state_todo = 0;
    public final static Integer changeProduct_detail_state_done = 1;
    public final static Integer changeProduct_detail_state_undo = 2;

    public final static String action_remark_changeProduct_refund = "换货被退商品退款";
    public final static String action_remark_changeProduct_returnProduct_reason = "换货被退商品退货";


    public final static String repairProduct = "repairProduct";

    public final static String repairProduct_action_name_repairProduct = "repairProduct";
    public final static String repairProduct_action_name_saleAudit = "repairProductSaleAudit";
    public final static String repairProduct_action_name_directorAudit = "repairProductDirectorAudit";
    public final static String repairProduct_action_name_warehousingAudit = "repairProductWarehousingAudit";
    public final static String repairProduct_action_name_paid = "repairProductPaid";
    public final static String repairProduct_action_name_complete = "repairProductComplete";

    public final static Integer repairProduct_action_paid = 1;
    public final static Integer repairProduct_action_salePass = 3;
    public final static Integer repairProduct_action_saleNotPass = 31;
    public final static Integer repairProduct_action_directorPass = 4;
    public final static Integer repairProduct_action_directorNotPass = 41;
    public final static Integer repairProduct_action_warehousingPass = 5;
    public final static Integer repairProduct_action_warehousingNotPass = 51;
    public final static Integer repairProduct_action_complete= 6;

    public final static Integer repairProduct_state_apply = 0;
    public final static Integer repairProduct_state_paid = 1;
    public final static Integer repairProduct_state_cancel = 2;
    public final static Integer repairProduct_state_salePass = 3;
    public final static Integer repairProduct_state_saleNotPass = 31;
    public final static Integer repairProduct_state_directorPass = 4;
    public final static Integer repairProduct_state_directorNotPass = 41;
    public final static Integer repairProduct_state_warehousingPass = 5;
    public final static Integer repairProduct_state_warehousingNotPass = 51;
    public final static Integer repairProduct_state_complete = 6;

    public final static Integer repairProduct_detail_state_unrepair = 0;
    public final static Integer repairProduct_detail_state_repaired = 1;
    public final static Integer repairProduct_detail_state_cannotRepair = 2;

    public final static String action_name_print_expressWaybill = "expressWaybill";
    public final static Integer action_print_expressWaybill = 7;
}
