package com.hzg.tools;

import com.google.gson.reflect.TypeToken;
import com.hzg.erp.*;
import com.hzg.finance.FinanceClient;
import com.hzg.finance.Voucher;
import com.hzg.sys.Audit;
import com.hzg.sys.SysClient;
import com.hzg.sys.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: ViewData.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/7/20
 */
@Component
public class RenderHtmlData {

    @Autowired
    private SysClient sysClient;

    @Autowired
    private ErpClient erpClient;

    @Autowired
    private FinanceClient financeClient;

    @Autowired
    private Writer writer;

    public String getRefuseUserOptions(User currentUser, List<Audit> audits, String refuseUserOptions, int deep) {

        for (int i = 0; i < audits.size(); i++) {
            if (audits.get(i).getUser() != null &&
                    !refuseUserOptions.contains("'" + audits.get(i).getUser().getId() + "'") &&
                    audits.get(i).getUser().getId().compareTo(currentUser.getId()) != 0) {

                refuseUserOptions += "<option value='" + audits.get(i).getUser().getId() + "'>" + audits.get(i).getUser().getName() + "</option>";
            }
        }

        /**
         * 添加发起人
         */
        if (audits.get(0).getEntity().equals(AuditFlowConstant.business_purchase) ||
                audits.get(0).getEntity().equalsIgnoreCase(AuditFlowConstant.business_purchaseEmergency)) {

            List<Purchase> purchases = writer.gson.fromJson(erpClient.query(Purchase.class.getSimpleName().toLowerCase(),
                    "{\"id\":" + audits.get(0).getEntityId() + "}"),
                    new TypeToken<List<Purchase>>() {}.getType());

            if (!refuseUserOptions.contains("'" +  purchases.get(0).getInputer().getId() + "'") &&
                    purchases.get(0).getInputer().getId().compareTo(currentUser.getId()) != 0) {
                refuseUserOptions = "<option value='" + purchases.get(0).getInputer().getId() + "'>" + purchases.get(0).getInputer().getName() + "</option>"
                        + refuseUserOptions;
            }

        } else if (audits.get(0).getEntity().equals(AuditFlowConstant.business_product)) {
            List<Product> products = writer.gson.fromJson(erpClient.query(Product.class.getSimpleName().toLowerCase(),
                    "{\"id\":" + audits.get(0).getEntityId() + "}"),
                    new TypeToken<List<Product>>() {}.getType());

            List<ProductDescribe> describes = writer.gson.fromJson(erpClient.query(ProductDescribe.class.getSimpleName().toLowerCase(),
                    "{\"id\":" + products.get(0).getDescribe().getId() + "}"),
                    new TypeToken<List<ProductDescribe>>() {}.getType());

            if (!refuseUserOptions.contains("'" +  describes.get(0).getPhotographer().getId() + "'") &&
                    describes.get(0).getPhotographer().getId().compareTo(currentUser.getId()) != 0) {
                refuseUserOptions = "<option value='" + describes.get(0).getPhotographer().getId() + "'>" +
                        describes.get(0).getPhotographer().getName() + "</option>"
                        + refuseUserOptions;
            }

        } else if (audits.get(0).getEntity().equals(AuditFlowConstant.business_price_change_saler) ||
                audits.get(0).getEntity().equals(AuditFlowConstant.business_price_change_charger) ||
                audits.get(0).getEntity().equals(AuditFlowConstant.business_price_change_manager) ||
                audits.get(0).getEntity().equals(AuditFlowConstant.business_price_change_director)) {
            List<ProductPriceChange> productPriceChanges = writer.gson.fromJson(erpClient.query(ProductPriceChange.class.getSimpleName().toLowerCase(),
                    "{\"id\":" + audits.get(0).getEntityId() + "}"),
                    new TypeToken<List<ProductPriceChange>>() {}.getType());

            if (!refuseUserOptions.contains("'" +  productPriceChanges.get(0).getUser().getId() + "'") &&
                    productPriceChanges.get(0).getUser().getId().compareTo(currentUser.getId()) != 0) {
                refuseUserOptions = "<option value='" + productPriceChanges.get(0).getUser().getId() + "'>" +
                        productPriceChanges.get(0).getUser().getName() + "</option>"
                        + refuseUserOptions;
            }
        } else if (audits.get(0).getEntity().equals(AuditFlowConstant.business_voucherAudit)){
            List<Voucher> vouchers = writer.gson.fromJson(financeClient.query(Voucher.class.getSimpleName().toLowerCase(),
                    "{\"id\":" + audits.get(0).getEntityId() + "}"),
                    new TypeToken<List<Voucher>>() {}.getType());

            if (!refuseUserOptions.contains("'" +  vouchers.get(0).getChartMaker().getId() + "'") &&
                    vouchers.get(0).getChartMaker().getId().compareTo(currentUser.getId()) != 0) {
                refuseUserOptions = "<option value='" + vouchers.get(0).getChartMaker().getId() + "'>" +
                        vouchers.get(0).getChartMaker().getName() + "</option>"
                        + refuseUserOptions;
            }
        }


        if (!audits.isEmpty() && audits.size() > 1) {
            if (!refuseUserOptions.contains("上一节点") && deep == 0) {
                refuseUserOptions = "<option value='" + audits.get(audits.size()-2).getUser().getId() + "'>上一节点</option>" + refuseUserOptions;
            }
        }

        if (audits.get(0).getPreFlowAuditNo() != null) {
            List<Audit> preFlowAudits = writer.gson.fromJson(sysClient.query(Audit.class.getSimpleName().toLowerCase(), "{\"no\":" + audits.get(0).getPreFlowAuditNo() + "}"),
                    new TypeToken<List<Audit>>() {}.getType());
            refuseUserOptions = getRefuseUserOptions(currentUser, preFlowAudits, refuseUserOptions, ++deep);
        }

        return refuseUserOptions;
    }
}
