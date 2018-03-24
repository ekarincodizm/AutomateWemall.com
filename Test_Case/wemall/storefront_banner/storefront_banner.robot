*** Settings ***
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/common/web_common_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/storefront_page/storefront_page_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/storefront_page/storefront_landing_web_page_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/storefront_cms/manage_shop_banner/css_manage_shop_banner_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_list_page/css_shop_list_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_shop_management_keywords.robot
Resource          ${CURDIR}/../../../Resource/TestData/storefronts/storefront_data.robot
Library           Selenium2Library
Library           ${CURDIR}/../../../Python_Library/ExtendedSelenium/
Force Tags        WLS_Wemall_storefront_banner

Suite Setup       Run Keywords    Prepare Data for Storefront API    ${merchant_id}    ${shop_name}    ${shop_slug}    active
    ...           AND    Open Storefront - Shop List Page
Suite Teardown      Run Keywords    Close All Browsers
    ...             AND    Delete Shop and All Storefront Data    ${suite_shop_id}

*** variables ***
${shop_slug}    targus
${shop_name}    Targus
${merchant_id}      TAR090098
${web}             Web
${mobile}          Mobile
${module}          Banner
${merchant_data}       ${CURDIR}/../../../../Resource/test_data/merchant/css_merchants_create_retail_merchant.json

# Banner No. 1
${bannerName1}              Banner1
${bannerOrder1}             1
${bannerStatus1}            active
${bannerNewTab1}             ${TRUE}
${bannerLinkTh1}            http://www.itruemart.com
${bannerLinkEn1}            http://www.itruemart.com/en
${bannerAltTh1}             iTruemart
${bannerAltEn1}             iTruemart EN
${bannerImageThTxt1}
${bannerImageEnTxt1}
@{banner1}                  ${bannerName1}     ${bannerOrder1}     ${bannerStatus1}    ${bannerNewTab1}    ${bannerLinkTh1}    ${bannerLinkEn1}   ${bannerAltTh1}     ${bannerAltEn1}    ${bannerAltEn1}    ${bannerImageThTxt1}    ${bannerImageEnTxt1}

# Banner No. 2
${bannerName2}              Banner2
${bannerOrder2}             2
${bannerStatus2}            active
${bannerNewTab2}             ${TRUE}
${bannerLinkTh2}            http://www.itruemart.com
${bannerLinkEn2}            http://www.itruemart.com/en
${bannerAltTh2}             iTruemart
${bannerAltEn2}             iTruemart EN
${bannerImageThTxt2}
${bannerImageEnTxt2}
@{banner2}                  ${bannerName2}     ${bannerOrder2}     ${bannerStatus2}    ${bannerNewTab2}    ${bannerLinkTh2}    ${bannerLinkEn2}   ${bannerAltTh2}     ${bannerAltEn2}    ${bannerAltEn2}    ${bannerImageThTxt2}    ${bannerImageEnTxt2}

# Banner No. 5
${bannerName5}              Banner5
${bannerOrder5}             5
${bannerStatus5}            active
${bannerNewTab5}             ${TRUE}
${bannerLinkTh5}            http://www.itruemart.com
${bannerLinkEn5}            http://www.itruemart.com/en
${bannerAltTh5}             iTruemart
${bannerAltEn5}             iTruemart EN
${bannerImageThTxt5}
${bannerImageEnTxt5}
@{banner5}                  ${bannerName5}     ${bannerOrder5}     ${bannerStatus5}    ${bannerNewTab5}    ${bannerLinkTh5}    ${bannerLinkEn5}   ${bannerAltTh5}     ${bannerAltEn5}    ${bannerAltEn5}    ${bannerImageThTxt5}    ${bannerImageEnTxt5}

*** Test Cases ***
TC_WMALL_00117 Only one banner_web_view
    [Tags]    cms_storefront    banner_web_view    Regression   TC_WMALL_00117    WLS_Medium
    [Setup]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    banner
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${web}
    Wait Until Angular Ready    30s
    Create Banner By Order Number       1       @{banner1}
    Click Save for Banner Storefront page
    Click Publish for Banner Storefront page
    Sleep    60s
    Change URL To Storefront Page    ${shop_slug}
    Banner Target Carousel By Index Should be Equal    0    _blank
    Banner Image Carousel By Index Should Contain    0    ${bannerImageThTxt1}
    Banner Alt Carousel By Index Should be Equal    0    ${bannerAltTh1}
    Banner Link Carousel By Index Should be Equal    0    ${bannerLinkTh1}
    Banner Should Not Show Carousel Dot
    Banner Amount Dot Should Be    1
    Change URL To Storefront Page - Secondary Language    ${shop_slug}
    Banner Target Carousel By Index Should be Equal    0    _blank
    Banner Image Carousel By Index Should Contain    0    ${bannerImageEnTxt1}
    Banner Alt Carousel By Index Should be Equal    0    ${bannerAltEn1}
    Banner Link Carousel By Index Should be Equal    0    ${bannerLinkEn1}
    Banner Should Not Show Carousel Dot
    Banner Amount Dot Should Be    1
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view.lower()}     banner

TC_WMALL_00118 Order banner not sort web view
    [Tags]    cms_storefront    banner_web_view    Regression   TC_WMALL_00118    WLS_High
    [Setup]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    banner
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${web}
    Wait Until Angular Ready    30s
    Create Banner By Order Number       2       @{banner2}
    Create Banner By Order Number       5       @{banner5}
    Click Save for Banner Storefront page
    Click Publish for Banner Storefront page
    Sleep    60s
    Change URL To Storefront Page    ${shop_slug}
    Banner Target Carousel By Index Should be Equal    0    _blank
    Banner Image Carousel By Index Should Contain    0    ${bannerImageThTxt2}
    Banner Alt Carousel By Index Should be Equal    0    ${bannerAltTh2}
    Banner Link Carousel By Index Should be Equal    0    ${bannerLinkTh2}
    Banner Target Carousel By Index Should be Equal    1    _blank
    Banner Image Carousel By Index Should Contain    1    ${bannerImageThTxt5}
    Banner Alt Carousel By Index Should be Equal    1    ${bannerAltTh5}
    Banner Link Carousel By Index Should be Equal    1    ${bannerLinkTh5}
    Banner Should Show Carousel Dot
    Banner Amount Dot Should Be    2
    Change URL To Storefront Page - Secondary Language    ${shop_slug}
    Banner Target Carousel By Index Should be Equal    0    _blank
    Banner Image Carousel By Index Should Contain    0    ${bannerImageEnTxt2}
    Banner Alt Carousel By Index Should be Equal    0    ${bannerAltEn2}
    Banner Link Carousel By Index Should be Equal    0    ${bannerLinkEn2}
    Banner Target Carousel By Index Should be Equal    1    _blank
    Banner Image Carousel By Index Should Contain    1    ${bannerImageEnTxt5}
    Banner Alt Carousel By Index Should be Equal    1    ${bannerAltEn5}
    Banner Link Carousel By Index Should be Equal    1    ${bannerLinkEn5}
    Banner Should Show Carousel Dot
    Banner Amount Dot Should Be    2
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view.lower()}     banner

TC_WMALL_00119 Banner timeout web view
    [Tags]    cms_storefront    banner_web_view    Regression   TC_WMALL_00119    WLS_High
    [Setup]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    banner
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${web}
    Wait Until Angular Ready    30s
    Create Banner By Order Number With Start And End Time       1       1    3    @{banner1}
    Click Save for Banner Storefront page
    Click Publish for Banner Storefront page
    Sleep    60s
    Change URL To Storefront Page    ${shop_slug}
    Banner Target Carousel By Index Should be Equal    0    _blank
    Banner Image Carousel By Index Should Contain    0    ${bannerImageThTxt1}
    Banner Alt Carousel By Index Should be Equal    0    ${bannerAltTh1}
    Banner Link Carousel By Index Should be Equal    0    ${bannerLinkTh1}
    Banner Should Not Show Carousel Dot
    Banner Amount Dot Should Be    1
    Change URL To Storefront Page - Secondary Language     ${shop_slug}
    Banner Target Carousel By Index Should be Equal    0    _blank
    Banner Image Carousel By Index Should Contain    0    ${bannerImageEnTxt1}
    Banner Alt Carousel By Index Should be Equal    0    ${bannerAltEn1}
    Banner Link Carousel By Index Should be Equal    0    ${bannerLinkEn1}
    Banner Should Not Show Carousel Dot
    Banner Amount Dot Should Be    1
    Sleep    60s
    Change URL To Storefront Page    ${shop_slug}
    Banner Not Should Be Show
    Change URL To Storefront Page - Secondary Language    ${shop_slug}
    Banner Not Should Be Show
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view.lower()}     banner

TC_WMALL_00120 Banner start time web view
    [Tags]    cms_storefront    banner_web_view    Regression   TC_WMALL_00120    WLS_High
    [Setup]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    banner
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${web}
    Wait Until Angular Ready    30s
    Create Banner By Order Number With Start And End Time       1       2    60     @{banner1}
    Click Save for Banner Storefront page
    Click Publish for Banner Storefront page
    Change URL To Storefront Page    ${shop_slug}
    Banner Not Should Be Show
    Change URL To Storefront Page - Secondary Language    ${shop_slug}
    Banner Not Should Be Show
    Sleep    120s
    Change URL To Storefront Page    ${shop_slug}
    Banner Target Carousel By Index Should be Equal    0    _blank
    Banner Image Carousel By Index Should Contain    0    ${bannerImageThTxt1}
    Banner Alt Carousel By Index Should be Equal    0    ${bannerAltTh1}
    Banner Link Carousel By Index Should be Equal    0    ${bannerLinkTh1}
    Banner Should Not Show Carousel Dot
    Banner Amount Dot Should Be    1
    Change URL To Storefront Page - Secondary Language    ${shop_slug}
    Banner Target Carousel By Index Should be Equal    0    _blank
    Banner Image Carousel By Index Should Contain    0    ${bannerImageEnTxt1}
    Banner Alt Carousel By Index Should be Equal    0    ${bannerAltEn1}
    Banner Link Carousel By Index Should be Equal    0    ${bannerLinkEn1}
    Banner Should Not Show Carousel Dot
    Banner Amount Dot Should Be    1
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view.lower()}     banner

TC_WMALL_00121 Switch Banner timeout web view
    [Tags]    cms_storefront    banner_web_view    Regression   TC_WMALL_00121    WLS_High
    [Setup]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    banner
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${web}
    Wait Until Angular Ready    30s
    Create Banner By Order Number With Start And End Time       1       1    3    @{banner1}
    Create Banner By Order Number With Start And End Time       1       3    60    @{banner2}
    Click Save for Banner Storefront page
    Click Publish for Banner Storefront page
    Sleep    60s
    Change URL To Storefront Page     ${shop_slug}
    Banner Target Carousel By Index Should be Equal    0    _blank
    Banner Image Carousel By Index Should Contain    0    ${bannerImageThTxt1}
    Banner Alt Carousel By Index Should be Equal    0    ${bannerAltTh1}
    Banner Link Carousel By Index Should be Equal    0    ${bannerLinkTh1}
    Banner Should Not Show Carousel Dot
    Banner Amount Dot Should Be    1
    Change URL To Storefront Page - Secondary Language     ${shop_slug}
    Banner Target Carousel By Index Should be Equal    0    _blank
    Banner Image Carousel By Index Should Contain    0    ${bannerImageEnTxt1}
    Banner Alt Carousel By Index Should be Equal    0    ${bannerAltEn1}
    Banner Link Carousel By Index Should be Equal    0    ${bannerLinkEn1}
    Banner Should Not Show Carousel Dot
    Banner Amount Dot Should Be    1
    Sleep    120s
    Change URL To Storefront Page    ${shop_slug}
    Banner Target Carousel By Index Should be Equal    0    _blank
    Banner Image Carousel By Index Should Contain    0    ${bannerImageThTxt2}
    Banner Alt Carousel By Index Should be Equal    0    ${bannerAltTh2}
    Banner Link Carousel By Index Should be Equal    0    ${bannerLinkTh2}
    Banner Should Not Show Carousel Dot
    Banner Amount Dot Should Be    1
    Change URL To Storefront Page - Secondary Language    ${shop_slug}
    Banner Target Carousel By Index Should be Equal    0    _blank
    Banner Image Carousel By Index Should Contain    0    ${bannerImageEnTxt2}
    Banner Alt Carousel By Index Should be Equal    0    ${bannerAltEn2}
    Banner Link Carousel By Index Should be Equal    0    ${bannerLinkEn2}
    Banner Should Not Show Carousel Dot
    Banner Amount Dot Should Be    1
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view.lower()}     banner