*** Settings ***
Force Tags    WLS_API_CMS_Storefront
Suite Setup         Check is Shop Exist by Slug Then Delete Shop by Shop ID    ${scott_shop_slug}
Suite Teardown      Check is Shop Exist by Slug Then Delete Shop by Shop ID    ${scott_shop_slug}
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/api_shops_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot

*** Variables ***
${body_post_template}    ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/post_shop_template.json
${scott_merchant_id}     WMHULK1000
${scott_shop_name}       Scott Extra
${scott_shop_slug}       scott-shop-slug
${scott_shop_status}     inactive

*** Test Cases ***
############################# DELETE #############################
TC_WMALL_01407 Delete Shop Success
    [Tags]    delete_shops    api_shops    Regression    api_cms
    ${scott_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${scott_merchant_id}    ${scott_shop_name}    ${scott_shop_slug}    ${scott_shop_status}
    Get Shop by Shop ID    ${scott_shop_id}
    Verify Get Shop Success and Data Correct    ${scott_shop_id}    ${scott_merchant_id}    ${scott_shop_name}    ${scott_shop_slug}    ${scott_shop_status}
    Delete Shop by Shop ID    ${scott_shop_id}
    Verify Delete Shop Success and Response Data Correct
    Get Shop by Shop ID    ${scott_shop_id}
    Verify Response Success but Data Empty    null

TC_WMALL_01408 Delete Shop by Invalid Shop ID
    [Tags]    delete_shops    api_shops    Regression    api_cms
    Delete Shop by Shop ID    invalid_shop_id
    Verify Delete Shop Success and Response Data Correct
    Get Shop by Shop ID    invalid_shop_id
    Verify Response Success but Data Empty    null

TC_WMALL_01409 Update Shop With Empty Shop ID
    [Tags]    delete_shops    api_shops    Regression    api_cms
    Delete Shop by Shop ID Failed    ${EMPTY}
    Verify Reponse Failed Because API Gateway Not Nefine
