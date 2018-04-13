<%--
**
* Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
* 文件名: article.jsp
*
* @author yuanyun
* @Date  2017/09/28
* @version 1.00
*
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.hzg.tools.FileServerInfo" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%--jquery ui--%>
<link type="text/css" href="../../../res/css/jquery-ui-1.10.0.custom.css" rel="stylesheet">
<style type="text/css">

    /*关键设置 tbody出现滚动条*/
    table tbody {
        display: block;
        height: 520px;
        overflow: scroll;
    }

    table thead ,
    tbody tr {
        display: table;
        width: 100%;
        table-layout: fixed;
    }

    /*关键设置：滚动条默认宽度是17px 将thead的宽度减17px*/
    table thead {
        width: calc( 100% - 17px);
        background: rgba(52,73,94,.94);
        color: #ECF0F1;
    }

    .table tbody tr td {
        padding: 4px;
        vertical-align: middle;
        border-top: 0px;
    }

    table thead tr th,table thead tr th input {
        text-align: center;
        vertical-align: middle;
    }

</style>

<!-- page content -->
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3><c:choose><c:when test="${entity != null}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose>文章</h3>
            </div>

            <div class="title_right hidden">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search for...">
                        <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                  </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>

        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>后台管理 <small>文章</small></h2>

                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">

                        <form class="form-horizontal form-label-left" novalidate id="form">
                            <span class="section">文章信息</span>

                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="articleCate[id]">分类 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select id="articleCate[id]" name="articleCate[id]" class="form-control col-md-7 col-xs-12" required >
                                    </select>
                                </div>
                                <span id="remindCate" style="color: red"></span>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="title">标题 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="title" name="title" class="form-control col-md-7 col-xs-12" value="${entity.title}" data-validate-length="5,100" data-validate-words="1"  required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label for="image" class="control-label col-md-3 col-sm-3 col-xs-12">封面图 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="image" type="file" name="image" <c:if test="${entity == null}">required</c:if> >
                                    <c:if test="${entity != null}">
                                        <a id="imgA" href="${entity.imageUrl}" class="lightbox">
                                            <img id="img" src="${entity.imageUrl}" width="10%">
                                        </a>
                                    </c:if>
                                    <input id="imageUrl" type="hidden" name="imageUrl" value="" <c:if test="${entity.imageUrl != null}">${entity.imageUrl}</c:if> >
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="content">内容 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <textarea id="content"  name="content" required >${entity.content}</textarea>
                                </div>
                                <div id="remindContent" style="color: red" ></div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="shortContent">摘要 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <textarea id="shortContent" name="shortContent" cols="20" rows="5" required >${entity.shortContent}</textarea>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label for="position" class="control-label col-md-3 col-sm-3 col-xs-12">推荐位 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select id="position" name="position" class="form-control col-md-7 col-xs-12" required>
                                        <c:choose>
                                            <c:when test="${entity != null}">
                                                <option value="0" >请选择</option>
                                                <option value="1" <c:if test="${entity.position==1}">selected</c:if>>首页</option>
                                                <option value="2" <c:if test="${entity.position==2}">selected</c:if>>焦点图</option>
                                                <option value="3" <c:if test="${entity.position==3}">selected</c:if>>栏目推荐</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="0">请选择</option>
                                                <option value="1">首页</option>
                                                <option value="2">焦点图</option>
                                                <option value="3">栏目推荐</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </select>
                                </div>
                                <span id="remindPosition" style="color: red" ></span>
                            </div>

                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="tag[name]">标签 <span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12 ">
                                    <div class="input-prepend input-group" >
                                        <input type="text" id="tag[name]" name="tag[name]" value="<c:forEach var="articleTag" items="${entity.articleTags}">${articleTag.name};</c:forEach>" class="form-control col-md-7 col-xs-12" required readonly />
                                        <input type="hidden" id="articleTags" name="articleTags" value="<c:forEach var="articleTag" items="${entity.articleTags}">{'id':${articleTag.id}},</c:forEach>" class="form-control col-md-7 col-xs-12" />
                                        <span id="tag" class="add-on input-group-addon"><i class="glyphicon glyphicon-zoom-in"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="seoTitle">文章优化标题 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="seoTitle" name="seoTitle" class="form-control col-md-7 col-xs-12" value="${entity.seoTitle}" data-validate-length="5,80" data-validate-words="1" required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="seoKeyword">文章优化关键词 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="seoKeyword" name="seoKeyword" class="form-control col-md-7 col-xs-12" value="${entity.seoKeyword}" data-validate-length="5,80" data-validate-words="1" required type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="seoDesc">文章优化描述 <span class="required">*</span>
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="seoDesc" name="seoDesc" class="form-control col-md-7 col-xs-12" value="${entity.seoDesc}" data-validate-length="5,100" data-validate-words="1" required type="text">
                                </div>
                            </div>
                            <div class="ln_solid"></div>
                            <div class="form-group">
                                <div class="col-md-6 col-md-offset-3">
                                    <button id="cancel" type="button" class="btn btn-primary">返回</button>
                                    <c:if test="${entity == null}">
                                        <button id="send" type="button" class="btn btn-success">保存</button>
                                        <button id="publish" type="button" class="btn btn-success">发布</button>
                                    </c:if>
                                    <c:if test="${entity != null}">
                                            <c:if test="${entity.state == 0}">
                                                <button id="edit" type="button" class="btn btn-primary">编辑</button>
                                                <button id="send" type="button" class="btn btn-success">保存</button>
                                                <button id="publish" type="button" class="btn btn-success">发布</button>
                                                <button id="delete" type="button" class="btn btn-danger">删除</button>
                                            </c:if>
                                            <c:if test="${entity.state == 1}">
                                                <button id="edit" type="button" class="btn btn-primary">编辑</button>
                                                <button id="recover" type="button" class="btn btn-danger">撤销发布</button>
                                                <button id="delete" type="button" class="btn btn-danger">删除</button>
                                            </c:if>
                                            <c:if test="${entity.state == 2}">
                                                <button id="edit" type="button" class="btn btn-primary">编辑</button>
                                                <button id="recover" type="button" class="btn btn-danger">撤销删除</button>
                                            </c:if>
                                    </c:if>
                                </div>
                            </div>
                            <c:if test="${entity != null}"><input type="hidden" id="id" name="id" value="${entity.id}"></c:if>
                            <input type="hidden" id="state" name="state:number" value="<c:choose><c:when test="${entity != null}">${entity.state}</c:when><c:otherwise>0</c:otherwise></c:choose>">
                            <input type="hidden" id="author[id]" name="author[id]" value="${user.id}"  />
                        </form>
                        <div id="tagChooseDiv">
                            <br>
                            <table class="table table-bordered table-striped " width="100%" style="margin: 0px">
                                <thead>
                                <tr>
                                    <th style="width:60px;"><input type="checkbox" > 全选</th>
                                    <th width="50px">序号</th>
                                    <th>文章标签名称</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            <div style="text-align: right;padding-right: 10px;background-color: lightblue">
                                <div style="padding: 4px">共 <span class="recordsSum" style="font-weight: bold"></span> 条记录,已加载 <span class="loadSum" style="font-weight: bold"></span> 条记录</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    init(<c:out value="${entity == null}"/>);
    $("#content").attr("readonly",false);

    CKEDITOR.replace( 'content');

    $(".ui-dialog").remove();
    article.initArticleTag();

    /*检验编辑内容编辑区里的内容是否为空*/
    function test() {
        var editor_data = CKEDITOR.instances.content.getData();
        if(editor_data == null || editor_data == ""){
            $("#remindContent").show().html("内容不能为空！");
            return false;
        }else {
            $("#remindContent").hide();
        }
    }


    $(".lightbox").lightbox({
        fitToScreen: true,
        imageClickClose: false
    });

    /*保存文章*/
    $("#send").click(function () {
        $(document.getElementById("tag[name]")).attr("disabled","disabled");
        if(test()==false){
            return false;
        }
        articleSubmit();
    });

    /*发布文章*/
    $("#publish").click(function () {
        $(document.getElementById("tag[name]")).attr("disabled","disabled");
        if(test()==false){
            return false;
        }
        $("#state").val(1);
        articleSubmit();
    });

    /*处理撤销发布文章、删除文章和撤销删除文章的公用部分*/
    function common() {
        $(document.getElementById("articleCate[id]")).attr("disabled","disabled");
        $("#title").attr("disabled","disabled");
        $("#image").attr("disabled","disabled");
        $("#imageUrl").attr("disabled","disabled");
        $("#content").attr("disabled","disabled");
        $("#shortContent").attr("disabled","disabled");
        $("#position").attr("disabled","disabled");
        $("#seoTitle").attr("disabled","disabled");
        $("#seoKeyword").attr("disabled","disabled");
        $("#seoDesc").attr("disabled","disabled");
        $(document.getElementById("tag[name]")).attr("disabled","disabled");
    }

    /*撤销发布文章和撤销删除文章*/
    $("#recover").click(function () {
        $("#state").val(0);
        common();
        articleSubmit();
    });

    /*删除文章*/
    $("#delete").click(function () {
        $("#state").val(2);
        common();
        var deleteResult = articleSubmit();
        if(deleteResult!=false){
            $("#recover").attr("disabled","disabled");
            $("#send").attr("disabled","disabled");
            $("#publish").attr("disabled","disabled");
        }
    });

    /*封面图上传*/
    function coverPlanUpload() {
        var dir = "<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>"+"/article/"+"<%=new SimpleDateFormat("HHmmss").format(new Date())%>";
        var fd = new FormData();
        fd.append("name", $("#image")[0].files[0].name.split(".")[0]);
        fd.append("dir", dir);
        fd.append("file", $("#image")[0].files[0]);
        $("#form").sendFormData("<%=FileServerInfo.getUploadFilesUrl()%>", fd, function(result){

            var resultTd = $("#imageUrl").next();
            if (result.result.indexOf("success") == -1) {
                resultTd.html(result.result + ',请选择文件后，点击<a href="#uploadFile" onclick="tableSheet.uploadFile(this, tableSheet.uploadFilesUrl, tableSheet.imageServerUrl);">上传</a>');

            } else {
                resultTd.html('<a id="' + dir + '" href="' + "<%=FileServerInfo.getImageServerUrl()%>" + '/' + result.filePath + '" class="lightbox">查看图片</a>');
                $(document.getElementById(dir)).lightbox({
                    fitToScreen: true,
                    imageClickClose: false
                });
                $("#imageUrl").val("<%=FileServerInfo.getImageServerUrl()%>" + "/" + result.filePath);
                $("#content").val(CKEDITOR.instances.content.getData());
                $('#form').submitForm('<%=request.getContextPath()%>/sys/<c:choose><c:when test="${entity != null}">update</c:when><c:otherwise>save</c:otherwise></c:choose>/article',
                    function (result) {
                        if (result.result.indexOf("success") != -1){
                            $("#send").attr("disabled","disabled");
                        }
                    }
                );
            }
        });
    }
    /*提交文章的改变（包括内容的改变，状态的改变（状态的改变包括保存、发布和删除三种））*/
    function articleSubmit(){
        if ($(document.getElementById("articleCate[id]")).val()==""){
            $("#remindCate").show().html("请选择分类！");
            return false;
        }else {
            $("#remindCate").hide();
        }
        if ($("#position").val()==0){
            $("#remindPosition").show().html("请选择推荐位！");
            return false;
        }else {
            $("#remindPosition").hide();
        }

        if($("#image").val()==""||$("#image").val()==null){
            $("#content").val(CKEDITOR.instances.content.getData());
            $('#form').submitForm('<%=request.getContextPath()%>/sys/<c:choose><c:when test="${entity != null}">update</c:when><c:otherwise>save</c:otherwise></c:choose>/article',
                function (result) {
                    if (result.result.indexOf("success") != -1){
                        $("#send").attr("disabled","disabled");
                    }
                }
            );
        }else{
            coverPlanUpload();
        }

    };

    selector.setSelect(['articleCate[id]'], ['name'], ['id'],
        [<c:if test="${entity != null}">'${entity.articleCate.id}'</c:if>],
        ['<%=request.getContextPath()%>/sys/query/articleCate'],
        '{}', [], 0);

    <c:choose><c:when test="${entity != null}">document.title = "文章修改";</c:when><c:otherwise> document.title = "文章添加";</c:otherwise></c:choose>

</script>