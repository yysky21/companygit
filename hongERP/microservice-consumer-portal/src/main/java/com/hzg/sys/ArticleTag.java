package com.hzg.sys;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: ArticleTag.java
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2017/9/26
 */

@Entity(name = "hzg_article_tag")
public class ArticleTag implements Serializable {

    private static final long serialVersionUID = 660940222308324695L;

    public ArticleTag(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @Column(name="name",length=20)
    private String name;

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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Timestamp getInputDate() {
        return inputDate;
    }

    public void setInputDate(Timestamp inputDate) {
        this.inputDate = inputDate;
    }
}