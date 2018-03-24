*** Settings ***
Force Tags    WLS_Manage_Shop
Resource              ${CURDIR}/../../../Resource/init.robot
Resource              ${CURDIR}/../../../Keyword/API/api_portals/megamenus_keywords.robot
Resource              ${CURDIR}/../../../Keyword/Portal/portal_cms/mega_menu/cms_mega_menu_keywords.robot
Resource              ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/megamenus_keywords.robot
*** Variables ***
${merchant_id}             Doraemon0001
${shop_name}               Doraemon
${status}                  active
${shop_slug}               doraemon

${portal}                  portal
${mega_menu_tem1}          ${CURDIR}/../../../Resource/TestData/portals/mega_menus/megamenu_template1.json
${mega_menu_tem2}          ${CURDIR}/../../../Resource/TestData/portals/mega_menus/megamenu_template2.json
${OWL_CAROSEL_VERSION}       2

${Draft}                   draft
${Published}               published
${TH}                      th_TH
${EN}                      en_US

*** Test Cases ***

TC_WMALL_01713 API portal will clear cache after published portal mega-menus web.
    [Tags]    Regression    WLS_Medium
    [Setup]     Run Keywords    Prepare Template Mega Menu Data Draft    ${portal}    ${mega_menu_tem2}
        ...     AND    Publish Mega Menu Data    ${portal}
    Prepare Template Mega Menu Data Draft    ${portal}    ${mega_menu_tem1}
    Open Browser     ${WEMALL_WEB}/?${PRIVIEW_TOKEN}    Chrome
    Set Window Size     ${1440}    ${900}
    Select Window On Preview Portal Page
    Verify Mega Menu    ${portal}    ${TH}    1      1    ${Draft}
    Go To    ${WEMALL_WEB}/en/?${PRIVIEW_TOKEN}
    Verify Mega Menu    ${portal}    ${EN}    1      1    ${Draft}
    Go To    ${WEMALL_WEB}
    Verify Mega Menu    ${portal}    ${TH}    1      1    ${Published}
    Go To    ${WEMALL_WEB}/en
    Verify Mega Menu    ${portal}    ${EN}    1      1    ${Published}
    Publish Mega Menu Data    ${portal}
    Go To    ${WEMALL_WEB}
    Verify Mega Menu    ${portal}    ${TH}    1      1    ${Draft}
    Verify Mega Menu    ${portal}    ${TH}    1      1    ${Published}
    Go To    ${WEMALL_WEB}/en
    Verify Mega Menu    ${portal}    ${EN}    1      1    ${Draft}
    Verify Mega Menu    ${portal}    ${EN}    1      1    ${Published}
    Prepare Template Mega Menu Data Draft    ${portal}    ${mega_menu_tem2}
    Go To    ${WEMALL_WEB}/?${PRIVIEW_TOKEN}
    Verify Mega Menu    ${portal}    ${TH}    1      1    ${Draft}
    Go To    ${WEMALL_WEB}/en/?${PRIVIEW_TOKEN}
    Verify Mega Menu    ${portal}    ${EN}    1      1    ${Draft}
    Go To    ${WEMALL_WEB}
    ${status}=     Run Keyword And Return Status    Verify Mega Menu    ${portal}    ${TH}    1      1    ${Draft}
    Should Be Equal    '${status}'    'False'
    Publish Mega Menu Data    ${portal}
    Reload Page
    Run Keyword And Return Status    Verify Mega Menu    ${portal}    ${TH}    1      1    ${Draft}
    # [Teardown]    Run Keywords    Delete Shop and All Storefront Data    ${suite_shop_id}
    #     ...       AND    Close All Browsers
    [Teardown]    Close All Browsers

TC_WMALL_01714 API portal will clear cache after published portal mega-menus mobile.
    [Tags]    Regression    WLS_Medium
    [Setup]     Run Keywords    Prepare Template Mega Menu Data Draft    ${portal}    ${mega_menu_tem2}
        ...     AND    Publish Mega Menu Data    ${portal}
    Prepare Template Mega Menu Data Draft    ${portal}    ${mega_menu_tem1}
    Open Browser And Set Screen
    Add Cookie      is_mobile    true
    Reload Page
    Go To    ${WEMALL_WEB}/portal/page1?${PRIVIEW_TOKEN}&${MOBILE_TOKEN}
    Verify Mega Menu Mobile    ${portal}      ${TH}    1     1    ${Draft}
    Go To    ${WEMALL_WEB}/en/portal/page1?${PRIVIEW_TOKEN}&${MOBILE_TOKEN}
    Verify Mega Menu Mobile    ${portal}      ${EN}   1     1    ${Draft}
    Go To    ${WEMALL_WEB}/portal/page1
    Verify Mega Menu Mobile    ${portal}      ${TH}    0     1    ${Published}
    Go To    ${WEMALL_WEB}/en/portal/page1
    Verify Mega Menu Mobile    ${portal}      ${EN}    0     1    ${Published}
    Publish Mega Menu Data    ${portal}
    Go To    ${WEMALL_WEB}/portal/page1
    Verify Mega Menu Mobile    ${portal}      ${TH}    0     1    ${Draft}
    Verify Mega Menu Mobile    ${portal}      ${TH}    0     1    ${Published}
    Go To    ${WEMALL_WEB}/en/portal/page1
    Verify Mega Menu Mobile    ${portal}      ${EN}    0     1    ${Draft}
    Verify Mega Menu Mobile    ${portal}      ${EN}    0     1    ${Published}
    Prepare Template Mega Menu Data Draft    ${portal}    ${mega_menu_tem2}
    Go To    ${WEMALL_WEB}/portal/page1?${PRIVIEW_TOKEN}&${MOBILE_TOKEN}
    Verify Mega Menu Mobile    ${portal}      ${TH}    1     1    ${Draft}
    Go To    ${WEMALL_WEB}/en/portal/page1?${PRIVIEW_TOKEN}&${MOBILE_TOKEN}
    Verify Mega Menu Mobile    ${portal}      ${EN}    1     1    ${Draft}
    Go To    ${WEMALL_WEB}/portal/page1
    ${status}=     Run Keyword And Return Status    Verify Mega Menu Mobile    ${portal}      ${TH}    0     1    ${Draft}
    Should Be Equal    '${status}'    'False'
    Publish Mega Menu Data    ${portal}
    Reload Page
    Run Keyword And Return Status    Verify Mega Menu Mobile    ${portal}      ${TH}    0     1    ${Draft}
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

