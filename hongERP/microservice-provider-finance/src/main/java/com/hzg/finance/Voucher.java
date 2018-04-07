package com.hzg.finance;

import com.hzg.sys.User;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Set;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: Subject.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2017/11/24
 */
@Entity(name = "hzg_finance_voucher")
public class Voucher implements Serializable {

    private static final long serialVersionUID = -6318923031280791095L;

    public Voucher(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "categoryId")
    private VoucherCategory voucherCategory; // 凭证类别id

    @Column(name="no",length=10)
    private String no; // 凭证编号

    @Column(name="makeDate")
    private Timestamp makeDate; // 制单日期

    @Column(name="attachDocumentNum",length = 4)
    private Integer attachDocumentNum; // 附单据数

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "bookkeeperId")
    private User bookkeeper; // 记账人id

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "auditorId")
    private User auditor; // 审核人id

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "cashierId")
    private User cashier; // 出纳id

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "chartMakerId")
    private User chartMaker; // 制单人id

    @Column(name="printTimes",length = 4)
    private Integer printTimes; // 打印次数

    @Column(name="totalCapital",length=30)
    private String totalCapital;  // 大写合计

    @Column(name="debit", length = 10, precision = 2)
    private Float debit;  // 借方合计

    @Column(name="credit", length = 10, precision = 2)
    private Float credit;  // 贷方合计

    @Column(name="state",length=1)
    private Integer state;  //状态

    @OneToMany(mappedBy = "voucher", cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    private Set<VoucherDetail> details; // 凭证明细

    @OneToMany(mappedBy = "voucher", cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    private Set<VoucherItemSource> voucherItemSources; // 凭证条目来源

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public VoucherCategory getVoucherCategory() {
        return voucherCategory;
    }

    public void setVoucherCategory(VoucherCategory voucherCategory) {
        this.voucherCategory = voucherCategory;
    }

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public Timestamp getMakeDate() {
        return makeDate;
    }

    public void setMakeDate(Timestamp makeDate) {
        this.makeDate = makeDate;
    }

    public Integer getAttachDocumentNum() {
        return attachDocumentNum;
    }

    public void setAttachDocumentNum(Integer attachDocumentNum) {
        this.attachDocumentNum = attachDocumentNum;
    }

    public User getBookkeeper() {
        return bookkeeper;
    }

    public void setBookkeeper(User bookkeeper) {
        this.bookkeeper = bookkeeper;
    }

    public User getAuditor() {
        return auditor;
    }

    public void setAuditor(User auditor) {
        this.auditor = auditor;
    }

    public User getCashier() {
        return cashier;
    }

    public void setCashier(User cashier) {
        this.cashier = cashier;
    }

    public User getChartMaker() {
        return chartMaker;
    }

    public void setChartMaker(User chartMaker) {
        this.chartMaker = chartMaker;
    }

    public Integer getPrintTimes() {
        return printTimes;
    }

    public void setPrintTimes(Integer printTimes) {
        this.printTimes = printTimes;
    }

    public String getTotalCapital() {
        return totalCapital;
    }

    public void setTotalCapital(String totalCapital) {
        this.totalCapital = totalCapital;
    }

    public Float getDebit() {
        return debit;
    }

    public void setDebit(Float debit) {
        this.debit = debit;
    }

    public Float getCredit() {
        return credit;
    }

    public void setCredit(Float credit) {
        this.credit = credit;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Set<VoucherDetail> getDetails() {
        return details;
    }

    public void setDetails(Set<VoucherDetail> details) {
        this.details = details;
    }

    public Set<VoucherItemSource> getVoucherItemSources() {
        return voucherItemSources;
    }

    public void setVoucherItemSources(Set<VoucherItemSource> voucherItemSources) {
        this.voucherItemSources = voucherItemSources;
    }
}