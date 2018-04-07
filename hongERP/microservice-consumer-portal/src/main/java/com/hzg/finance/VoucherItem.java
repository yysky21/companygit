package com.hzg.finance;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: Subject.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2017/11/24
 */
@Entity(name = "hzg_finance_voucher_item")
public class VoucherItem implements Serializable {

    private static final long serialVersionUID = 2535611434150923526L;

    public VoucherItem(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @Column(name="summary",length=60)
    private String summary; // 摘要

    @Column(name="assistant",length=30)
    private String assistant; // 辅助项

    @Column(name="debit", length = 8, precision = 2)
    private Float debit;  // 借方

    @Column(name="credit", length = 8, precision = 2)
    private Float credit;  //贷方

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "subjectId")
    private Subject subject; // 科目id

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getAssistant() {
        return assistant;
    }

    public void setAssistant(String assistant) {
        this.assistant = assistant;
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

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }
}