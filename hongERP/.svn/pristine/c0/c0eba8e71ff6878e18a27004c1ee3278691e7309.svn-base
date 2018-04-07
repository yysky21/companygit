package com.hzg.finance;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: DocType.java
 * 类的详细说明
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2018/1/8
 */
@Entity(name = "hzg_finance_doctype")
public class DocType implements Serializable {

    private static final long serialVersionUID = 8983030174978330631L;

    public DocType() {
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", length = 11)
    private Integer id;

    @Column(name = "name", length = 16)
    private String name; // 单据类型名称

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
}