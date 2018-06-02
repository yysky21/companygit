package com.hzg.erp;

import com.hzg.sys.Article;
import com.hzg.sys.ArticleCate;
import com.hzg.sys.User;
import com.hzg.tools.*;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: ErpService.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2017/6/28
 */
@Service
public class DataTransformService {

    Logger logger = Logger.getLogger(DataTransformService.class);

    @Autowired
    private DataTransformDao dataTransformDao;

    @Autowired
    private SysClient sysClient;

    @Autowired
    private PayClient payClient;

    @Autowired
    private OrderClient orderClient;

    @Autowired
    private AfterSaleServiceClient afterSaleServiceClient;

    @Autowired
    private Writer writer;

    @Autowired
    public ObjectToSql objectToSql;

    @Autowired
    public SessionFactory sessionFactory;

    @Autowired
    private DateUtil dateUtil;

    @Autowired
    BarcodeUtil barcodeUtil;

    @Autowired
    ImageBase64 imageBase64;

    @Autowired
    private  StrUtil strUtil;

    public String saveProduct(Object[] objects) {
        String failProductIds = "";

        try {
            Product product = new Product();
            product.setNo(strUtil.getStringValue(objects[31]));
            product.setName(strUtil.getStringValue(objects[4]));
            product.setPrice(strUtil.getFloatValue(strUtil.getStringValue(objects[29]).replaceAll("[^-0-9?!.]","")));
            product.setFatePrice(strUtil.getFloatValue(objects[30]));
            if (strUtil.getIntegerValue(objects[39]) == 0) {
                product.setState(ErpConstant.product_state_onSale);
            } else {
                product.setState(ErpConstant.product_state_sold);
            }
            product.setUseType(ErpConstant.product);

            if (objects[1] != null) {
                String oldTypeSql = "select t.* from web_categoryproduct t where t.categoryproduct_id = " + strUtil.getIntegerValue(objects[1]);
                List<Object[]> oldTypeValues = (List<Object[]>) sessionFactory.getCurrentSession().createSQLQuery(oldTypeSql).list();

                if (!oldTypeValues.isEmpty()) {
                    ProductType productType = new ProductType();
                    productType.setName(strUtil.getStringValue(oldTypeValues.get(0)[1]));
                    List<ProductType> productTypes = dataTransformDao.query(productType);

                    if (!productTypes.isEmpty()) {
                        product.setType(productTypes.get(0));

                    } else {
                        productType.setAbbreviate(strUtil.getStringValue(oldTypeValues.get(0)[3]));
                        productType.setDescribes(strUtil.getStringValue(oldTypeValues.get(0)[8]));
                        productType.setKeyword(strUtil.getStringValue(oldTypeValues.get(0)[7]));
                        productType.setTitle(strUtil.getStringValue(oldTypeValues.get(0)[6]));
                        productType.setParent(new ProductType(strUtil.getIntegerValue(oldTypeValues.get(0)[2])));

                        dataTransformDao.save(productType);
                        product.setType(productType);
                    }
                }
            }

            ProductDescribe describe = new ProductDescribe();
            if (objects[3] != null) {
                String oldAdminSql = "select t.* from web_admin t where t.admin_id = " + strUtil.getIntegerValue(objects[3]) + "";
                List<Object[]> oldAdminValues = (List<Object[]>) sessionFactory.getCurrentSession().createSQLQuery(oldAdminSql).list();

                if (!oldAdminValues.isEmpty()) {
                    User user = new User();
                    user.setUsername(strUtil.getStringValue(oldAdminValues.get(0)[2]));
                    List<User> users = dataTransformDao.query(user);

                    if (!users.isEmpty()) {
                        describe.setEditor(users.get(0));
                    } else {

                        user.setName(strUtil.getStringValue(oldAdminValues.get(0)[3]));
                        user.setPassword(DigestUtils.md5Hex(strUtil.generateRandomStr(8)).toUpperCase());
                        user.setEmail(strUtil.getStringValue(oldAdminValues.get(0)[6]));

                        dataTransformDao.save(user);
                        describe.setEditor(user);
                    }
                }

                describe.setDescribes(strUtil.getStringValue(objects[8])+strUtil.getStringValue(objects[9]));
                /**
                 * 老系统图片目录结构和新系统不一致，这里把老系统商品的图片设置为新系统商品描述的图片父文件夹
                 * snapshotImgPath like: /uploads/2017/04/1493285466-DnRDGm.jpg
                 */
                describe.setImageParentDirPath(strUtil.getStringValue(objects[5]));
                describe.setSeoDesc(strUtil.getStringValue(objects[17]));
                describe.setSeoKeyword(strUtil.getStringValue(objects[16]));
                describe.setSeoTitle(strUtil.getStringValue(objects[15]));
                describe.setDate(strUtil.getTimestampByDate(strUtil.getDateValue(objects[10])));
            }

            product.setDescribe(describe);

            if (objects[50] != null) {
                String oldSupplierSql = "select t.* from web_supplier t where t.supplier_number = '" + strUtil.getStringValue(objects[50]) + "'";
                List<Object[]> oldSupplierValues = (List<Object[]>) sessionFactory.getCurrentSession().createSQLQuery(oldSupplierSql).list();

                if (!oldSupplierValues.isEmpty()) {
                    Supplier supplier = new Supplier();
                    supplier.setName(strUtil.getStringValue(oldSupplierValues.get(0)[10]));
                    List<Supplier> suppliers = dataTransformDao.query(supplier);

                    if (!suppliers.isEmpty()) {
                        product.setSupplier(suppliers.get(0));

                    } else {
                        if (oldSupplierValues.get(0)[3] != null) {
                            if (strUtil.getIntegerValue(oldSupplierValues.get(0)[3]) == 1) {
                                supplier.setState(ErpConstant.supplier_state_valid);
                            } else {
                                supplier.setState(ErpConstant.supplier_state_cancel);
                            }
                        }
                        supplier.setAddress(strUtil.getStringValue(oldSupplierValues.get(0)[7]));
                        supplier.setCharger(strUtil.getStringValue(oldSupplierValues.get(0)[1]));
                        supplier.setPhone(strUtil.getStringValue(oldSupplierValues.get(0)[6]));
                        supplier.setCooperateDate(strUtil.getTimestampValue(oldSupplierValues.get(0)[4]));
                        supplier.setInputDate(strUtil.getTimestampValue(oldSupplierValues.get(0)[4]));
                        supplier.setTypes(new Integer[]{0,1});
                        supplier.setAccount("");
                        supplier.setBranch("");
                        supplier.setBank("");
                        supplier.setPayTypes(new Integer[]{0,1,2,3,4,5,6});

                        if (product.getType() != null) {
                            supplier.setMainProductType(product.getType());
                        } else {
                            supplier.setMainProductType(new ProductType(0));
                        }

                        if (product.getDescribe().getEditor() != null) {
                            supplier.setInputer(product.getDescribe().getEditor());
                        } else {
                            supplier.setInputer(new User(0));
                        }

                        dataTransformDao.save(supplier);
                        product.setSupplier(supplier);
                    }
                }
            }

            String oldPropertiesSql = "select t1.attr_name as attrName, t.attr_value as attrValue from web_product_attr t, web_attribute t1 where t.goods_id = " + strUtil.getIntegerValue(objects[0]) + " and t.attr_id = t1.attr_id";
            List<Object[]> oldPropertiesValues = (List<Object[]>) sessionFactory.getCurrentSession().createSQLQuery(oldPropertiesSql).list();

            if (!oldPropertiesValues.isEmpty()) {
                Set<ProductOwnProperty> properties = new HashSet<>();
                for (Object[] oldPropertyValue : oldPropertiesValues) {

                    ProductOwnProperty property = new ProductOwnProperty();
                    property.setName(strUtil.getStringValue(oldPropertyValue[0]));
                    property.setValue(strUtil.getStringValue(oldPropertyValue[1]));

                    properties.add(property);
                }

                product.setProperties(properties);
            }

            Integer fatePrice =(int) Math.ceil(product.getFatePrice()/100);
            ProductOwnProperty productOwnProperty = new ProductOwnProperty();
            productOwnProperty.setName(ErpConstant.product_property_name_priceRange);
            productOwnProperty.setValue(fatePrice.toString());
            product.getProperties().add(productOwnProperty);

            dataTransformDao.save(product.getDescribe());
            dataTransformDao.save(product);

            Product doubleRelateProduct = new Product();
            doubleRelateProduct.setId(product.getId());
            for (ProductOwnProperty ownProperty : product.getProperties()) {
                ownProperty.setProduct(doubleRelateProduct);
                dataTransformDao.save(ownProperty);
            }

            List<User> users = dataTransformDao.query(new User());

            Purchase purchase = new Purchase();
            purchase.setNo(dataTransformDao.getNo(ErpConstant.no_purchase_perfix));
            purchase.setName("采购"+product.getNo());
            purchase.setType(ErpConstant.purchase_type_normal);
            purchase.setState(ErpConstant.purchase_state_close);
            purchase.setInputDate(dateUtil.getSecondCurrentTimestamp());
            if (!users.isEmpty()) {
                purchase.setCharger(users.get(0));
                purchase.setInputer(users.get(0));
            }
            dataTransformDao.save(purchase);

            PurchaseDetail purchaseDetail = new PurchaseDetail();
            purchaseDetail.setPurchase(purchase);
            purchaseDetail.setProductNo(product.getNo());
            purchaseDetail.setProductName(product.getName());
            purchaseDetail.setQuantity(1f);
            purchaseDetail.setUnit("piece");
            purchaseDetail.setSupplier(product.getSupplier());
            dataTransformDao.save(purchaseDetail);

            PurchaseDetailProduct purchaseDetailProduct = new PurchaseDetailProduct();
            purchaseDetailProduct.setProduct(product);
            purchaseDetailProduct.setPurchaseDetail(purchaseDetail);
            dataTransformDao.save(purchaseDetailProduct);


            List<Warehouse> warehouses = dataTransformDao.query(new Warehouse());

            StockInOut stockInOut = new StockInOut();
            stockInOut.setNo(dataTransformDao.getNo(ErpConstant.no_stockInOut_perfix));
            stockInOut.setType(ErpConstant.stockInOut_type_increment);
            if (!warehouses.isEmpty()) {
                stockInOut.setWarehouse(warehouses.get(0));
            }
            stockInOut.setState(ErpConstant.stockInOut_state_finished);
            stockInOut.setInputDate(dateUtil.getSecondCurrentTimestamp());
            dataTransformDao.save(stockInOut);

            StockInOutDetail stockInOutDetail = new StockInOutDetail();
            stockInOutDetail.setState(ErpConstant.stockInOut_detail_state_finished);
            stockInOutDetail.setStockInOut(stockInOut);
            stockInOutDetail.setProductNo(product.getNo());
            stockInOutDetail.setQuantity(1f);
            stockInOutDetail.setUnit("piece");
            dataTransformDao.save(stockInOutDetail);

            StockInOutDetailProduct stockInOutDetailProduct = new StockInOutDetailProduct();
            stockInOutDetailProduct.setProduct(product);
            stockInOutDetailProduct.setStockInOutDetail(stockInOutDetail);
            dataTransformDao.save(stockInOutDetailProduct);


            Stock stock = new Stock();
            stock.setProductNo(product.getNo());
            List<Stock> dbStocks = dataTransformDao.query(stock);

            if (!dbStocks.isEmpty()) {
                Stock updateStock = new Stock();
                updateStock.setQuantity(new BigDecimal(Float.toString(dbStocks.get(0).getQuantity())).add(new BigDecimal(Float.toString(1))).floatValue());
                dataTransformDao.updateById(updateStock.getId(), updateStock);

            } else {
                stock.setQuantity(1f);
                stock.setState(ErpConstant.stock_state_valid);
                stock.setUnit("piece");
                stock.setNo(dataTransformDao.getNo(ErpConstant.no_stock_perfix));
                stock.setDate(dateUtil.getSecondCurrentTimestamp());

                if (!warehouses.isEmpty()) {
                    stock.setWarehouse(warehouses.get(0));
                }

                dataTransformDao.save(stock);
            }

        } catch (Exception e) {
            logger.info("product id:" + objects[0] + ", save error");
            logger.error(e.getMessage(), e);
            failProductIds += strUtil.getStringValue(objects[0]) + ":" + e.getMessage() + ";";
        }

        return failProductIds;
    }

    public String saveArticle(Object[] objects) {
        String failProductIds = "";

        try {
            Article article = new Article();
            article.setState(1);
            article.setTitle(strUtil.getStringValue(objects[3]));
            article.setContent(strUtil.getStringValue(objects[8]));
            article.setShortContent(strUtil.getStringValue(objects[18]));
            article.setHits(strUtil.getIntegerValue(objects[12]));
            article.setImageUrl(strUtil.getStringValue(objects[6]));
            article.setInputDate(strUtil.getTimestampByDate(strUtil.getDateValue(objects[10])));
            article.setSeoTitle(strUtil.getStringValue(objects[15]));
            article.setSeoKeyword(strUtil.getStringValue(objects[16]));
            article.setSeoDesc(strUtil.getStringValue(objects[17]));
            article.setPosition(strUtil.getBooleanValue(objects[23]) ? 1 : 0);

            if (objects[2] != null) {
                String oldAdminSql = "select t.* from web_admin t where t.admin_id = " + strUtil.getIntegerValue(objects[2]) + "";
                List<Object[]> oldAdminValues = (List<Object[]>) sessionFactory.getCurrentSession().createSQLQuery(oldAdminSql).list();

                if (!oldAdminValues.isEmpty()) {
                    User user = new User();
                    user.setUsername(strUtil.getStringValue(oldAdminValues.get(0)[2]));
                    List<User> users = dataTransformDao.query(user);

                    if (!users.isEmpty()) {
                        article.setAuthor(users.get(0));
                    } else {

                        user.setName(strUtil.getStringValue(oldAdminValues.get(0)[3]));
                        user.setPassword(DigestUtils.md5Hex(strUtil.generateRandomStr(8)).toUpperCase());
                        user.setEmail(strUtil.getStringValue(oldAdminValues.get(0)[6]));

                        dataTransformDao.save(user);
                       article.setAuthor(user);
                    }
                }
            }

            if (objects[1] != null) {
                String oldCategorySql = "select t.* from web_category t where t.category_id = " + strUtil.getIntegerValue(objects[1]);
                List<Object[]> oldCategoryValues = (List<Object[]>) sessionFactory.getCurrentSession().createSQLQuery(oldCategorySql).list();

                if (!oldCategoryValues.isEmpty()) {
                    ArticleCate articleCate = new ArticleCate();
                    articleCate.setName(strUtil.getStringValue(oldCategoryValues.get(0)[1]));
                    List<ArticleCate> articleCates = dataTransformDao.query(articleCate);

                    if (!articleCates.isEmpty()) {
                        article.setArticleCate(articleCate);

                    } else {
                        articleCate.setParent(new ArticleCate(strUtil.getIntegerValue(oldCategoryValues.get(0)[2])));
                        articleCate.setNickname(strUtil.getStringValue(oldCategoryValues.get(0)[3]));
                        articleCate.setArticleTitle(strUtil.getStringValue(oldCategoryValues.get(0)[6]));
                        articleCate.setArticleKeyword(strUtil.getStringValue(oldCategoryValues.get(0)[7]));
                        articleCate.setArticleDesc(strUtil.getStringValue(oldCategoryValues.get(0)[8]));

                        dataTransformDao.save(articleCate);
                        article.setArticleCate(articleCate);
                    }
                }
            }

            dataTransformDao.save(article);

        } catch (Exception e) {
            logger.info("article id:" + objects[0] + ", save error");
            logger.error(e.getMessage(), e);
            failProductIds += strUtil.getStringValue(objects[0]) + ":" + e.getMessage() + ";";
        }

        return failProductIds;
    }

}