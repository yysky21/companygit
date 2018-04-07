package com.hzg.erp;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: StockInOutDetailProduct.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/11/2
 */
@Entity(name = "hzg_stock_inout_detail_product")
public class StockInOutDetailProduct implements Serializable {

    private static final long serialVersionUID = 345435245233255L;

    public StockInOutDetailProduct(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "stockInOutDetailId")
    private StockInOutDetail stockInOutDetail;

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

    public StockInOutDetail getStockInOutDetail() {
        return stockInOutDetail;
    }

    public void setStockInOutDetail(StockInOutDetail stockInOutDetail) {
        this.stockInOutDetail = stockInOutDetail;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}