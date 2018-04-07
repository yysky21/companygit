package com.hzg.finance;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: SubjectRelate.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2017/12/15
 */
@Entity(name = "hzg_finance_subject_relate")
public class SubjectRelate implements Serializable {

    private static final long serialVersionUID = 819369426429869932L;

    public SubjectRelate() {
        super();
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", length = 11)
    private Integer id;

    @ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "categoryId")
    private SubjectCategory subjectCategory; // 科目类别id

    @Column(name = "entity", length = 16)
    private String entity; // 关联实体

    @Column(name = "field", length = 16)
    private String field; // 关联字段

    @Column(name = "fieldName", length = 16)
    private String fieldName; // 关联字段中文名

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public SubjectCategory getSubjectCategory() {
        return subjectCategory;
    }

    public void setSubjectCategory(SubjectCategory subjectCategory) {
        this.subjectCategory = subjectCategory;
    }

    public String getEntity() {
        return entity;
    }

    public void setEntity(String entity) {
        this.entity = entity;
    }

    public String getField() {
        return field;
    }

    public void setField(String field) {
        this.field = field;
    }

    public String getFieldName() {
        return fieldName;
    }

    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }
    
}