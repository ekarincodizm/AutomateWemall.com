*** Settings ***
Force Tags    WLS_Manage_Shop
Suite Setup         Open Wemall Browser
Suite Teardown      Close All Browsers
Test Setup         Create Shop But Do Not Initial Data    ${merchant_id}    ${shop_name}    ${shop_slug}
Test Teardown      Delete Shop and All Storefront Data    ${suite_shop_id}
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Resource/TestData/storefronts/storefront_data.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/storefront_page/storefront_page_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
Resource          ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot
Resource          ${CURDIR}/../../../Resource/TestData/storefronts/storefront_data.robot
Library           ${CURDIR}/../../../Keyword/API/api_storefronts/storefront.py

*** Variables ***
${merchant_id}         OD27052
${shop_name}           OUTDOOR
${shop_slug}           outdoor

*** Test Cases ***
TC_WMALL_01709 API storefront clear cache after published storefront web.
    [Tags]    Regression    WLS_Medium
    Prepare Storefront Content Draft by Storefront API    ${suite_shop_id}    web
    Verify Shop Content with Prepare Data - Web Preview Mode    ${shop_slug}
    Updated Prepare Storefront Content Draft    ${suite_shop_id}    web
    sleep    3s
    Verify Shop Content with Updated Prepare Data - Web Preview Mode    ${shop_slug}
    Published Storefront Data    ${suite_shop_id}    web
    Verify Shop Content with Updated Prepare Data - Web Published Mode    ${shop_slug}
    Modified Prepare Storefront Content Draft    ${suite_shop_id}    web
    Verify Shop Content with Modified Data - Web Preview Mode    ${shop_slug}
    Published Storefront Data    ${suite_shop_id}    web
    Verify Shop Content with Modified Data - Web Published Mode    ${shop_slug}

TC_WMALL_01710 API storefront clear cache after published storefront mobile.
    [Tags]    Regression    WLS_Medium
    Prepare Storefront Content Draft by Storefront API    ${suite_shop_id}    mobile
    Verify Shop Content with Prepare Data - Mobile Preview Mode    ${shop_slug}
    Updated Prepare Storefront Content Draft    ${suite_shop_id}    mobile
    sleep    3s
    Verify Shop Content with Updated Prepare Data - Mobile Preview Mode    ${shop_slug}
    Published Storefront Data    ${suite_shop_id}    mobile
    Verify Shop Content with Updated Prepare Data - Mobile Published Mode    ${shop_slug}
    Modified Prepare Storefront Content Draft    ${suite_shop_id}    mobile
    Verify Shop Content with Modified Data - Mobile Preview Mode    ${shop_slug}
    Published Storefront Data    ${suite_shop_id}    mobile
    Verify Shop Content with Modified Data - Mobile Published Mode    ${shop_slug}
    [Teardown]    Run Keywords    Delete Is Mobile Cookie
    ...    AND    Delete Shop and All Storefront Data    ${suite_shop_id}

