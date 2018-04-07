package com.hzg.order;

import com.hzg.erp.Product;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: OrderGiftProduct.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/11/15
 */
@Entity(name = "hzg_order_gift_product")
public class OrderGiftProduct implements Serializable {

    private static final long serialVersionUID = 345435245233258L;

    public OrderGiftProduct(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "orderGiftId")
    private OrderGift orderGift;

    @OneToOne(cascade = CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "productId")
    private Product product;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public OrderGift getOrderGift() {
        return orderGift;
    }

    public void setOrderGift(OrderGift orderGift) {
        this.orderGift = orderGift;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}