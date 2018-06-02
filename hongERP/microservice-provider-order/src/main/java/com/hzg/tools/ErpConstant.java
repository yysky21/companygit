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

public class ErpConstant {

    public final static String no_purchase_perfix = "CG";

    public final static String product = "product";
    public final static String purchase = "purchase";

    public final static String product_id = "productId";
    public final static String product_no = "productNo";
    public final static String stock_quantity = "stockQuantity";
    public final static String product_onSale_quantity = "productOnSaleQuantity";
    public final static String product_sold_quantity = "productSoldQuantity";
    public final static String product_onReturn_quantity = "productOnReturnQuantity";
    public final static String product_returned_quantity = "productReturnedQuantity";
    public final static String product_onChange_quantity = "productOnChangeQuantity";
    public final static String product_changed_quantity = "productChangedQuantity";
    public final static String product_onRepair_quantity = "productOnRepairQuantity";
    public final static String product_repaired_quantity = "productRepairedQuantity";

    public final static String price = "price";

    public final static Integer product_price_change_state_use = 1;

    public final static String no_stockInOut_perfix = "RC";
    public final static Integer stockInOut_type_returnProduct = 7;
    public final static Integer stockInOut_type_normal_outWarehouse = 11;
    public final static Integer stockInOut_state_finished = 1;

    public final static Integer product_state_stockIn = 1;
    public final static Integer product_state_stockIn_part = 12;
    public final static Integer product_state_purchase_close = 11;
    public final static Integer product_state_stockOut = 2;
    public final static Integer product_state_stockOut_part = 21;
    public final static Integer product_state_onSale = 3;
    public final static Integer product_state_sold = 4;
    public final static Integer product_state_sold_part = 41;
    public final static Integer product_state_shipped = 8;
    public final static Integer product_state_shipped_part = 81;
    public final static Integer product_state_repairedProduct = 87;
    public final static Integer product_state_onRepairProduct_part = 88;
    public final static Integer product_state_repairedProduct_part = 89;
    public final static Integer product_state_onReturnProduct_part = 94;
    public final static Integer product_state_onChangeOnReturnProduct_part = 99;
    public final static Integer product_state_returnedProduct = 91;
    public final static Integer product_state_returnedProduct_part = 95;

    public final static String product_use_type_acc = "acc";

    public final static String deliver_sfExpress = "顺丰快递";
    public final static String deliver_sfExpress_type = "顺丰标快";

    public final static Integer express_state_sending = 0;
    public final static Integer express_state_sended = 1;
    public final static Integer express_state_send_fail = 2;

    public final static Integer express_detail_state_unSend = 0;
    public final static Integer express_detail_state_sended = 1;
    public final static Integer express_detail_state_received = 2;
    public final static Integer express_detail_state_receive_fail = 3;

    public final static String stockOut = "stockOut";
    public final static Integer stockInOut_type_process = 3;

    public final static String product_action_name_setProductsSold = "setProductsSold";
    public final static String product_action_name_setProductsOnReturn = "setProductsOnReturn";
    public final static String product_action_name_setProductsReturned = "setProductsReturned";
    public final static String product_action_name_setPurchaseProductsOnReturn = "setPurchaseProductsOnReturn";
    public final static String product_action_name_setPurchaseProductsReturned = "setPurchaseProductsReturned";
    public final static String product_action_name_setProductsOnChange = "setProductsOnChange";
    public final static String product_action_name_setProductsOnChangeOnReturn = "setProductsOnChangeOnReturn";
    public final static String product_action_name_setProductsChanged = "setProductsChanged";
    public final static String product_action_name_setProductsOnRepair = "setProductsOnRepair";
    public final static String product_action_name_setProductsRepaired = "setProductsRepaired";
    public final static String stockInOut_action_name_inProduct = "stockInProduct";
    public final static String stockInOut_action_name_outProduct = "stockOutProduct";
    public final static String product_action_name_upShelf = "upShelfProduct";
    public final static String product_action_name_recoverState = "recoverState";
    public final static String product_action_name_setProductEdit = "setProductEdit";

    public final static String unit_g = "克";
    public final static String unit_kg = "千克";
    public final static String unit_ct = "克拉";
    public final static String unit_oz = "盎司";

    public final static Integer purchase_type_deposit = 4;
}
