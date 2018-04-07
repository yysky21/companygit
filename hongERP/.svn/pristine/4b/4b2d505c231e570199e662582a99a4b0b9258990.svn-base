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
@Entity(name = "hzg_finance_voucher_detail")
public class VoucherDetail implements Serializable {

    private static final long serialVersionUID = 2652370911563735881L;

    public VoucherDetail(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "voucherId")
    private Voucher voucher; //凭证id

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "voucherItemId")
    private VoucherItem voucherItem; // 凭证条目id

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

    public VoucherItem getVoucherItem() {
        return voucherItem;
    }

    public void setVoucherItem(VoucherItem voucherItem) {
        this.voucherItem = voucherItem;
    }
}