*** Settings ***
Force Tags    WLS_API_CMS_Storefront
Suite Setup     Prepare Data for Storefront API    ${nike_merchant_id}    ${nike_shop_name}    ${nike_shop_slug}    ${nike_shop_status}
Suite Teardown    Run Keywords    Delete Shop by Shop ID Success    ${suite_shop_id}
    ...    AND    Delete Storefront Web and Mobile All Type and All Version    ${suite_shop_id}
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/api_shops_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot
Resource            ${CURDIR}/../../../Resource/TestData/storefronts/storefront_data.robot

*** Variables ***
${nike_merchant_id}       SNEAKER17568
${nike_shop_name}         Sneaker Shop
${nike_shop_slug}         sneaker
${nike_shop_status}       active
${body_post_template}     ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/post_shop_template.json
${updated_shoppages}      ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/prepare_shop_pages.json

*** Test Cases ***
############################# GET ALL #############################
TC_WMALL_01364 Get All Shops
    [Tags]    get_shops    api_shops    Regression    api_cms
    Get All Shops
    Verify Get All Shops Success and Data Correct

############################# GET by Shop ID #############################
TC_WMALL_01365 Get Shop by Shop ID
    [Tags]    get_shops    api_shops    Regression    api_cms
    Get Shop by Shop ID    ${suite_shop_id}
    Verify Get Shop Success and Data Correct    ${suite_shop_id}    ${nike_merchant_id}    ${nike_shop_name}    ${nike_shop_slug}    ${nike_shop_status}
    Verify Node Pages from Shops is Empty
    Verify Get Shop Response Node Time Correct

TC_WMALL_01366 Get Shop by Invalid Shop ID
    [Tags]    get_shops    api_shops    Regression    api_cms
    Get Shop by Shop ID    invalid_shop_id
    Verify Response Success but Data Empty    null

############################# GET by Shop Slug #############################
TC_WMALL_01367 Get Shop by Shop Slug
    [Tags]    get_shops    api_shops    Regression    api_cms
    Get Shop by Shop Slug    ${nike_shop_slug}
    Verify Get Shop Success and Data Correct    ${suite_shop_id}    ${nike_merchant_id}    ${nike_shop_name}    ${nike_shop_slug}    ${nike_shop_status}
    Verify Node Pages from Shops is Empty
    Verify Get Shop Response Node Time Correct

TC_WMALL_01368 Get Shop by Invalid Shop Slug
    [Tags]    get_shops    api_shops    Regression    api_cms
    Get Shop by Shop Slug    invalid_shop_slug
    Verify Response Success but Data Empty    null

TC_WMALL_01369 Get Shop by Empty Shop Slug
    [Tags]    get_shops    api_shops    Regression    api_cms
    Get Shop by Shop Slug    ${EMPTY}
    Verify Response Success but Data Empty    null

############################# GET by Shop Name #############################
TC_WMALL_01370 Get Shop by Shop Name
    [Tags]    get_shops    api_shops    Regression    api_cms
    Get Shop by Shop Name    ${nike_shop_name}
    Verify Get Shop Success and Data Correct    ${suite_shop_id}    ${nike_merchant_id}    ${nike_shop_name}    ${nike_shop_slug}    ${nike_shop_status}
    Verify Node Pages from Shops is Empty
    Verify Get Shop Response Node Time Correct

TC_WMALL_01371 Get Shop by Invalid Shop Name
    [Tags]    get_shops    api_shops    Regression    api_cms
    Get Shop by Shop Name    invalid_shop_name
    Verify Response Success but Data Empty    null

TC_WMALL_01372 Get Shop by Empty Shop Name
    [Tags]    get_shops    api_shops    Regression    api_cms
    Get Shop by Shop Name    ${EMPTY}
    Verify Response Success but Data Empty    null

############################# GET by Merchant ID #############################
TC_WMALL_01373 Get Shop by Merchant ID
    [Tags]    get_shops    api_shops    Regression    api_cms
    Get Shop by Merchant ID    ${nike_merchant_id}
    Verify Get Shop Success and Data Correct    ${suite_shop_id}    ${nike_merchant_id}    ${nike_shop_name}    ${nike_shop_slug}    ${nike_shop_status}
    Verify Node Pages from Shops is Empty
    Verify Get Shop Response Node Time Correct

TC_WMALL_01374 Get Shop by Invalid Merchant ID
    [Tags]    get_shops    api_shops    Regression    api_cms
    Get Shop by Merchant ID    invalid_merchant_id
    Verify Response Success but Data Empty    null

TC_WMALL_01375 Get Shop by Empty Merchant ID
    [Tags]    get_shops    api_shops    Regression    api_cms
    Get Shop by Merchant ID    ${EMPTY}
    Verify Response Success but Data Empty    null

############################# GET Shop and Check Node Pages #############################
TC_ITMWM_05534 Get Shop and Node Pages is Matched with Expected
    [Tags]    get_shops    api_shops    Regression    api_cms
    Update Shop Success    ${suite_shop_id}    ${updated_shoppages}    ${nike_merchant_id}    ${nike_shop_name}    ${nike_shop_slug}    active
    ##### Get shop by id #####
    Get Shop by Shop ID    ${suite_shop_id}
    Verify Get Shop Success and Data Correct    ${suite_shop_id}    ${nike_merchant_id}    ${nike_shop_name}    ${nike_shop_slug}    ${nike_shop_status}
    Verify Get Shop Response Node Time Correct
    Verify Node Pages Matched with Expected    ${updated_shoppages}

    ##### Get shop by slug #####
    Get Shop by Shop Slug    ${nike_shop_slug}
    Verify Get Shop Success and Data Correct    ${suite_shop_id}    ${nike_merchant_id}    ${nike_shop_name}    ${nike_shop_slug}    ${nike_shop_status}
    Verify Get Shop Response Node Time Correct
    Verify Node Pages Matched with Expected    ${updated_shoppages}

    ##### Get shop by name #####
    Get Shop by Shop Name    ${nike_shop_name}
    Verify Get Shop Success and Data Correct    ${suite_shop_id}    ${nike_merchant_id}    ${nike_shop_name}    ${nike_shop_slug}    ${nike_shop_status}
    Verify Get Shop Response Node Time Correct
    Verify Node Pages Matched with Expected    ${updated_shoppages}

    ##### Get shop by merchant id #####
    Get Shop by Merchant ID    ${nike_merchant_id}
    Verify Get Shop Success and Data Correct    ${suite_shop_id}    ${nike_merchant_id}    ${nike_shop_name}    ${nike_shop_slug}    ${nike_shop_status}
    Verify Get Shop Response Node Time Correct
    Verify Node Pages Matched with Expected    ${updated_shoppages}
    [Teardown]    Update Shop Success    ${body_post_template}    ${updated_shoppages}    ${nike_merchant_id}    ${nike_shop_name}    ${nike_shop_slug}    active


