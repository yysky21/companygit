package com.hzg.afterSaleService;

import com.hzg.pay.Pay;
import com.hzg.sys.Action;
import com.hzg.sys.User;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;
import java.util.Set;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: RepairProduct.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/3/19
 */
@Entity(name = "hzg_repairproduct")
public class RepairProduct implements Serializable {
    private static final long serialVersionUID = 345435245233267L;

    public RepairProduct(){
        super();
    }

    public RepairProduct(Integer id){
        super();
        this.id = id;
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @Column(name="no",length=16)
    private String no;

    @Column(name="entity",length=32)
    private String entity;

    @Column(name="entityId", length = 11)
    private Integer entityId;

    @Column(name="entityNo", length = 16)
    private String entityNo;

    @Column(name="amount", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float amount;

    @Column(name="describes",length=60)
    private String describes;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    private User user;

    @Column(name="state",length = 2)
    private Integer state;

    @Column(name="date")
    private Timestamp date;

    @Column(name="inputDate")
    private Timestamp inputDate;

    @OneToMany(mappedBy = "repairProduct", cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    private Set<RepairProductDetail> details;

    @Transient
    private List<Action> actions;

    @Transient
    private String sessionId;

    @Transient
    private List<Pay> pays;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
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

    public String getEntityNo() {
        return entityNo;
    }

    public void setEntityNo(String entityNo) {
        this.entityNo = entityNo;
    }

    public Float getAmount() {
        return amount;
    }

    public void setAmount(Float amount) {
        this.amount = amount;
    }


    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public Timestamp getInputDate() {
        return inputDate;
    }

    public void setInputDate(Timestamp inputDate) {
        this.inputDate = inputDate;
    }

    public Set<RepairProductDetail> getDetails() {
        return details;
    }

    public void setDetails(Set<RepairProductDetail> details) {
        this.details = details;
    }

    public List<Action> getActions() {
        return actions;
    }

    public void setActions(List<Action> actions) {
        this.actions = actions;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public String getDescribes() {
        return describes;
    }

    public void setDescribes(String describes) {
        this.describes = describes;
    }

    public List<Pay> getPays() {
        return pays;
    }

    public void setPays(List<Pay> pays) {
        this.pays = pays;
    }

    public String getStateName() {
        switch (state) {
            case 0 : return "申请";
            case 1 : return "已付款";
            case 2 : return "取消";
            case 3 : return "销售确认可修补";
            case 31 : return ":销售确认不可修补";
            case 4 : return "销售总监确认可修补";
            case 41 : return "销售总监确认不可修补";
            case 5 : return "仓储确认可修补";
            case 51 : return "仓储确认不可修补";
            case 6 : return "6:修补完成";
            default : return "";
        }
    }
}