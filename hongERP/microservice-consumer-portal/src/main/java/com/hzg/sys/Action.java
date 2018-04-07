package com.hzg.sys;

import com.hzg.tools.AfterSaleServiceConstant;
import com.hzg.tools.ErpConstant;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: Action.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/10/30
 */
@Entity(name = "hzg_action")
public class Action implements Serializable {
    private static final long serialVersionUID = 345435245233251L;

    public Action(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @Column(name="entity",length=32)
    private String entity;

    @Column(name="entityId", length = 11)
    private Integer entityId;

    @Column(name="type",length=2)
    private Integer type;

    @Column(name="inputDate")
    private Timestamp inputDate;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "inputerId")
    private User inputer;

    @Column(name="remark",length=256)
    private String remark;

    @Transient
    private List<Integer> entityIds;

    @Transient
    private String sessionId;

    @Transient
    private String auditResult;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Timestamp getInputDate() {
        return inputDate;
    }

    public void setInputDate(Timestamp inputDate) {
        this.inputDate = inputDate;
    }

    public User getInputer() {
        return inputer;
    }

    public void setInputer(User inputer) {
        this.inputer = inputer;
    }

    public List<Integer> getEntityIds() {
        return entityIds;
    }

    public void setEntityIds(List<Integer> entityIds) {
        this.entityIds = entityIds;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getAuditResult() {
        return auditResult;
    }

    public void setAuditResult(String auditResult) {
        this.auditResult = auditResult;
    }

    public String getTypeName() {
        if (entity.equals(AfterSaleServiceConstant.returnProduct)) {
            switch (type) {
                case 1 : return "财务确认已退款";
                case 3 : return "销售确认可退";
                case 31 : return "销售确认不可退";
                case 4 : return "销售总监确认可退";
                case 41 : return "销售总监确认不可退";
                case 5 : return "仓储确认可退";
                case 51 : return "仓储确认不可退";
                case 7 : return "采购确认退货";
                case 8 : return "仓储确认已寄货物";
                case 9 : return "供应商确认收货";
                default : return "";
            }
        } else if (entity.equals(AfterSaleServiceConstant.changeProduct)) {
            switch (type) {
                case 1 : return "财务确认换货完成";
                case 3 : return "销售确认要退商品可退";
                case 31 : return "销售确认要退商品不可退";
                case 4 : return "销售总监确认要退商品可退";
                case 41 : return "销售总监确认要退商品不可退";
                case 5 : return "仓储确认要退商品可退";
                case 51 : return "仓储确认要退商品不可退";
                default : return "";
            }
        } else if (entity.equals(AfterSaleServiceConstant.repairProduct)) {
            switch (type) {
                case 1 : return "财务确认修补款已付";
                case 3 : return "销售确认可修补";
                case 31 : return "销售确认不可修补";
                case 4 : return "销售总监确认可修补";
                case 41 : return "销售总监确认不可修补";
                case 5 : return "仓储确认可修补";
                case 51 : return "仓储确认不可修补";
                case 6 : return "仓储确认修补完成";
                default : return "";
            }
        } else if (entity.equals(ErpConstant.borrowProduct)) {
            switch (type) {
                case 0 : return "仓储审核通过";
                case 1 : return "仓储审核不通过";
                default : return "";
            }
        } else if (entity.equals(ErpConstant.borrowProductReturn)) {
            switch (type) {
                case 0 : return "仓储审核通过";
                case 1 : return "仓储审核不通过";
                default : return "";
            }
        }
        return "";
    }
}
