package com.hzg.erp;

import com.hzg.tools.ProductUtil;
import com.hzg.tools.SpringUtil;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;
import java.util.Set;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: Product.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/5/25
 */
@Entity(name = "hzg_product")
public class Product implements Serializable {
    private static final long serialVersionUID = 345435245233232L;

    public Product(){
        super();
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", length = 11)
    private Integer id;

    @Column(name="no",length=16)
    private String no;

    @Column(name="name",length=30)
    private String name;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "typeId")
    private ProductType type;

    @Column(name="certificate",length=60)
    private String certificate;

    @Column(name="price", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float price;

    @Column(name="fatePrice", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float fatePrice;

    @Column(name="feature",length=6)
    private String feature;

    @Column(name="state",length = 2)
    private Integer state;

    @ManyToOne(cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "supplierId")
    private Supplier supplier;

    @ManyToOne(cascade = CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "describeId")
    private ProductDescribe describe;

    @Column(name="costPrice", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float costPrice;

    @Column(name="unitPrice", length = 32)
    @Type(type = "com.hzg.tools.FloatDesType")
    private Float unitPrice;

    @Column(name="useType", length = 12)
    private String useType;

    @OneToMany(mappedBy = "product", cascade=CascadeType.DETACH, fetch = FetchType.LAZY)
    private Set<ProductOwnProperty> properties;

    @Transient
    private Float soldQuantity;

    @Transient
    private String soldUnit;

    @Transient
    private Float returnQuantity;

    @Transient
    private String returnUnit;

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

    public ProductType getType() {
        return type;
    }

    public void setType(ProductType type) {
        this.type = type;
    }

    public String getCertificate() {
        return certificate;
    }

    public void setCertificate(String certificate) {
        this.certificate = certificate;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public Float getFatePrice() {
        return fatePrice;
    }

    public void setFatePrice(Float fatePrice) {
        this.fatePrice = fatePrice;
    }

    public String getFeature() {
        return feature;
    }

    public void setFeature(String feature) {
        this.feature = feature;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public ProductDescribe getDescribe() {
        return describe;
    }

    public void setDescribe(ProductDescribe describe) {
        this.describe = describe;
    }

    public Float getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(Float costPrice) {
        this.costPrice = costPrice;
    }

    public Float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(Float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getUseType() {
        return useType;
    }

    public void setUseType(String useType) {
        this.useType = useType;
    }

    public Set<ProductOwnProperty> getProperties() {
        return properties;
    }

    public void setProperties(Set<ProductOwnProperty> properties) {
        this.properties = properties;
    }

    public Float getSoldQuantity() {
        return soldQuantity;
    }

    public void setSoldQuantity(Float soldQuantity) {
        this.soldQuantity = soldQuantity;
    }

    public String getSoldUnit() {
        return soldUnit;
    }

    public void setSoldUnit(String soldUnit) {
        this.soldUnit = soldUnit;
    }

    public Float getReturnQuantity() {
        return returnQuantity;
    }

    public void setReturnQuantity(Float returnQuantity) {
        this.returnQuantity = returnQuantity;
    }

    public String getReturnUnit() {
        return returnUnit;
    }

    public void setReturnUnit(String returnUnit) {
        this.returnUnit = returnUnit;
    }

    public String getStateName() {
        switch (state) {
            case 0 : return "采购";
            case 1 : return "入库";
            case 2 : return "出库";
            case 3 : return "在售";
            case 4 : return "已售";
            case 10 : return "采购审核通过";
            case 11 : return "采购完成";
            case 6 : return "编辑";
            case 7 : return "多媒体文件已上传";
            case 8 : return "已发货";
            case 9 : return "申请退货";
            case 91 : return "已退货";
            case 92 : return "申请换货";
            case 93 : return "已换货";
            default : return "";
        }
    }

    public String getPropertyValue(String name) {
        String realName = ((ProductUtil)SpringUtil.getBean("productUtil")).getPropertyName(name, type.getName());

        if (properties != null) {
            for (ProductOwnProperty property : properties) {
                if (property.getName().equals(realName)) {
                    return property.getValue();
                }
            }
        }

        return "";
    }

    public String getPropertyJson(String name) {
        String json = "";

        String realName = ((ProductUtil)SpringUtil.getBean("productUtil")).getPropertyName(name, type.getName());

        if (properties != null) {
            for (ProductOwnProperty property : properties) {
                if (property.getName().equals(realName)) {

                    if (property.getProperty() != null) {
                        json = "{\"property\":{\"id\":" + property.getProperty().getId() + "},\"name\":\"" + property.getName() + "\",\"value\":\"" + property.getValue() + "\"}";
                    } else {
                        json = "{\"name\":\"" + property.getName() + "\",\"value\":\"" + property.getValue() + "\"}";
                    }

                    break;
                }
            }
        }

        return json;
    }

    public String getPropertyJson(String name, String value) {
        String json = "";

        String realName = ((ProductUtil)SpringUtil.getBean("productUtil")).getPropertyName(name, type.getName());

        if (properties != null) {
            for (ProductOwnProperty property : properties) {
                if (property.getName().equals(realName) && property.getValue().equals(value)) {

                    if (property.getProperty() != null) {
                        json = "{\"property\":{\"id\":" + property.getProperty().getId() + "},\"name\":\"" + property.getName() + "\",\"value\":\"" + property.getValue() + "\"}";
                    } else {
                        json = "{\"name\":\"" + property.getName() + "\",\"value\":\"" + property.getValue() + "\"}";
                    }


                    break;
                }
            }
        }

        return json;
    }

    public String getMutilPropertyValues(String name) {
        String values = "";

        String realName = ((ProductUtil)SpringUtil.getBean("productUtil")).getPropertyName(name, type.getName());

        if (properties != null) {
            for (ProductOwnProperty property : properties) {
                if (property.getName().equals(realName)) {
                    values += property.getValue() + "#";
                }
            }
        }

        return values.equals("") ? "" : values.substring(0, values.length()-1);
    }

    public String getPropertyCode(String typeName, String propertyName) {
        return ((ProductUtil)SpringUtil.getBean("productUtil")).getPropertyCode(typeName, propertyName);
    }

    public String getPropertyQuantityType(String propertyName) {
        return ((ProductUtil)SpringUtil.getBean("productUtil")).getPropertyQuantityType(propertyName);
    }
}
