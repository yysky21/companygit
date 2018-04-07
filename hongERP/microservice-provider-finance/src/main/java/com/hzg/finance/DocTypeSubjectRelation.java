package com.hzg.finance;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: DocTypeSubjectRelation.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2018/1/8
 */
@Entity(name = "hzg_finance_doctypesubject_relation")
public class DocTypeSubjectRelation implements Serializable {

    private static final long serialVersionUID = -3331194702476199622L;

    public DocTypeSubjectRelation() {
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", length = 11)
    private Integer id;

    @ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "doctypeId")
    private DocType docType; // 单据类型id

    @ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "subjectId")
    private Subject subject; // 科目id

    @Column(name = "direction", length = 1)
    private Integer direction; // 余额方向

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public DocType getDocType() {
        return docType;
    }

    public void setDocType(DocType docType) {
        this.docType = docType;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    public Integer getDirection() {
        return direction;
    }

    public void setDirection(Integer direction) {
        this.direction = direction;
    }
}