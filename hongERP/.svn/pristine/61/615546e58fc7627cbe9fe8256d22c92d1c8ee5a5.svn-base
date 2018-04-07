package com.hzg.finance;

import com.hzg.customer.Customer;
import com.hzg.sys.User;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: CustomerContact.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2018/3/21
 */
@Entity(name = "hzg_finance_form_customercontact")
public class CustomerContact implements Serializable {

    private static final long serialVersionUID = 2414524680958726317L;

    public CustomerContact() {
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "customerId")
    private Customer customer; // 客户id

    @Column(name="date")
    private Timestamp date; // 单据日期

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "docTypeId")
    private DocType docType; // 单据类型id

    @Column(name="no",length=16)
    private String no; // 单据编号

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "chartMakerId")
    private User chartMaker; // 业务员id

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

    @Column(name="receivable", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float receivable; // 应收金额

    @Column(name="received", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float received; // 已收金额

    @Column(name="remainder", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float remainder; // 应收余额

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
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

    public User getChartMaker() {
        return chartMaker;
    }

    public void setChartMaker(User chartMaker) {
        this.chartMaker = chartMaker;
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

    public Float getReceivable() {
        return receivable;
    }

    public void setReceivable(Float receivable) {
        this.receivable = receivable;
    }

    public Float getReceived() {
        return received;
    }

    public void setReceived(Float received) {
        this.received = received;
    }

    public Float getRemainder() {
        return remainder;
    }

    public void setRemainder(Float remainder) {
        this.remainder = remainder;
    }
}