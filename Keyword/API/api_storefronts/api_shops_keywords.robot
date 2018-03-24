*** Settings ***
Library             HttpLibrary.HTTP
Resource            ${CURDIR}/../common/api_keywords.robot
# Resource            ${CURDIR}/../../Common/keywords_wemall_common.robot
Library             Collections
Library             OperatingSystem

*** Variables ***
${body_post_template}      ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/post_shop_template.json

*** Keywords ***
####### Prepare Data #######
Prepare Shop Data For Suite
    [Arguments]    ${merchant_id}    ${shop_name}    ${slug}    ${status}   ${shop_json_template}
    ${shop_id}=           Prepare Shop Data     ${merchant_id}    ${shop_name}    ${slug}    ${status}   ${shop_json_template}
    Set Suite Variable    ${suite_shop_id}    ${shop_id}
    Log    Suite Shop ID : ${suite_shop_id}

Prepare Shop Data
    [Arguments]    ${merchant_id}    ${shop_name}    ${slug}    ${status}   ${shop_json_template}
    ${shop_id}=    Create Shop Success and Data Correct    ${shop_json_template}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    [Return]        ${shop_id}

Prepare Shop Data Dynamo
    ${json_data}=     Get File    ${DATA_PATH}
    Dynamo Put Item    ${STOREFRONT_SHOP_TABLE}    ${json_data}
    ${TEST_SHOP_DICT}=    Convert Json To Dict    ${json_data}
    ${TEST_SHOP_ID}=      Get From Dictionary   ${TEST_SHOP_DICT}   id
    ${TEST_SHOP_SLUG}=    Get From Dictionary   ${TEST_SHOP_DICT}   slug
    ${TEST_SHOP_PAGES_DICT}=    Get From Dictionary    ${TEST_SHOP_DICT}    pages
    ${PAGES_ID_LIST}=    Get Dictionary Keys    ${TEST_SHOP_PAGES_DICT}   # keys will be a list of key items

    Set Suite Variable    ${SUITE_PAGES_ID_LIST}    ${PAGES_ID_LIST}
    Set Suite Variable    ${SUTIE_TEST_SHOP_PAGES_DICT}     ${TEST_SHOP_PAGES_DICT}
    Set Suite Variable    ${SUTIE_TEST_SHOP_ID}    ${TEST_SHOP_ID}

####### GET #######
Get All Shops
    HTTP Get Request    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}

Get Shop by Shop ID
    [Arguments]    ${shop_id}
    HTTP Get Request    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}${shop_id}

Get Shop by Shop Slug
    [Arguments]    ${shop_slug}
    HTTP Get Request    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}slug/${shop_slug}

Get Shop by Shop Name
    [Arguments]    ${shop_name}
    HTTP Get Request    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}name/${shop_name}

Get Shop by Merchant ID
    [Arguments]    ${merchant_id}
    HTTP Get Request    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}merchant_id/${merchant_id}

####### POST #######
Prepare Json Body for Post Shop
    [Arguments]    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Get File    ${json_data_file}
    ${json_data}=    Add Node to Json Body    ${json_data}    merchant_id    ${merchant_id}
    ${json_data}=    Add Node to Json Body    ${json_data}    shop_name    ${shop_name}
    ${json_data}=    Add Node to Json Body    ${json_data}    slug    ${slug}
    ${json_data}=    Add Node to Json Body    ${json_data}    shop_status    ${status}
    [Return]    ${json_data}

Create Shop
    [Arguments]    ${request_body}
    # Wemall Common - Debug    ${STOREFRONT-API-httpLib}    STOREFRONT-API-httpLib
    HTTP Post Request    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}    ${request_body}
    ${shop_id}=    Get Shop ID from Response Body Data
    [Return]    ${shop_id}

Create Shop Failed
    [Arguments]    ${request_body}
    HTTP Post Request Failed    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}    ${request_body}

Create Shop Not Success
    [Arguments]    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${request_body}=    Prepare Json Body for Post Shop    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    HTTP Post Request Failed    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}    ${request_body}

Create Shop Success
    [Arguments]    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Prepare Json Body for Post Shop    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${shop_id}=    api_shops_keywords.Create Shop    ${json_data}
    [Return]    ${shop_id}

Create Shop Success and Data Correct
    [Arguments]    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${shop_id}=    Create Shop Success    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Verify Response Success and Data Not Empty
    [Return]    ${shop_id}

Create Shop WO Shop Name Node
    [Arguments]    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Prepare Json Body for Post Shop    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Remove Node from Json Body    ${json_data}    shop_name
    Create Shop Failed    ${json_data}

Create Shop WO Shop Slug Node
    [Arguments]    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Prepare Json Body for Post Shop    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Remove Node from Json Body    ${json_data}    slug
    Create Shop Failed    ${json_data}

Create Shop WO Merchant ID Node
    [Arguments]    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Prepare Json Body for Post Shop    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Remove Node from Json Body    ${json_data}    merchant_id
    ${shop_id}=    Create Shop    ${json_data}
    [Return]    ${shop_id}

Create Shop Success WO Shop Status Node
    [Arguments]    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}
    ${json_data}=    Prepare Json Body for Post Shop    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    active
    ${json_data}=    Remove Node from Json Body    ${json_data}    shop_status
    ${shop_id}=    Create Shop    ${json_data}
    [Return]    ${shop_id}

Create Shop WO Logo Node
    [Arguments]    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Prepare Json Body for Post Shop    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Remove Node from Json Body    ${json_data}    logo
    ${shop_id}=    Create Shop    ${json_data}
    [Return]    ${shop_id}

####### PUT #######
Update Shop
    [Arguments]    ${shop_id}    ${request_body}
    HTTP Put Request    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}${shop_id}    ${request_body}

Update Shop Failed
    [Arguments]    ${shop_id}    ${request_body}
    HTTP Put Request Failed    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}${shop_id}    ${request_body}

Update Shop Success
    [Arguments]    ${shop_id}    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Prepare Json Body for Post Shop    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Update Shop    ${shop_id}    ${json_data}

Update Shop Not Success
    [Arguments]    ${shop_id}    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Prepare Json Body for Post Shop    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Update Shop Failed    ${shop_id}    ${json_data}

Update Shop WO Shop Name Node
    [Arguments]    ${shop_id}    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Prepare Json Body for Post Shop    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Remove Node from Json Body    ${json_data}    shop_name
    Update Shop Failed    ${shop_id}    ${json_data}

Update Shop WO Shop Slug Node
    [Arguments]    ${shop_id}    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Prepare Json Body for Post Shop    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Remove Node from Json Body    ${json_data}    slug
    Update Shop Failed    ${shop_id}    ${json_data}

Update Shop WO Merchant ID Node
    [Arguments]    ${shop_id}    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Prepare Json Body for Post Shop    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Remove Node from Json Body    ${json_data}    merchant_id
    Update Shop    ${shop_id}    ${json_data}

Update Shop Success WO Shop Status Node
    [Arguments]    ${shop_id}    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}
    ${json_data}=    Prepare Json Body for Post Shop    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    active
    ${json_data}=    Remove Node from Json Body    ${json_data}    shop_status
    Update Shop    ${shop_id}    ${json_data}

Update Shop WO Logo Node
    [Arguments]    ${shop_id}    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Prepare Json Body for Post Shop    ${json_data_file}    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    ${json_data}=    Remove Node from Json Body    ${json_data}    logo
    Update Shop    ${shop_id}    ${json_data}

####### DELETE #######
Delete Shop by Shop ID
    [Arguments]    ${shop_id}
    HTTP Delete Request    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}${shop_id}

Delete Shop by Shop ID Failed
    [Arguments]    ${shop_id}
    HTTP Delete Request Failed    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}${shop_id}

Delete Shop by Shop ID Success
    [Arguments]    ${shop_id}
    Delete Shop by Shop ID    ${shop_id}
    Verify Delete Shop Success and Response Data Correct

####### Verify #######
Verify Get All Shops Success and Data Correct
    Response Status Code Should Equal    200 OK
    ${response_body}=    Get Response Body
    ${data}=    Get Json Value    ${response_body}    /data
    ${dic}=    Convert Json to Dict    ${data}
    ${body_lenght}=    Get Length    ${dic}
    Should Not Be Equal As Integers    0    ${body_lenght}

Verify Shop Data Correct
    [Arguments]    ${response_body}    ${expected_shop_id}    ${expected_merchant_id}    ${expected_shop_name}    ${expected_slug}    ${expected_status}
    ${shop_id}=    Get Json Value    ${response_body}    /data/id
    ${merchant_id}=    Get Json Value    ${response_body}    /data/merchant_id
    ${shop_name}=    Get Json Value    ${response_body}    /data/shop_name
    ${slug}=    Get Json Value    ${response_body}    /data/slug
    ${status}=    Get Json Value    ${response_body}    /data/shop_status
    Should Be Equal As Strings    "${expected_shop_id}"    ${shop_id}
    Should Be Equal As Strings    "${expected_merchant_id}"    ${merchant_id}
    Should Be Equal As Strings    "${expected_shop_name}"    ${shop_name}
    Should Be Equal As Strings    "${expected_slug}"    ${slug}
    Should Be Equal As Strings    "${expected_status}"    ${status}

Verify Get Shop Success and Data Correct
    [Arguments]    ${expected_shop_id}    ${expected_merchant_id}    ${expected_shop_name}    ${expected_slug}    ${expected_status}
    Response Status Code Should Equal    200 OK
    ${response_body}=    Get Response Body
    Verify Shop Data Correct    ${response_body}    ${expected_shop_id}    ${expected_merchant_id}    ${expected_shop_name}    ${expected_slug}    ${expected_status}
    Verify Node Data is Not Empty    ${response_body}    /data/logo

Verify Get Shop Success and Data Correct but Node Logo is Empty
    [Arguments]    ${expected_shop_id}    ${expected_merchant_id}    ${expected_shop_name}    ${expected_slug}    ${expected_status}
    Response Status Code Should Equal    200 OK
    ${response_body}=    Get Response Body
    Verify Shop Data Correct    ${response_body}    ${expected_shop_id}    ${expected_merchant_id}    ${expected_shop_name}    ${expected_slug}    ${expected_status}
    Verify Node Data is Empty    ${response_body}    /data/logo    null

Verify Get Shop Response Node Time Correct
    ${response_body}=    Get Response Body
    Verify Node Data is Not Empty    ${response_body}    /data/created_at
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at_web
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at_mobile
    Verify Node Data is Not Empty    ${response_body}    /data/published_at_web
    Verify Node Data is Not Empty    ${response_body}    /data/published_at_mobile

Verify Node Pages from Shops is Empty
    ${response_body}=    Get Response Body
    Verify Node Data is Empty    ${response_body}    /data/pages    {}

Verify Node Pages from Shops is Not Empty
    ${response_body}=    Get Response Body
    Verify Node Data is Not Empty    ${response_body}    /data/pages

Verify Node Pages Matched with Expected
    [Arguments]    ${expected_shops_json_data}
    ${response_body}=    Get Response Body
    ${actual_pages}=    Get Json Value    ${response_body}    /data/pages
    ${actual_pages_dict}    Convert Json To Dict    ${actual_pages}
    # expedted
    ${expected_json_data}=    Get File    ${expected_shops_json_data}
    ${expected_pages}=    Get Json Value    ${expected_json_data}    /pages
    ${expected_pages_dict}    Convert Json To Dict    ${expected_pages}
    Dictionaries Should Be Equal    ${actual_pages_dict}    ${expected_pages_dict}    Pages data not matched

Get Shop Data and Verify Shop Waiting Status for Storefront Data
    [Arguments]    ${shop_id}
    Get Shop by Shop ID    ${shop_id}
    ${response_body}=    Get Response Body
    Verify Node Time New Shop Correct    ${response_body}

Get Shop Data and Verify Shop Draft Status for Storefront Web Data
    [Arguments]    ${shop_id}
    Get Shop by Shop ID    ${shop_id}
    ${response_body}=    Get Response Body
    Verify Node Data is Not Empty    ${response_body}    /data/created_at
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at_web
    Verify Node Data is Empty    ${response_body}    /data/updated_at_mobile    null
    Verify Node Data is Empty    ${response_body}    /data/published_at_web    null
    Verify Node Data is Empty    ${response_body}    /data/published_at_mobile    null

Get Shop Data and Verify Shop Published Status for Storefront Web Data
    [Arguments]    ${shop_id}
    Get Shop by Shop ID    ${shop_id}
    ${response_body}=    Get Response Body
    Verify Node Data is Not Empty    ${response_body}    /data/created_at
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at_web
    Verify Node Data is Empty    ${response_body}    /data/updated_at_mobile    null
    Verify Node Data is Not Empty    ${response_body}    /data/published_at_web
    Verify Node Data is Empty    ${response_body}    /data/published_at_mobile    null
    ${updated_time}=    Get Json Value    ${response_body}    /data/updated_at_web
    ${published_time}=    Get Json Value    ${response_body}    /data/published_at_web
    Should Be True    ${updated_time}<${published_time}

Get Shop Data and Verify Shop Modified Status for Storefront Web Data
    [Arguments]    ${shop_id}
    Get Shop by Shop ID    ${shop_id}
    ${response_body}=    Get Response Body
    Verify Node Data is Not Empty    ${response_body}    /data/created_at
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at_web
    Verify Node Data is Empty    ${response_body}    /data/updated_at_mobile    null
    Verify Node Data is Not Empty    ${response_body}    /data/published_at_web
    Verify Node Data is Empty    ${response_body}    /data/published_at_mobile    null
    ${updated_time}=    Get Json Value    ${response_body}    /data/updated_at_web
    ${published_time}=    Get Json Value    ${response_body}    /data/published_at_web
    Should Be True    ${published_time}<${updated_time}

Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data
    [Arguments]    ${shop_id}
    Get Shop by Shop ID    ${shop_id}
    ${response_body}=    Get Response Body
    Verify Node Data is Not Empty    ${response_body}    /data/created_at
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at
    Verify Node Data is Empty        ${response_body}    /data/updated_at_web    null
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at_mobile
    Verify Node Data is Empty        ${response_body}    /data/published_at_web    null
    Verify Node Data is Empty        ${response_body}    /data/published_at_mobile    null

Get Shop Data and Verify Shop Published Status for Storefront Mobile Data
    [Arguments]    ${shop_id}
    Get Shop by Shop ID    ${shop_id}
    ${response_body}=    Get Response Body
    Verify Node Data is Not Empty    ${response_body}    /data/created_at
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at
    Verify Node Data is Empty        ${response_body}    /data/updated_at_web    null
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at_mobile
    Verify Node Data is Empty        ${response_body}    /data/published_at_web    null
    Verify Node Data is Not Empty    ${response_body}    /data/published_at_mobile
    ${updated_time}=    Get Json Value    ${response_body}    /data/updated_at_mobile
    ${published_time}=    Get Json Value    ${response_body}    /data/published_at_mobile
    Should Be True    ${updated_time}<${published_time}

Get Shop Data and Verify Shop Modified Status for Storefront Mobile Data
    [Arguments]    ${shop_id}
    Get Shop by Shop ID    ${shop_id}
    ${response_body}=    Get Response Body
    Verify Node Data is Not Empty    ${response_body}    /data/created_at
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at
    Verify Node Data is Empty        ${response_body}    /data/updated_at_web    null
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at_mobile
    Verify Node Data is Empty        ${response_body}    /data/published_at_web    null
    Verify Node Data is Not Empty    ${response_body}    /data/published_at_mobile
    ${updated_time}=    Get Json Value    ${response_body}    /data/updated_at_mobile
    ${published_time}=    Get Json Value    ${response_body}    /data/published_at_mobile
    Should Be True    ${published_time}<${updated_time}

Verify Delete Shop Success and Response Data Correct
    Response Status Code Should Equal    200 OK
    ${response_body}=    Get Response Body
    ${data}=    Get Json Value    ${response_body}    /data
    Should Be Equal As Strings    true    ${data}

Verify Response Create and Update Shop Data Correct
    [Arguments]    ${response_body}    ${expected_merchant_id}    ${expected_shop_name}    ${expected_slug}    ${expected_status}    ${expected_updated_by}
    Assert Node Data Value with Expected    ${response_body}    /data/merchant_id    ${expected_merchant_id}    Merchant id not mathced
    Assert Node Data Value with Expected    ${response_body}    /data/shop_name    ${expected_shop_name}    Shop Name not mathced
    Assert Node Data Value with Expected    ${response_body}    /data/slug    ${expected_slug}    Shop Slug not mathced
    Assert Node Data Value with Expected    ${response_body}    /data/shop_status    ${expected_status}    Shop Status not mathced
    Assert Node Data Value with Expected    ${response_body}    /data/updated_by    ${expected_updated_by}    Updated by not mathced

Verify Node Time New Shop Correct
    [Arguments]    ${response_body}
    Verify Node Data is Not Empty    ${response_body}    /data/created_at
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at
    Verify Node Data is Empty    ${response_body}    /data/updated_at_web    null
    Verify Node Data is Empty    ${response_body}    /data/updated_at_mobile    null
    Verify Node Data is Empty    ${response_body}    /data/published_at_web    null
    Verify Node Data is Empty    ${response_body}    /data/published_at_mobile    null
    ${updated_time}=    Get Json Value    ${response_body}    /data/updated_at
    ${created_time}=    Get Json Value    ${response_body}    /data/created_at
    Should Be Equal As Strings    ${created_time}    ${updated_time}

Verify Create Shop Success and Response Data Correct
    [Arguments]    ${expected_merchant_id}    ${expected_shop_name}    ${expected_slug}    ${expected_status}
    Response Status Code Should Equal    200 OK
    ${response_body}=    Get Response Body
    Verify Response Create and Update Shop Data Correct    ${response_body}    ${expected_merchant_id}    ${expected_shop_name}    ${expected_slug}    ${expected_status}    hulk_robot
    Verify Node Data is Not Empty    ${response_body}    /data/logo
    Verify Node Time New Shop Correct    ${response_body}

Verify Create Shop Success and Response Data Correct but Node Logo is Empty
    [Arguments]    ${expected_merchant_id}    ${expected_shop_name}    ${expected_slug}    ${expected_status}
    Response Status Code Should Equal    200 OK
    ${response_body}=    Get Response Body
    Verify Response Create and Update Shop Data Correct    ${response_body}    ${expected_merchant_id}    ${expected_shop_name}    ${expected_slug}    ${expected_status}    hulk_robot
    Verify Node Data is Empty    ${response_body}    /data/logo    null
    Verify Node Time New Shop Correct    ${response_body}

Verify Node Time Updated Shop Correct
    [Arguments]    ${response_body}
    Verify Node Data is Not Empty    ${response_body}    /data/created_at
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at
    Verify Node Data is Empty    ${response_body}    /data/updated_at_web    null
    Verify Node Data is Empty    ${response_body}    /data/updated_at_mobile    null
    Verify Node Data is Empty    ${response_body}    /data/published_at_web    null
    Verify Node Data is Empty    ${response_body}    /data/published_at_mobile    null
    ${updated_time}=    Get Json Value    ${response_body}    /data/updated_at
    ${created_time}=    Get Json Value    ${response_body}    /data/created_at
    Should Be True    ${created_time}<${updated_time}

Verify Update Shop Success and Response Data Correct
    [Arguments]    ${expected_merchant_id}    ${expected_shop_name}    ${expected_slug}    ${expected_status}    ${expected_updated_by}
    Response Status Code Should Equal    200 OK
    ${response_body}=    Get Response Body
    Verify Response Create and Update Shop Data Correct    ${response_body}    ${expected_merchant_id}    ${expected_shop_name}    ${expected_slug}    ${expected_status}    ${expected_updated_by}
    Verify Node Data is Not Empty    ${response_body}    /data/logo
    Verify Node Time Updated Shop Correct    ${response_body}

####### Utility #######
Get Shop ID from Response Body Data
    ${response_body}=    Get Response Body
    ${shop_id}=    Get Json Value    ${response_body}    /data/id
    ${shop_id}=    Cut Quotation Marks and Get Only Value    ${shop_id}
    [Return]    ${shop_id}

Get Shop Name from Shop Slug
    [Arguments]    ${shopSlug}
    Get Shop by Shop Slug    ${shopSlug}
    ${response_body}=     Get Response Body
    # Log    ${response_body}
    ${shop_name}=    Get Json Value    ${response_body}    /data/shop_name
    [Return]    ${shop_name}

Get Id Shop from Shop Name
    [Arguments]    ${shopName}
    Get Shop by Shop Name    ${shopName}
    ${response_body}=     Get Response Body
    # Log    ${response_body}
    ${shop_id}=    Get Json Value    ${response_body}    /data/id
    [Return]    ${shop_id}


