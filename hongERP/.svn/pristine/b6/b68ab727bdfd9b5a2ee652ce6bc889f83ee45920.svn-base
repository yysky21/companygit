package com.hzg.erp;

import com.hzg.order.Order;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: PurchaseBook.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/8/15
 */
@Entity(name = "hzg_purchase_book")
public class PurchaseBook implements Serializable {
    private static final long serialVersionUID = 345435245233263L;

    public PurchaseBook(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @Column(name="deposit", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float deposit;

    @Column(name="payDate")
    private Timestamp payDate;

    @Column(name="state",length = 1)
    private Integer state;

    @OneToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "purchaseId")
    private Purchase purchase;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Float getDeposit() {
        return deposit;
    }

    public void setDeposit(Float deposit) {
        this.deposit = deposit;
    }

    public Timestamp getPayDate() {
        return payDate;
    }

    public void setPayDate(Timestamp payDate) {
        this.payDate = payDate;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Purchase getPurchase() {
        return purchase;
    }

    public void setPurchase(Purchase purchase) {
        this.purchase = purchase;
    }
}
