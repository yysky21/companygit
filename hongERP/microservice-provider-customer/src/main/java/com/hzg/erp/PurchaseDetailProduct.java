package com.hzg.erp;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: PurchaseDetailProducts.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/11/2
 */
@Entity(name = "hzg_purchase_detail_product")
public class PurchaseDetailProduct implements Serializable {

    private static final long serialVersionUID = 345435245233254L;

    public PurchaseDetailProduct(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "purchaseDetailId")
    private PurchaseDetail purchaseDetail;

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

    public PurchaseDetail getPurchaseDetail() {
        return purchaseDetail;
    }

    public void setPurchaseDetail(PurchaseDetail purchaseDetail) {
        this.purchaseDetail = purchaseDetail;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}