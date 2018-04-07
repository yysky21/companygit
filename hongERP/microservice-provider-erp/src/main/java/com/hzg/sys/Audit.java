package com.hzg.sys;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: Audit.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/7/17
 */
@Entity(name = "hzg_sys_audit")
public class Audit implements Serializable {

    private static final long serialVersionUID = 345435245233223L;

    public Audit(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @Column(name="no",length=16)
    private String no;

    @Column(name="name",length=64)
    private String name;

    @Column(name="content",length=256)
    private String content;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    private User user;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "postId")
    private Post post;

    @Column(name="result",length=1)
    private String result;

    @Column(name="dealDate")
    private Timestamp dealDate;

    @Column(name="inputDate")
    private Timestamp inputDate;

    @Column(name="remark",length=256)
    private String remark;

    @Column(name="entity",length=32)
    private String entity;

    @Column(name="entityId", length = 11)
    private Integer entityId;

    @Column(name="entityNo",length=32)
    private String entityNo;

    @Column(name="state",length = 1)
    private Integer state;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "refusePostId")
    private Post refusePost;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "refuseUserId")
    private User refuseUser;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "companyId")
    private Company company;

    @Column(name="action",length=32)
    private String action;

    @Column(name="refusedAction",length=32)
    private String refusedAction;

    @Column(name="preFlowAuditNo",length=32)
    private String preFlowAuditNo;

    @Transient
    private User toRefuseUser;

    @Transient
    private Post toRefusePost;


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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public Timestamp getDealDate() {
        return dealDate;
    }

    public void setDealDate(Timestamp dealDate) {
        this.dealDate = dealDate;
    }

    public Timestamp getInputDate() {
        return inputDate;
    }

    public void setInputDate(Timestamp inputDate) {
        this.inputDate = inputDate;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Post getRefusePost() {
        return refusePost;
    }

    public void setRefusePost(Post refusePost) {
        this.refusePost = refusePost;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getRefusedAction() {
        return refusedAction;
    }

    public void setRefusedAction(String refusedAction) {
        this.refusedAction = refusedAction;
    }

    public Post getToRefusePost() {
        return toRefusePost;
    }

    public void setToRefusePost(Post toRefusePost) {
        this.toRefusePost = toRefusePost;
    }

    public User getRefuseUser() {
        return refuseUser;
    }

    public void setRefuseUser(User refuseUser) {
        this.refuseUser = refuseUser;
    }

    public String getPreFlowAuditNo() {
        return preFlowAuditNo;
    }

    public void setPreFlowAuditNo(String preFlowAuditNo) {
        this.preFlowAuditNo = preFlowAuditNo;
    }

    public User getToRefuseUser() {
        return toRefuseUser;
    }

    public void setToRefuseUser(User toRefuseUser) {
        this.toRefuseUser = toRefuseUser;
    }

    public String getStateName() {
        if(state == 0){
            return "待办";
        }else if(state == 1){
            return "已办";
        }

        return "";
    }

    public String getResultName() {
        if  (result != null){
            if (result.equals("Y")) {
                return "已通过";
            } else if (result.equals("N")) {
                return "未通过";
            } else if (result.equals("L")) {
                return "锁定";
            }
        }
        return "";
    }
}