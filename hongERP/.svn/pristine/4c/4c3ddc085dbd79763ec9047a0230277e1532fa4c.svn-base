package com.hzg.finance;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Arrays;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: Subject.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2017/11/24
 */
@Entity(name = "hzg_finance_subject")
public class Subject implements Serializable {

    private static final long serialVersionUID = 2486554138700278364L;

    public Subject(){
        super();
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", length = 11)
    private Integer id;

    @Column(name = "no", length = 16)
    private String no; // 科目编码

    @Column(name = "codeRule", length = 16)
    private String codeRule; // 编码规则

    @ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "categoryId")
    private SubjectCategory subjectCategory; // 科目类别id

    @Column(name = "name", length = 20)
    private String name; // 科目名称

    @Column(name = "type", length = 1)
    private Integer type; // 科目类型

    @Column(name = "direction", length = 1)
    private Integer direction; // 余额方向

    @Column(name = "accountItems", length = 20)
    @Type(type = "com.hzg.tools.IntegersType")
    private Integer[] accountItems; // 辅助核算项

    @Column(name = "state", length = 1)
    private Integer state; // 状态(在用/停用)

    @Column(name = "info", length = 1)
    private Integer info; // 填制凭证时是否录入结算信息

    @Column(name = "paperFormat", length = 1)
    private Integer paperFormat; // 账面格式

    @Column(name="inputDate")
    private Timestamp inputDate; // 创建时间

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

    public String getCodeRule() {
        return codeRule;
    }

    public void setCodeRule(String codeRule) {
        this.codeRule = codeRule;
    }

    public SubjectCategory getSubjectCategory() {
        return subjectCategory;
    }

    public void setSubjectCategory(SubjectCategory subjectCategory) {
        this.subjectCategory = subjectCategory;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getDirection() {
        return direction;
    }

    public void setDirection(Integer direction) {
        this.direction = direction;
    }

    public Integer[] getAccountItems() {
        return accountItems;
    }

    public void setAccountItems(Integer[] accountItems) {
        this.accountItems = accountItems;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Integer getInfo() {
        return info;
    }

    public void setInfo(Integer info) {
        this.info = info;
    }

    public Integer getPaperFormat() {
        return paperFormat;
    }

    public void setPaperFormat(Integer paperFormat) {
        this.paperFormat = paperFormat;
    }

    public Timestamp getInputDate() {
        return inputDate;
    }

    public void setInputDate(Timestamp inputDate) {
        this.inputDate = inputDate;
    }

    public String getAccountItemsStr() {
        return Arrays.deepToString(accountItems);
    }
}