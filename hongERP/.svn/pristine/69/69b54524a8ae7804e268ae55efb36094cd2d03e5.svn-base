package com.hzg.erp;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: BorrowProductReturnDetailProduct.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2018/3/30
 */
@Entity(name = "hzg_borrowproduct_return_detail_product")
public class BorrowProductReturnDetailProduct implements Serializable {

    private static final long serialVersionUID = 345435245233276L;

    public BorrowProductReturnDetailProduct(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "borrowProductReturnDetailId")
    private BorrowProductReturnDetail borrowProductReturnDetail;

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

    public BorrowProductReturnDetail getBorrowProductReturnDetail() {
        return borrowProductReturnDetail;
    }

    public void setBorrowProductReturnDetail(BorrowProductReturnDetail borrowProductReturnDetail) {
        this.borrowProductReturnDetail = borrowProductReturnDetail;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}