*** Settings ***
Force Tags    WLS_Manage_Shop
Suite Setup         Run Keywords    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}
    ...             AND    Open Storefront - Shop List Page
Suite Teardown      Run Keywords    Close All Browsers
    ...             AND    Delete Shop and All Storefront Data    ${suite_shop_id}

Resource            ${CURDIR}/../../../Resource/init.robot
# Resource            ${CURDIR}/../../../Keywords/api_merchant/css_api_merchant_keyword.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_list_page/css_shop_list_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_shop_management_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/manage_shop_content/css_manage_shop_content_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/common_page/css_common_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/common/web_common_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/ckeditor/web_ckeditor_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall-mobile/common/mobile_common_keywords.robot
Library             OperatingSystem
Library             Selenium2Library
Library             ${CURDIR}/../../../Python_Library/ExtendedSelenium/

*** Variables ***
${merchant_id}         TOSHIBA00813
${shop_name}           Toshiba
${status}              active
${shop_slug}           toshiba

${module}              Content
${web}                 Web
${mobile}              Mobile
${ckidprimary}         contents_html_primary
${ckidsecondary}       contents_html_secondary
${imgsource}           <img alt="" src="http://alpha-cdn.wemall-dev.com/th/content/MTH10000_web_images/content-storefront.jpg" style="width: 1920px; height: 116px;">
${pic}                 http://alpha-cdn.wemall-dev.com/th/content/MTH10000_web_images/content-storefront.jpg
${merchant_data}       ${CURDIR}/../../../Resource/TestData/merchant/css_merchants_create_retail_merchant.json

${storefrontContent}                  .store-front-main-content
${storefrontContentMobile}            div.store-front-main-content
${cssFilePath}         ${CURDIR}/../../../Resource/TestData/storefronts/menu_template.css
${test_content_en}     ${CURDIR}/../../../Resource/TestData/storefronts/merchant_template_en.txt
${test_content_th}     ${CURDIR}/../../../Resource/TestData/storefronts/merchant_template_th.txt

*** Test Cases ***
TC_WMALL_01148 Content cms will show detail for Web only
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}

TC_WMALL_01149 Don't fill required field then click save will show error message for Web
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Save for Content Storefront page
    Wait For Error Content Storefront page

TC_WMALL_01150 Don't fill required field will click preview show error message for Web
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Preview Thai for Content Storefront page
    Wait For Error Content Storefront page
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Preview English for Content Storefront page
    Wait For Error Content Storefront page

TC_WMALL_01151 Don’t fill secondary language will show content primary language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Clear Text    ${ckidsecondary}
    Click Preview English for Content Storefront page
    Verify Window Preview Storefront Web EN Contains    ${shop_slug}    ${storefrontContent}    ${pic}
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web.lower()}    ${module.lower()}

TC_WMALL_01152 Add Storefront Content content Thai Language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}

TC_WMALL_01153 Add Storefront Content content Eng Language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}

TC_WMALL_01154 Upload Image and get link URL Thai Language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Input Image to Ckditor for TH Language
    Click Save for Content Storefront page
    Wait For Success Content Storefront page

TC_WMALL_01155 Upload Image and get link URL Eng Language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Input Image to Ckditor for TH Language
    Input Image to Ckditor for EN Language
    Click Save for Content Storefront page
    Wait For Success Content Storefront page

TC_WMALL_01156 Edit Storefront Content Content Thai Language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page

TC_WMALL_01157 Edit Storefront Content Content Eng Language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page

TC_WMALL_01158 Save to draft button for Web
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}   web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page

TC_WMALL_01159 Save & Preview Thai button for Web
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}   web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Click Preview Thai for Content Storefront page
    Verify Window Preview Storefront Web TH Contains    ${shop_slug}    ${storefrontContent}    ${IMG_PIC}

TC_WMALL_01160 Save & Preview English button for Web
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Click Preview English for Content Storefront page
    Click Publish for Content Storefront page
    Verify Window Preview Storefront Web EN Contains    ${shop_slug}    ${storefrontContent}    ${IMG_PIC}

TC_WMALL_01161 Publish button for Web
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page

TC_WMALL_01162 Content cms will show detail for Mobile only
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}

TC_WMALL_01163 Don't fill required field then click save will show error message for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Save for Content Storefront page
    Wait For Error Content Storefront page

TC_WMALL_01164 Don't fill required field will click preview show error message for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Preview Thai for Content Storefront page
    Wait For Error Content Storefront page
    Go to URL Shop List Page
    Wait Until Angular Ready    60s
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Preview English for Content Storefront page
    Wait For Error Content Storefront page

TC_WMALL_01165 Don’t fill secondary language will show content primary language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Clear Text    ${ckidsecondary}
    Click Preview English for Content Storefront page
    Verify Window Preview Storefront Mobile EN Contains    ${shop_slug}    ${storefrontContentMobile}    ${pic}

TC_WMALL_01166 Add Storefront Content content Thai Language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}

TC_WMALL_01167 Add Storefront Content content Eng Language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}

TC_WMALL_01168 Upload Image and get link URL Thai Language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Input Image to Ckditor for TH Language
    Click Save for Content Storefront page
    Wait For Success Content Storefront page

TC_WMALL_01169 Upload Image and get link URL Eng Language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Input Image to Ckditor for TH Language
    Input Image to Ckditor for EN Language
    Click Save for Content Storefront page
    Wait For Success Content Storefront page

TC_WMALL_01170 Edit Storefront Content Content Thai Language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page

TC_WMALL_01171 Edit Storefront Content Content Eng Language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page

TC_WMALL_01172 Save to draft button for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page

TC_WMALL_01173 Save & Preview Thai button for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Click Preview Thai for Content Storefront page
    Verify Window Preview Storefront Mobile TH Contains    ${shop_slug}    ${storefrontContentMobile}    ${pic}

TC_WMALL_01174 Save & Preview English button for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Click Preview English for Content Storefront page
    Verify Window Preview Storefront Mobile EN Contains    ${shop_slug}    ${storefrontContentMobile}    ${pic}

TC_WMALL_01175 Publish button for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_mobile    WLS_High
    [Setup]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web.lower()}    content    ${prepare_content}
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Click Publish for Content Storefront page
    Close Browser
    Open Mobile Browser    ${WEMALL_WEB}/shop/${shop_slug}    chrome
    Wait Until Angular Ready    60s
    Verify Window Storefront Mobile TH Contains    ${shop_slug}    ${storefrontContentMobile}    ${pic}
    [Teardown]    Delete All Cookies

TC_WMALL_01300 Update CSS for Web
    [Tags]    Regression    manage_storefront    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Upload CSS    ${cssFilePath}
    Verify CSS Is Uploaded    ${suite_shop_id}    ${web.lower()}
    Click Preview Thai for Content Storefront page
    Verify Window Preview Storefront Web TH Contains CSS    ${shop_slug}    ${suite_shop_id}    ${web.lower()}    ${module.lower()}    1
    Select Window    title=WeMall: CMS Storefront
    Click Preview English for Content Storefront page
    Verify Window Preview Storefront Web EN Contains CSS    ${shop_slug}    ${suite_shop_id}    ${web.lower()}    ${module.lower()}    1

TC_WMALL_01308 Upload file less than limit file size (set limit = 10MB)
    [Tags]    Regression    manage_storefront    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Sleep    10s
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    Add Image    ${IMAGE_UPLOAD}    ${IMAGE_LT_10MB}
    Wait Until Element Is Visible    ${IMAGE_UPLOAD_ICON}
    Wait Until Element Is Not Visible    ${IMAGE_UPLOAD_ICON}    120s

TC_WMALL_01309 Upload file large than limit file size (set limit = 10MB)
    [Tags]    Regression    manage_storefront    WLS_Medium
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Sleep    10s
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    Add Image    ${IMAGE_UPLOAD}    ${IMAGE_GT_10MB}
    ${class}=    Get Element Attribute    ${IMAGE_ALERT}@class
    Should Not Contain    ${class}    ng-hide
    ${txt}=    Get Text    ${IMAGE_ALERT}
    Should Be Equal    ${txt}    Upload failed
    ${txt}=    Get Text    ${IMAGE_ALERT_LIST}
    Should Be Equal    ${txt}    file_type_10.gif - File size is more than 10MB

TC_WMALL_01310 Upload file not image type
    [Tags]    Regression    manage_storefront    WLS_Medium
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Sleep    10s
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    Add Image    ${IMAGE_UPLOAD}    ${NON_IMAGE}
    ${class}=    Get Element Attribute    ${IMAGE_ALERT}@class
    Should Not Contain    ${class}    ng-hide
    ${txt}=    Get Text    ${IMAGE_ALERT}
    Should Be Equal    ${txt}    Upload failed
    ${txt}=    Get Text    ${IMAGE_ALERT_LIST}
    Should Be Equal    ${txt}    Motion.csv - File type is not support

TC_WMALL_01314 Alignment Storefront Content TH for Web
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    ${content}=    Get File    ${test_content_th}
    CKEditor Input Text    ${ckidprimary}    ${content}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Click Preview Thai for Content Storefront page
    Verify Window Preview Storefront Web TH Alignment Center    ${shop_slug}

TC_WMALL_01315 Alignment Storefront Content EN for Web
    [Tags]    Regression    manage_storefront    manage_storefront_content_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    ${content}=    Get File    ${test_content_en}
    CKEditor Input Text    ${ckidprimary}    ${content}
    CKEditor Input Text    ${ckidsecondary}    ${content}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Click Preview English for Content Storefront page
    Verify Window Preview Storefront Web EN Alignment Center    ${shop_slug}

# Is it applied on Mobile
# TC_WMALL_XXXX2 - Update CSS for Mobile
#     [Tags]    Regression    manage_storefront
#     Go to URL Shop List Page
#     Click Create Merchant for Mobile    ${suite_shop_id}
#     Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
#     Wait Until Angular Ready    60s
#     CKEditor Input Text    ${ckidprimary}    ${imgsource}
#     Upload CSS    ${cssFilePath}
#     Verify CSS Is Uploaded    ${suite_shop_id}    ${mobile.lower()}
#     Click Preview Thai for Content Storefront page
#     Verify Window Preview Storefront Mobile TH Contains CSS    ${shop_slug}    ${suite_shop_id}    ${mobile.lower()}    ${module.lower()}
#     Select Window    title=WeMall: CMS Storefront
#     Click Preview English for Content Storefront page
#     Verify Window Preview Storefront Mobile EN Contains CSS    ${shop_slug}    ${suite_shop_id}    ${mobile.lower()}    ${module.lower()}



