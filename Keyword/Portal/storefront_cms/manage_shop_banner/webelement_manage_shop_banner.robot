*** Variable ***
${ADD_BANNER_BUTTON}    css=a[ng-click="addBanner()"]
${SAVE_BANNER_BUTTON}       jquery=#btnDraft
${PREVIEW_BANNER_BUTTON}      jquery=#btnPreview
${PUBLISH_BANNER_BUTTON}    jquery=#btnPublish

${EDIT_BANNER_BUTTON}       jquery=a[ng-click='editBanner(banner)']
${DELETE_BANNER_BUTTON}     jquery=a[ng-click='deleteBanner(banner)']
#${EDIT_BANNER_BUTTON}       jquery=a[ng-click='editBanner(banner)']:eq(0)
    #$("a[ng-click='editBanner(banner)']:eq(0)")
    #$('a.blue[title=Edit]')
    #div.alert.ng-isolate-scope.alert-danger span.ng-binding.ng-scope:contains('Time is overlapping on cell order [1]')

${ALERT_BANNER_SUCCESS}            css=div.alert-success > div > span
${ALERT_BANNER_ERROR}              css=div.alert-danger > div > span
${ALERT_MAIN_BANNER_ERROR}         jquery=div.alert.ng-isolate-scope.alert-danger span.ng-binding.ng-scope
${PUBLISH_BANNER_SUCCEED}          Publish successfully
${SAVE_BANNER_SUCCESS}             Save to draft successfully
${ERROR_BANNER_REQUIRED_MESSAGE}            Please enter all fields
${ERROR_BANNER_START_DATE_GREATER_CURRENT_DATE}            Start date should be greater than Current date
${ERROR_BANNER_END_DATE_GREATER_START_DATE}            End date should be greater than Start date
${ERROR_BANNER_START_DATE_MISSING}            Start date is missing
${ERROR_BANNER_END_DATE_MISSING}            End date is missing
${ERROR_BANNER_OVERLAPPING}                 Time is overlapping on cell order
${BANNER_FORM_ID}      id=bannerForm
${table_banner_list}    jquery=table.table-striped.table-hover
${column_banner_name}    ${table_banner_list} thead tr th:eq(0)
${column_banner_order}    ${table_banner_list} thead tr th:eq(1)
${BANNER_DATE_FORMAT_FROM_DB}               %Y-%m-%dT%H:%M:%S+07:00

${BANNER_DATE_FORMAT_FOR_DISPLAY}           %d/%m/%Y %H:%M

${BANNER_FILTER}                            jquery=a.btn.btn-default.shiny:eq(1)
${ACTIVE_BANNER_STATUS}                     jquery=ul.dropdown-menu li a:contains('Active')
${INACTIVE_BANNER_STATUS}                   jquery=ul.dropdown-menu li a:contains('Inactive')
${ALL_BANNER_STATUS}                        jquery=ul.dropdown-menu li a:contains('All')

${MODAL_BANNER_ALERT}                       jquery=div.alert-danger div span
${MODAL_BANNER_NAME_TH_TXT}                 jquery=#sfbName
${MODAL_BANNER_ORDER_TXT}                   jquery=#sfbOrder
${MODAL_BANNER_STATUS_TXT}                  jquery=#sfbStatus
${MODAL_BANNER_NEW_TAB_TXT}                 jquery=#sfbTarget
${MODAL_BANNER_LINK_TH_TXT}                 jquery=#sfbLinkTh
${MODAL_BANNER_LINK_EN_TXT}                 jquery=#sfbLinkEn
${MODAL_BANNER_ALT_TH_TXT}                  jquery=#sfbAltTh
${MODAL_BANNER_ALT_EN_TXT}                  jquery=#sfbAltEn

${MODAL_BANNER_START_DATE_TXT}              jquery=#sfbStartDate
${MODAL_BANNER_END_DATE_TXT}                jquery=#sfbEndDate

${MODAL_BANNER_WEB_IMAGE_TH_SELECT}         jquery=#btnWebImageTH
${MODAL_BANNER_WEB_IMAGE_TH_PATH}           ${CURDIR}/../../../../Resource/TestData/storefronts/banner_data/FotorB3TH.jpg
${MODAL_BANNER_WEB_IMAGE_EN_PATH}           ${CURDIR}/../../../../Resource/TestData/storefronts/banner_data/FotorB3US.jpg
${MODAL_BANNER_WEB_IMAGE_TH_ID}            jquery=#sfbImgWebImageTH
${MODAL_BANNER_WEB_IMAGE_EN_ID}            jquery=#sfbImgWebImageEN

${MODAL_BANNER_WEB_IMAGE_FILE_TH_TXT}       jquery=input:file[ng-model="banner.webImageTHFile"]
${MODAL_BANNER_WEB_IMAGE__FILE_EN_TXT}      jquery=input:file[ng-model="banner.webImageENFile"]

${MODAL_BANNER_CONFIRM_DELETE}              jquery=div.modal-dialog div.modal-header h3:contains("Confirm delete")
${BANNER_CONFIRM_DELETE_BUTTON}             jquery=div.modal-dialog button:contains("OK")

${OK_BANNER_FORM_BUTTON}                    jquery=#btnSave
${START_DATE_INPUT}                         jquery=#sfbStartDate
${END_DATE_INPUT}                           jquery=#sfbEndDate
${ADD_BANNER_TITLE}                         jquery=#title
${STATUS_BANNER_BUTTON}                     jquery=table[data-id=bannerListTable] input[type=checkbox].checkbox-slider
${STATUS_BANNER_BUTTON_FOR_BANNER_FORM}     jquery=.modal-content input[type=checkbox].checkbox-slider
${DIV_BANNER_ON_FRONTEND}                   jquery=div.wm-store-highlight-banner.ng-isolate-scope

${banner_storefront_index}                  jquery=.wm-store-highlight-banner.ng-isolate-scope .owl-item:not(.cloned)
