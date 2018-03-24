*** Settings ***
Force Tags    WLS_Content_Wemall    wemall_header
Suite Setup       Open Browser and Go to Specific URL    ${WEMALL_WEB}
Suite Teardown    Run Keywords    Close All Browsers
Test Template     Search Product
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Search_page/Keywords_SearchPage.robot

*** Variables ***
${username}       robot01@mail.com
${user_display_name}    Robot01@mail.com
${password}       123456

*** Test Cases ***
TC_WMALL_01428 Level C brand page header - Search Product (WeMall_version)    ${WEMALL_WEB}/brand/samsung-6931849325692.html
    [Tags]    regression    TC_WMALL_01428    WLS_Medium

TC_WMALL_01438 Level C category page header - Search Product (WeMall_version)    ${WEMALL_WEB}/category/hulk-3302288514534.html
    [Tags]    regression    TC_WMALL_01438    WLS_Medium

TC_ITMWM_03996 Header on Lv.C for Merchant page - Search Product (WeMall_version)     ${WEMALL_WEB}/m-${SHOP_LYRA_ROBOT}-category-${CAT_SLUG_PKEY}.html
    [Tags]    regression    TC_ITMWM_03996    lyra    WLS_High

TC_WMALL_01448 Search page header - Search Product (WeMall_version)    ${WEMALL_WEB}/search2?q=Apple
    [Tags]    regression    TC_WMALL_01448    WLS_Medium

TC_WMALL_01458 Everyday Wow page header - Search Product (WeMall_version)    ${WEMALL_WEB}/everyday-wow
    [Tags]    regression    TC_WMALL_01458    WLS_Medium

TC_WMALL_01534 Login header - Search Product (WeMall_version)   ${WEMALL_WEB}/auth/login    https
   [tags]    regression    TC_WMALL_01534    WLS_Medium

TC_WMALL_01535 Register header - Search Product (WeMall_version)   ${WEMALL_WEB}/users/register    https
   [tags]    regression    TC_WMALL_01535    WLS_Medium

TC_WMALL_01536 Level D header - Search Product (WeMall_version)   ${WEMALL_WEB}/products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html
   [tags]    regression    TC_WMALL_01536    WLS_Medium

TC_WMALL_01666 Wemall Portal page header - Search Product (WeMall_version)    ${WEMALL_WEB}
    [tags]    regression    TC_WMALL_01666    WLS_Medium

TC_WMALL_01667 Wemall Stronfront page header - Search Product (WeMall_version)    ${WEMALL_WEB}/shop/canon
    [tags]    regression    TC_WMALL_01667    WLS_Medium

TC_WMALL_01677 Forgot Password page header - Search Product (WeMall_version)    ${WEMALL_WEB}/forgot_password    https
    [tags]    regression    TC_WMALL_01677    WLS_Medium

*** Keywords ***
Search Product
    [Arguments]    ${full_url}    ${protocol}=http
    Go to Specific URL    ${full_url}
    Check Location Contain    ${full_url}    ${protocol}
    Verify Search Box Exist
    Verify Autosuggestion    iphone
    Search Product in WeMall    iphone
    Verify Search Result Label    iphone
    Verify Search Text Box and Page Will Redirect to Search Page    iphone
