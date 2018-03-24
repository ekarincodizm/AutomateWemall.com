*** Setting ***
Force Tags    WLS_PDS_Category
Library           HttpLibrary.HTTP
Library           Collections
Library           DatabaseLibrary
Library           String
Library           ${CURDIR}/../../../Python_Library/FileKeyword.py
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Database/PDS/keyword_categories.robot
Resource          ${CURDIR}/../../../Keyword/API/PDS/pds_api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/Keywords_PDS_Common.robot
Resource          ${CURDIR}/../../../Resource/init.robot
# Resource          ${CURDIR}/../../../Resource/Config/${env}/env_config.robot
# Resource          ${CURDIR}/../../../Resource/TestData/${env}/test_data.robot
Test Teardown     Run keyword If    "${cat_id}" != "${EMPTY}"    Run Keywords    Log    ${cat_id}    AND    Permanent Delete Category By Category ID    ${cat_id}

*** Variables ***
${parent_id}     1
${cat_id}        ${EMPTY}

*** Test Cases ***
TC_ITMWM_00652 GET: /merchants/:merchant_code/categories - get empty merchant's category by merchant code - success 200
    [Tags]    success    TC_ITMWM_00652    API_category    ready    regression    phoenix
    ${tc_number}=    Get Test Case Number
    ${test_merchant_code}=    Set Variable    ${tc_number}
    # Test Step:
    ${response}=    Get Category By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Response is Empty Data From Get All Categories

TC_ITMWM_00653 GET: /merchants/:merchant_code/categories - get single merchant's category by merchant code - success 200
    [Tags]    success    TC_ITMWM_00653    API_category    ready    regression    phoenix
    # Prerequisite: There is a category for a merchant
    ${tc_number}=    Get Test Case Number
    @{expected_name_trail}=                Create List    ${tc_number}
    @{expected_name_translation_trail}=    Create List    ${tc_number}-EN
    ${expected_display_image_desktop}=     Set Variable    image_url_desktop-${tc_number}
    ${expected_display_image_mobile}=      Set Variable    image_url_mobile-${tc_number}

    ${test_merchant_code}=      Set Variable    ${tc_number}
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner    "${test_merchant_code}"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating

    # Test Step:
    ${response}=     Get Category By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Number of Category From Response    ${response}    1

    Verify Category Name Trail From Response Data Should Be Equal    ${response}    ${expected_name_trail}    ${expected_name_translation_trail}    ${cat_id}
    Verify Display Image From Response Data Should Be Equal    ${response}    ${expected_display_image_desktop}    ${expected_display_image_mobile}    ${cat_id}

TC_ITMWM_00654 GET: /merchants/:merchant_code/categories - get multiple merchant's categories by merchant code - success 200
    [Tags]    success    TC_ITMWM_00654    API_category    ready    regression    phoenix
    # Prerequisite: There are 2 categories for a merchant
    ${tc_number}=    Get Test Case Number
    @{expected_name_trail_1}=                Create List    ${tc_number}-1
    @{expected_name_translation_trail_1}=    Create List    ${tc_number}-EN
    @{expected_name_trail_2}=                Create List    ${tc_number}-2
    @{expected_name_translation_trail_2}=    Create List    ${tc_number}-EN
    ${test_merchant_code}=    Set Variable    ${tc_number}
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner    "${test_merchant_code}"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner    "${test_merchant_code}"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id_2}=     Get Category ID After Creating
    ${cat_pkey_1}=    Get Category Pkey After Creating

    # Test Step:
    @{expected_slug_trail}=    Create List    ${tc_number}-slug-${cat_pkey_1}
    ${response}=     Get Category By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Number of Category From Response    ${response}    2
    Verify Category Name Trail From Response Data Should Be Equal    ${response}    ${expected_name_trail_1}    ${expected_name_translation_trail_1}    ${cat_id_1}
    Verify Category Name Trail From Response Data Should Be Equal    ${response}    ${expected_name_trail_2}    ${expected_name_translation_trail_2}    ${cat_id_2}
    Verify Slug Trail From Response Data Should Be Equal    ${response}    ${expected_slug_trail}    ${cat_id_2}

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2}    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}

TC_ITMWM_00655 GET: /merchants/:merchant_code/categories - get merchant's category by non-existing merchant code - success 200
    [Tags]    success    TC_ITMWM_00655    API_category    ready    regression    phoenix
    # Prerequisite: There is no category for a merchant
    ${tc_number}=    Get Test Case Number
    ${test_merchant_code}=    Set Variable    ${tc_number}

    # Test Step:
    ${response}=    Get Category By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Response is Empty Data From Get All Categories

TC_ITMWM_00656 GET: /merchants/:merchant_code/categories - get merchant's category that merchant was deleted by merchant code - success 200
    [Tags]    success    TC_ITMWM_00656    API_category    ready    regression    phoenix
    # Prerequisite: There is a category for a merchant
    ${tc_number}=    Get Test Case Number
    ${test_merchant_code}=    Set Variable    ${tc_number}
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner    "${test_merchant_code}"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating

    # Test Step:
    ${response}=     Get Category By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Number of Category From Response    ${response}    1

    #.. delete category
    Delete Category By Category ID    ${cat_id}

    ${response}=    Get Category By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Response is Empty Data From Get All Categories

TC_ITMWM_00657 GET: /merchants/:merchant_code/categories - get category by Blank - success 200
    [Tags]    success    TC_ITMWM_00657    API_category    ready    regression    phoenix
    # Prerequisite: There is no category for a merchant
    ${tc_number}=    Get Test Case Number
    ${test_merchant_code}=    Set Variable    ${tc_number}

    # Test Step:
    ${response}=    Get Category By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Response is Empty Data From Get All Categories

TC_ITMWM_00658 GET: /merchants/:merchant_code/categories - get category by Whitespace - success 200
    [Tags]    success    TC_ITMWM_00658    API_category    ready    regression    phoenix
    # Prerequisite: There is no category for a merchant
    ${tc_number}=    Get Test Case Number
    ${test_merchant_code}=    Set Variable    ${tc_number}

    # Test Step:
    ${response}=    Get Category By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Response is Empty Data From Get All Categories
