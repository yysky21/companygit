package com.hzg.sys;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: AuditFlowNode.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/5/23
 */
@Entity(name = "hzg_sys_audit_flow_node")
public class AuditFlowNode implements Serializable {

    private static final long serialVersionUID = 345435245233224L;

    public AuditFlowNode(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @Column(name="name",length=64)
    private String name;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "postId")
    private Post post;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "nextPostId")
    private Post nextPost;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "auditFlowId")
    private AuditFlow auditFlow;

    @Column(name="action",length=32)
    private String action;

    @Column(name="refusedAction",length=32)
    private String refusedAction;


    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public Post getNextPost() {
        return nextPost;
    }

    public void setNextPost(Post nextPost) {
        this.nextPost = nextPost;
    }

    public AuditFlow getAuditFlow() {
        return auditFlow;
    }

    public void setAuditFlow(AuditFlow auditFlow) {
        this.auditFlow = auditFlow;
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
}