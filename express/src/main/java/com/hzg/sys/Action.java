package com.hzg.sys;

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
}
