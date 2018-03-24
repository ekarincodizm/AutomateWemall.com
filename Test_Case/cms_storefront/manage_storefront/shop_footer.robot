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
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/manage_shop_footer/css_manage_shop_footer_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/common_page/css_common_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/common/web_common_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/ckeditor/web_ckeditor_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall-mobile/common/mobile_common_keywords.robot
Library             Selenium2Library
Library             ${CURDIR}/../../../Python_Library/ExtendedSelenium/

*** Variables ***
${merchant_id}         SAMSUNG00215
${shop_name}           SAMSUNG
${status}              active
${shop_slug}           samsung

${module}              Footer
${web}                 Web
${mobile}              Mobile
${ckidprimary}         footer_html_primary
${ckidsecondary}       footer_html_secondary
${imgsource}           <img alt="" src="http://alpha-cdn.wemall-dev.com/th/footer/MTH10000_images/footer-storefront.jpg" style="width: 1920px; height: 116px;">
${pic}                 http://alpha-cdn.wemall-dev.com/th/footer/MTH10000_images/footer-storefront.jpg
${merchant_data}       ${CURDIR}/../../../Resource/TestData/merchant/css_merchants_create_retail_merchant.json
# ${storefrontFooter}                      div#footer
${storefrontFooter}                      div.body-wrapper p
${storefrontFooterMobile}                div.storefront-footer
${cssFilePath}         ${CURDIR}/../../../Resource/TestData/storefronts/menu_template.css

*** Test Cases ***

# DEL - del
#     [Tags]    Regression    del
    # Delete Shop and All Storefront Data    a2a4731d-79da-4ad3-ae72-f4d62851670f

TC_WMALL_01176 Footer cms will show detail for Web only
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}

TC_WMALL_01177 Don't fill required field then click save will show error message for Web
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Save for Footer Storefront page
    Wait For Error Footer Storefront page

TC_WMALL_01178 Don't fill required field will click preview show error message for Web
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Preview Thai for Footer Storefront page
    Wait For Error Footer Storefront page
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Preview English for Footer Storefront page
    Wait For Error Footer Storefront page

TC_WMALL_01179 Don’t fill secondary language will show Footer primary language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Clear Text    ${ckidsecondary}
    Click Preview English for Footer Storefront page
    Verify Window Preview Storefront Web EN Contains    ${shop_slug}    ${storefrontFooter}    ${pic}
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web.lower()}    ${module.lower()}

TC_WMALL_01180 Add Storefront Footer Footer Thai Language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}

TC_WMALL_01181 Add Storefront Footer content Eng Language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}

TC_WMALL_01182 Upload Image and get link URL Thai Language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Input Image to Ckditor for TH Language
    Click Save for Footer Storefront page
    Wait For Success Footer Storefront page

TC_WMALL_01183 Upload Image and get link URL Eng Language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Input Image to Ckditor for TH Language
    Input Image to Ckditor for EN Language
    Click Save for Footer Storefront page
    Wait For Success Footer Storefront page

TC_WMALL_01184 Edit Storefront Footer Content Thai Language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Footer Storefront page
    Wait For Success Footer Storefront page

TC_WMALL_01185 Edit Storefront Footer Content Eng Language for Web
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Click Save for Footer Storefront page
    Wait For Success Footer Storefront page

TC_WMALL_01186 Save to draft button for Web
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Footer Storefront page
    Wait For Success Footer Storefront page

TC_WMALL_01187 Save & Preview Thai button for Web
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}   web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Footer Storefront page
    Wait For Success Footer Storefront page
    Click Preview Thai for Footer Storefront page
    Verify Window Preview Storefront Web TH Contains    ${shop_slug}    ${storefrontFooter}    ${IMG_PIC}

TC_WMALL_01188 Save & Preview English button for Web
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}   web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Footer Storefront page
    Wait For Success Footer Storefront page
    Click Preview English for Footer Storefront page
    Verify Window Preview Storefront Web EN Contains    ${shop_slug}    ${storefrontFooter}    ${IMG_PIC}

TC_WMALL_01189 Publish button for Web
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_web    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}   web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Footer Storefront page
    Wait For Success Footer Storefront page
    Click Publish for Footer Storefront page
    Go to Storefront Window Path    ${shop_slug}
    Verify Window Storefront Web TH Contains    ${shop_slug}    ${storefrontFooter}    ${IMG_PIC}

TC_WMALL_01190 Footer cms will show detail for Mobile only
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}

TC_WMALL_01191 Don't fill required field then click save will show error message for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}   mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Save for Footer Storefront page
    Wait For Error Footer Storefront page

TC_WMALL_01192 Don't fill required field will click preview show error message for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Preview Thai for Footer Storefront page
    Wait For Error Footer Storefront page
    Go to URL Shop List Page
    Wait Until Angular Ready    60s
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Preview English for Footer Storefront page
    Wait For Error Footer Storefront page

TC_WMALL_01193 Don’t fill secondary language will show Footer primary language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Clear Text    ${ckidsecondary}
    Click Preview English for Footer Storefront page
    Verify Window Preview Storefront Mobile EN Contains    ${shop_slug}    ${storefrontFooterMobile}    ${pic}
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web.lower()}    ${module.lower()}

TC_WMALL_01194 Add Storefront Footer content Thai Language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}

TC_WMALL_01195 Add Storefront Footer content Eng Language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}

TC_WMALL_01196 Upload Image and get link URL Thai Language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Input Image to Ckditor for TH Language
    Click Save for Footer Storefront page
    Wait For Success Footer Storefront page

TC_WMALL_01197 Upload Image and get link URL Eng Language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Input Image to Ckditor for TH Language
    Input Image to Ckditor for EN Language
    Click Save for Footer Storefront page
    Wait For Success Footer Storefront page

TC_WMALL_01198 Edit Storefront Footer Content Thai Language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Footer Storefront page
    Wait For Success Footer Storefront page

TC_WMALL_01199 Edit Storefront Footer Content Eng Language for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page   ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Click Save for Footer Storefront page
    Wait For Success Footer Storefront page

TC_WMALL_01200 Save to draft button for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Footer Storefront page
    Wait For Success Footer Storefront page

TC_WMALL_01201 Save & Preview Thai button for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Footer Storefront page
    Wait For Success Footer Storefront page
    Click Preview Thai for Footer Storefront page
    Verify Window Preview Storefront Mobile TH Contains    ${shop_slug}    ${storefrontFooterMobile}    ${pic}

TC_WMALL_01202 Save & Preview English button for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidsecondary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Footer Storefront page
    Wait For Success Footer Storefront page
    Click Preview English for Footer Storefront page
    Verify Window Preview Storefront Mobile EN Contains    ${shop_slug}    ${storefrontFooterMobile}    ${pic}

TC_WMALL_01203 Publish button for Mobile
    [Tags]    Regression    manage_storefront    manage_storefront_footer_for_mobile    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Footer Storefront page
    Wait For Success Footer Storefront page
    Click Publish for Footer Storefront page
    Close Browser
    Open Mobile Browser    ${WEMALL_WEB}/shop/${shop_slug}    chrome
    Wait Until Angular Ready    60s
    Verify Window Storefront Mobile TH Contains    ${shop_slug}    ${storefrontFooterMobile}    ${pic}
    [Teardown]    Delete All Cookies

TC_WMALL_01301 Update CSS for Web
    [Tags]    Regression    manage_storefront    WLS_High
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Upload CSS    ${cssFilePath}
    Verify CSS Is Uploaded    ${suite_shop_id}    ${web.lower()}
    Click Preview Thai for Footer Storefront page
    Verify Window Preview Storefront Web TH Contains CSS    ${shop_slug}    ${suite_shop_id}    ${web.lower()}    ${module.lower()}    2
    Select Window    title=WeMall: CMS Storefront
    Click Preview English for Footer Storefront page
    Verify Window Preview Storefront Web EN Contains CSS    ${shop_slug}    ${suite_shop_id}    ${web.lower()}    ${module.lower()}    2

# Is it applied on Mobile
# TC_WMALL_XXXX2 - Update CSS for Mobile
#     [Tags]    Regression    manage_storefront
#     Go to URL Shop List Page
#     Go To Manage Storefront Page    ${suite_shop_id}    mobile
#     Click Link on Management Page    ${suite_shop_id}    ${module}    ${mobile}
#     Wait Until Angular Ready    60s
#     CKEditor Input Text    ${ckidprimary}    ${imgsource}
#     Upload CSS    ${cssFilePath}
#     Verify CSS Is Uploaded    ${suite_shop_id}    ${mobile.lower()}
#     Click Preview Thai for Footer Storefront page
#     Verify Window Preview Storefront Mobile TH Contains CSS    ${shop_slug}    ${suite_shop_id}    ${mobile.lower()}    ${module.lower()}
#     Select Window    title=WeMall: CMS Storefront
#     Click Preview English for Footer Storefront page
#     Verify Window Preview Storefront Mobile EN Contains CSS    ${shop_slug}    ${suite_shop_id}    ${mobile.lower()}    ${module.lower()}



