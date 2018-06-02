package com.hzg.order;

import com.hzg.erp.Product;
import com.hzg.sys.User;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Set;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: OrderGift.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/9/19
 */
@Entity(name = "hzg_order_gift")
public class OrderGift implements Serializable {
    private static final long serialVersionUID = 345435245233250L;

    public OrderGift(){
        super();
    }

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name="id", length=11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "orderId")
    private Order order;

    @Column(name = "productNo")
    private String productNo;

    @Column(name="quantity", length = 8, precision = 2)
    private Float quantity;

    @Column(name="unit",length=6)
    private String unit;

    @OneToMany(mappedBy = "orderGift", cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    private Set<OrderGiftProduct> orderGiftProducts;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public String getProductNo() {
        return productNo;
    }

    public void setProductNo(String productNo) {
        this.productNo = productNo;
    }

    public Float getQuantity() {
        return quantity;
    }

    public void setQuantity(Float quantity) {
        this.quantity = quantity;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Set<OrderGiftProduct> getOrderGiftProducts() {
        return orderGiftProducts;
    }

    public void setOrderGiftProducts(Set<OrderGiftProduct> orderGiftProducts) {
        this.orderGiftProducts = orderGiftProducts;
    }
}