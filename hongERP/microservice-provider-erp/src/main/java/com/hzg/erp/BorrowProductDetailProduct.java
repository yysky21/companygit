package com.hzg.erp;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: BorrowProductDetailProduct.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2018/3/30
 */
@Entity(name = "hzg_borrowproduct_detail_product")
public class BorrowProductDetailProduct implements Serializable {

    private static final long serialVersionUID = 345435245233272L;

    public BorrowProductDetailProduct(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "borrowProductDetailId")
    private BorrowProductDetail borrowProductDetail;

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

    public BorrowProductDetail getBorrowProductDetail() {
        return borrowProductDetail;
    }

    public void setBorrowProductDetail(BorrowProductDetail borrowProductDetail) {
        this.borrowProductDetail = borrowProductDetail;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}