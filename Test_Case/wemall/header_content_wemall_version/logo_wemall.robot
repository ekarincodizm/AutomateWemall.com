*** Settings ***
Force Tags    WLS_Content_Wemall    wemall_header
Suite Setup         Open Browser and Go to Specific URL    ${WEMALL_WEB}
Suite Teardown      Run Keywords    Close All Browsers
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Test Template       Logo WeMall

*** Variables ***
${username}             robot01@mail.com
${user_display_name}    Robot01@mail.com
${password}             123456

*** Test Cases ***
TC_WMALL_01427 Level C brand page header - Logo WeMall (WeMall_version)    ${WEMALL_WEB}/brand/samsung-6931849325692.html
    [tags]    regression    TC_WMALL_01427    WLS_Medium

TC_WMALL_01437 Level C category page header - Logo WeMall (WeMall_version)    ${WEMALL_WEB}/category/hulk-3302288514534.html
    [tags]    regression    TC_WMALL_01437    WLS_Medium

TC_ITMWM_03996 Header on Lv.C for Merchant page - Logo WeMall (WeMall_version)    ${WEMALL_WEB}/m-${SHOP_LYRA_ROBOT}-category-${CAT_SLUG_PKEY}.html
    [tags]    lyra

TC_WMALL_01447 Search page header - Logo WeMall (WeMall_version)    ${WEMALL_WEB}/search2?q=Apple
    [tags]    regression    TC_WMALL_01447    WLS_Medium

TC_WMALL_01457 Everyday Wow page header - Logo WeMall (WeMall_version)    ${WEMALL_WEB}/everyday-wow
    [tags]    regression    TC_WMALL_01457    WLS_Medium

TC_WMALL_01518 Login header - Logo WeMall (WeMall_version)   ${WEMALL_WEB}/auth/login    https
   [tags]    regression    TC_WMALL_01518    WLS_Medium

TC_WMALL_01519 Register header - Logo WeMall (WeMall_version)   ${WEMALL_WEB}/users/register    https
   [tags]    regression    TC_WMALL_01519    WLS_Medium

TC_WMALL_01520 Level D header - Logo WeMall (WeMall_version)   ${WEMALL_WEB}/products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html
   [tags]    regression    TC_WMALL_01520    WLS_Medium

TC_WMALL_01658 Wemall Portal page header - Logo WeMall (WeMall_version)    ${WEMALL_WEB}
    [tags]    regression    TC_WMALL_01658    WLS_Medium

TC_WMALL_01659 Wemall Stronfront page header - Logo WeMall (WeMall_version)    ${WEMALL_WEB}/shop/canon
    [tags]    regression    TC_WMALL_01659    WLS_Medium

TC_WMALL_01674 Forgot Password page header - Logo WeMall (WeMall_version)    ${WEMALL_WEB}/forgot_password    https
    [tags]    regression    TC_WMALL_01674    WLS_Medium

*** Keywords ***
Logo WeMall
    [Arguments]    ${full_url}    ${protocol}=http
    Go to Specific URL    ${full_url}
    Check Location Contain    ${full_url}    ${protocol}
    Verify WeMall Logo    ${protocol}
    Click WeMall Logo
    Location Should Be    ${WEMALL_WEB}/