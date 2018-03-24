*** Settings ***
Force Tags    WLS_Wemall_storefront_homepage
Library          Selenium2Library
Library          ${CURDIR}/../../../Python_Library/ExtendedSelenium/
Resource         ${CURDIR}/../../../Resource/init.robot
Resource         ${CURDIR}/../../../Keyword/API/api_storefronts/api_shops_keywords.robot
Resource         ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot
Resource         ${CURDIR}/../../../Keyword/API/api_portals/menubars_keywords.robot

*** Variables ***
${merchant_id}             Doraemon0001
${shop_name}               Doraemon
${status}                  active
${shop_slug}               doraemon

${portal}                  portal
${template_json_menu}      ${CURDIR}/../../../Resource/TestData/portals/menu_bars/template_menu.json
${MNP_URL}                 http://www.wemall-dev.com/truemove-h/mnp
${MNP_menu}                ย้ายค่ายเบอร์เดิม

*** Test Cases ***

TC_WMALL_01722, TC_WMALL_01724 - Clear cookie on mobile device.
    [Tags]    Regression
    Prepare Storefront Web Data With Content for Storefront API    ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}
    Go To Shop In Shop By Mobile Device    ${shop_slug}    true
    ${click_result}    Run Keyword And Return Status    Click Element and Wait Angular Ready    jquery=.logo
    Run Keyword If    '${click_result}' == 'False'    Execute Javascript    $('.logo').click()
    Location Should Be    ${Wemall_URL}/portal/page1
    Go To Shop In Shop By Mobile Device    ${shop_slug}    false
    ${click_result}    Run Keyword And Return Status    Click Element and Wait Angular Ready    jquery=.logo
    Run Keyword If    '${click_result}' == 'False'    Execute Javascript    $('.logo').click()
    Location Should Be    ${Wemall_URL}/
    [Teardown]    Run Keywords    Delete Shop and All Storefront Data    ${suite_shop_id}
        ...       AND    Close All Browsers

TC_WMALL_01723 Menu Level 1 on portal page when reduce the width screen.
    [Tags]     Regression
    [Setup]    Prepare Menu Bars Data For Suite Get    ${portal}    ${template_json_menu}
    Open Browser And Set Screen
    Select Menubars Dropdown    ${MNP_menu}
    Sleep    5s
    Select Window    url=${MNP_URL}
    Location Should Be    ${MNP_URL}
    [Teardown]    Close All Browsers

*** Keyword ***
Go To Shop In Shop By Mobile Device
    [Arguments]     ${shop_slug}    ${cookie}
    Open Browser     ${WEMALL_WEB}/shop/${shop_slug}    Chrome
    Add Cookie      is_mobile    ${cookie}
    Reload Page

Open Browser And Set Screen
    Open Browser     ${WEMALL_WEB}    Chrome
    Set Window Position    ${0}    ${0}
    Set Window Size     ${720}    ${900}

Select Menubars Dropdown
    [Arguments]    ${name_menu}
    Click Element    jquery=#portal-menu-bars-dropdown
    Click Element and Wait Angular Ready    jquery=a:contains('${name_menu}'):eq(0)

