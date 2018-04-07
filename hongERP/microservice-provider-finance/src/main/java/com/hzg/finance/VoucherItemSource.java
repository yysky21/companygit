package com.hzg.finance;

import com.hzg.erp.ProductType;
import com.hzg.erp.Warehouse;
import com.hzg.pay.Account;
import com.hzg.sys.User;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Set;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: VoucherItemSource.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2018/1/8
 */
@Entity(name = "hzg_finance_voucher_itemsource")
public class VoucherItemSource implements Serializable {

    private static final long serialVersionUID = 4172956843516758894L;

    public VoucherItemSource() {
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", length = 11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "voucherId")
    private Voucher voucher; // 凭证id

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "chartMakerId")
    private User chartMaker; // 制单人id

    @Column(name="date")
    private Timestamp date; // 日期日期

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "warehouseId")
    private Warehouse warehouse; // 仓库id

    @ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "doctypeId")
    private DocType docType; // 单据类型id

    @Column(name = "businessType", length = 16)
    private String businessType; // 业务类型

    @Column(name = "docNo", length = 16)
    private String docNo; // 单据编号

    @Column(name = "contactUnit", length = 30)
    private String contactUnit; // 往来单位名称

    @Column(name="amount", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float amount; // 金额

    @Column(name = "remark", length = 256)
    private String remark; // 备注

    @Column(name = "extend", length = 32)
    private String extend; // 扩展字段

    @Column(name="state",length=1)
    private Integer state;  //状态

    @OneToMany(mappedBy = "voucherItemSource", cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    private Set<VoucherItemSourceDetail> details; // 凭证明细

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Voucher getVoucher() {
        return voucher;
    }

    public void setVoucher(Voucher voucher) {
        this.voucher = voucher;
    }

    public User getChartMaker() {
        return chartMaker;
    }

    public void setChartMaker(User chartMaker) {
        this.chartMaker = chartMaker;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    public DocType getDocType() {
        return docType;
    }

    public void setDocType(DocType docType) {
        this.docType = docType;
    }

    public String getBusinessType() {
        return businessType;
    }

    public void setBusinessType(String businessType) {
        this.businessType = businessType;
    }

    public String getDocNo() {
        return docNo;
    }

    public void setDocNo(String docNo) {
        this.docNo = docNo;
    }

    public String getContactUnit() {
        return contactUnit;
    }

    public void setContactUnit(String contactUnit) {
        this.contactUnit = contactUnit;
    }

    public Float getAmount() {
        return amount;
    }

    public void setAmount(Float amount) {
        this.amount = amount;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getExtend() {
        return extend;
    }

    public void setExtend(String extend) {
        this.extend = extend;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Set<VoucherItemSourceDetail> getDetails() {
        return details;
    }

    public void setDetails(Set<VoucherItemSourceDetail> details) {
        this.details = details;
    }
}