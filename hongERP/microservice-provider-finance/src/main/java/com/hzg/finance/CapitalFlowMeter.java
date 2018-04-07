package com.hzg.finance;

import com.hzg.pay.Account;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: CapitalFlowMeter.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2018/3/21
 */
@Entity(name = "hzg_finance_form_capitalflowmeter")
public class CapitalFlowMeter implements Serializable {

    private static final long serialVersionUID = -7365999602555055641L;

    public CapitalFlowMeter() {
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "accountId")
    private Account account; // 账号id

    @Column(name="date")
    private Timestamp date; // 单据日期

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "docTypeId")
    private DocType docType; // 单据类型id

    @Column(name="no",length=16)
    private String no; // 单据编号

    @Column(name="beginning", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float beginning; // 期初余额

    @Column(name="income", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float income; // 收入金额

    @Column(name="spending", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float spending; // 支出金额

    @Column(name="ending", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float ending; // 期末余额

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
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

    public Float getBeginning() {
        return beginning;
    }

    public void setBeginning(Float beginning) {
        this.beginning = beginning;
    }

    public Float getIncome() {
        return income;
    }

    public void setIncome(Float income) {
        this.income = income;
    }

    public Float getSpending() {
        return spending;
    }

    public void setSpending(Float spending) {
        this.spending = spending;
    }

    public Float getEnding() {
        return ending;
    }

    public void setEnding(Float ending) {
        this.ending = ending;
    }
}