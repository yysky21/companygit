package com.hzg.finance;

import com.hzg.customer.Customer;
import com.hzg.erp.Supplier;
import com.hzg.sys.User;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: SupplierContact.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2018/3/21
 */
@Entity(name = "hzg_finance_form_suppliercontact")
public class SupplierContact implements Serializable {

    private static final long serialVersionUID = 2496905048891758506L;

    public SupplierContact() {
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "supplierId")
    private Supplier supplier; // 客户id

    @Column(name="date")
    private Timestamp date; // 单据日期

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "docTypeId")
    private DocType docType; // 单据类型id

    @Column(name="no",length=16)
    private String no; // 单据编号

    @Column(name="productNo",length=16)
    private String productNo; // 商品编号

    @Column(name="productName",length=16)
    private String productName; // 商品名称

    @Column(name="unit",length=8)
    private String unit; // 计量单位

    @Column(name="quantity", length = 8, precision = 2)
    private Float quantity; // 数量

    @Column(name="unitPrice", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float unitPrice; // 单价

    @Column(name="beginning", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float beginning; // 期初余额

    @Column(name="payable", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float payable; // 应付金额

    @Column(name="paid", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float paid; // 已付金额

    @Column(name="remainder", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float remainder; // 应付余额

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public DocType getDocType() {
        return docType;
    }

    public void setDocType(DocType docType) {
        this.docType = docType;
    }

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public String getProductNo() {
        return productNo;
    }

    public void setProductNo(String productNo) {
        this.productNo = productNo;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Float getQuantity() {
        return quantity;
    }

    public void setQuantity(Float quantity) {
        this.quantity = quantity;
    }

    public Float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(Float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public Float getBeginning() {
        return beginning;
    }

    public void setBeginning(Float beginning) {
        this.beginning = beginning;
    }

    public Float getPayable() {
        return payable;
    }

    public void setPayable(Float payable) {
        this.payable = payable;
    }

    public Float getPaid() {
        return paid;
    }

    public void setPaid(Float paid) {
        this.paid = paid;
    }

    public Float getRemainder() {
        return remainder;
    }

    public void setRemainder(Float remainder) {
        this.remainder = remainder;
    }
}