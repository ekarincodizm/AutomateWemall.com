*** Settings ***
Force Tags    WLS_API_CMS_Storefront
Suite Setup         Check is Shop Exist by Slug Then Delete Shop by Shop ID    ${disney_shop_slug}
Suite Teardown      Check is Shop Exist by Slug Then Delete Shop by Shop ID    ${disney_shop_slug}
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/api_shops_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot

*** Variables ***
${body_post_template}             ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/post_shop_template.json
${body_put_template}              ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/put_shop_template.json
${disney_merchant_id}             DISNEY1105
${disney_shop_name}               Disney Store
${disney_shop_slug}               disney-store
${disney_shop_slug_TH}            ดิสนีย์-สโตร์
${deafult_merchant_id}            ${EMPTY}
${updated_disney_merchant_id}     DISNEY1106
${updated_disney_shop_name}       Disney Stores
${updated_disney_shop_slug}       disney-stores
${updated_disney_shop_slug_TH}    ดิสนีย์-สโตร์s
${robot_updated_by}               updated_hulk_robot

*** Test Cases ***
############################# POST #############################
TC_WMALL_01391 Update Shop Success
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Verify Node Pages from Shops is Empty
    Sleep    1s
    Update Shop Success    ${disney_shop_id}    ${body_put_template}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug}    active
    Verify Update Shop Success and Response Data Correct    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug}    active    ${robot_updated_by}
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug}    active
    Verify Node Pages from Shops is Empty
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01392 Update Shop By Slug Thai Language
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Verify Node Pages from Shops is Empty
    Sleep    1s
    Update Shop Success    ${disney_shop_id}    ${body_put_template}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Update Shop Success and Response Data Correct    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active    ${robot_updated_by}
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Node Pages from Shops is Empty
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01393 Update Shop by Empty Merchant ID
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Verify Node Pages from Shops is Empty
    Sleep    1s
    Update Shop Success    ${disney_shop_id}    ${body_put_template}    ${EMPTY}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Update Shop Success and Response Data Correct    ${deafult_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active    ${robot_updated_by}
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${deafult_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Node Pages from Shops is Empty
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01394 Update Shop by Empty Shop Name
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Verify Node Pages from Shops is Empty
    Update Shop Not Success    ${disney_shop_id}    ${body_put_template}    ${updated_disney_merchant_id}    ${EMPTY}    ${disney_shop_slug_TH}    active
    Verify Error Code Message    400 Bad Request    CSS4001    Missing Required Field    Shop name is missing.
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Verify Node Pages from Shops is Empty
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01395 Update Shop by Empty Shop Slug
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Verify Node Pages from Shops is Empty
    Update Shop Not Success    ${disney_shop_id}    ${body_put_template}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${EMPTY}    active
    Verify Error Code Message    400 Bad Request    CSS4001    Missing Required Field    Shop url is missing.
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Verify Node Pages from Shops is Empty
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01396 Update Shop by Wrong Shop Slug Format
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Verify Node Pages from Shops is Empty
    Update Shop Not Success    ${disney_shop_id}    ${body_put_template}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    disney_shop    active
    Verify Error Code Message    400 Bad Request    CSS4006    Invalid Input Data Format    Invalid shop url format
    Get Shop by Shop Slug    disney_shop
    Verify Response Success but Data Empty    null
    Update Shop Not Success    ${disney_shop_id}    ${body_put_template}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    disney shop    active
    Verify Error Code Message    400 Bad Request    CSS4006    Invalid Input Data Format    Invalid shop url format
    Get Shop by Shop Slug    disney shop
    Verify Response Success but Data Empty    null
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01397 Update Shop by Empty Shop Status
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    active
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Node Pages from Shops is Empty
    Sleep    1s
    Update Shop Success    ${disney_shop_id}    ${body_put_template}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    ${EMPTY}
    Verify Update Shop Success and Response Data Correct    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active    ${robot_updated_by}
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Node Pages from Shops is Empty
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active
    Update Shop Success    ${disney_shop_id}    ${body_put_template}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Verify Update Shop Success and Response Data Correct    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    inactive    ${robot_updated_by}
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Verify Node Pages from Shops is Empty
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01398 Update Shop Without Merchant ID in Body
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    active
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Node Pages from Shops is Empty
    Sleep    1s
    Update Shop WO Merchant ID Node    ${disney_shop_id}    ${body_put_template}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Update Shop Success and Response Data Correct    ${deafult_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active    ${robot_updated_by}
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${deafult_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Node Pages from Shops is Empty
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01399 Update Shop Without Shop Name in Body
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    active
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Node Pages from Shops is Empty
    Update Shop WO Shop Name Node    ${disney_shop_id}    ${body_put_template}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}  active
    Verify Error Code Message    400 Bad Request    CSS4001    Missing Required Field    Shop name is missing.
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Node Pages from Shops is Empty
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01400 Update Shop Without Shop Slug in Body
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    active
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    active
    Verify Node Pages from Shops is Empty
    Update Shop WO Shop Slug Node    ${disney_shop_id}    ${body_put_template}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug}    active
    Verify Error Code Message    400 Bad Request    CSS4001    Missing Required Field    Shop url is missing.
    Get Shop by Shop Slug    ${disney_shop_slug}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    active
    Verify Node Pages from Shops is Empty
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01401 Update Shop Without Logo
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    active
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Node Pages from Shops is Empty
    Sleep    1s
    Update Shop WO Logo Node    ${disney_shop_id}    ${body_put_template}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Update Shop Success and Response Data Correct    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active    ${robot_updated_by}
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Node Pages from Shops is Empty
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01402 Update Shop Without Shop Status
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    active
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Node Pages from Shops is Empty
    Sleep    1s
    Update Shop Success WO Shop Status Node    ${disney_shop_id}    ${body_put_template}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}
    Verify Update Shop Success and Response Data Correct    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active    ${robot_updated_by}
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Node Pages from Shops is Empty
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}

TC_WMALL_01403 Update Shop Duplicate Merchant ID
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    ${disney_shop_id_2}=    Create Shop Success and Data Correct    ${body_post_template}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Sleep    1s
    Update Shop Success    ${disney_shop_id_2}    ${body_put_template}    ${disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Update Shop Success and Response Data Correct    ${disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active    ${robot_updated_by}
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Verify Node Pages from Shops is Empty
    Get Shop by Shop ID    ${disney_shop_id_2}
    Verify Get Shop Success and Data Correct    ${disney_shop_id_2}    ${disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Node Pages from Shops is Empty
    [Teardown]    Run Keywords    Delete Shop by Shop ID Success    ${disney_shop_id}
    ...    AND    Delete Shop by Shop ID Success    ${disney_shop_id_2}

TC_WMALL_01404 Update Shop Duplicate Shop Name
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    ${disney_shop_id_2}=    Create Shop Success and Data Correct    ${body_post_template}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Sleep    1s
    Update Shop Not Success    ${disney_shop_id_2}    ${body_put_template}    ${updated_disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug_TH}    active
    Verify Error Code Message    400 Bad Request    CSS4004    Duplicate Data    Shop name already exists
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Verify Node Pages from Shops is Empty
    Get Shop by Shop ID    ${disney_shop_id_2}
    Verify Get Shop Success and Data Correct    ${disney_shop_id_2}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Verify Node Pages from Shops is Empty
    [Teardown]    Run Keywords    Delete Shop by Shop ID Success    ${disney_shop_id}
    ...    AND    Delete Shop by Shop ID Success    ${disney_shop_id_2}

TC_WMALL_01405 Update Shop Duplicate Shop Slug
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    ${disney_shop_id_2}=    Create Shop Success and Data Correct    ${body_post_template}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Sleep    1s
    Update Shop Not Success    ${disney_shop_id_2}    ${body_put_template}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug}    active
    Verify Error Code Message    400 Bad Request    CSS4004    Duplicate Data    Shop url already exists
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Verify Node Pages from Shops is Empty
    Get Shop by Shop ID    ${disney_shop_id_2}
    Verify Get Shop Success and Data Correct    ${disney_shop_id_2}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug_TH}    inactive
    Verify Node Pages from Shops is Empty
    [Teardown]    Run Keywords    Delete Shop by Shop ID Success    ${disney_shop_id}
    ...    AND    Delete Shop by Shop ID Success    ${disney_shop_id_2}

TC_WMALL_01406 Update Shop With Empty Shop ID
    [Tags]    post_shops    api_shops    Regression    api_cms
    ${disney_shop_id}=    Create Shop Success and Data Correct    ${body_post_template}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Update Shop Not Success    ${EMPTY}    ${body_put_template}    ${updated_disney_merchant_id}    ${updated_disney_shop_name}    ${disney_shop_slug}    active
    Verify Reponse Failed Because API Gateway Not Nefine
    Get Shop by Shop ID    ${disney_shop_id}
    Verify Get Shop Success and Data Correct    ${disney_shop_id}    ${disney_merchant_id}    ${disney_shop_name}    ${disney_shop_slug}    inactive
    Verify Node Pages from Shops is Empty
    [Teardown]    Delete Shop by Shop ID Success    ${disney_shop_id}
