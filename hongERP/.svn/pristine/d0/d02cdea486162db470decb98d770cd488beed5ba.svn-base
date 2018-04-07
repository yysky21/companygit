package com.hzg.erp;

import com.hzg.sys.Action;
import com.hzg.sys.User;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;
import java.util.Set;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: BorrowProductReturn.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2018/3/30
 */
@Entity(name = "hzg_borrowproduct_return")
public class BorrowProductReturn implements Serializable {

    private static final long serialVersionUID = 345435245233273L;

    public BorrowProductReturn(){
        super();
    }

    public BorrowProductReturn(Integer id){
        super();
        this.id = id;
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @Column(name="no",length=16)
    private String no;

    @Column(name="state", length = 1)
    private Integer state;

    @Column(name="describes",length=60)
    private String describes;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "returnerId")
    private User returner;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "chargerId")
    private User charger;

    @Column(name="date")
    private Timestamp date;

    @Column(name="inputDate")
    private Timestamp inputDate;

    @OneToMany(mappedBy = "borrowProductReturn", cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    private Set<BorrowProductReturnDetail> details;

    @Transient
    private String sessionId;

    @Transient
    private List<Action> actions;

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

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getDescribes() {
        return describes;
    }

    public void setDescribes(String describes) {
        this.describes = describes;
    }

    public User getCharger() {
        return charger;
    }

    public void setCharger(User charger) {
        this.charger = charger;
    }

    public User getReturner() {
        return returner;
    }

    public void setReturner(User returner) {
        this.returner = returner;
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

    public Set<BorrowProductReturnDetail> getDetails() {
        return details;
    }

    public void setDetails(Set<BorrowProductReturnDetail> details) {
        this.details = details;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public List<Action> getActions() {
        return actions;
    }

    public void setActions(List<Action> actions) {
        this.actions = actions;
    }

    public String getStateName() {
        switch (state) {
            case 0 : return "保存";
            case 1 : return "申请";
            case 2 : return "完成";
            case 3 : return "取消";
            default : return "";
        }
    }
}