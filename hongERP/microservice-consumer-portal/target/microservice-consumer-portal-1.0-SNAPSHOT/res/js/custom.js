/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: custom.js
 *
 * @author smjie
 * @Date  2017/5/6
 * @version 1.00
 */
/**
 * Resize function without multiple trigger
 *
 * Usage:
 * $(window).smartresize(function(){
 *     // code here
 * });
 */
(function($,sr){
    // debouncing function from John Hann
    // http://unscriptable.com/index.php/2009/03/20/debouncing-javascript-methods/
    var debounce = function (func, threshold, execAsap) {
        var timeout;

        return function debounced () {
            var obj = this, args = arguments;
            function delayed () {
                if (!execAsap)
                    func.apply(obj, args);
                timeout = null;
            }

            if (timeout)
                clearTimeout(timeout);
            else if (execAsap)
                func.apply(obj, args);

            timeout = setTimeout(delayed, threshold || 100);
        };
    };

    // smartresize
    jQuery.fn[sr] = function(fn){  return fn ? this.bind('resize', debounce(fn)) : this.trigger(sr); };

})(jQuery,'smartresize');
/**
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var CURRENT_URL = window.location.href.split('#')[0].split('?')[0],
    $BODY = $('body'),
    $MENU_TOGGLE = $('#menu_toggle'),
    $SIDEBAR_MENU = $('#sidebar-menu'),
    $SIDEBAR_FOOTER = $('.sidebar-footer'),
    $LEFT_COL = $('.left_col'),
    $RIGHT_COL = $('.right_col'),
    $NAV_MENU = $('.nav_menu'),
    $FOOTER = $('footer');



// Sidebar
function init_sidebar() {
// TODO: This is some kind of easy fix, maybe we can improve this
    var setContentHeight = function () {
        // reset height
        $RIGHT_COL.css('min-height', $(window).height());

        var bodyHeight = $BODY.outerHeight(),
            footerHeight = $BODY.hasClass('footer_fixed') ? -10 : $FOOTER.height(),
            leftColHeight = $LEFT_COL.eq(1).height() + $SIDEBAR_FOOTER.height(),
            contentHeight = bodyHeight < leftColHeight ? leftColHeight : bodyHeight;

        // normalize content
        contentHeight -= $NAV_MENU.height() + footerHeight;

        $RIGHT_COL.css('min-height', contentHeight);
    };

    $SIDEBAR_MENU.find('a').on('click', function(ev) {
        console.log('clicked - sidebar_menu');
        var $li = $(this).parent();

        if ($li.is('.active')) {
            $li.removeClass('active active-sm');
            $('ul:first', $li).slideUp(function() {
                setContentHeight();
            });
        } else {
            // prevent closing menu if we are on child menu
            if (!$li.parent().is('.child_menu')) {
                $SIDEBAR_MENU.find('li').removeClass('active active-sm');
                $SIDEBAR_MENU.find('li ul').slideUp();
            }else
            {
                if ( $BODY.is( ".nav-sm" ) )
                {
                    $SIDEBAR_MENU.find( "li" ).removeClass( "active active-sm" );
                    $SIDEBAR_MENU.find( "li ul" ).slideUp();
                }
            }
            $li.addClass('active');

            $('ul:first', $li).slideDown(function() {
                setContentHeight();
            });
        }
    });

// toggle small or large menu
    $MENU_TOGGLE.on('click', function() {
        console.log('clicked - menu toggle');

        if ($BODY.hasClass('nav-md')) {
            $SIDEBAR_MENU.find('li.active ul').hide();
            $SIDEBAR_MENU.find('li.active').addClass('active-sm').removeClass('active');
        } else {
            $SIDEBAR_MENU.find('li.active-sm ul').show();
            $SIDEBAR_MENU.find('li.active-sm').addClass('active').removeClass('active-sm');
        }

        $BODY.toggleClass('nav-md nav-sm');

        setContentHeight();
    });

    // check active menu
    $SIDEBAR_MENU.find('a[href="' + CURRENT_URL + '"]').parent('li').addClass('current-page');

    $SIDEBAR_MENU.find('a').filter(function () {
        return this.href == CURRENT_URL;
    }).parent('li').addClass('current-page').parents('ul').slideDown(function() {
        setContentHeight();
    }).parent().addClass('active');

    // recompute content when resizing
    $(window).smartresize(function(){
        setContentHeight();
    });

    setContentHeight();

    // fixed sidebar
    if ($.fn.mCustomScrollbar) {
        $('.menu_fixed').mCustomScrollbar({
            autoHideScrollbar: true,
            theme: 'minimal',
            mouseWheel:{ preventDefault: true }
        });
    }
}

/* AUTOSIZE */

function init_autosize() {

    if(typeof $.fn.autosize !== 'undefined'){

        autosize($('.resizable_textarea'));

    }

}

var hisUrls = [], hisIndex = 0, hisLength = 10;
var dataListQueryJson = "{}", dataListQueryEntity = "";
var returnPage = false;
var username = "";

function render(url){
    $.ajax({
        type: "get",
        url:  url,

        success: function (pageContent) {
            if (isValid(pageContent, url.substring(0, url.indexOf("/")))) {
                setHisUrls(url);
                $("#pageContent").empty().html(pageContent);
            }
        }
    });
}

function renderQuery(url,json){
    $.ajax({
        type: "post",
        url:  url,
        data: {json: json},

        success: function (pageContent) {
            if (isValid(pageContent, url.substring(0, url.indexOf("/")))) {
                setHisUrls(url);
                $("#pageContent").empty().html(pageContent);
            }
        }
    });
}

function renderAudit(element, url){
    $("#cancel, #return").unbind("click").click(function(){
        render(getPreUrls());
        returnPage = true;
    });

    $.ajax({
        type: "get",
        url:  url,
        success: function (pageContent) {
            if (isValid(pageContent, url.substring(0, url.indexOf("/")))) {

                pageContent = pageContent.replace("right_col", "").
                replace('<span class="section">', '<span class="section" style="color:#73879C;font-size:18px;font-weight:400;padding-bottom:10px">');

                element.empty().html(pageContent);

                /**
                 * 蕴藏部分元素
                 */
                element.find(".page-title").css("display", "none");
                element.find(".clearfix").css("display", "none");
                element.find(".x_title").css("display", "none");

                $('#result').attr("readonly", false).css("border", "1px solid #ccc");

                document.getElementById("submitDiv").parentNode.innerHTML = "";
            }
        }
    });
}

function isValid(pageContent, contextPath) {
    if (typeof pageContent == 'object' && pageContent.result.indexOf("对不起，你访问的页面不存在，或者会话已经过期") != -1) {
        $("#pageContent").empty().html("<div class='right_col' style='height: 100%'>" + pageContent.result +
            "<br/><br/><a href='" + contextPath + "/sys/user/signIn'>请重新登录</a></div>");

        return false;
    }

    return true;
}

function setHisUrls(url) {
    if (url != hisUrls[hisIndex]) {
        if (hisUrls.length == hisLength) {
            hisIndex = 0;
        } else {
            ++hisIndex;
        }

        hisUrls[hisIndex] = url;
    }
}

function getPreUrls() {
    if (hisIndex == 0 && hisUrls.length == hisLength) {
        hisIndex = hisUrls.length - 1;
    } else {
        --hisIndex;
    }

    return hisUrls[hisIndex];
}

function setSelect(src, value) {
    var options = src.options;
    for (var i = 0; i < options.length; i++) {
        if (options[i].value == value) {
            options[i].selected = true;
        }
    }
}

function setCheck(src,value) {
    for (var i = 0; i < src.length; i++) {
        if (src[i].value == value) {
            console.log(src[i]);
            src[i].selected = true;
        }
    }
}

function setMutilSelect(src, values) {
    for (var vi in values) {
        setSelect(src, values[vi]);
    }
}

function setMutilCheckbox(src, values) {
    for (var vi in values) {
        setCheck(src, values[vi]);
    }
}

$.fn.accountInput = function(){
    $(this).keyup(function(event){
        if (event.keyCode != 8 || event.keyCode != 46) {  // 8: BackSpace key code, 46: delete key code
            var value = this.value.replace(/\s*/g, "");
            var spaceValue = "";
            for (var i = 0; i < value.length; i++) {
                spaceValue += value.charAt(i);
                if ((i+1)%4 == 0) {
                    spaceValue += " ";
                }
            }
            this.value = spaceValue;
        }
    });
}

function init(editable) {
    $("#edit").unbind("click").click(function(){
        editable = true;
        $('#form :input').attr("readonly",false).css("border", "1px solid #ccc");
        $('#send, #doBusiness, #delete, #recover,#publish,#stop').attr("disabled", false);
        $("#edit").attr("disabled", "disabled");
    });

    $("#editState").unbind("click").click(function(){
        $('#delete, #recover').attr("disabled", false);
        $("#editState").attr("disabled", "disabled");
    });

    if (!editable) {
        $('#form :input').attr("readonly","readonly").css("border", "0");
        $('#send, #doBusiness, #delete, #recover,#publish,#stop').attr("disabled","disabled");
    }

    $("#cancel, #return").unbind("click").click(function(){
        render(getPreUrls());
        returnPage = true;
    });
}

Math.formatFloat = function(f, digit) {
    var m = Math.pow(10, digit);
    return parseInt(f * m, 10) / m;
}

$(document).ready(function() {
    init_sidebar();
    init_autosize();

    $("#auditA").click();

    $("#signOut").click(function(){
        $("#signOutForm").submit();
    });

    if ($("input.flat")[0]) {
        $(document).ready(function () {
            $('input.flat').iCheck({
                checkboxClass: 'icheckbox_flat-green',
                radioClass: 'iradio_flat-green'
            });
        });
    }

    $("#send").keydown(function(event){
        if(event.keyCode == 13){ //绑定回车
            this.click();
            // event.preventDefault();
            return false;
        }
    });

    $("#sidebar-menu ul li ul li a").click(function(){render($(this).attr("href").toString().substring(1));});
});
