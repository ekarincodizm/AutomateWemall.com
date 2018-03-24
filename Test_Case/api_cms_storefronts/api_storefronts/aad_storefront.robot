*** Settings ***
Force Tags    WLS_API_CMS_Storefront
Suite Setup         Prepare Data for Storefront API    ${merchant_id}    ${shop_name}    ${slug}    ${status}
Suite Teardown      Delete Storefront Web and Mobile All Type and All Version    ${suite_shop_id}
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/common/api_keywords.robot
Library             ${CURDIR}/../../../Keyword/API/api_storefronts/storefront.py

*** Variables ***
${merchant_id}      NIKE30000
${shop_name}        Nike Shop
${slug}             nike-shop
${status}           active
${anonymousId}      anonymousId
${web_view}         web

*** Test Cases ***
TC_WMALL_00588 Authentication Get Storefront
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    Get Tokens from AAD    ${EMAIL}    ${PASSWORD}    ${GRANT_TYPE}
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    anonymousId=${anonymousId}    accessToken=${ACCESS_TOKENS}
    Response Header Should Contain Data    ${Response}    ${suite_shop_id}
    Response Menu Should Contain Data    ${Response}    ${suite_shop_id}
    Response Banner Should Contain Data    ${Response}    ${suite_shop_id}
    Response Content Should Contain Data    ${Response}    ${suite_shop_id}
    Response Footer Should Contain Data    ${Response}    ${suite_shop_id}
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    anonymousId=${EMPTY}    accessToken=${ACCESS_TOKENS}
    Response Header Should Contain Data    ${Response}    ${suite_shop_id}
    Response Menu Should Contain Data    ${Response}    ${suite_shop_id}
    Response Banner Should Contain Data    ${Response}    ${suite_shop_id}
    Response Content Should Contain Data    ${Response}    ${suite_shop_id}
    Response Footer Should Contain Data    ${Response}    ${suite_shop_id}
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    anonymousId=${anonymousId}    accessToken=${EMPTY}
    Response Header Should Contain Data    ${Response}    ${suite_shop_id}
    Response Menu Should Contain Data    ${Response}    ${suite_shop_id}
    Response Banner Should Contain Data    ${Response}    ${suite_shop_id}
    Response Content Should Contain Data    ${Response}    ${suite_shop_id}
    Response Footer Should Contain Data    ${Response}    ${suite_shop_id}
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    anonymousId=${EMPTY}    accessToken=${EMPTY}
    Response Header Should Contain Data    ${Response}    ${suite_shop_id}
    Response Menu Should Contain Data    ${Response}    ${suite_shop_id}
    Response Banner Should Contain Data    ${Response}    ${suite_shop_id}
    Response Content Should Contain Data    ${Response}    ${suite_shop_id}
    Response Footer Should Contain Data    ${Response}    ${suite_shop_id}

TC_WMALL_00589 Expired Token for Get Storefront
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    Get Storefront Failed    ${suite_shop_id}    ${web_view}    ${anonymousId}    ${EXPIRED_TOKENS}
    Verify Request Failed Because Access Token Expired for CSS
    Get Storefront Failed    ${suite_shop_id}    ${web_view}    ${EMPTY}    ${EXPIRED_TOKENS}
    Verify Request Failed Because Access Token Expired for CSS

