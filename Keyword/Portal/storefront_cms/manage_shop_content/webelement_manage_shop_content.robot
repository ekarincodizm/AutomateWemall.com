*** Variable ***
${PUBLISH_BUTTON}           css=a[ng-click="publish()"]
${SAVE_BUTTON}              css=a[ng-click="saveToDraft()"]
${PREVIEW_THAI_BUTTON}      css=a[ng-click="saveToDraft(previewPrimaryUrl)"]
${PREVIEW_ENG_BUTTON}       css=a[ng-click="saveToDraft(previewSecondaryUrl)"]
# ${ALERT_SUCCESS}            css=div.alert-success > div > span
# ${ALERT_ERROR}              css=div.alert-danger > div > span
${ALERT_SUCCESS}            jquery=div.alert.alert-success span.ng-binding
${ALERT_ERROR}              jquery=div.alert.alert-danger span.ng-binding


${ERROR_MESSAGE}            Please enter all required fields
${PUBLISH_SUCCEED}          Publish successfully
${SAVE_SUCCESS}             Save to draft successfully

######### Ckeditor ##########
${SOURCE_ICONTH}       jquery=span.cke_button_label.cke_button__source_label:eq(0)
${SOURCE_ICONEN}       jquery=span.cke_button_label.cke_button__source_label:eq(1)
${IMG_PIC}             http://alpha-cdn.wemall-dev.com/th/content/MTH10000_web_images/content-storefront.jpg
${IMG_ICONTH}          jquery=a.cke_button.cke_button__image:eq(0)
${IMG_INPUTFIELDTH}    jquery=table.cke_dialog_contents tr:eq(0) td table:eq(0) tr:eq(0) input
${IMG_INPUTFIELDEN}    jquery=table.cke_dialog_contents:eq(1) tr:eq(0) td table:eq(0) tr:eq(0) input
${OK_ICONTH}           jquery=a[title='OK']:eq(0)


${IMG_ICONEN}          jquery=a.cke_button.cke_button__image:eq(1)
${OK_ICONEN}           jquery=a[title='OK']:eq(1)


${IMAGE_LT_10MB}       ${CURDIR}/../../../../Resource/TestData/storefronts/upload_data/file_type_1.gif
${IMAGE_GT_10MB}       ${CURDIR}/../../../../Resource/TestData/storefronts/upload_data/file_type_10.gif
${NON_IMAGE}           ${CURDIR}/../../../../Resource/TestData/storefronts/upload_data/Motion.csv
${IMAGE_UPLOAD}        jquery=input:file[name="image_upload"]
${IMAGE_ALERT}         jquery=#cmsAlertImage div span
${IMAGE_ALERT_LIST}    jquery=#cmsAlertImage div li:eq(0)
${IMAGE_UPLOAD_ICON}   jquery=div[name="image_upload"] i.fa-spinner