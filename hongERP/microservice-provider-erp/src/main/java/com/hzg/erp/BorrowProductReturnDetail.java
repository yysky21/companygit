package com.hzg.erp;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: BorrowProductReturnDetail.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2018/3/30
 */
@Entity(name = "hzg_borrowproduct_return_detail")
public class BorrowProductReturnDetail implements Serializable {

    private static final long serialVersionUID = 345435245233274L;

    public BorrowProductReturnDetail(){
        super();
    }

    public BorrowProductReturnDetail(Integer id){
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
    @JoinColumn(name="borrowDetailId")
    private BorrowProductDetail borrowProductDetail;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name="borrowProductReturnId")
    private BorrowProductReturn borrowProductReturn;

    @OneToMany(mappedBy = "borrowProductReturnDetail", cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    private Set<BorrowProductReturnDetailProduct> detailProducts;

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

    public BorrowProductDetail getBorrowProductDetail() {
        return borrowProductDetail;
    }

    public void setBorrowProductDetail(BorrowProductDetail borrowProductDetail) {
        this.borrowProductDetail = borrowProductDetail;
    }

    public BorrowProductReturn getBorrowProductReturn() {
        return borrowProductReturn;
    }

    public void setBorrowProductReturn(BorrowProductReturn borrowProductReturn) {
        this.borrowProductReturn = borrowProductReturn;
    }

    public Set<BorrowProductReturnDetailProduct> getDetailProducts() {
        return detailProducts;
    }

    public void setDetailProducts(Set<BorrowProductReturnDetailProduct> detailProducts) {
        this.detailProducts = detailProducts;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}