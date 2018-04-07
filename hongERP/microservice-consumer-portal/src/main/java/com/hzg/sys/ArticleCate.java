package com.hzg.sys;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: ArticleCate.java
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2017/9/26
 */

@Entity(name = "hzg_article_cate")
public class ArticleCate implements Serializable {

    private static final long serialVersionUID = 345435245233226L;

    public ArticleCate(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "parentId")
    private ArticleCate parent;

    @Column(name="name",length=20)
    private String name;

    @Column(name="nickname",length=20)
    private String nickname;

    @Column(name="articleTitle",length=50)
    private String articleTitle;

    @Column(name="articleKeyword",length=50)
    private String articleKeyword;

    @Column(name="articleDesc",length=100)
    private String articleDesc;

    @Column(name="inputDate")
    private Timestamp inputDate;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public ArticleCate getParent() {
        return parent;
    }

    public void setParent(ArticleCate parent) {
        this.parent = parent;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getArticleTitle() {
        return articleTitle;
    }

    public void setArticleTitle(String articleTitle) {
        this.articleTitle = articleTitle;
    }

    public String getArticleKeyword() {
        return articleKeyword;
    }

    public void setArticleKeyword(String articleKeyword) {
        this.articleKeyword = articleKeyword;
    }

    public String getArticleDesc() {
        return articleDesc;
    }

    public void setArticleDesc(String articleDesc) {
        this.articleDesc = articleDesc;
    }

    public Timestamp getInputDate() {
        return inputDate;
    }

    public void setInputDate(Timestamp inputDate) {
        this.inputDate = inputDate;
    }
}