package com.hzg.afterSaleService;

import com.hzg.erp.Product;
import com.hzg.tools.AfterSaleServiceConstant;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: ChangeProductDetail.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2018/1/31
 */
@Entity(name = "hzg_changeproduct_detail")
public class ChangeProductDetail implements Serializable {
    private static final long serialVersionUID = 345435245233265L;

    public ChangeProductDetail(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "changeProductId")
    private ChangeProduct changeProduct;

    @Column(name="type",length=1)
    private Integer type;

    @Column(name = "productNo", length = 16)
    private String productNo;

    @Column(name="price", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float price;

    @Column(name="quantity", length = 8, precision = 2)
    private Float quantity;

    @Column(name="unit",length=6)
    private String unit;

    @Column(name="amount", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float amount;

    @Column(name="state",length = 1)
    private Integer state;

    @OneToMany(mappedBy = "changeProductDetail", cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    private Set<ChangeProductDetailProduct> changeProductDetailProducts;

    @Transient
    private Product product;

    @Transient
    private String sessionId;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public ChangeProduct getChangeProduct() {
        return changeProduct;
    }

    public void setChangeProduct(ChangeProduct changeProduct) {
        this.changeProduct = changeProduct;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getProductNo() {
        return productNo;
    }

    public void setProductNo(String productNo) {
        this.productNo = productNo;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
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

    public Float getAmount() {
        return amount;
    }

    public void setAmount(Float amount) {
        this.amount = amount;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Set<ChangeProductDetailProduct> getChangeProductDetailProducts() {
        return changeProductDetailProducts;
    }

    public void setChangeProductDetailProducts(Set<ChangeProductDetailProduct> changeProductDetailProducts) {
        this.changeProductDetailProducts = changeProductDetailProducts;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public String getStateName() {
        if (type.equals(AfterSaleServiceConstant.changeProduct_detail_type_changeProduct)) {
            switch (state) {
                case 0:
                    return "未换货";
                case 1:
                    return "已换货";
                case 2:
                    return "不能换货";
                default:
                    return "";
            }
        } else if (type.equals(AfterSaleServiceConstant.changeProduct_detail_type_returnProduct)) {
            switch (state) {
                case 0:
                    return ":未退货";
                case 1:
                    return "已退货";
                case 2:
                    return "不能退货";
                default:
                    return "";
            }
        }
        return "";
    }
}
