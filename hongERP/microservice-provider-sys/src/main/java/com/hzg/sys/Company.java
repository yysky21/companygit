package com.hzg.sys;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: Company.java
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/4/12
 */
@Entity(name = "hzg_sys_company")
public class Company implements Serializable {

    private static final long serialVersionUID = 345435245233218L;

    public Company(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @Column(name="name",length=30)
    private String name;

    @Column(name="phone",length=16)
    private String phone;

    @Column(name="address",length=60)
    private String address;

    @Column(name="city",length=16)
    private String city;

    @Column(name="province",length=16)
    private String province;

    @Column(name="country",length=16)
    private String country;

    @Column(name="inputDate")
    private Timestamp inputDate;

    @OneToOne(cascade = CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "chargerId")
    private User charger;

    @Column(name="postCode",length=7)
    private String postCode;

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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public Timestamp getInputDate() {
        return inputDate;
    }

    public void setInputDate(Timestamp inputDate) {
        this.inputDate = inputDate;
    }

    public User getCharger() {
        return charger;
    }

    public void setCharger(User charger) {
        this.charger = charger;
    }

    public String getPostCode() {
        return postCode;
    }

    public void setPostCode(String postCode) {
        this.postCode = postCode;
    }
}