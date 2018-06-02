package com.hzg.sys;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Set;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: Article.java
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2017/9/26
 */
@Entity(name = "hzg_article")
public class Article implements Serializable {

    private static final long serialVersionUID = 345435245233219L;

    public Article(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "cateId")
    private ArticleCate articleCate;

    @Column(name="title",length=100)
    private String title;

    @Column(name="imageUrl",length=50)
    private String imageUrl;

    @Column(name="content")
    private String content;

    @Column(name="shortContent",length=300)
    private String shortContent;

    @Column(name="position", length = 1)
    private Integer position;

    @Column(name="hits", length = 11)
    private Integer hits;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "authorId")
    private User author;

    @Column(name="inputDate")
    private Timestamp inputDate;

    @Column(name="state", length = 1)
    private Integer state;

    @Column(name="seoTitle",length=80)
    private String seoTitle;

    @Column(name="seoKeyword",length=80)
    private String seoKeyword;

    @Column(name="seoDesc",length=100)
    private String seoDesc;

    @ManyToMany(cascade = {CascadeType.DETACH}, fetch = FetchType.LAZY)
    @JoinTable(name = "hzg_articletag_relation"
            , joinColumns = {@JoinColumn(name = "articleId")}
            , inverseJoinColumns = {@JoinColumn(name = "tagId")})
    private Set<ArticleTag> articleTags;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public ArticleCate getArticleCate() {
        return articleCate;
    }

    public void setArticleCate(ArticleCate articleCate) {
        this.articleCate = articleCate;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getShortContent() {
        return shortContent;
    }

    public void setShortContent(String shortContent) {
        this.shortContent = shortContent;
    }

    public Integer getPosition() {
        return position;
    }

    public void setPosition(Integer position) {
        this.position = position;
    }

    public Integer getHits() {
        return hits;
    }

    public void setHits(Integer hits) {
        this.hits = hits;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public Timestamp getInputDate() {
        return inputDate;
    }

    public void setInputDate(Timestamp inputDate) {
        this.inputDate = inputDate;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getSeoTitle() {
        return seoTitle;
    }

    public void setSeoTitle(String seoTitle) {
        this.seoTitle = seoTitle;
    }

    public String getSeoKeyword() {
        return seoKeyword;
    }

    public void setSeoKeyword(String seoKeyword) {
        this.seoKeyword = seoKeyword;
    }

    public String getSeoDesc() {
        return seoDesc;
    }

    public void setSeoDesc(String seoDesc) {
        this.seoDesc = seoDesc;
    }

    public Set<ArticleTag> getArticleTags() {
        return articleTags;
    }

    public void setArticleTags(Set<ArticleTag> articleTags) {
        this.articleTags = articleTags;
    }
}