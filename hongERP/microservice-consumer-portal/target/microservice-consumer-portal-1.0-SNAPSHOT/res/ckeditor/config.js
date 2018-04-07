/**
 * @license Copyright (c) 2003-2017, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function (config) {
    // Define changes to default configuration here. For example:
    // config.language = 'fr';
    // config.uiColor = '#AADC6E';
    config.enterMode = CKEDITOR.ENTER_BR;
    config.shiftEnterMode = CKEDITOR.ENTER_BR;
    config.skin="kama";
    // 上传文件时servlet
    config.filebrowserImageUploadUrl = 'http://stream.demohzg.com/uploadCKEditorFile';
    // 预览区域显示内容
    config.image_previewText = ' ';
    // 移除图片上传页面的'高级','链接'页签
    config.removeDialogTabs = 'image:advanced;image:Link';

};
