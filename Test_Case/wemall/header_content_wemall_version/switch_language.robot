*** Settings ***
Force Tags    WLS_Content_Wemall    wemall_header
Suite Setup         Open Browser and Go to Specific URL    ${WEMALL_WEB}
Suite Teardown      Run Keywords    Close All Browsers
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Test Template       Switch Language

*** Variables ***
${username}             robot01@mail.com
${user_display_name}    Robot01@mail.com
${password}             123456

*** Test Cases ***
TC_WMALL_01432 Level C brand page header - Switch Language (WeMall_version)    ${WEMALL_WEB}/brand/samsung-6931849325692.html    /brand/samsung-6931849325692.html    /brand/samsung-6931849325692.html
    [tags]    regression    TC_WMALL_01432    WLS_Medium

TC_WMALL_01442 Level C category page header - Switch Language (WeMall_version)    ${WEMALL_WEB}/category/hulk-3302288514534.html    /category/hulk-3302288514534.html    /category/hulk-3302288514534.html

TC_WMALL_01442 Level C category page header - Switch Language (WeMall_version)    ${WEMALL_WEB}/m-${SHOP_LYRA_ROBOT}-category-${CAT_SLUG_PKEY}.html    /m-${SHOP_LYRA_ROBOT}-category-${CAT_SLUG_PKEY}.html    /m-${SHOP_LYRA_ROBOT}-category-${CAT_SLUG_PKEY}.html
    [tags]    regression    TC_WMALL_01442    lyra    WLS_Medium

TC_WMALL_01452 Search page header - Switch Language (WeMall_version)    ${WEMALL_WEB}/search2?q=Apple    /search2?q=Apple    /search2?q=Apple
    [tags]    regression    TC_WMALL_01452    WLS_Medium

TC_WMALL_01462 Everyday Wow page header - Switch Language (WeMall_version)    ${WEMALL_WEB}/everyday-wow    /everyday-wow    /everyday-wow
    [tags]    regression    TC_WMALL_01462    WLS_Medium

TC_WMALL_01537 Login header - Switch Language (WeMall_version)   ${WEMALL_WEB}/auth/login    /auth/login    /auth/login    https
   [tags]    regression    TC_WMALL_01537    WLS_Medium

TC_WMALL_01538 Register header - Switch Language (WeMall_version)   ${WEMALL_WEB}/users/register    /users/register    /users/register    https
   [tags]    regression    TC_WMALL_01538    WLS_Medium

TC_WMALL_01539 Level D header - Switch Language (WeMall_version)   ${WEMALL_WEB}/products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html    /products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html    /products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html
   [tags]    regression    TC_WMALL_01539    WLS_Medium

TC_WMALL_01668 Wemall Portal page header - Switch Language (WeMall_version)    ${WEMALL_WEB}    ${EMPTY}    ${EMPTY}
    [tags]    regression    TC_WMALL_01668    WLS_Medium

TC_WMALL_01669 Wemall Stronfront page header - Switch Language (WeMall_version)    ${WEMALL_WEB}/shop/canon    /shop/canon    /shop/canon
    [tags]    regression    TC_WMALL_01669    WLS_Medium

TC_WMALL_01678 Forgot Password page header - Switch Language (WeMall_version)    ${WEMALL_WEB}/forgot_password    /forgot_password    /forgot_password    https
    [tags]    regression    TC_WMALL_01678    WLS_Medium

*** Keywords ***
Switch Language
    [Arguments]    ${full_url}    ${EN_url}    ${TH_url}    ${protocol}=http
    Go to Specific URL    ${full_url}
    Check Location Contain    ${full_url}    ${protocol}
    Verify Language Button    ${protocol}
    Switch to EN Language
    Verify Switch to EN    ${EN_url}    ${protocol}
    Switch to TH Language
    Verify Switch to TH    ${TH_url}    ${protocol}