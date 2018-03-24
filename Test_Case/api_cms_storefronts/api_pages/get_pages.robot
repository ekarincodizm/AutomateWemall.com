*** Settings ***
Force Tags    WLS_API_CMS_Storefront
Library             OperatingSystem
Library             Collections
Library             ${CURDIR}/../../../Python_Library/DynamoDb.py
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/api_pages_keywords.robot
Resource            ${CURDIR}/../../../Resource/init.robot
Suite Setup         Prepare Shop Data Dynamo
Suite Teardown      Tear Down Shop Data Dynamo

*** Variable ***
${DATA_PATH}                  ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/shop/shop_dynamo.json

*** Keywords ***
Prepare Shop Data Dynamo
    ${json_data}=     Get File    ${DATA_PATH}
    Dynamo Put Item    ${STOREFRONT_SHOP_TABLE}    ${json_data}
    ${TEST_SHOP_DICT}=    Convert Json To Dict    ${json_data}
    ${TEST_SHOP_ID}=	  Get From Dictionary	${TEST_SHOP_DICT}	id
    ${TEST_SHOP_SLUG}=	  Get From Dictionary	${TEST_SHOP_DICT}	slug
    ${TEST_SHOP_PAGES_DICT}=	Get From Dictionary    ${TEST_SHOP_DICT}	pages
    ${PAGES_ID_LIST}=    Get Dictionary Keys    ${TEST_SHOP_PAGES_DICT}   # keys will be a list of key items

    Set Suite Variable    ${SUITE_PAGES_ID_LIST}    ${PAGES_ID_LIST}
    Set Suite Variable    ${SUTIE_TEST_SHOP_PAGES_DICT}     ${TEST_SHOP_PAGES_DICT}
    Set Suite Variable    ${SUTIE_TEST_SHOP_ID}      ${TEST_SHOP_ID}
    Set Suite Variable    ${SUTIE_TEST_SHOP_SLUG}    ${TEST_SHOP_SLUG}

Tear Down Shop Data Dynamo
    Dynamo Delete Item    ${STOREFRONT_SHOP_TABLE}    {"id":"${SUTIE_TEST_SHOP_ID}"}

*** Test Cases ***
TC_ITMWM_05528 [Web][Th] Test Get Pages Detail List by Shop Id
    [Tags]    get_pages    api_pages    Regression    api_cms
    Get Pages Detail List by Shop ID   ${SUTIE_TEST_SHOP_ID}
    ${data}=    Verify Get All Page Success and Data Correct
    Verify Data Correct With Json     ${data}    ${SUTIE_TEST_SHOP_PAGES_DICT}

TC_ITMWM_05529 [Web][Th] Test Get Page Detail by Page Id
    [Tags]    get_pages    api_pages    Regression    api_cms
    LOG     ${SUITE_PAGES_ID_LIST}
    :FOR    ${PAGE_ID}   IN     @{SUITE_PAGES_ID_LIST}
    \    Log    ${PAGE_ID}
    \    ${EXPECTED_PAGE_INFO}=    Get From Dictionary    ${SUTIE_TEST_SHOP_PAGES_DICT}    ${PAGE_ID}
    \    Log    Item: ${EXPECTED_PAGE_INFO}
    \    Get Pages Detail by Page ID    ${SUTIE_TEST_SHOP_ID}     ${PAGE_ID}
    \    ${data}=    Verify Get All Page Success and Data Correct
    \    Verify Data Correct With Json    ${data}    ${EXPECTED_PAGE_INFO}

TC_ITMWM_05530 [Web][Th] Test Get Page Detail by Invalid Page Id
    [Tags]    get_pages    api_pages    Regression    api_cms
    Get Pages Detail by Page ID    ${SUTIE_TEST_SHOP_ID}     XXXX
    Verify Response Success but Data Empty    null

TC_ITMWM_05592 [Web][Th] Test Get Page Detail by Empty Page Id
    [Tags]    get_pages    api_pages    Regression    api_cms
    Get Pages Detail by Page ID    ${SUTIE_TEST_SHOP_ID}     ${EMPTY}
    ${data}=    Verify Get All Page Success and Data Correct
    Verify Data Correct With Json     ${data}    ${SUTIE_TEST_SHOP_PAGES_DICT}

TC_ITMWM_05593 [Web][Th] Test Get Pages Detail List by Shop Slug
    [Tags]    get_pages    api_pages    Regression    api_cms
    Get Pages Detail List by Shop Slug     ${SUTIE_TEST_SHOP_SLUG}     ${EMPTY}
    ${data}=    Verify Get All Page Success and Data Correct
    Verify Data Correct With Json     ${data}    ${SUTIE_TEST_SHOP_PAGES_DICT}

TC_ITMWM_05531 [Web][Th] Test Get Pages Detail By Page Slug
    [Tags]    get_pages    api_pages    Regression    api_cms
    LOG     ${SUITE_PAGES_ID_LIST}
    :FOR    ${PAGE_ID}   IN     @{SUITE_PAGES_ID_LIST}
    \    Log    ${PAGE_ID}
    \    ${EXPECTED_PAGE_INFO}=    Get From Dictionary    ${SUTIE_TEST_SHOP_PAGES_DICT}    ${PAGE_ID}
    \    ${EXPECTED_SLUG}=    Get From Dictionary    ${EXPECTED_PAGE_INFO}    slug
    \    Log    Item: ${EXPECTED_PAGE_INFO}
    \    Get Pages Detail by Page Slug   ${SUTIE_TEST_SHOP_SLUG}     ${EXPECTED_SLUG}
    \    ${data}=    Verify Get All Page Success and Data Correct
    \    Verify Data Correct With Json    ${data}    ${EXPECTED_PAGE_INFO}

TC_ITMWM_05532 [Web][Th] Test Get Page Detail by Invalid Page Slug
    [Tags]    get_pages    api_pages    Regression    api_cms
    Get Pages Detail by Page Slug    ${SUTIE_TEST_SHOP_SLUG}     XXXX
    Verify Response Success but Data Empty    null

TC_ITMWM_05533 [Web][Th] Get Page Detail by Empty Page Slug
    [Tags]    get_pages    api_pages    Regression    api_cms
    Get Pages Detail by Page Slug    ${SUTIE_TEST_SHOP_SLUG}     ${EMPTY}
    ${data}=    Verify Get All Page Success and Data Correct
    Verify Data Correct With Json    ${data}    ${SUTIE_TEST_SHOP_PAGES_DICT}

#TC_WMALL_XXXX [Web][Th] Test Scan Dynamo
#     [Tags]    Test
#    :FOR    ${PAGE_ID}   IN     @{SUITE_PAGES_ID_LIST}
#    \    Log    ${PAGE_ID}
#    \    ${ScanKey}=    Convert Json To Dict    {"id":"${SUTIE_TEST_SHOP_ID}"}
#    \    ${items}=    Dynamo Get Item    ${STOREFRONT_SHOP_TABLE}    ${ScanKey}
#    \    Log    Item: ${items}
