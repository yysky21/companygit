package com.hzg.finance;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: Subject.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2017/11/24
 */
@Entity(name = "hzg_finance_voucher_category")
public class VoucherCategory implements Serializable {

    private static final long serialVersionUID = 3929087064255555988L;

    public VoucherCategory(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @Column(name="voucherWord",length=10)
    private String voucherWord; // 凭证字

    @Column(name="name",length=16)
    private String name; // 凭证类别名称

    @Column(name="inputDate")
    private Timestamp inputDate; // 创建时间

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getVoucherWord() {
        return voucherWord;
    }

    public void setVoucherWord(String voucherWord) {
        this.voucherWord = voucherWord;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Timestamp getInputDate() {
        return inputDate;
    }

    public void setInputDate(Timestamp inputDate) {
        this.inputDate = inputDate;
    }
}