*** Settings ***
Force Tags    WLS_API_CMS_Storefront
Suite Setup         Check is Shop Exist by Slug Then Delete Shop by Shop ID    ${disney_shop_slug}
Suite Teardown      Check is Shop Exist by Slug Then Delete Shop by Shop ID    ${disney_shop_slug}
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/api_shops_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot

*** Variables ***
${body_post_template}     ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/post_shop_template.json
${disney_merchant_id}     DISNEY1105
${disney_shop_name}       Disney Store
${disney_shop_slug}       disney-store
${disney_shop_slug_TH}    ดิสนีย์-สโตร์
${deafult_merchant_id}    ${EMPTY}

*** Test Cases ***
############################# POST #############################
TC_WMALL_01376 Create Shop Success
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    active
    Verify Create Shop Success and Response Data Correct    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    active
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    active
    Verify Node Pages from Shops is Empty
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01377 Create Shop By Slug Thai Language
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Create Shop Success and Response Data Correct    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    active
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Node Pages from Shops is Empty
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01378 Create Shop by Empty Merchant ID
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success    ${body_post_template}    ${EMPTY}    ${disney_shop_name}    ${disney_shop_slug}    active
    Verify Create Shop Success and Response Data Correct    ${deafult_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    active
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${deafult_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    active
    Verify Node Pages from Shops is Empty
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01379 Create Shop by Empty Shop Name
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Not Success    ${body_post_template}    ${disney_merchant_id}    ${EMPTY}    ${disney_shop_slug}    active
    Verify Error Code Message    400 Bad Request    CSS4001    Missing Required Field    Shop name is missing.
    Get Shop by Shop Slug    ${disney_shop_slug}
    Verify Response Success but Data Empty    null
    # [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01380 Create Shop by Empty Shop Slug
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Not Success    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${EMPTY}    active
    Verify Error Code Message    400 Bad Request    CSS4001    Missing Required Field    Shop url is missing.
    Get Shop by Shop Slug    ${disney_shop_slug}
    Verify Response Success but Data Empty    null
    # [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01381 Create Shop by Wrong Shop Slug Format
    [Tags]    post_shops    api_shops    Regression    api_cms
    Create Shop Not Success    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    disney_shop    inactive
    Verify Error Code Message    400 Bad Request    CSS4006    Invalid Input Data Format    Invalid shop url format
    Get Shop by Shop Slug    disney_shop
    Verify Response Success but Data Empty    null
    Create Shop Not Success    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    disney shop    inactive
    Verify Error Code Message    400 Bad Request    CSS4006    Invalid Input Data Format    Invalid shop url format
    Get Shop by Shop Slug    disney shop
    Verify Response Success but Data Empty    null

TC_WMALL_01382 Create Shop by Empty Shop Status
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    ${EMPTY}
    Verify Create Shop Success and Response Data Correct    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Verify Node Pages from Shops is Empty
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01383 Create Shop Without Merchant ID in Body
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop WO Merchant ID Node    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Verify Create Shop Success and Response Data Correct    ${deafult_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${deafult_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Verify Node Pages from Shops is Empty
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01384 Create Shop Without Shop Name in Body
    [Tags]    post_shops    api_shops    Regression    api_cms
    Create Shop WO Shop Name Node    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Verify Error Code Message    400 Bad Request    CSS4001    Missing Required Field    Shop name is missing.
    Get Shop by Shop Slug    ${disney_shop_slug}
    Verify Response Success but Data Empty    null

TC_WMALL_01385 Create Shop Without Shop Slug in Body
    [Tags]    post_shops    api_shops    Regression    api_cms
    Create Shop WO Shop Slug Node    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Verify Error Code Message    400 Bad Request    CSS4001    Missing Required Field    Shop url is missing.
    Get Shop by Shop Slug    ${disney_shop_slug}
    Verify Response Success but Data Empty    null

TC_WMALL_01386 Create Shop Without Logo
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop WO Logo Node    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Verify Create Shop Success and Response Data Correct but Node Logo is Empty    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct but Node Logo is Empty    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Verify Node Pages from Shops is Empty
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01387 Create Shop Without Shop Status
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success WO Shop Status Node    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}
    Verify Create Shop Success and Response Data Correct    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01388 Create Shop Duplicate Merchant ID
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    ${disney_shop_id_2}=    Create Shop Success    ${body_post_template}    ${disney_merchant_id}    disney_shop_2    disney-shop-2    inactive
    Verify Create Shop Success and Response Data Correct    ${disney_merchant_id}    disney_shop_2    disney-shop-2    inactive
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Get Shop by Shop ID    ${disney_shop_id_2}
    Verify Get Shop Success and Data Correct    ${disney_shop_id_2}    ${disney_merchant_id}    disney_shop_2    disney-shop-2    inactive
    Verify Node Pages from Shops is Empty
    [Teardown]    Run Keywords    Delete Shop by Shop ID Success    ${disney_shop_id}
    ...    AND    Delete Shop by Shop ID Success    ${disney_shop_id_2}

TC_WMALL_01389 Create Shop Duplicate Shop Name
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Create Shop Not Success    ${body_post_template}    merchant_2    ${disney_shop_name}    disney-shop-2    inactive
    Verify Error Code Message    400 Bad Request    CSS4004    Duplicate Data    Shop name already exists
    Get Shop by Shop Slug    ${disney_shop_slug}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Verify Node Pages from Shops is Empty
    Get Shop by Shop Slug    disney-shop-2
    Verify Response Success but Data Empty    null
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01390 Create Shop Duplicate Shop Slug
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Create Shop Not Success    ${body_post_template}    merchant_2    disney_shop_2    ${disney_shop_slug}    inactive
    Verify Error Code Message    400 Bad Request    CSS4004    Duplicate Data    Shop url already exists
    Get Shop by Shop Name    ${disney_shop_name}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Verify Node Pages from Shops is Empty
    Get Shop by Shop Name    disney_shop_2
    Verify Response Success but Data Empty    null
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}
