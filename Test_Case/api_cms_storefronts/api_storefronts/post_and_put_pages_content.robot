*** Settings ***
Force Tags    WLS_API_CMS_Storefront
Library             OperatingSystem
Library             Collections
Library             ${CURDIR}/../../../Python_Library/DynamoDb.py
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/api_pages_keywords.robot
Resource            ${CURDIR}/../../../Resource/TestData/storefronts/storefront_data.robot
Resource            ${CURDIR}/../../../Resource/init.robot

Suite Setup         Prepare Shop Data Dynamo
Suite Teardown      Tear Down Shop Data Dynamo
Test Template       Content Page

*** Variable ***

${DATA_PATH}              ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/shop/shop_dynamo_without_pages.json
@{failed_list}              400 Bad Request    CSS4001    Missing Required Field    Shop id is empty.
@{failed_list_not_exit}     400 Bad Request    CSS4009    Item does not exist    Shop id doesn't exists
@{failed_list_empty}            400 Bad Request    CSS4006    Invalid Input Data Format    Invalid shop id
@{failed_list_null}            400 Bad Request    CSS4006    Invalid Input Data Format    Invalid shop id

*** Test Cases ***
TC_ITMWM_05538 Create Content-Pages success [Web]    create   true   web    draft   no_parent
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05539 Create Content-Pages fails when parent_id node not exist [Web]     create   false   web    draft   parent__node_doesnt_exists       ${failed_list_not_exit}
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05540 Create Content-Pages fails when id not exist and parent must exist [Web]      create   false   web    draft   ไอดีมั่ว       ${failed_list_not_exit}
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05541 Create Content-Pages fails when id same shop_id but parent_id is empty [Web]      create   false   web    draft   ${EMPTY}       ${failed_list_empty}
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05542 Create Content-Pages fails when id same shop_id but parent_id Null [Web]       create   false   web    draft   ${NULL}       ${failed_list_null}
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05543 Create Content-Pages without type. [Web]       create   false   web    draft   ${SUITE_SHOP_PAGE_ID}       ${failed_list_not_exit}    ${prepare_content_without_type}
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05544 Create Content-Pages without version. [Web]       create   false   web    draft   ${SUITE_SHOP_PAGE_ID}       ${failed_list_not_exit}    ${prepare_content_without_version}
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05545 Create Content-Pages without data. [Web]     create   false   web    draft   ${SUITE_SHOP_PAGE_ID}       ${failed_list_not_exit}       ${prepare_content_without_data}
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05546 Create Content-Pages success [Mobile]     create   true   mobile    draft   no_parent
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05547 Create Content-Pages fails when parent_id not exist [Mobile]      create   false   mobile    draft   parent__node_doesnt_exists       ${failed_list_not_exit}
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05548 Create Content-Pages fails when id not exist and parent must exist[Mobile]    create   false   mobile    draft   ไอดีมั่ว       ${failed_list_not_exit}
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05549 Create Content-Pages fails when id same shop_id but parent_id is empty [Mobile]      create   false   mobile    draft   ${EMPTY}       ${failed_list_empty}
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05550 Create Content-Pages fails when id same shop_id but parent_id null [Mobile]       create   false   mobile    draft   ${NULL}       ${failed_list_null}
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05551 Create Content-Pages without type. [Mobile]       create   false   mobile    draft   ${SUITE_SHOP_PAGE_ID}       ${failed_list_not_exit}    ${prepare_content_without_type}
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05552 Create Content-Pages without version. [Mobile]       create   false   mobile    draft   ${SUITE_SHOP_PAGE_ID}       ${failed_list_not_exit}    ${prepare_content_without_version}
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05553 Create Content-Pages without data. [Mobile]     create   false   mobile    draft   ${SUITE_SHOP_PAGE_ID}       ${failed_list_not_exit}       ${prepare_content_without_data}
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05554 Update Content-Pages success [Web]    update   true   web    draft   no_parent
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05555 Update Content-Pages fails when parent_id not exist [Web]     update   false   web    draft   parent__node_doesnt_exists       ${failed_list_not_exit}
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05556 Update Content-Pages fails when id not exist and parent must exist [Web]      update   false   web    draft   ไอดีมั่ว       ${failed_list_not_exit}
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05557 Update Content-Pages fails when id same shop_id but parent_id is empty [Web]      update   false   web    draft   ${EMPTY}       ${failed_list_empty}
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05558 Update Content-Pages fails when id same shop_id but parent_id null [Web]      update   false   web    draft   ${NULL}       ${failed_list_null}
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05559 Update Content-Pages without type. [Web]      update   false   web    draft   ${SUITE_SHOP_PAGE_ID}       ${failed_list_not_exit}    ${updated_prepare_content_without_type}
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05560 Update Content-Pages without version. [Web]       update   false   web    draft   ${SUITE_SHOP_PAGE_ID}       ${failed_list_not_exit}    ${updated_prepare_content_without_version}
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05561 Update Content-Pages without data. [Web]      update   false   web    draft   ${SUITE_SHOP_PAGE_ID}       ${failed_list_not_exit}    ${updated_prepare_content_without_data}
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05562 Update Content-Pages success [Mobile]     update   true   mobile    draft   no_parent
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05563 Update Content-Pages fails when parent_id not exist [Mobile]      update   false   mobile    draft   parent__node_doesnt_exists       ${failed_list_not_exit}
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05564 Update Content-Pages fails when id not exist and parent must exist [Mobile]       update   false   mobile    draft   ไอดีมั่ว       ${failed_list_not_exit}
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05565 Update Content-Pages fails when id same shop_id but parent_id is empty [Mobile]       update   false   mobile    draft   ${EMPTY}       ${failed_list_empty}
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05566 Update Content-Pages fails when id same shop_id but parent_id null [Mobile]       update   false   mobile    draft   ${NULL}       ${failed_list_null}
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05567 Update Content-Pages without type. [Mobile]       update   false   mobile    draft   ${SUITE_SHOP_PAGE_ID}       ${failed_list_not_exit}    ${updated_prepare_content_without_type}
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05568 Update Content-Pages without version. [Mobile]        update   false   mobile    draft   ${SUITE_SHOP_PAGE_ID}       ${failed_list_not_exit}    ${updated_prepare_content_without_version}
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression

TC_ITMWM_05569 Update Content-Pages without data. [Mobile]        update   false   mobile    draft   ${SUITE_SHOP_PAGE_ID}       ${failed_list_not_exit}    ${updated_prepare_content_without_data}
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression


*** Keywords ***
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
    Set Suite Variable    ${SUTIE_TEST_SHOP_ID}      ${TEST_SHOP_ID}
    Set Suite Variable    ${SUTIE_TEST_SHOP_SLUG}    ${TEST_SHOP_SLUG}
    :FOR    ${PAGE_ID}   IN     @{SUITE_PAGES_ID_LIST}
    \    Log    ${PAGE_ID}
    \    Set Suite Variable    ${SUITE_SHOP_PAGE_ID}     ${PAGE_ID}

Tear Down Shop Data Dynamo
    Dynamo Delete Item    ${STOREFRONT_SHOP_TABLE}    {"id":"${SUTIE_TEST_SHOP_ID}"}

Get Shop Content Web Draft From DynamoDB
    [Arguments]    ${content_id}
    ${STOREFRONT_INFO}=    Dynamo Get Item    ${STOREFRONT_STOREFRONT_WEB_DRAFT_TABLE}     {"id":"${content_id}","type":"content"}
    [Return]     ${STOREFRONT_INFO}

Get Page Content Web Draft From DynamoDB
    [Arguments]    ${shop_id}    ${content_id}
    ${STOREFRONT_INFO}=    Dynamo Get Item    ${STOREFRONT_STOREFRONT_WEB_DRAFT_TABLE}    {"id":"${content_id}","type":"content"}
    [Return]       ${STOREFRONT_INFO}

Verify Storefront Post Page Data
    [Arguments]    ${expected_page_dict}    ${actual_page_dict}    ${content_id}    ${version}
    Set To Dictionary   ${actual_page_dict}    version       ${version}
    Set To Dictionary   ${expected_page_dict}    id            ${content_id}
    Dictionary Should Contain Sub Dictionary     ${actual_page_dict}     ${expected_page_dict}

Content Page
    [Arguments]     ${action}   ${is_success}   ${site}    ${version}   ${parent_id}   ${failed_list}=@{failed_list}        ${content}=${prepare_content}
    Run Keyword If      '${action}' == 'create'    Create   ${is_success}   ${site}    ${version}   ${parent_id}    ${failed_list}    ${content}
    Run Keyword If      '${action}' == 'update'    Update   ${is_success}   ${site}    ${version}   ${parent_id}    ${failed_list}    ${content}

Create
    [Arguments]     ${is_success}   ${site}    ${version}   ${parent_id}   ${failed_list}   ${content}
    Run Keyword If      '${is_success}' == 'true'       Create Success Case     ${site}    ${version}
    Run Keyword If      '${is_success}' == 'false'      Create Failed Case      ${site}    ${parent_id}   ${failed_list}     ${content}

Create Success Case
    [Arguments]     ${site}    ${version}
    ${expected_content}=    Get File     ${prepare_content}
    Create Pages Content Data From Input File      ${SUTIE_TEST_SHOP_ID}      ${SUITE_SHOP_PAGE_ID}    ${site}    ${prepare_content}
    ${STOREFRONT_INFO}=    Get Page Content Web Draft From DynamoDB   ${SUTIE_TEST_SHOP_ID}      ${SUITE_SHOP_PAGE_ID}
    ${EXPECTED}=    Convert Json To Dict    ${expected_content}
    Verify Storefront Post Page Data     ${EXPECTED}    ${STOREFRONT_INFO}     ${SUITE_SHOP_PAGE_ID}    ${version}

Create Failed Case
    [Arguments]     ${site}    ${parent_id}     ${failed_list}       ${content}
    Run Keyword If    '${parent_id}' == 'parent__node_doesnt_exists'        Create Storefront Data Failed From Input File    ${SUITE_SHOP_PAGE_ID}    ${site}     ${content}
    Run Keyword If    '${parent_id}' != 'parent__node_doesnt_exists'        Create Pages Content Data Failed From Input File    ${parent_id}    ${SUTIE_TEST_SHOP_ID}    ${site}     ${content}
    Verify Error Code Message    @{failed_list}

Update
    [Arguments]     ${is_success}   ${site}    ${version}   ${parent_id}   ${failed_list}   ${content}
    Run Keyword If      '${is_success}' == 'true'       Update Success Case     ${site}    ${version}
    Run Keyword If      '${is_success}' == 'false'      Update Failed Case      ${site}    ${parent_id}   ${failed_list}     ${content}

Update Success Case
    [Arguments]     ${site}    ${version}
    ${expected_content}=    Get File     ${updated_prepare_content}
    Update Pages Content Data From Input File      ${SUTIE_TEST_SHOP_ID}      ${SUITE_SHOP_PAGE_ID}    ${site}    ${updated_prepare_content}
    ${STOREFRONT_INFO}=    Get Page Content Web Draft From DynamoDB   ${SUTIE_TEST_SHOP_ID}      ${SUITE_SHOP_PAGE_ID}
    ${EXPECTED}=    Convert Json To Dict    ${expected_content}
    Verify Storefront Post Page Data     ${EXPECTED}    ${STOREFRONT_INFO}     ${SUITE_SHOP_PAGE_ID}    ${version}

Update Failed Case
    [Arguments]     ${site}    ${parent_id}     ${failed_list}       ${content}
    Run Keyword If    '${parent_id}' == 'parent__node_doesnt_exists'        Update Storefront Data From Input File But Failed    ${SUITE_SHOP_PAGE_ID}    ${site}     ${content}
    Run Keyword If    '${parent_id}' != 'parent__node_doesnt_exists'        Update Pages Content Data Failed From Input File    ${parent_id}    ${SUTIE_TEST_SHOP_ID}    ${site}     ${content}
    Verify Error Code Message    @{failed_list}

