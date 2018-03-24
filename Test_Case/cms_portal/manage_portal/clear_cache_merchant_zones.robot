*** Settings ***
Force Tags    WLS_Manage_Shop
Resource              ${CURDIR}/../../../Resource/init.robot
Resource              ${CURDIR}/../../../Keyword/Portal/portal_cms/merchant_zones/merchantzones_portals.robot
# Resource              ${CURDIR}/../../../Keyword/API/api_portals/merchantzones_keywords.robot
Suite Teardown        Prepare Merchant Zone Data End
# Resource              ${CURDIR}/../../../Keyword/Portal/portal_cms/mega_menu/cms_mega_menu_keywords.robot
# Resource              ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/megamenus_keywords.robot
*** Variables ***
${merchant_id}             Doraemon0001
${shop_name}               Doraemon
${status}                  active
${shop_slug}               doraemon

${portal}                  portal
${merchant_zone_group}     ${CURDIR}/../../../Resource/TestData/portals/merchant_zones/merchant_zone_group_data1.json
${merchant_zone}           ${CURDIR}/../../../Resource/TestData/portals/merchant_zones/merchant_zone_data1.json

${merchant_zone_group2}     ${CURDIR}/../../../Resource/TestData/portals/merchant_zones/merchant_zone_group_data2.json

${Draft}                   draft
${Published}               published
${TH}                      th_TH
${EN}                      en_US
${PRIVIEW_TOKEN}           preview=678e45fa792c0a865d0eaee1b19e834d

${merchant_zone2}          ${CURDIR}/../../../Resource/TestData/portals/merchant_zones/merchant_zone_template.json
${merchant_group1}         ${CURDIR}/../../../Resource/TestData/portals/merchant_zones/merchant_group_template1.json
${merchant_group2}         ${CURDIR}/../../../Resource/TestData/portals/merchant_zones/merchant_group_template2.json
${merchant_group3}         ${CURDIR}/../../../Resource/TestData/portals/merchant_zones/merchant_group_template3.json
${merchant_group4}         ${CURDIR}/../../../Resource/TestData/portals/merchant_zones/merchant_group_template4.json

*** Test Cases ***

TC_WMALL_01715 API portal will clear cache after published portal merchant zones web.
    [Tags]    Regression    WLS_Medium
    [Setup]     Delete Module Type in Merchant Zone    ${portal}
    ### Prepare Data Publish ###
    Create Module Type in Merchant Zone    ${portal}    ${merchant_zone}
    Update Merchant Zone Group    ${portal}    merchant_zone_group_id_cc    ${merchant_zone_group}
    Published Merchant Zones Data    ${portal}
     ### Prepare Data Draft ###
    Update Merchant Zone Group    ${portal}    merchant_zone_group_id_cc    ${merchant_zone_group2}
    Open Browser And Set Screen
    Verify Publish Data Merchant Zone On Portal Page    ${portal}    ${TH}
    Go To    ${WEMALL_WEB}/en
    Verify Publish Data Merchant Zone On Portal Page    ${portal}    ${EN}
    Go To    ${WEMALL_WEB}/?${PRIVIEW_TOKEN}
    Verify Draft Data Merchant Zone On Portal Page    ${portal}    ${TH}
    Go To    ${WEMALL_WEB}/en/?${PRIVIEW_TOKEN}
    Verify Draft Data Merchant Zone On Portal Page    ${portal}    ${EN}
    Published Merchant Zones Data    ${portal}
    Go To    ${WEMALL_WEB}
    Verify Draft Data Merchant Zone On Portal Page    ${portal}    ${TH}
    [Teardown]    Close All Browsers

TC_WMALL_01716 API portal will clear cache after published portal merchant zones mobile.
    [Tags]    Regression    WLS_Medium
    [Setup]     Delete Module Type in Merchant Zone    ${portal}
    ### Prepare Data Publish ###
    Create Module Type in Merchant Zone    ${portal}    ${merchant_zone}
    Update Merchant Zone Group    ${portal}    merchant_zone_group_id_cc    ${merchant_zone_group}
    Published Merchant Zones Data    ${portal}
     ### Prepare Data Draft ###
    Update Merchant Zone Group    ${portal}    merchant_zone_group_id_cc    ${merchant_zone_group2}
    Go To Wemall Mobile Device
    Sleep    5s
    Verify Publish Data Merchant Zone On Mobile    ${portal}    ${TH}
    Go To     ${WEMALL_WEB}/en/portal/page1
    Sleep    5s
    Verify Publish Data Merchant Zone On Mobile    ${portal}    ${EN}
    Go To    ${WEMALL_WEB}/portal/page1?${PRIVIEW_TOKEN}&is_mobile=1
    Sleep    5s
    Verify Draft Data Merchant Zone On Mobile    ${portal}    ${TH}
    Go To    ${WEMALL_WEB}/en/portal/page1?${PRIVIEW_TOKEN}&is_mobile=1
    Sleep    5s
    Verify Draft Data Merchant Zone On Mobile    ${portal}    ${EN}
    Published Merchant Zones Data    ${portal}
    Go To    ${WEMALL_WEB}
    Sleep    5s
    Verify Draft Data Merchant Zone On Mobile    ${portal}    ${TH}

*** Keyword ***
Go To Wemall Mobile Device
    Open Browser     ${WEMALL_WEB}    Chrome
    Add Cookie      is_mobile    true
    Reload Page

Open Browser And Set Screen
    Open Browser     ${WEMALL_WEB}    Chrome
    Set Window Position    ${0}    ${0}
    Set Window Size     ${720}    ${900}

Select Menubars Dropdown
    [Arguments]    ${name_menu}
    Click Element    jquery=#portal-menu-bars-dropdown
    Click Element and Wait Angular Ready    jquery=a:contains('${name_menu}'):eq(0)

Prepare Merchant Zone Data End
    Delete Module Type in Merchant Zone    ${portal}
    Create Module Type in Merchant Zone    ${portal}    ${merchant_zone2}
    Update Merchant Zone Group    ${portal}    55f14fd879879    ${merchant_group1}
    Update Merchant Zone Group    ${portal}    55f14fce45902    ${merchant_group2}
    Update Merchant Zone Group    ${portal}    55f14fe256d04    ${merchant_group3}
    Update Merchant Zone Group    ${portal}    55f0ff9eb38f5    ${merchant_group4}
    Published Merchant Zones Data    ${portal}
