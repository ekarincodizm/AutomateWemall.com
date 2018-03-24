*** Settings ***
Library             HttpLibrary.HTTP
Library             Collections
Resource            ${CURDIR}/../common/api_keywords.robot
Library             ${CURDIR}/../../../Python_Library/DynamoDb.py
Resource            ${CURDIR}/storefront_keywords.robot

*** Variables ***
${body_pages_template}    ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/pages/pages_template.json

*** Keywords ***
####### Prepare Data #######
Prepare Pages and Content
    [Arguments]    ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}   ${shop_json_template}=${body_post_template}
    ${pages_id}=    Create Pages Success    ${body_pages_template}    ${suite_shop_id}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    Prepare Storefront Content by Storefront API    ${suite_shop_id}

Prepare Pages Data For Suite
    [Arguments]   ${shop_id}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    ${pages_id}=    Create Pages Success    ${body_pages_template}    ${shop_id}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    Set Suite Variable    ${suite_pages_id}    ${pages_id}
    Log    Suite Pages ID : ${suite_pages_id}

####### GET #######
Get Pages Detail List by Shop ID
    [Arguments]    ${shop_id}
    HTTP Get Request    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}${shop_id}/pages

Get Pages Detail by Page ID
    [Arguments]    ${shop_id}    ${page_id}
    HTTP Get Request    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}${shop_id}/pages/${page_id}

Get Pages Detail List by Shop Slug
    [Arguments]    ${shop_slug}    ${page_id}
    HTTP Get Request    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}slug/${shop_slug}/pages

Get Pages Detail by Page Slug
    [Arguments]    ${shop_slug}    ${page_slug}
    HTTP Get Request    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}slug/${shop_slug}/pages/${page_slug}

Get Pages Detail by Page Slug Failed
    [Arguments]    ${shop_slug}    ${page_slug}
    HTTP Get Request Failed    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}slug/${shop_slug}/pages/${page_slug}

####### POST #######
Prepare Json Body for Post Pages
    [Arguments]    ${json_data_file}    ${page_name}    ${slug_name}    ${banner_display}    ${page_status}
    ${json_data}=    Get File    ${json_data_file}
    ${json_data}=    Add Node to Json Body    ${json_data}    name    ${page_name}
    ${json_data}=    Add Node to Json Body    ${json_data}    slug    ${slug_name}
    ${json_data}=    Add Node to Json Body    ${json_data}    banner_display    ${banner_display}
    ${json_data}=    Add Node to Json Body    ${json_data}    page_status    ${page_status}
    [Return]    ${json_data}

Create Pages
    [Arguments]    ${shop_id}    ${request_body}
    HTTP Post Request    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}${shop_id}/pages    ${request_body}
    ${pages_id}=    Get Pages ID from Response Body Data
    [Return]    ${pages_id}

Create Pages Failed
    [Arguments]    ${shop_id}    ${request_body}
    HTTP Post Request Failed    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}${shop_id}/pages    ${request_body}

Create Pages Not Success
    [Arguments]    ${json_data_file}    ${shop_id}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    ${request_body}=    Prepare Json Body for Post Pages    ${json_data_file}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    Create Pages Failed    ${shop_id}    ${request_body}

Create Pages Success
    [Arguments]    ${json_data_file}    ${shop_id}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    ${json_data}=    Prepare Json Body for Post Pages    ${json_data_file}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    ${pages_id}=    Create Pages    ${shop_id}    ${json_data}
    [Return]    ${pages_id}

Create Pages WO Pages Name Node
    [Arguments]    ${json_data_file}    ${shop_id}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    ${json_data}=    Prepare Json Body for Post Pages    ${json_data_file}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    ${json_data}=    Remove Node from Json Body    ${json_data}    name
    Create Pages Failed    ${shop_id}    ${json_data}

Create Pages WO Pages Slug Node
    [Arguments]    ${json_data_file}    ${shop_id}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    ${json_data}=    Prepare Json Body for Post Pages    ${json_data_file}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    ${json_data}=    Remove Node from Json Body    ${json_data}    slug
    Create Pages Failed    ${shop_id}    ${json_data}

Create Pages WO Pages Banner Display Node
    [Arguments]    ${json_data_file}    ${shop_id}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    ${json_data}=    Prepare Json Body for Post Pages    ${json_data_file}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    ${json_data}=    Remove Node from Json Body    ${json_data}    banner_display
    Create Pages Failed    ${shop_id}    ${json_data}

Create Pages WO Pages Status Node
    [Arguments]    ${json_data_file}    ${shop_id}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    ${json_data}=    Prepare Json Body for Post Pages    ${json_data_file}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    ${json_data}=    Remove Node from Json Body    ${json_data}    page_status
    Create Pages Failed    ${shop_id}    ${json_data}

####### PUT #######
Update Pages
    [Arguments]    ${shop_id}    ${pages_id}    ${request_body}
    HTTP Put Request    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}${shop_id}/pages/${pages_id}    ${request_body}

Update Pages Failed
    [Arguments]    ${shop_id}    ${pages_id}    ${request_body}
    HTTP Put Request Failed    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}${shop_id}/pages/${pages_id}    ${request_body}

Update Pages Success
    [Arguments]    ${shop_id}    ${pages_id}    ${json_data_file}    ${page_name}    ${slug}    ${banner_display}    ${status}
    ${json_data}=    Prepare Json Body for Post Pages    ${json_data_file}    ${page_name}    ${slug}    ${banner_display}    ${status}
    Update Pages    ${shop_id}    ${pages_id}    ${json_data}

Update Pages Not Success
    [Arguments]    ${shop_id}    ${pages_id}    ${json_data_file}    ${page_name}    ${slug}    ${banner_display}    ${status}
    ${json_data}=    Prepare Json Body for Post Pages    ${json_data_file}    ${page_name}    ${slug}    ${banner_display}    ${status}
    Update Pages Failed    ${shop_id}    ${pages_id}    ${json_data}

Update Pages By Pages Name Node Only Failed
    [Arguments]    ${shop_id}    ${pages_id}    ${json_data_file}    ${page_name}
    ${json_data}=    Prepare Json Body for Post Pages    ${json_data_file}    ${page_name}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    ${json_data}=    Remove Node from Json Body    ${json_data}    slug
    ${json_data}=    Remove Node from Json Body    ${json_data}    banner_display
    ${json_data}=    Remove Node from Json Body    ${json_data}    page_status
    ${json_data}=    Remove Node from Json Body    ${json_data}    page_updated_by
    Update Pages Failed    ${shop_id}    ${pages_id}    ${json_data}

Update Pages By Pages Name Node Only
    [Arguments]    ${shop_id}    ${pages_id}    ${json_data_file}    ${page_name}
    ${json_data}=    Prepare Json Body for Post Pages    ${json_data_file}    ${page_name}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    ${json_data}=    Remove Node from Json Body    ${json_data}    slug
    ${json_data}=    Remove Node from Json Body    ${json_data}    banner_display
    ${json_data}=    Remove Node from Json Body    ${json_data}    page_status
    ${json_data}=    Remove Node from Json Body    ${json_data}    page_updated_by
    Update Pages    ${shop_id}    ${pages_id}    ${json_data}

Update Pages By Banner Display Node Only
    [Arguments]    ${shop_id}    ${pages_id}    ${json_data_file}    ${banner_display}
    ${json_data}=    Prepare Json Body for Post Pages    ${json_data_file}    ${EMPTY}    ${EMPTY}    ${banner_display}    ${EMPTY}
    ${json_data}=    Remove Node from Json Body    ${json_data}    slug
    ${json_data}=    Remove Node from Json Body    ${json_data}    name
    ${json_data}=    Remove Node from Json Body    ${json_data}    page_status
    ${json_data}=    Remove Node from Json Body    ${json_data}    page_updated_by
    Log    ${json_data}
    Update Pages    ${shop_id}    ${pages_id}    ${json_data}

Update Pages By Page Status Node Only
    [Arguments]    ${shop_id}    ${pages_id}    ${json_data_file}    ${page_status}
    ${json_data}=    Prepare Json Body for Post Pages    ${json_data_file}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${page_status}
    ${json_data}=    Remove Node from Json Body    ${json_data}    slug
    ${json_data}=    Remove Node from Json Body    ${json_data}    name
    ${json_data}=    Remove Node from Json Body    ${json_data}    banner_display
    ${json_data}=    Remove Node from Json Body    ${json_data}    page_updated_by
    Update Pages    ${shop_id}    ${pages_id}    ${json_data}

####### DELETE #######
Delete Pages by Shop ID
    [Arguments]    ${shop_id}    ${page_id}
    HTTP Delete Request    ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}${shop_id}/pages/${page_id}

Delete Pages by Shop ID Failed
    [Arguments]    ${shop_id}    ${page_id}
    HTTP Delete Request Failed     ${STOREFRONT-API-httpLib}    http    ${CSS_SHOP}${shop_id}/pages/${page_id}

Delete Pages and Delete Pages Content Data by Specific Pages id
    [Arguments]    ${shop_id}     ${page_id}
    Delete Pages by Shop ID    ${shop_id}     ${page_id}
    Delete Storefront Draft and Published Success All Type      ${page_id}      web
    Delete Storefront Draft and Published Success All Type      ${page_id}      mobile

####### Verify #######

Verify Get All Page Success and Data Correct
    Response Status Code Should Equal    200 OK
    ${response_body}=    Get Response Body
    ${data}=    Get Json Value    ${response_body}    /data
    ${dic}=    Convert Json to Dict    ${data}
    ${body_lenght}=    Get Length    ${dic}
    Should Not Be Equal As Integers    0    ${body_lenght}
    [Return]     ${data}

Verify Data Correct With Json
    [Arguments]    ${json}    ${expected_attr_list}
    ${actual_pages_list}=    Convert Json To Dict    ${json}
    Lists Should Be Equal    ${actual_pages_list}    ${expected_attr_list}

Verify Response Create and Update Pages Data Correct
    [Arguments]    ${response_body}    ${expected_pages_id}    ${expected_pages_name}    ${expected_slug}    ${expected_banner_status}    ${expected_status}    ${expected_updated_by}=${EMPTY}
    Assert Node Data Value with Expected    ${response_body}    /data/id    ${expected_pages_id}    Pages id not mathced
    Assert Node Data Value with Expected    ${response_body}    /data/name    ${expected_pages_name}    Pages Name not mathced
    Assert Node Data Value with Expected    ${response_body}    /data/slug    ${expected_slug}    Page Slug not mathced
    Assert Node Data Value with Expected    ${response_body}    /data/banner_display    ${expected_banner_status}    Banner Display not mathced
    Assert Node Data Value with Expected    ${response_body}    /data/page_status    ${expected_status}    Page status not mathced

Verify Create Pages Success and Response Data Correct
    [Arguments]    ${expected_pages_id}    ${expected_pages_name}    ${expected_slug}    ${expected_banner_status}    ${expected_status}
    Response Status Code Should Equal    200 OK
    ${response_body}=    Get Response Body
    Verify Response Create and Update Pages Data Correct    ${response_body}    ${expected_pages_id}    ${expected_pages_name}    ${expected_slug}    ${expected_banner_status}        ${expected_status}    hulk_robot
    # Verify Node Time New Page Correct    ${response_body}

API Pages - Compare Pages Update Content Time with Pages Content Data
    [Arguments]    ${pages_content_response}    ${pages_data_response}    ${view}
    ${pages_content_updated_time}=    Get Data in Response from Node    ${pages_content_response}    data/updated_at
    ${pages_data_updated_time}=       Get Json Value    ${pages_data_response}    /data/updated_at_${view}
    Should Be Equal As Strings    "${pages_content_updated_time}"    ${pages_data_updated_time}    Updated Time Not Equal

API Pages - Compare Pages Published Content Time with Pages Content Data
    [Arguments]    ${pages_content_response}    ${pages_data_response}    ${view}
    ${pages_content_published_time}=    Get Data in Response from Node    ${pages_content_response}    data/updated_at
    ${pages_data_published_time}=       Get Json Value    ${pages_data_response}    /data/published_at_${view}
    Should Be Equal As Strings    "${pages_content_published_time}"    ${pages_data_published_time}    Published Time Not Equal

API Pages - Verify Pages Status Waiting Response Node Time
    [Arguments]    ${view}
    ${response_body}=    Get Response Body
    Verify Node Data is Empty    ${response_body}    /data/updated_at_${view}    null
    Verify Node Data is Empty    ${response_body}    /data/published_at_${view}    null

API Pages - Verify Pages Status Draft Response Node Time
    [Arguments]    ${view}
    ${response_body}=    Get Response Body
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at_${view}
    Verify Node Data is Empty    ${response_body}    /data/published_at_${view}    null

API Pages - Verify Pages Status Published Response Node Time
    [Arguments]    ${view}
    ${response_body}=    Get Response Body
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at_${view}
    Verify Node Data is Not Empty    ${response_body}    /data/published_at_${view}

API Pages - Verify Pages Status Modified Response Node Time
    [Arguments]    ${view}
    ${response_body}=    Get Response Body
    Verify Node Data is Not Empty    ${response_body}    /data/updated_at_${view}
    Verify Node Data is Not Empty    ${response_body}    /data/published_at_${view}

####### Utility #######
Get Pages Detail by Page ID And Return Response
    [Arguments]    ${shop_id}    ${page_id}
    Get Pages Detail by Page ID    ${shop_id}    ${page_id}
    ${res}=    Get Response Body
    [Return]    ${res}

Get Shop from Dynamo
    [Arguments]    ${shop_id}
    # ${ScanKey}=    Convert Json To Dict    {"id":"${shop_id}"}
    ${items}=    Dynamo Get Item    ${STOREFRONT_SHOP_TABLE}    {"id":"${shop_id}"}
    Log    Item: ${items}
    [Return]    ${items}

Get Page from Dynamo
    [Arguments]    ${shop_id}    ${page_id}
    ${shop_dic}=    Get Shop from Dynamo    ${shop_id}
    ${page_dic}=    Get From Dictionary    ${shop_dic}    pages
    ${page_dic}=    Get From Dictionary    ${page_dic}    ${page_id}
    Log    Pages: ${page_dic}
    [Return]     ${page_dic}

Get Pages ID from Response Body Data
    ${response_body}=    Get Response Body
    ${page_id}=    Get Json Value    ${response_body}    /data/id
    ${page_id}=    Cut Quotation Marks and Get Only Value    ${page_id}
    [Return]    ${page_id}


