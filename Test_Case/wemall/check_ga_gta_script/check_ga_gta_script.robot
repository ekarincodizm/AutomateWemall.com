*** Settings ***
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/common/web_common_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/check_ga_gta_script/check_ga_gta_script_keywords.robot
Resource          ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot

Suite Setup       Run Keywords    Open Wemall Browser
Suite Teardown    Run Keywords    Close All Browsers

*** Variables ***
${merchant_shop_slug_active1}        activeslug01
${merchant_id_storefront1}           MTH1008123
${merchant_shop_slug_active2}        activeslug02
${merchant_id_storefront2}           MTH1008224
${merchant_shop_slug_active3}        activeslug03
${merchant_id_storefront3}           MTH1008325

*** Test Cases ***
TC_WMALL_01295 GA_GTA - Check GA/GTA Script Merchant 1
    [Tags]    GA-GTA    Regression
    [Setup]    Prepare Data for Storefront API     ${merchant_id_storefront1}    ${merchant_shop_slug_active1}    ${merchant_shop_slug_active1}    active
    Go To Storefront Page    ${merchant_shop_slug_active1}
    Script Should Contain NoScript
    [Teardown]    Delete Storefront Web and Mobile All Type and All Version     ${suite_shop_id}

TC_WMALL_01296 GA_GTA - Check GA/GTA Script Merchant 2
    [Tags]    GA-GTA    Regression
    [Setup]    Prepare Data for Storefront API     ${merchant_id_storefront2}    ${merchant_shop_slug_active2}    ${merchant_shop_slug_active2}    active
    Go To Storefront Page    ${merchant_shop_slug_active2}
    Script Should Contain NoScript
    [Teardown]    Delete Storefront Web and Mobile All Type and All Version     ${suite_shop_id}

TC_WMALL_01297 GA_GTA - Check GA/GTA Script Merchant 3
    [Tags]    GA-GTA    Regression
    [Setup]    Prepare Data for Storefront API     ${merchant_id_storefront3}    ${merchant_shop_slug_active3}    ${merchant_shop_slug_active3}    active
    Go To Storefront Page    ${merchant_shop_slug_active3}
    Script Should Contain NoScript
    [Teardown]    Delete Storefront Web and Mobile All Type and All Version     ${suite_shop_id}



