package com.hzg.order;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: OrderBook.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/8/15
 */
@Entity(name = "hzg_order_book")
public class OrderBook implements Serializable {
    private static final long serialVersionUID = 345435245233239L;

    public OrderBook(){
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
    @JoinColumn(name = "orderId")
    private Order order;

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

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public String getStateName() {
        switch (state) {
            case 0 : return "未支付";
            case 1 : return "已支付";
            case 2 : return "取消";
            default : return "";
        }
    }
}
