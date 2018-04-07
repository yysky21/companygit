package com.hzg.finance;

import com.hzg.pay.Account;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: BankSubjectExtend.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2017/11/24
 */
@Entity(name = "hzg_finance_banksubject_extend")
public class BankSubjectExtend implements Serializable {

    private static final long serialVersionUID = -5763969327174667752L;

    public BankSubjectExtend() {
        super();
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", length = 11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "accountId")
    private Account account; // 账户id

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

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }
}