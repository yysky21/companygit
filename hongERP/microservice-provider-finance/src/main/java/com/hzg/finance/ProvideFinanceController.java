package com.hzg.finance;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.hzg.erp.ProductType;
import com.hzg.erp.Purchase;
import com.hzg.erp.Supplier;
import com.hzg.erp.Warehouse;
import com.hzg.pay.Account;
import com.hzg.sys.*;
import com.hzg.tools.*;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletResponse;
import java.math.BigInteger;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: FinanceController.java
 *
 * @author yuanyun
 * @version 1.00
 * @Date 2017/11/25
 */
@Controller
@RequestMapping("/finance")
public class ProvideFinanceController {

    Logger logger = Logger.getLogger(ProvideFinanceController.class);

    @Autowired
    private FinanceDao financeDao;

    @Autowired
    private FinanceService financeService;

    @Autowired
    private DateUtil dateUtil;

    @Autowired
    private Writer writer;

    @Autowired
    private Transcation transcation;

    @Autowired
    private SysClient sysClient;

    /**
     * 保存实体
     * @param response
     * @param entity
     * @param json
     */
    @Transactional
    @PostMapping("/save")
    public void save(HttpServletResponse response, String entity, @RequestBody String json){
        logger.info("save start, parameter:" + entity + ":" + json);

        String result = CommonConstant.fail;
        Timestamp inputDate = dateUtil.getSecondCurrentTimestamp();

        try {
            if (entity.equalsIgnoreCase(Voucher.class.getSimpleName())) {
                List<Voucher> vouchers = writer.gson.fromJson(json, new TypeToken<List<Voucher>>() {}.getType());
                for (Voucher voucher : vouchers){
                    Set<VoucherItemSource> voucherItemSources = voucher.getVoucherItemSources();
                    if ( voucherItemSources != null && !voucherItemSources.isEmpty()){
                        Iterator<VoucherItemSource> iterator = voucherItemSources.iterator();
                        VoucherItemSource voucherItemSource = new VoucherItemSource();
                        while (iterator.hasNext()){
                            voucherItemSource = iterator.next();
                            break;
                        }
                        VoucherItemSource voucherItemSource1 = (VoucherItemSource)financeDao.queryById(voucherItemSource.getId(),VoucherItemSource.class);
                        if (voucherItemSource1.getState() == 0){
                            continue;
                        } else {
                            voucher.setTotalCapital(CapitalConvert.change(voucher.getDebit()));
                            // 保存凭证
                            result += financeDao.save(voucher);
                            // 保存凭证明细
                            result += financeService.saveVoucherDetail(voucher);
                            // 修改凭证条目来源的状态为0，即已生成
                            result += financeService.updateVoucherItemSource(voucher);
                            /**
                             * 提醒审核人员审核凭证
                             */
                            String auditEntity = AuditFlowConstant.business_voucherAudit;
                            result += financeService.launchAuditFlow(auditEntity, voucher.getId(), "请审核凭证编号为" +voucher.getNo()+"的凭证",
                                    "请审核凭证编号为" +voucher.getNo()+"的凭证" ,voucher.getChartMaker());
                        }
                    } else {
                        voucher.setTotalCapital(CapitalConvert.change(voucher.getDebit()));
                        // 保存凭证
                        result += financeDao.save(voucher);
                        // 保存凭证明细
                        result += financeService.saveVoucherDetail(voucher);
                        /**
                         * 提醒审核人员审核凭证
                         */
                        String auditEntity = AuditFlowConstant.business_voucherAudit;
                        result += financeService.launchAuditFlow(auditEntity, voucher.getId(), "请审核凭证编号为" +voucher.getNo()+"的凭证",
                                "请审核凭证编号为" +voucher.getNo()+"的凭证" ,voucher.getChartMaker());
                    }
                }
                if (result.equals(CommonConstant.fail)){
                    result += "凭证已经全部保存过了";
                }

            } else if (entity.equalsIgnoreCase(VoucherCategory.class.getSimpleName())){
                VoucherCategory voucherCategory = writer.gson.fromJson(json, VoucherCategory.class);
                voucherCategory.setInputDate(inputDate);
                result = financeDao.save(voucherCategory);

            } else if (entity.equalsIgnoreCase(Subject.class.getSimpleName())){
                Subject subject = writer.gson.fromJson(json, Subject.class);
                subject.setInputDate(inputDate);
                result = financeDao.save(subject);

            } else if (entity.equalsIgnoreCase(BankSubjectExtend.class.getSimpleName())){
                if (json.equals("[{}]")){
                    List<BankSubjectExtend> lists = financeDao.queryAll(BankSubjectExtend.class);
                    if (lists != null ) {
                        if (!lists.isEmpty()){
                            // 删除所有记录
                            result += financeDao.delAll(BankSubjectExtend.class);
                        } else {
                            // 不做处理
                            result += "fail,扩展设置数据不能为空，请输入值！";
                        }
                    } else {
                        // 不做处理
                        result += "fail,扩展设置数据不能为空，请输入值！";
                    }
                } else {
                    List<BankSubjectExtend> bankSubjectExtends = writer.gson.fromJson(json, new TypeToken<List<BankSubjectExtend>>() {
                    }.getType());
                    // 新增的第一条扩展的id
                    Integer id = 0;
                    for (int i = 0; i < bankSubjectExtends.size(); i++) {
                        result += financeDao.save(bankSubjectExtends.get(i));
                        if (i == 0 && transcation.dealResult(result) == CommonConstant.success) {
                            id = bankSubjectExtends.get(i).getId();
                        }
                    }
                    //查看之前是否有记录
                    List<BankSubjectExtend> lists = financeDao.queryPart(BankSubjectExtend.class, id);
                    if (lists != null && !lists.isEmpty() && transcation.dealResult(result) == CommonConstant.success) {
                        // 删除之前的所有记录
                        result += financeDao.delPart(BankSubjectExtend.class, id);
                    }
                }
            } else if (entity.equalsIgnoreCase(PurchaseSubjectExtend.class.getSimpleName())){
                if (json.equals("[{}]")){
                    List<PurchaseSubjectExtend> lists = financeDao.queryAll(PurchaseSubjectExtend.class);
                    if (lists != null ) {
                        if (!lists.isEmpty()){
                            // 删除所有记录
                            result += financeDao.delAll(PurchaseSubjectExtend.class);
                        } else {
                            // 不做处理
                            result += "fail,扩展设置数据不能为空，请输入值！";
                        }
                    } else {
                        // 不做处理
                        result += "fail,扩展设置数据不能为空，请输入值！";
                    }
                } else {
                    List<PurchaseSubjectExtend> purchaseSubjectExtends = writer.gson.fromJson(json, new TypeToken<List<PurchaseSubjectExtend>>() {
                    }.getType());
                    // 新增的第一条扩展的id
                    Integer id = 0;
                    for (int i = 0; i < purchaseSubjectExtends.size(); i++) {
                        result += financeDao.save(purchaseSubjectExtends.get(i));
                        if (i == 0 && transcation.dealResult(result) == CommonConstant.success) {
                            id = purchaseSubjectExtends.get(i).getId();
                        }
                    }
                    //查看之前是否有记录
                    List<PurchaseSubjectExtend> lists = financeDao.queryPart(PurchaseSubjectExtend.class, id);
                    if (lists != null && !lists.isEmpty() && transcation.dealResult(result) == CommonConstant.success) {
                        // 删除之前的所有记录
                        result += financeDao.delPart(PurchaseSubjectExtend.class, id);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            result += CommonConstant.fail;
        } finally {
            result = transcation.dealResult(result);
        }

        writer.writeStringToJson(response, "{\"" + CommonConstant.result + "\":\"" + result + "\"}");
        logger.info("save end, result:" + result);
    }

    @RequestMapping(value = "/query", method = {RequestMethod.GET, RequestMethod.POST})
    public void query(HttpServletResponse response, String entity, @RequestBody String json){
        logger.info("query start, parameter:" + entity + ":" + json);

        if (entity.equalsIgnoreCase(Voucher.class.getSimpleName())) {
            Voucher voucher = writer.gson.fromJson(json, Voucher.class);
             List<Voucher> vouchers = financeDao.query(voucher);
            for (Voucher voucher1 : vouchers) {
                Set<VoucherDetail> voucherDetails = voucher1.getDetails();
                for (VoucherDetail voucherDetail : voucherDetails){
                    int id = voucherDetail.getVoucherItem().getId();
                    VoucherItem voucherItem = (VoucherItem) financeDao.queryById(id,VoucherItem.class);
                    voucherDetail.setVoucherItem(voucherItem);
                }
            }
            writer.writeObjectToJson(response, vouchers);

        } else if (entity.equalsIgnoreCase(VoucherCategory.class.getSimpleName())){
            VoucherCategory voucherCategory = writer.gson.fromJson(json, VoucherCategory.class);
            writer.writeObjectToJson(response, financeDao.query(voucherCategory));

        } else if (entity.equalsIgnoreCase(Subject.class.getSimpleName())){
            Subject subject = writer.gson.fromJson(json, Subject.class);
            writer.writeObjectToJson(response, financeDao.query(subject));

        } else if (entity.equalsIgnoreCase(SubjectCategory.class.getSimpleName())){
            SubjectCategory subjectCategory = writer.gson.fromJson(json, SubjectCategory.class);
            writer.writeObjectToJson(response, financeDao.query(subjectCategory));

        } else if (entity.equalsIgnoreCase(SubjectRelate.class.getSimpleName())){
            SubjectRelate subjectRelate = writer.gson.fromJson(json, SubjectRelate.class);
            writer.writeObjectToJson(response, financeDao.query(subjectRelate));

        }

        logger.info("query end");
    }

    @RequestMapping(value = "/queryDistinct", method = {RequestMethod.GET, RequestMethod.POST})
    public void queryDistinct(HttpServletResponse response, String entity){
        logger.info("queryDistinct start, parameter:" + entity);

        if (entity.equalsIgnoreCase(Subject.class.getSimpleName())){
            Subject subject = new Subject();
            List<Subject> subjects = financeDao.queryDistinct(subject);
            for (Subject subject1:subjects) {
                Integer idd = subject1.getSubjectCategory().getId();
                SubjectCategory subjectCategory = (SubjectCategory)financeDao.queryById(idd,SubjectCategory.class);
                subject1.setSubjectCategory(subjectCategory);
            }
            writer.writeObjectToJson(response, subjects);

        } else if (entity.equalsIgnoreCase(BankSubjectExtend.class.getSimpleName())){
            BankSubjectExtend bankSubjectExtend = new BankSubjectExtend();
            List<BankSubjectExtend> bankSubjectExtends = financeDao.queryDistinct(bankSubjectExtend);
            for (BankSubjectExtend bankSubjectExtend1:bankSubjectExtends) {
                Integer id1 = bankSubjectExtend1.getAccount().getId();
                Integer id2 = bankSubjectExtend1.getSubject().getId();
                Account account = (Account)financeDao.queryById(id1,Account.class);
                Subject subject = (Subject)financeDao.queryById(id2,Subject.class);
                bankSubjectExtend1.setAccount(account);
                bankSubjectExtend1.setSubject(subject);
            }
            writer.writeObjectToJson(response, bankSubjectExtends);

        } else if (entity.equalsIgnoreCase(PurchaseSubjectExtend.class.getSimpleName())){
            PurchaseSubjectExtend purchaseSubjectExtend = new PurchaseSubjectExtend();
            List<PurchaseSubjectExtend> purchaseSubjectExtends = financeDao.queryDistinct(purchaseSubjectExtend);
            for (PurchaseSubjectExtend purchaseSubjectExtend1:purchaseSubjectExtends) {
                Integer id1 = purchaseSubjectExtend1.getSupplier().getId();
                Integer id2 = purchaseSubjectExtend1.getSubject().getId();
                Supplier supplier = (Supplier) financeDao.queryById(id1,Supplier.class);
                Subject subject = (Subject)financeDao.queryById(id2,Subject.class);
                purchaseSubjectExtend1.setSupplier(supplier);
                purchaseSubjectExtend1.setSubject(subject);
            }
            writer.writeObjectToJson(response, purchaseSubjectExtends);
        }

        logger.info("queryDistinct end");
    }

    @RequestMapping(value = "/suggest", method = {RequestMethod.GET, RequestMethod.POST})
    public void suggest(HttpServletResponse response, String entity, @RequestBody String json){
        logger.info("suggest start, parameter:" + entity + ":" + json);

        if (entity.equalsIgnoreCase(VoucherCategory.class.getSimpleName())) {
            VoucherCategory voucherCategory = writer.gson.fromJson(json, VoucherCategory.class);
            writer.writeObjectToJson(response, financeDao.suggest(voucherCategory, null));

        } else if (entity.equalsIgnoreCase(Subject.class.getSimpleName())){
            Subject subject = writer.gson.fromJson(json, Subject.class);
            writer.writeObjectToJson(response, financeDao.suggest(subject, null));

        } else if (entity.equalsIgnoreCase(Supplier.class.getSimpleName())){
            Supplier supplier = writer.gson.fromJson(json, Supplier.class);
            writer.writeObjectToJson(response, financeDao.suggest(supplier, null));

        }else if (entity.equalsIgnoreCase(User.class.getSimpleName())){
            User user = writer.gson.fromJson(json, User.class);
            writer.writeObjectToJson(response, financeDao.suggest(user, null));

        }else if (entity.equalsIgnoreCase(Account.class.getSimpleName())){
            Account account = writer.gson.fromJson(json, Account.class);
            writer.writeObjectToJson(response, financeDao.suggest(account, null));
        }
        logger.info("suggest end");
    }

    @RequestMapping(value = "/getNo", method = {RequestMethod.GET, RequestMethod.POST})
    public void obtainNo(HttpServletResponse response){
        logger.info("getNo start" );
        writer.writeStringToJson(response, "{\"" + FinanceConstant.no + "\":\"" + financeDao.getNo() + "\"}");
        logger.info("getNo end");
    }

    @RequestMapping(value = "/complexQuery", method = {RequestMethod.GET, RequestMethod.POST})
    public void complexQuery(HttpServletResponse response, String entity, @RequestBody String json, int position, int rowNum){
        logger.info("complexQuery start, parameter:" + entity + ":" + json + "," + position + "," + rowNum);

        Map<String, String> queryParameters = null;
        try {
            queryParameters = writer.gson.fromJson(json, new TypeToken<Map<String, String>>(){}.getType());
        } catch (Exception e){
            e.getMessage();
        }

        if (entity.equalsIgnoreCase(Voucher.class.getSimpleName())) {
            writer.writeObjectToJson(response, financeService.privateQuery(entity, json, position, rowNum));

        } else if (entity.equalsIgnoreCase(VoucherCategory.class.getSimpleName())) {
            List<VoucherCategory> voucherCategories = financeDao.complexQuery(VoucherCategory.class, queryParameters, position, rowNum);
            writer.writeObjectToJson(response, voucherCategories);

        } else if (entity.equalsIgnoreCase(Subject.class.getSimpleName())) {
            List<Subject> subjects = financeDao.complexQuery(Subject.class, queryParameters, position, rowNum);
            writer.writeObjectToJson(response, subjects);

        } else if (entity.equalsIgnoreCase(DocType.class.getSimpleName())) {
            List<DocType> docTypes = financeDao.complexQuery(DocType.class, queryParameters, position, rowNum);
            writer.writeObjectToJson(response, docTypes);

        } else if (entity.equalsIgnoreCase(FinanceConstant.chartMaker)) {
            List<User> users = financeDao.complexQuery(User.class, queryParameters, position, rowNum);
            for (User user : users){
                Set<Post> posts = user.getPosts();
                Set<Post> posts1 = new HashSet<Post>();
                for (Post post : posts){
                    List<Post> posts2 = writer.gson.fromJson(
                            sysClient.query(Post.class.getSimpleName().toLowerCase(), writer.gson.toJson(post)),
                            new com.google.gson.reflect.TypeToken<List<Post>>() {}.getType());
                    posts1.add(posts2.get(0));
                }
                user.setPosts(posts1);
            }
            writer.writeObjectToJson(response, users);

        } else if (entity.equalsIgnoreCase(Warehouse.class.getSimpleName())) {
            List<Warehouse> warehouses = financeDao.complexQuery(Warehouse.class, queryParameters, position, rowNum);
            writer.writeObjectToJson(response, warehouses);

        } else if (entity.equalsIgnoreCase(ProductType.class.getSimpleName())) {
            List<ProductType> productTypes = financeDao.complexQuery(ProductType.class, queryParameters, position, rowNum);
            writer.writeObjectToJson(response, productTypes);

        } else if (entity.equalsIgnoreCase(Account.class.getSimpleName())) {
            List<Account> accounts = financeDao.complexQuery(Account.class, queryParameters, position, rowNum);
            writer.writeObjectToJson(response, accounts);

        } else if (entity.equalsIgnoreCase(VoucherItemSource.class.getSimpleName())) {
            writer.writeObjectToJson(response, financeService.privateQuery(entity, json, position, rowNum));

        }

        logger.info("complexQuery end");
    }

    @RequestMapping(value = "/privateQuery", method = {RequestMethod.GET, RequestMethod.POST})
    public void privateQuery(HttpServletResponse response, String entity, @RequestBody String json){
        logger.info("privateQuery start, parameter:" + entity + ":" + json);

        if (entity.equalsIgnoreCase(Subject.class.getSimpleName())) {
            String flag  = "";

            if (financeDao.query(writer.gson.fromJson(json, Subject.class)) != null && !financeDao.query(writer.gson.fromJson(json, Subject.class)).isEmpty()) {
                flag = "true";
            } else {
                flag = "false";
            }
            String js = "{\"flag\":\"" + flag + "\"}";
            writer.writeStringToJson(response, js);

        } else if (entity.equalsIgnoreCase(Voucher.class.getSimpleName())){
            List<VoucherItemSource> voucherItemSourceList = new ArrayList<VoucherItemSource>();
            List<VoucherItemSource> voucherItemSources = writer.gson.fromJson(json, new TypeToken<List<VoucherItemSource>>() {}.getType());
            for (VoucherItemSource voucherItemSource : voucherItemSources){
                VoucherItemSource voucherItemSource1 = (VoucherItemSource) financeDao.query(voucherItemSource).get(0);
                voucherItemSourceList.add(voucherItemSource1);
            }
            List<Voucher> vouchers = new ArrayList<Voucher>();
            // 判断是否需要新建一条凭证的标志，true：代表需要，false：代表不需要
            boolean flag = true;
            Voucher voucher = null;
            Set<VoucherDetail> voucherDetails = null;
            Set<VoucherItemSource> voucherItemSources1 = null;
            for (int i = 0; i < voucherItemSourceList.size(); i++){
                if (flag == true){
                    voucher = new Voucher();
                    voucherDetails = new HashSet<VoucherDetail>();
                    voucherItemSources1 = new HashSet<VoucherItemSource>();
                }
                VoucherItemSource voucherItemSource = voucherItemSourceList.get(i);
                String contactUnit = voucherItemSource.getContactUnit();
                if (contactUnit == null || contactUnit.equals("")){
                    String summary = voucherItemSource.getBusinessType()+"/"+voucherItemSource.getWarehouse().getName();
                    DocType docType = new DocType();
                    if (voucherItemSource.getDocType().getId() == 2){
                        docType.setId(2);
                        DocTypeSubjectRelation docTypeSubjectRelation = new DocTypeSubjectRelation();
                        docTypeSubjectRelation.setDocType(docType);
                        List<DocTypeSubjectRelation> docTypeSubjectRelations = financeDao.query(docTypeSubjectRelation);
                        setAmount(docTypeSubjectRelations,voucherItemSource,voucherDetails,FinanceConstant.purchase_returnProduct,summary);
                        voucher.setDetails(voucherDetails);
                        voucher.setNo(financeDao.getNo());
                        voucher.setDebit(getTotalDebit(voucher));
                        voucher.setCredit(getTotalDebit(voucher));
                        voucherItemSources1.add(voucherItemSource);
                        voucher.setVoucherItemSources(voucherItemSources1);
                        vouchers.add(voucher);
                        flag = true;
                    } else if (voucherItemSource.getDocType().getId() == 4){
                        docType.setId(4);
                        DocTypeSubjectRelation docTypeSubjectRelation = new DocTypeSubjectRelation();
                        docTypeSubjectRelation.setDocType(docType);
                        List<DocTypeSubjectRelation> docTypeSubjectRelations = financeDao.query(docTypeSubjectRelation);
                        setAmount(docTypeSubjectRelations,voucherItemSource,voucherDetails,FinanceConstant.order_returnProduct,summary);
                        voucher.setDetails(voucherDetails);
                        voucher.setNo(financeDao.getNo());
                        voucher.setDebit(getTotalDebit(voucher));
                        voucher.setCredit(getTotalDebit(voucher));
                        voucherItemSources1.add(voucherItemSource);
                        voucher.setVoucherItemSources(voucherItemSources1);
                        vouchers.add(voucher);
                        flag = true;
                    } else if (voucherItemSource.getDocType().getId() == 7){
                        docType.setId(7);
                        DocTypeSubjectRelation docTypeSubjectRelation = new DocTypeSubjectRelation();
                        docTypeSubjectRelation.setDocType(docType);
                        List<DocTypeSubjectRelation> docTypeSubjectRelations = financeDao.query(docTypeSubjectRelation);
                        for (DocTypeSubjectRelation docTypeSubjectRelation1 : docTypeSubjectRelations){
                            VoucherDetail voucherDetail = new VoucherDetail();
                            VoucherItem voucherItem = new VoucherItem();
                            voucherItem.setSummary(summary);
                            voucherItem.setSubject(docTypeSubjectRelation1.getSubject());
                            // 金额方向是借方
                            if (docTypeSubjectRelation1.getDirection() == 1){
                                voucherItem.setDebit(voucherItemSource.getAmount()+Float.parseFloat(voucherItemSource.getExtend()));
                            } else {
                                if (docTypeSubjectRelation1.getSubject().getName().equals(FinanceConstant.processRepair)){
                                    voucherItem.setCredit(Float.parseFloat(voucherItemSource.getExtend()));
                                } else {
                                    voucherItem.setCredit(voucherItemSource.getAmount());
                                }
                            }
                            voucherDetail.setVoucherItem(voucherItem);
                            voucherDetails.add(voucherDetail);
                        }
                        voucher.setDetails(voucherDetails);
                        voucher.setNo(financeDao.getNo());
                        voucher.setDebit(getTotalDebit(voucher));
                        voucher.setCredit(getTotalDebit(voucher));
                        voucherItemSources1.add(voucherItemSource);
                        voucher.setVoucherItemSources(voucherItemSources1);
                        vouchers.add(voucher);
                        flag = true;
                    } else if (voucherItemSource.getDocType().getId() == 8){
                        docType.setId(8);
                        DocTypeSubjectRelation docTypeSubjectRelation = new DocTypeSubjectRelation();
                        docTypeSubjectRelation.setDocType(docType);
                        List<DocTypeSubjectRelation> docTypeSubjectRelations = financeDao.query(docTypeSubjectRelation);
                        for (DocTypeSubjectRelation docTypeSubjectRelation1 : docTypeSubjectRelations){
                            VoucherDetail voucherDetail = new VoucherDetail();
                            VoucherItem voucherItem = new VoucherItem();
                            voucherItem.setSummary(summary);
                            voucherItem.setSubject(docTypeSubjectRelation1.getSubject());
                            // 金额方向是借方
                            if (docTypeSubjectRelation1.getDirection() == 1){
                                voucherItem.setDebit(voucherItemSource.getAmount());
                            } else {
                                voucherItem.setCredit(voucherItemSource.getAmount());
                            }
                            voucherDetail.setVoucherItem(voucherItem);
                            voucherDetails.add(voucherDetail);
                        }
                        voucher.setDetails(voucherDetails);
                        voucher.setNo(financeDao.getNo());
                        voucher.setDebit(getTotalDebit(voucher));
                        voucher.setCredit(getTotalDebit(voucher));
                        voucherItemSources1.add(voucherItemSource);
                        voucher.setVoucherItemSources(voucherItemSources1);
                        vouchers.add(voucher);
                        flag = true;
                    }
                } else {
                    VoucherDetail voucherDetail = new VoucherDetail();
                    if (voucherItemSource.getDocType().getId() == 1){
                        String summary = voucherItemSource.getBusinessType()+"/"+ voucherItemSource.getContactUnit();
                        DocType docType = new DocType();
                        docType.setId(1);
                        DocTypeSubjectRelation docTypeSubjectRelation = new DocTypeSubjectRelation();
                        docTypeSubjectRelation.setDocType(docType);
                        List<DocTypeSubjectRelation> docTypeSubjectRelations = financeDao.query(docTypeSubjectRelation);
                        setAmount(docTypeSubjectRelations,voucherItemSource,voucherDetails,FinanceConstant.purchase_returnProduct,summary);
                        voucher.setDetails(voucherDetails);
                        voucherItemSources1.add(voucherItemSource);
                    } else if (voucherItemSource.getDocType().getId() == 3){
                        String summary = "销售库存商品/" + voucherItemSource.getBusinessType()+"/"+ voucherItemSource.getContactUnit();
                        DocType docType = new DocType();
                        docType.setId(3);
                        DocTypeSubjectRelation docTypeSubjectRelation = new DocTypeSubjectRelation();
                        docTypeSubjectRelation.setDocType(docType);
                        List<DocTypeSubjectRelation> docTypeSubjectRelations = financeDao.query(docTypeSubjectRelation);
                        setAmount(docTypeSubjectRelations,voucherItemSource,voucherDetails,FinanceConstant.order_returnProduct,summary);
                        voucher.setDetails(voucherDetails);
                        voucherItemSources1.add(voucherItemSource);
                    } else if (voucherItemSource.getDocType().getId() == 5){
                        String summary = "";
                        if (voucherItemSource.getBusinessType().equals(FinanceConstant.payAmount) || voucherItemSource.getBusinessType().equals(FinanceConstant.purchase_returnProduct)){
                            summary = "支付/" + voucherItemSource.getContactUnit() + "/" + "商品货款";
                        } else {
                            summary = "预付/" + voucherItemSource.getContactUnit() + "/" + "商品货款";
                        }
                        DocType docType = new DocType();
                        docType.setId(5);
                        DocTypeSubjectRelation docTypeSubjectRelation = new DocTypeSubjectRelation();
                        docTypeSubjectRelation.setDocType(docType);
                        List<DocTypeSubjectRelation> docTypeSubjectRelations = financeDao.query(docTypeSubjectRelation);
                        setAmount(docTypeSubjectRelations,voucherItemSource,voucherDetails,FinanceConstant.purchase_returnProduct,summary);
                        voucher.setDetails(voucherDetails);
                        voucherItemSources1.add(voucherItemSource);
                    } else if (voucherItemSource.getDocType().getId() == 6){
                        String summary = "";
                        if (voucherItemSource.getBusinessType().equals(FinanceConstant.receiptAmount) || voucherItemSource.getBusinessType().equals(FinanceConstant.order_returnProduct)){
                            summary = "收到/" + voucherItemSource.getContactUnit() + "/" + "转来货款";
                        } else {
                            summary = "收到/" + voucherItemSource.getContactUnit() + "/" + "转来订金";
                        }
                        DocType docType = new DocType();
                        docType.setId(6);
                        DocTypeSubjectRelation docTypeSubjectRelation = new DocTypeSubjectRelation();
                        docTypeSubjectRelation.setDocType(docType);
                        List<DocTypeSubjectRelation> docTypeSubjectRelations = financeDao.query(docTypeSubjectRelation);
                        setAmount(docTypeSubjectRelations,voucherItemSource,voucherDetails,FinanceConstant.order_returnProduct,summary);
                        voucher.setDetails(voucherDetails);
                        voucherItemSources1.add(voucherItemSource);
                    }
                    // 判断是否已经到最后一条凭证条目来源，是：将该凭证增加到凭证集合中并设置是否需要新建一条凭证为true
                    if (i == voucherItemSourceList.size()-1){
                        voucher.setNo(financeDao.getNo());
                        voucher.setDebit(getTotalDebit(voucher));
                        voucher.setCredit(getTotalDebit(voucher));
                        voucher.setVoucherItemSources(voucherItemSources1);
                        vouchers.add(voucher);
                        flag = true;
                    }else {
                        // 判断该凭证条目来源是否与下一条凭证条目来源的往来单位相同
                        if (!voucherItemSource.getContactUnit().equals(voucherItemSourceList.get(i+1).getContactUnit())){
                            voucher.setNo(financeDao.getNo());
                            voucher.setDebit(getTotalDebit(voucher));
                            voucher.setCredit(getTotalDebit(voucher));
                            voucher.setVoucherItemSources(voucherItemSources1);
                            vouchers.add(voucher);
                            flag = true;
                        } else {
                            flag = false;
                        }
                    }
                }
            }
            writer.writeObjectToJson(response,vouchers);
        }

        logger.info("privateQuery end");
    }

    public void setAmount(List<DocTypeSubjectRelation> docTypeSubjectRelations,VoucherItemSource voucherItemSource,Set<VoucherDetail> voucherDetails,String businessType,String summary){
        for (DocTypeSubjectRelation docTypeSubjectRelation1 : docTypeSubjectRelations){
            VoucherDetail voucherDetail = new VoucherDetail();
            VoucherItem voucherItem = new VoucherItem();
            voucherItem.setSummary(summary);
            voucherItem.setSubject(docTypeSubjectRelation1.getSubject());
            if (docTypeSubjectRelation1.getSubject().getAccountItems() != null){
                voucherItem.setAssistant(voucherItemSource.getContactUnit());
            }
            // 金额方向是借方
            if (docTypeSubjectRelation1.getDirection() == 1){
                // 业务类型是采购退货或者销售退货则金额为负
                if (voucherItemSource.getBusinessType().equals(businessType)) {
                    voucherItem.setDebit(-voucherItemSource.getAmount());
                }else {
                    voucherItem.setDebit(voucherItemSource.getAmount());
                }
            } else {
                if (voucherItemSource.getBusinessType().equals(businessType)) {
                    voucherItem.setCredit(-voucherItemSource.getAmount());
                } else {
                    voucherItem.setCredit(voucherItemSource.getAmount());
                }
            }
            voucherDetail.setVoucherItem(voucherItem);
            voucherDetails.add(voucherDetail);
        }
    }

    public Float getTotalDebit(Voucher voucher){
        Set<VoucherDetail> voucherDetails = voucher.getDetails();
        Float debit = 0.0f;
        for(VoucherDetail voucherDetail : voucherDetails){
            Float debit1 = voucherDetail.getVoucherItem().getDebit();
            if (debit1 != null){
                debit += debit1;
            }
        }
        return debit;
    }



    /**
     * 查询条件限制下的记录数
     * @param response
     * @param entity
     * @param json
     */
    @RequestMapping(value = "/recordsSum", method = {RequestMethod.GET, RequestMethod.POST})
    public void recordsSum(HttpServletResponse response, String entity, @RequestBody String json){
        logger.info("recordsSum start, parameter:" + entity + ":" + json);
        BigInteger recordsSum = new BigInteger("-1");

        Map<String, String> queryParameters = null;
        try {
            queryParameters = writer.gson.fromJson(json, new TypeToken<Map<String, String>>() {}.getType());
        } catch (Exception e){
            e.getMessage();
        }

        if (entity.equalsIgnoreCase(Voucher.class.getSimpleName())) {
            recordsSum = financeService.privateRecordNum(entity, json);

        } else if (entity.equalsIgnoreCase(VoucherCategory.class.getSimpleName())){
            recordsSum =  financeDao.recordsSum(VoucherCategory.class, queryParameters);

        } else if (entity.equalsIgnoreCase(Subject.class.getSimpleName())){
            recordsSum =  financeDao.recordsSum(Subject.class, queryParameters);

        } else if (entity.equalsIgnoreCase(DocType.class.getSimpleName())){
            recordsSum =  financeDao.recordsSum(DocType.class, queryParameters);

        } else if (entity.equalsIgnoreCase(FinanceConstant.chartMaker)){
            recordsSum =  financeDao.recordsSum(User.class, queryParameters);

        } else if (entity.equalsIgnoreCase(Warehouse.class.getSimpleName())){
            recordsSum =  financeDao.recordsSum(Warehouse.class, queryParameters);

        } else if (entity.equalsIgnoreCase(ProductType.class.getSimpleName())){
            recordsSum =  financeDao.recordsSum(ProductType.class, queryParameters);

        } else if (entity.equalsIgnoreCase(Account.class.getSimpleName())){
            recordsSum =  financeDao.recordsSum(Account.class, queryParameters);
        }

        writer.writeStringToJson(response, "{\"" + CommonConstant.recordsSum + "\":" + recordsSum + "}");

        logger.info("recordsSum end");
    }

    @Transactional
    @PostMapping("/update")
    public void update(HttpServletResponse response, String entity, @RequestBody String json){
        logger.info("update start, parameter:" + entity + ":" + json);

        String result = CommonConstant.fail;

        try {
            if (entity.equalsIgnoreCase(VoucherCategory.class.getSimpleName())) {
                VoucherCategory voucherCategory = writer.gson.fromJson(json, VoucherCategory.class);
                result = financeDao.updateById(voucherCategory.getId(), voucherCategory);

            } else if (entity.equalsIgnoreCase(Subject.class.getSimpleName())){
                Subject subject = writer.gson.fromJson(json, Subject.class);
                result = financeDao.updateById(subject.getId(), subject);

            } else if (entity.equalsIgnoreCase(Voucher.class.getSimpleName())) {
                List<Voucher> vouchers = writer.gson.fromJson(json, new TypeToken<List<Voucher>>() {}.getType());
                for (Voucher voucher : vouchers){
                    voucher.setTotalCapital(CapitalConvert.change(voucher.getDebit()));
                    // 更新凭证
                    result += financeDao.updateById(voucher.getId(),voucher).substring(0,7);
                    // 更新凭证明细
                    result += financeService.updateVoucherDetail(voucher).substring(0,7);
                    /**
                     * 提醒审核人员审核凭证
                     */
                    String auditEntity = AuditFlowConstant.business_voucherAudit;
                    result += financeService.launchAuditFlow(auditEntity, voucher.getId(), "请审核凭证编号为" +voucher.getNo()+"的凭证",
                            "请审核凭证编号为" +voucher.getNo()+"的凭证" ,voucher.getChartMaker());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            result += CommonConstant.fail;
        } finally {
            result = transcation.dealResult(result);
        }

        writer.writeStringToJson(response, "{\"" + CommonConstant.result + "\":\"" + result + "\"}");
        logger.info("update end, result:" + result);
    }

    @Transactional
    @RequestMapping(value = "/delete", method = {RequestMethod.GET, RequestMethod.POST})
    public void delete(HttpServletResponse response, String entity, @RequestBody String json){
        logger.info("delete start, parameter:" + entity + ":" + json);
        String result = CommonConstant.fail;

        try {
            if (entity.equalsIgnoreCase(VoucherCategory.class.getSimpleName())) {
                result += financeDao.delete(writer.gson.fromJson(json, VoucherCategory.class));

            } else if (entity.equalsIgnoreCase(Subject.class.getSimpleName())) {
                result += financeDao.delete(writer.gson.fromJson(json, Subject.class));

            } else if (entity.equalsIgnoreCase(Voucher.class.getSimpleName())) {
                Voucher voucher = writer.gson.fromJson(json, Voucher.class);
                voucher = (Voucher) financeDao.queryById(voucher.getId(),Voucher.class);
                Set<VoucherDetail> voucherDetails = voucher.getDetails();
                Set<VoucherItemSource> voucherItemSources = voucher.getVoucherItemSources();
                if (voucherDetails != null && !voucherDetails.isEmpty()){
                    for (VoucherDetail voucherDetail : voucherDetails){
                        result += financeDao.delete(voucherDetail.getVoucherItem()).substring(0,7);
                        result += financeDao.delete(voucherDetail).substring(0,7);
                    }
                }
                if (voucherItemSources != null && !voucherItemSources.isEmpty()){
                    for (VoucherItemSource voucherItemSource : voucherItemSources){
                        Voucher voucher1 = new Voucher();
                        voucher1.setId(-1);
                        voucherItemSource.setVoucher(voucher1);
                        voucherItemSource.setState(1);
                        result += financeDao.updateById(voucherItemSource.getId(),voucherItemSource).substring(0,7);
                    }
                }
                result += financeDao.delete(voucher);
            }
        } catch (Exception e) {
            e.printStackTrace();
            result += CommonConstant.fail;
        } finally {
            result = transcation.dealResult(result);
        }

        writer.writeStringToJson(response, "{\"" + CommonConstant.result + "\":\"" + result + "\"}");
        logger.info("delete end");
    }

}
