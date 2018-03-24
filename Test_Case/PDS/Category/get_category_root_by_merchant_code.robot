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
Resource          ${CURDIR}/../../../Resource/Config/${env}/env_config.robot
Resource          ${CURDIR}/../../../Resource/TestData/${env}/test_data.robot
Test Teardown     Run keyword If    "${cat_id}" != "${EMPTY}"    Run Keywords    Log    ${cat_id}    AND    Permanent Delete Category By Category ID    ${cat_id}

*** Variables ***
${parent_id}     1
${cat_id}        ${EMPTY}

*** Test Cases ***
TC_ITMWM_00121 GET: /merchants/:merchant_code/categories/root - get empty merchant's category root by merchant code - success 200
    [Tags]    success    TC_ITMWM_00121    API_category    ready    regression    phoenix
    ${tc_number}=    Get Test Case Number
    ${test_merchant_code}=    Set Variable    ${tc_number}

    # Test Step:
    ${response}=    Get Category Root By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Response is Empty Data From Get All Categories

TC_ITMWM_00122 GET: /merchants/:merchant_code/categories/root - get single merchant's category root by merchant code - success 200
    [Tags]    success    TC_ITMWM_00122    API_category    ready    regression    phoenix
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
    ${response}=     Get Category Root By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Owner From Response Should Be Equal     ${response}    ${test_merchant_code}
    Verify Category Level From Response Should Be Equal     ${response}    1
    Verify Category is Child of Root    ${response}    ${cat_id}

TC_ITMWM_00123 GET: /merchants/:merchant_code/categories - get multiple merchant's categories root by merchant code - success 200
    [Tags]    success    TC_ITMWM_00123    API_category    ready    regression    phoenix
    # Prerequisite: There are 2 categories for a merchant
    ${tc_number}=    Get Test Case Number
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

    # Test Step:
    ${response}=     Get Category Root By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Owner From Response Should Be Equal     ${response}    ${test_merchant_code}
    Verify Category Level From Response Should Be Equal     ${response}    1
    Verify Category is Child of Root    ${response}    ${cat_id_1}
    Verify Category is Child of Root    ${response}    ${cat_id_2}

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2}    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}

TC_ITMWM_00124 GET: /merchants/:merchant_code/categories - get merchant's category by non-existing merchant code - success 200
    [Tags]    fail    TC_ITMWM_00124    API_category    ready    regression    phoenix    golf
    # Prerequisite: There is no category for a merchant
    ${tc_number}=    Get Test Case Number
    ${test_merchant_code}=    Set Variable    ${tc_number}

    # Test Step:
    ${response}=    Get Category Root By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Response is Empty Data From Get All Categories

TC_ITMWM_00125 GET: /merchants/:merchant_code/categories - get merchant's category that merchant was deleted by merchant code - success 200
    [Tags]    success    TC_ITMWM_00125    API_category    ready    regression    phoenix
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
    ${response}=     Get Category Root By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Owner From Response Should Be Equal     ${response}    ${test_merchant_code}
    Verify Category Level From Response Should Be Equal     ${response}    1
    Verify Category is Child of Root    ${response}    ${cat_id}

    #.. delete category
    Delete Category By Category ID    ${cat_id}

    ${response}=    Get Category Root By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Response is Empty Data From Get All Categories

TC_ITMWM_00126 GET: /merchants/:merchant_code/categories - get category by Blank - success 200
    [Tags]    success    TC_ITMWM_00126    API_category    ready    regression    phoenix
    # Prerequisite: There is no category for a merchant
    ${tc_number}=    Get Test Case Number
    ${test_merchant_code}=    Set Variable    ${tc_number}

    # Test Step:
    ${response}=    Get Category Root By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Response is Empty Data From Get All Categories

TC_iTM_0007 GET: /merchants/:merchant_code/categories - get category by Whitespace - success 200
    [Tags]    success    TC_iTM_04029    API_category    ready    phoenix
    # Prerequisite: There is no category for a merchant
    ${tc_number}=    Get Test Case Number
    ${test_merchant_code}=    Set Variable    ${tc_number}

    # Test Step:
    ${response}=    Get Category Root By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Response is Empty Data From Get All Categories
