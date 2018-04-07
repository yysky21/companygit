package com.hzg.finance;

import com.hzg.customer.Customer;
import com.hzg.erp.ProductType;
import com.hzg.sys.User;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: GrossProfit.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2018/3/21
 */
@Entity(name = "hzg_finance_form_grossprofit")
public class GrossProfit implements Serializable {

    private static final long serialVersionUID = 2838768277564054104L;

    public GrossProfit() {
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @Column(name="date")
    private Timestamp date; // 单据日期

    @Column(name="no",length=16)
    private String no; // 销售订单号

    @Column(name="businessType",length=16)
    private String businessType; // 业务类型

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "chartMakerId")
    private User chartMaker; // 业务员id

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "customerId")
    private Customer customer; // 客户id

    @Column(name="unit",length=16)
    private String unit; // 计量单位

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "typeId")
    private ProductType type; // 商品分类id

    @Column(name="productNo",length=16)
    private String productNo; // 商品编号

    @Column(name="productName",length=16)
    private String productName; // 商品名称

    @Column(name="quantity", length = 8, precision = 2)
    private Float quantity; // 数量

    @Column(name="unitPrice", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float unitPrice; // 单价

    @Column(name="discount", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float discount; // 折让金额

    @Column(name="saleAmount", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float saleAmount; // 销售金额

    @Column(name="cost", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float cost; // 成本金额

    @Column(name="grossProfit", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float grossProfit; // 毛利

    @Column(name="grossProfitRate",length=16)
    private String grossProfitRate; // 毛利率

    @Column(name="processIncome", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float processIncome; // 加工费收入

    @Column(name="processCost", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float processCost; // 加工费成本

    @Column(name="processGrossProfit", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float processGrossProfit; // 加工毛利

    @Column(name="processGrossProfitRate",length=16)
    private String processGrossProfitRate; // 加工毛利率

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public String getBusinessType() {
        return businessType;
    }

    public void setBusinessType(String businessType) {
        this.businessType = businessType;
    }

    public User getChartMaker() {
        return chartMaker;
    }

    public void setChartMaker(User chartMaker) {
        this.chartMaker = chartMaker;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public ProductType getType() {
        return type;
    }

    public void setType(ProductType type) {
        this.type = type;
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

    public Float getDiscount() {
        return discount;
    }

    public void setDiscount(Float discount) {
        this.discount = discount;
    }

    public Float getSaleAmount() {
        return saleAmount;
    }

    public void setSaleAmount(Float saleAmount) {
        this.saleAmount = saleAmount;
    }

    public Float getCost() {
        return cost;
    }

    public void setCost(Float cost) {
        this.cost = cost;
    }

    public Float getGrossProfit() {
        return grossProfit;
    }

    public void setGrossProfit(Float grossProfit) {
        this.grossProfit = grossProfit;
    }

    public String getGrossProfitRate() {
        return grossProfitRate;
    }

    public void setGrossProfitRate(String grossProfitRate) {
        this.grossProfitRate = grossProfitRate;
    }

    public Float getProcessIncome() {
        return processIncome;
    }

    public void setProcessIncome(Float processIncome) {
        this.processIncome = processIncome;
    }

    public Float getProcessCost() {
        return processCost;
    }

    public void setProcessCost(Float processCost) {
        this.processCost = processCost;
    }

    public Float getProcessGrossProfit() {
        return processGrossProfit;
    }

    public void setProcessGrossProfit(Float processGrossProfit) {
        this.processGrossProfit = processGrossProfit;
    }

    public String getProcessGrossProfitRate() {
        return processGrossProfitRate;
    }

    public void setProcessGrossProfitRate(String processGrossProfitRate) {
        this.processGrossProfitRate = processGrossProfitRate;
    }
}