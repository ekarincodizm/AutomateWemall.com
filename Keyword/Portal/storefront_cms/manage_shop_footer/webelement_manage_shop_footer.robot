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
${IMG_PIC}             http://alpha-cdn.wemall-dev.com/th/footer/MTH10000_images/footer-storefront.jpg
${IMG_ICONTH}          jquery=a.cke_button.cke_button__image:eq(0)
${IMG_INPUTFIELDTH}    jquery=table.cke_dialog_contents tr:eq(0) td table:eq(0) tr:eq(0) input
${IMG_INPUTFIELDEN}    jquery=table.cke_dialog_contents:eq(1) tr:eq(0) td table:eq(0) tr:eq(0) input
${OK_ICONTH}           jquery=a[title='OK']:eq(0)


${IMG_ICONEN}          jquery=a.cke_button.cke_button__image:eq(1)
${OK_ICONEN}           jquery=a[title='OK']:eq(1)


