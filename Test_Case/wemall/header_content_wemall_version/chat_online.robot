*** Settings ***
Force Tags    WLS_Content_Wemall    wemall_header
Suite Setup         Open Browser and Go to Specific URL    ${WEMALL_WEB}
Suite Teardown      Run Keywords    Close All Browsers
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Test Template       Chat Online

*** Variables ***
${username}             robot01@mail.com
${user_display_name}    Robot01@mail.com
${password}             123456

*** Test Cases ***
TC_WMALL_01426 Level C brand page header - Chat Online (WeMall_version)    ${WEMALL_WEB}/brand/samsung-6931849325692.html
    [tags]    regression    TC_WMALL_01426    WLS_Medium

TC_WMALL_01436 Level C category page header - Chat Online (WeMall_version)    ${WEMALL_WEB}/category/hulk-3302288514534.html
    [tags]    regression    TC_WMALL_01436    WLS_Medium

TC_ITMWM_03996 Header on Lv.C for Merchant page - Chat Online (WeMall_version)    ${WEMALL_WEB}/m-${SHOP_LYRA_ROBOT}-category-${CAT_SLUG_PKEY}.html
    [tags]    lyra

TC_WMALL_01446 Search page header - Chat Online (WeMall_version)    ${WEMALL_WEB}/search2?q=Apple
    [tags]    regression    TC_WMALL_01446    WLS_Medium

TC_WMALL_01456 Everyday Wow page header - Chat Online (WeMall_version)    ${WEMALL_WEB}/everyday-wow
    [tags]    regression    TC_WMALL_01456    WLS_Medium

TC_WMALL_01509 Login header - Chat Online (WeMall_version)   ${WEMALL_WEB}/auth/login    https
   [tags]    regression    TC_WMALL_01509    WLS_Medium

TC_WMALL_01510 Register header - Chat Online (WeMall_version)   ${WEMALL_WEB}/users/register    https
   [tags]    regression    TC_WMALL_01510    WLS_Medium

TC_WMALL_01511 Level D header - Chat Online (WeMall_version)   ${WEMALL_WEB}/products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html
   [tags]    regression    TC_WMALL_01511    WLS_Medium

TC_WMALL_01652 Wemall Portal page header - Menu bars (WeMall_version)    ${WEMALL_WEB}
   [tags]    regression    TC_WMALL_01652    WLS_Medium

TC_WMALL_01653 Wemall Stronfront page header - Menu bars (WeMall_version)    ${WEMALL_WEB}/shop/canon
   [tags]    regression    TC_WMALL_01653    WLS_Medium

TC_WMALL_01671 Forgot Password page header - Menu bars (WeMall_version)     ${WEMALL_WEB}/forgot_password    https
    [tags]    regression    TC_WMALL_01671    WLS_Medium

*** Keywords ***
Chat Online
    [Arguments]    ${full_url}    ${protocol}=http
    Go to Specific URL    ${full_url}
    Check Location Contain    ${full_url}    ${protocol}
    Verify Chat Online Link Display    ${protocol}