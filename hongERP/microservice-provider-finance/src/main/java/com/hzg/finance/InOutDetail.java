package com.hzg.finance;

import com.hzg.erp.ProductType;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: InOutDetail.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2018/3/21
 */
@Entity(name = "hzg_finance_form_inoutdetail")
public class InOutDetail implements Serializable {

    private static final long serialVersionUID = -2411446950616734298L;

    public InOutDetail() {
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "typeId")
    private ProductType type; // 商品分类id

    @Column(name="productNo",length=16)
    private String productNo; // 商品编号

    @Column(name="productName",length=16)
    private String productName; // 商品名称

    @Column(name="unit",length=16)
    private String unit; // 计量单位

    @Column(name="date")
    private Timestamp date; // 单据日期

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "docTypeId")
    private DocType docType; // 单据类型id

    @Column(name="no",length=16)
    private String no; // 单据编号

    @Column(name="beginQuantity", length = 8, precision = 2)
    private Float beginQuantity; // 期初数量

    @Column(name="beginUnitPrice", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float beginUnitPrice; // 期初单价

    @Column(name="beginAmount", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float beginAmount; // 期初金额

    @Column(name="inQuantity", length = 8, precision = 2)
    private Float inQuantity; // 本期收入数量

    @Column(name="inUnitPrice", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float inUnitPrice; // 本期收入单价

    @Column(name="inAmount", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float inAmount; // 本期收入金额

    @Column(name="outQuantity", length = 8, precision = 2)
    private Float outQuantity; // 本期发出数量

    @Column(name="outUnitPrice", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float outUnitPrice; // 本期发出单价

    @Column(name="outAmount", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float outAmount; // 本期发出金额

    @Column(name="endQuantity", length = 8, precision = 2)
    private Float endQuantity; // 结存数量

    @Column(name="endUnitPrice", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float endUnitPrice; // 结存单价

    @Column(name="endAmount", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float endAmount; // 结存金额

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
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

    public Float getBeginQuantity() {
        return beginQuantity;
    }

    public void setBeginQuantity(Float beginQuantity) {
        this.beginQuantity = beginQuantity;
    }

    public Float getBeginUnitPrice() {
        return beginUnitPrice;
    }

    public void setBeginUnitPrice(Float beginUnitPrice) {
        this.beginUnitPrice = beginUnitPrice;
    }

    public Float getBeginAmount() {
        return beginAmount;
    }

    public void setBeginAmount(Float beginAmount) {
        this.beginAmount = beginAmount;
    }

    public Float getInQuantity() {
        return inQuantity;
    }

    public void setInQuantity(Float inQuantity) {
        this.inQuantity = inQuantity;
    }

    public Float getInUnitPrice() {
        return inUnitPrice;
    }

    public void setInUnitPrice(Float inUnitPrice) {
        this.inUnitPrice = inUnitPrice;
    }

    public Float getInAmount() {
        return inAmount;
    }

    public void setInAmount(Float inAmount) {
        this.inAmount = inAmount;
    }

    public Float getOutQuantity() {
        return outQuantity;
    }

    public void setOutQuantity(Float outQuantity) {
        this.outQuantity = outQuantity;
    }

    public Float getOutUnitPrice() {
        return outUnitPrice;
    }

    public void setOutUnitPrice(Float outUnitPrice) {
        this.outUnitPrice = outUnitPrice;
    }

    public Float getOutAmount() {
        return outAmount;
    }

    public void setOutAmount(Float outAmount) {
        this.outAmount = outAmount;
    }

    public Float getEndQuantity() {
        return endQuantity;
    }

    public void setEndQuantity(Float endQuantity) {
        this.endQuantity = endQuantity;
    }

    public Float getEndUnitPrice() {
        return endUnitPrice;
    }

    public void setEndUnitPrice(Float endUnitPrice) {
        this.endUnitPrice = endUnitPrice;
    }

    public Float getEndAmount() {
        return endAmount;
    }

    public void setEndAmount(Float endAmount) {
        this.endAmount = endAmount;
    }
}