*** Settings ***
Force Tags    WLS_Content_Wemall    wemall_header
Suite Setup         Prepare Menu Bars And Open Browser
# Suite Setup         Open Browser and Go to Specific URL    ${WEMALL_WEB}
Suite Teardown      Run Keywords    Close All Browsers
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Resource            ${CURDIR}/../../../Keyword/API/api_portals/menubars_keywords.robot
# Test Template       Menu Bars

*** Variables ***
${username}             robot01@mail.com
${user_display_name}    Robot01@mail.com
${password}             123456
${prepare_menu_bars_data}    ${CURDIR}/../../../Resource/TestData/portals/menu_bars/prepare_menu_bars_data.json
${menu_mnp1}    xpath=/html/body/div[1]/div[2]/div/div[3]/div[1]/div/ul/li[4]/ul/li/a
${menu_mnp2}    xpath=/html/body/div[2]/div[2]/div/div[2]/div[1]/div/ul/li[4]/ul/li/a

*** Test Cases ***
TC_WMALL_01435 Level C brand page header - Menu bars (WeMall_version)
    [tags]    regression    TC_WMALL_01435    WLS_Medium
    Go to Specific URL    ${WEMALL_WEB}/brand/samsung-6931849325692.html
    Check Location Contain   ${WEMALL_WEB}/brand/samsung-6931849325692.html    http
    Show Menubars Mode    ${menu_mnp1}

TC_WMALL_01445 Level C category page header - Menu bars (WeMall_version)
    [tags]    regression    TC_WMALL_01445    WLS_Medium
    Go to Specific URL    ${WEMALL_WEB}/category/tablet-3363917653771.html
    Check Location Contain   ${WEMALL_WEB}/category/tablet-3363917653771.html    http
    Show Menubars Mode    ${menu_mnp1}

TC_ITMWM_03996 Header on Lv.C for Merchant page - Menu bars (WeMall_version)
    [tags]    lyra
    Go to Specific URL    ${WEMALL_WEB}/m-${SHOP_LYRA_ROBOT}-category-${CAT_SLUG_PKEY}.html
    Check Location Contain    ${WEMALL_WEB}/m-${SHOP_LYRA_ROBOT}-category-${CAT_SLUG_PKEY}.html    http
    Level D Mode

TC_WMALL_01455 Search page header - Menu bars (WeMall_version)
    [tags]    regression    TC_WMALL_01455    WLS_Medium
    Go to Specific URL    ${WEMALL_WEB}/search2?q=Apple
    Check Location Contain    ${WEMALL_WEB}/search2?q=Apple    http
    Show Menubars Mode    ${menu_mnp2}

TC_WMALL_01465 Everyday Wow page header - Menu bars (WeMall_version)
    [tags]    regression    TC_WMALL_01465    WLS_Medium
    Go to Specific URL    ${WEMALL_WEB}/everyday-wow
    Check Location Contain   ${WEMALL_WEB}/everyday-wow    http
    Show Menubars Mode    ${menu_mnp1}

TC_WMALL_01529 Level D header - Menu bars (WeMall_version)
    [tags]    regression    TC_WMALL_01529    WLS_Medium
    Go to Specific URL    ${WEMALL_WEB}/products/tefal-al800-2826298171251.html
    Check Location Contain    ${WEMALL_WEB}/products/tefal-al800-2826298171251.html    http
    Level D Mode

TC_WMALL_01530 Portal header - Menu bars (WeMall_version)
    [tags]    regression    TC_WMALL_01530    WLS_Medium
    Go to Specific URL    ${WEMALL_WEB}
    Check Location Contain    ${WEMALL_WEB}    http
    Show Mega Menus Mode

TC_WMALL_01531 Login header - Menu bars (WeMall_version)
   [tags]    regression    TC_WMALL_01531    WLS_Medium
    Go to Specific URL    ${WEMALL_WEB}/auth/login
    Check Location Contain    ${WEMALL_WEB}/auth/login    https
    Level D Mode

TC_WMALL_01532 Register header - Menu bars (WeMall_version)
   [tags]    regression    TC_WMALL_01532    WLS_Medium
    Go to Specific URL    ${WEMALL_WEB}/users/register
    Check Location Contain    ${WEMALL_WEB}/users/register    https
    Level D Mode

TC_WMALL_01676 Forgot Password page header - Menu bars (WeMall_version)
    [tags]    regression    TC_WMALL_01676    WLS_Medium
    Go to Specific URL    ${WEMALL_WEB}/forgot_password
    Check Location Contain    ${WEMALL_WEB}/forgot_password    https
    Show Menubars Mode    ${menu_mnp1}

*** Keywords ***
Show Mega Menus Mode
    Verify Mega Menu Display
    Click Categories Button
    Verify Mega Menu Not Display
    Click Categories Button
    Mouse Over on My Account
    Verify Mega Menu Display

Show Menubars Mode
    [Arguments]    ${locator}=${menu_mnp1}
    Verify Menu Bar Display    ${prepare_menu_bars_data}    ${locator}

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

Prepare Menu Bars And Open Browser
    Prepare Menu Bars Data For Suite Get    portal    ${prepare_menu_bars_data}
    Open Browser and Go to Specific URL    ${WEMALL_WEB}
    # Maximize Browser Window
    # Set Window Size    ${1440}    ${900}

#Menu Bars
#    [Arguments]    ${full_url}    ${mode}    ${protocol}=http
#    Go to Specific URL    ${full_url}
#    Check Location Contain    ${full_url}    ${protocol}
#    Run Keyword If    ${mode} == 1    Show Mega Menus Mode
#    ...    ELSE IF    ${mode} == 2    Show Menubars Mode
#    ...    ELSE IF    ${mode} == 3    Level D Mode

