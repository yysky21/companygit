package com.hzg.order;

import com.hzg.erp.Product;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: OrderPrivateAcc.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/8/15
 */
@Entity(name = "hzg_order_private_acc")
public class OrderPrivateAcc implements Serializable {
    private static final long serialVersionUID = 345435245233246L;

    public OrderPrivateAcc(){
        super();
    }

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name="id", length=11)
    private Integer id;

    @Column(name = "productNo")
    private String productNo;

    @Column(name="quantity", length = 8, precision = 2)
    private Float quantity;

    @Column(name="unit",length=6)
    private String unit;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "privateId")
    private OrderPrivate orderPrivate;

    @OneToMany(mappedBy = "orderPrivateAcc", cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    private Set<OrderPrivateAccProduct> orderPrivateAccProducts;

    @Transient
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

    public OrderPrivate getOrderPrivate() {
        return orderPrivate;
    }

    public void setOrderPrivate(OrderPrivate orderPrivate) {
        this.orderPrivate = orderPrivate;
    }

    public Set<OrderPrivateAccProduct> getOrderPrivateAccProducts() {
        return orderPrivateAccProducts;
    }

    public void setOrderPrivateAccProducts(Set<OrderPrivateAccProduct> orderPrivateAccProducts) {
        this.orderPrivateAccProducts = orderPrivateAccProducts;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
