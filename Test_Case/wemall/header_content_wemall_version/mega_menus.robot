*** Settings ***
Force Tags    WLS_Content_Wemall    wemall_header
Suite Setup         Open Browser and Set Window Size
# Suite Setup         Open Browser and Go to Specific URL    ${WEMALL_WEB}
Suite Teardown      Run Keywords    Close All Browsers
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
# Resource            ${CURDIR}/../../../Keyword/API/api_portals/menubars_keywords.robot
Test Template       Mega Menus

*** Variables ***
${username}             robot01@mail.com
${user_display_name}    Robot01@mail.com
${password}             123456
${prepare_menu_bars_data}    ${CURDIR}/../../../Resource/TestData/portals/menu_bars/prepare_menu_bars_data.json

*** Test Cases ***
TC_WMALL_01434 Level C brand page header - Mega Menus (WeMall_version)    ${WEMALL_WEB}/brand/samsung-6931849325692.html    2
    [tags]    regression    TC_WMALL_01434    WLS_Medium

TC_WMALL_01444 Level C category page header - Mega Menus (WeMall_version)    ${WEMALL_WEB}/category/tablet-3363917653771.html    2
    [tags]    regression    TC_WMALL_01444    WLS_Medium

TC_ITMWM_03996 Header on Lv.C for Merchant page - Mega Menus (WeMall_version)    ${WEMALL_WEB}/m-${SHOP_LYRA_ROBOT}-category-${CAT_SLUG_PKEY}.html    3
    [tags]    lyra

TC_WMALL_01454 Search page header - Mega Menus (WeMall_version)    ${WEMALL_WEB}/search2?q=Apple    2
    [tags]    regression    TC_WMALL_01454    WLS_Medium

TC_WMALL_01464 Everyday Wow page header - Mega Menus (WeMall_version)    ${WEMALL_WEB}/everyday-wow    2
    [tags]    regression    TC_WMALL_01464    WLS_Medium

TC_WMALL_01521 LevelD header - Mega Menus (WeMall_version)   ${WEMALL_WEB}/products/tefal-al800-2826298171251.html    3
    [tags]    regression    TC_WMALL_01521    WLS_Medium

TC_WMALL_01522 Portal header - Mega Menus (WeMall_version)   ${WEMALL_WEB}    1
    [tags]    regression    TC_WMALL_01522    WLS_Medium

TC_WMALL_01523 Login header - Mega Menus (WeMall_version)   ${WEMALL_WEB}/auth/login    3    https
   [tags]    regression    TC_WMALL_01523    WLS_Medium

TC_WMALL_01524 Register header - Mega Menus (WeMall_version)   ${WEMALL_WEB}/users/register    3    https
   [tags]    regression    TC_WMALL_01524    WLS_Medium

TC_WMALL_01525 Level D header - Mega Menus (WeMall_version)   ${WEMALL_WEB}/products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html    3
   [tags]    regression    TC_WMALL_01525    WLS_Medium

TC_WMALL_01660 Wemall Portal page header - Mega Menus (WeMall_version)    ${WEMALL_WEB}    1
    [tags]    regression    TC_WMALL_01660    WLS_Medium

TC_WMALL_01661 Wemall Stronfront page header - Mega Menus (WeMall_version)    ${WEMALL_WEB}/shop/canon    3
    [tags]    regression    TC_WMALL_01661    WLS_Medium

TC_WMALL_01675 Forgot Password page header - Mega Menus (WeMall_version)    ${WEMALL_WEB}/forgot_password    2    https
    [tags]    regression    TC_WMALL_01675    WLS_Medium

*** Keywords ***
Mega Menus
    [Arguments]    ${full_url}    ${mode}    ${protocol}=http
    Go to Specific URL    ${full_url}
    Check Location Contain    ${full_url}    ${protocol}
    Run Keyword If    ${mode} == 1    Show Mega Menus Mode
    ...    ELSE IF    ${mode} == 2    Hide Mega Menus Mode
    ...    ELSE IF    ${mode} == 3    Level D Mode

Show Mega Menus Mode
    Verify Mega Menu Display
    Click Categories Button
    Verify Mega Menu Not Display
    Click Categories Button
    Mouse Over on My Account
    Verify Mega Menu Display

Hide Mega Menus Mode
    Verify Mega Menu Not Display
    Click Categories Button
    Verify Mega Menu Display
    Click Categories Button
    Verify Mega Menu Not Display
    Click Categories Button
    Verify Mega Menu Display
    Mouse Over on My Account
    Verify Mega Menu Not Display

Level D Mode
    Mouse Over On Hamburger
    Verify Mega Menu Display
    # Verify Wow Logo Display
    Mouse Over on My Account
    Verify Mega Menu Not Display
    Mouse Over On Hamburger
    Verify Mega Menu Display
    Click Hambergur
    Verify Mega Menu Not Display

Open Browser and Set Window Size
    Open Browser and Go to Specific URL    ${WEMALL_WEB}
    Set Window Size    ${1440}    ${900}


