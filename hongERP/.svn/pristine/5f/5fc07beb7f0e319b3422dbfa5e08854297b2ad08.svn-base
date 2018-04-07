package com.hzg.erp;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: BorrowProductDetail.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2018/3/30
 */
@Entity(name = "hzg_borrowproduct_detail")
public class BorrowProductDetail implements Serializable {

    private static final long serialVersionUID = 345435245233271L;

    public BorrowProductDetail(){
        super();
    }

    public BorrowProductDetail(Integer id){
        super();
        this.id = id;
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @Column(name="productNo", length = 16)
    private String productNo;

    @Column(name="quantity", length = 5)
    private Float quantity;

    @Column(name="unit",length=8)
    private String unit;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name="borrowProductId")
    private BorrowProduct borrowProduct;

    @Column(name="state", length = 1)
    private Integer state;

    @OneToMany(mappedBy = "borrowProductDetail", cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    private Set<BorrowProductDetailProduct> detailProducts;

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

    public BorrowProduct getBorrowProduct() {
        return borrowProduct;
    }

    public void setBorrowProduct(BorrowProduct borrowProduct) {
        this.borrowProduct = borrowProduct;
    }

    public Set<BorrowProductDetailProduct> getDetailProducts() {
        return detailProducts;
    }

    public void setDetailProducts(Set<BorrowProductDetailProduct> detailProducts) {
        this.detailProducts = detailProducts;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}