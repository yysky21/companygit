package com.hzg.finance;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: VoucherItemSourceDetail.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2018/1/12
 */
@Entity(name = "hzg_finance_voucher_itemsource_detail")
public class VoucherItemSourceDetail implements Serializable {

    private static final long serialVersionUID = 5021436419469414982L;

    public VoucherItemSourceDetail() {
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", length = 11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "itemsourceId")
    private VoucherItemSource voucherItemSource; // 凭证条目来源id

    @Column(name="entity", length = 32)
    private String entity; // 条件实体,如:商品类型:productType，支付方式:payType等

    @Column(name="entityId", length = 11)
    private Integer entityId; //商品分类id,支付方式id等

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public VoucherItemSource getVoucherItemSource() {
        return voucherItemSource;
    }

    public void setVoucherItemSource(VoucherItemSource voucherItemSource) {
        this.voucherItemSource = voucherItemSource;
    }

    public String getEntity() {
        return entity;
    }

    public void setEntity(String entity) {
        this.entity = entity;
    }

    public Integer getEntityId() {
        return entityId;
    }

    public void setEntityId(Integer entityId) {
        this.entityId = entityId;
    }
}