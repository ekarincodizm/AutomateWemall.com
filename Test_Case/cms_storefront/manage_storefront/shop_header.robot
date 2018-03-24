*** Settings ***
Force Tags    WLS_Manage_Shop
Suite Setup         Run Keywords    Prepare Storefront With Content for Storefront API    ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}
    ...             AND    Open Storefront - Shop List Page
Suite Teardown      Run Keywords    Close All Browsers
    ...             AND    Delete Shop and All Storefront Data    ${suite_shop_id}

Resource            ${CURDIR}/../../../Resource/init.robot
# Resource            ${CURDIR}/../../../Keywords/api_merchant/css_api_merchant_keyword.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_list_page/css_shop_list_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_shop_management_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/manage_shop_header/css_manage_shop_header_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/common_page/css_common_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/common/web_common_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/ckeditor/web_ckeditor_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall-mobile/common/mobile_common_keywords.robot
Library             Selenium2Library
Library             ${CURDIR}/../../../Python_Library/ExtendedSelenium/

*** Variables ***
${merchant_id}         APPLE0131
${shop_name}           Apple Store
${status}              active
${shop_slug}           apple
${module}              Header
${web}                 Web
${mobile}              Mobile
# ${ckidprimary}         html_primary
${ckidprimary}         header-portal_html_primary
# ${ckidsecondary}       html_secondary
${ckidsecondary}       header-portal_html_secondary
${imgsource}                 <img alt="" src="http://alpha-cdn.wemall-dev.com/th/Header/MTH10000_images/banner-storefront.png" style="width: 1920px; height: 116px;">
${pic}                 http://alpha-cdn.wemall-dev.com/th/Header/MTH10000_images/banner-storefront.png
${merchant_data}       ${CURDIR}/../../../Resource/TestData/merchant/css_merchants_create_retail_merchant.json

${storefrontHeader}    .inner-store-header
${cssFilePath}         ${CURDIR}/../../../Resource/TestData/storefronts/menu_template.css

*** Test Cases ***

TC_WMALL_01110 Header cms will show detail for Web only
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}

TC_WMALL_01111 Don't fill required field then click save will show error message for Web
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Save for Header Storefront page
    Wait For Error Header Storefront page

TC_WMALL_01112 Don't fill required field will click preview show error message for Web
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Preview Thai for Header Storefront page
    Wait For Error Header Storefront page
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Preview English for Header Storefront page
    Wait For Error Header Storefront page

TC_WMALL_01113 Don’t fill secondary language will show content primary language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Clear Text    ${ckidsecondary}
    Click Preview English for Header Storefront page
    Verify Window Preview Storefront Web EN Contains    ${shop_slug}    ${storefrontHeader}    ${pic}
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web.lower()}    ${module.lower()}

TC_WMALL_01114 Add Storefront Header content Thai Language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}

TC_WMALL_01115 Add Storefront Header content Eng Language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}

TC_WMALL_01116 Upload Image and get link URL Thai Language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Input Image to Ckditor for TH Language
    Click Save for Header Storefront page
    Wait For Success Header Storefront page

TC_WMALL_01117 Upload Image and get link URL Eng Language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Input Image to Ckditor for TH Language
    Input Image to Ckditor for EN Language
    Click Save for Header Storefront page
    Wait For Success Header Storefront page

TC_WMALL_01118 Edit Storefront Header Content Thai Language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Header Storefront page
    Wait For Success Header Storefront page

TC_WMALL_01119 Edit Storefront Header Content Eng Language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Click Save for Header Storefront page
    Wait For Success Header Storefront page

TC_WMALL_01120 Save to draft button for Web
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Header Storefront page
    Wait For Success Header Storefront page

TC_WMALL_01121 Save & Preview Thai button for Web
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Header Storefront page
    Wait For Success Header Storefront page
    Click Preview Thai for Header Storefront page
    Verify Window Preview Storefront Web TH Contains    ${shop_slug}    ${storefrontHeader}    ${IMG_PIC}

TC_WMALL_01122 Save & Preview English button for Web
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Header Storefront page
    Wait For Success Header Storefront page
    Click Preview English for Header Storefront page
    Verify Window Preview Storefront Web EN Contains    ${shop_slug}    ${storefrontHeader}    ${IMG_PIC}

TC_WMALL_01123 Publish button for Web
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Header Storefront page
    Wait For Success Header Storefront page
    Click Publish for Header Storefront page
    Go to Storefront Window Path    ${shop_slug}
    Verify Window Storefront Web TH Contains    ${shop_slug}    ${storefrontHeader}    ${IMG_PIC}

TC_WMALL_01124 Header cms will show detail for Mobile only
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}

TC_WMALL_01125 Don't fill required field then click save will show error message for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Save for Header Storefront page
    Wait For Error Header Storefront page

TC_WMALL_01126 Don't fill required field will click preview show error message for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Preview Thai for Header Storefront page
    Wait For Error Header Storefront page
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Preview English for Header Storefront page
    Wait For Error Header Storefront page

TC_WMALL_01127 Don’t fill secondary language will show content primary language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Clear Text    ${ckidsecondary}
    Click Preview English for Header Storefront page
    Verify Window Preview Storefront Mobile EN Contains    ${shop_slug}    div.storefront-header div.storefront-cover p:eq(0)    ${pic}
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web.lower()}    ${module.lower()}

TC_WMALL_01128 Add Storefront Header content Thai Language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}

TC_WMALL_01129 Add Storefront Header content Eng Language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}

TC_WMALL_01130 Upload Image and get link URL Thai Language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Input Image to Ckditor for TH Language
    Click Save for Header Storefront page
    Wait For Success Header Storefront page

TC_WMALL_01131 Upload Image and get link URL Eng Language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Input Image to Ckditor for TH Language
    Input Image to Ckditor for EN Language
    Click Save for Header Storefront page
    Wait For Success Header Storefront page

TC_WMALL_01132 Edit Storefront Header Content Thai Language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Header Storefront page
    Wait For Success Header Storefront page

TC_WMALL_01133 Edit Storefront Header Content Eng Language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Click Save for Header Storefront page
    Wait For Success Header Storefront page

TC_WMALL_01134 Save to draft button for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Header Storefront page
    Wait For Success Header Storefront page

TC_WMALL_01135 Save & Preview Thai button for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Header Storefront page
    Wait For Success Header Storefront page
    Click Preview Thai for Header Storefront page
    Verify Window Preview Storefront Mobile TH Contains    ${shop_slug}    div.storefront-header div.storefront-cover p:eq(0)    ${pic}

TC_WMALL_01136 Save & Preview English button for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Header Storefront page
    Wait For Success Header Storefront page
    Click Preview English for Header Storefront page
    Verify Window Preview Storefront Mobile EN Contains    ${shop_slug}    div.storefront-header div.storefront-cover p:eq(0)    ${pic}

TC_WMALL_01137 Publish button for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_header_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Header Storefront page
    Wait For Success Header Storefront page
    Click Publish for Header Storefront page
    Close Browser
    Open Mobile Browser    ${WEMALL_WEB}/shop/${shop_slug}    chrome
    Wait Until Angular Ready    60s
    Verify Window Storefront Mobile TH Contains    ${shop_slug}    div.storefront-header div.storefront-cover p:eq(0)    ${IMG_PIC}
    [Teardown]    Delete All Cookies

TC_WMALL_01299 Update CSS for Web
    [Tags]    Regression    manage_storefront    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Upload CSS    ${cssFilePath}
    Verify CSS Is Uploaded    ${suite_shop_id}    ${web.lower()}
    Click Preview Thai for Header Storefront page
    Verify Window Preview Storefront Web TH Contains CSS    ${shop_slug}    ${suite_shop_id}    ${web.lower()}    ${module.lower()}    2
    Select Window    title=WeMall: CMS Storefront
    Click Preview English for Header Storefront page
    Verify Window Preview Storefront Web EN Contains CSS    ${shop_slug}    ${suite_shop_id}    ${web.lower()}    ${module.lower()}    2


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
#     Click Preview Thai for Header Storefront page
#     Verify Window Preview Storefront Mobile TH Contains CSS    ${shop_slug}    ${suite_shop_id}    ${mobile.lower()}    ${module.lower()}
#     Select Window    title=WeMall: CMS Storefront
#     Click Preview English for Header Storefront page
#     Verify Window Preview Storefront Mobile EN Contains CSS    ${shop_slug}    ${suite_shop_id}    ${mobile.lower()}    ${module.lower()}

