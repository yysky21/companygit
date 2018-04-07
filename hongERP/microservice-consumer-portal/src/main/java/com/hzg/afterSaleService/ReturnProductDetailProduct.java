package com.hzg.afterSaleService;

import com.hzg.erp.Product;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: ReturnProductDetailProduct.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/11/29
 */
@Entity(name = "hzg_returnproduct_detail_product")
public class ReturnProductDetailProduct implements Serializable {

    private static final long serialVersionUID = 345435245233262L;

    public ReturnProductDetailProduct(){
        super();
    }

    public ReturnProductDetailProduct(Product product){
        super();
        this.product = product;
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "returnProductDetailId")
    private ReturnProductDetail returnProductDetail;

    @ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.LAZY)
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

    public ReturnProductDetail getReturnProductDetail() {
        return returnProductDetail;
    }

    public void setReturnProductDetail(ReturnProductDetail returnProductDetail) {
        this.returnProductDetail = returnProductDetail;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}