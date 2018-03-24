*** Settings ***
Force Tags    WLS_Content_Wemall    wemall_header
Suite Setup         Open Browser and Go to Specific URL    ${WEMALL_WEB}
Suite Teardown      Run Keywords    Close All Browsers
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Test Template       Guest User

*** Variables ***
${username}             robot01@mail.com
${user_display_name}    Robot01@mail.com
${password}             123456

*** Test Cases ***
TC_WMALL_01430 Level C brand page header - Guest user (WeMall_version)    ${WEMALL_WEB}/brand/samsung-6931849325692.html    /auth/login
    [tags]    regression    TC_WMALL_01430    WLS_Medium

TC_WMALL_01440 Level C category page header - Guest user (WeMall_version)    ${WEMALL_WEB}/category/tablet-3363917653771.html    /auth/login
    [tags]    regression    TC_WMALL_01440    WLS_Medium

TC_ITMWM_03996 Header on Lv.C for Merchant page - Guest user (WeMall_version)    ${WEMALL_WEB}/m-${SHOP_LYRA_ROBOT}-category-${CAT_SLUG_PKEY}.html    /auth/login
    [tags]    lyra

TC_WMALL_01450 Search page header - Guest user (WeMall_version)    ${WEMALL_WEB}/search2?q=Apple    /auth/login
    [tags]    regression    TC_WMALL_01450    WLS_Medium

TC_WMALL_01460 Everyday Wow page header - Guest user (WeMall_version)    ${WEMALL_WEB}/everyday-wow    /auth/login
    [tags]    regression    TC_WMALL_01460    WLS_Medium

TC_WMALL_01515 Login header - Guest user (WeMall_version)   ${WEMALL_WEB}/auth/login    /auth/login    https
   [tags]    regression    TC_WMALL_01515    WLS_Medium

TC_WMALL_01516 Register header - Guest user (WeMall_version)   ${WEMALL_WEB}/users/register    /auth/login    https
   [tags]    regression    TC_WMALL_01516    WLS_Medium

TC_WMALL_01517 Level D header - Guest user (WeMall_version)   ${WEMALL_WEB}/products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html    /auth/login
   [tags]    regression    TC_WMALL_01517    WLS_Medium

TC_WMALL_01656 Wemall Portal page header - Guest user (WeMall_version)    ${WEMALL_WEB}    /auth/login
    [tags]    regression    TC_WMALL_01656    WLS_Medium

TC_WMALL_01657 Wemall Stronfront page header - Guest user (WeMall_version)    ${WEMALL_WEB}/shop/canon    /auth/login
    [tags]    regression    TC_WMALL_01657    WLS_Medium

TC_WMALL_01673 Forgot Password page header - Guest user (WeMall_version)    ${WEMALL_WEB}/forgot_password    /auth/login    https
    [tags]    regression    TC_WMALL_01673    WLS_Medium

*** Keywords ***
Guest User
    [Arguments]    ${full_url}    ${expected_payment_status_url}    ${protocol}=http
    Go to Specific URL    ${full_url}
    Check Location Contain    ${full_url}    ${protocol}
    Verify Login Link Display As Not Login
    Click Order and Payment status Checking Link
    Verify Login Link Display As Not Login
    Check Location Contain    ${expected_payment_status_url}    ${protocol}
