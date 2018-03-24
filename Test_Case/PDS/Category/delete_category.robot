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
TC_ITMWM_00384 DELETE: /categories/:id - delete category by existing category ID - success 200
    [Tags]    success    TC_ITMWM_00384    API_category    ready    regression    phoenix
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=      Get Category ID After Creating

    # Test Step:
    #Delete cate and check result
    ${response}=    Delete Category By Category ID    ${cat_id}
    Verify Success Response Status Code and Message

    #Call API for check existing deleted cate
    ${response}=    Get Category By Category ID    ${cat_id}
    Verify Fail Response Status Code and Message    404    error    Not found category

TC_ITMWM_00385 DELETE: /categories/:id - delete category by non-existing category ID - fail 404
    [Tags]    fail    TC_ITMWM_00385    API_category    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=      Get Category ID After Creating
    ${cat_id_evaluate}=    Evaluate    ${cat_id}+100

    # Test Step:
    #Delete cate and check result
    ${response}=    Delete Category By Category ID    ${cat_id_evaluate}
    Verify Fail Response Status Code and Message    404    error    Not found category

TC_ITMWM_00386 DELETE: /categories/:id - delete category by EMPTY - fail 405
    [Tags]    fail    TC_ITMWM_00386    API_category    ready    phoenix
    ${cat_id}=      Set Variable    ${EMPTY}

    # Test Step:
    #Delete cate and check result
    ${response}=    Delete Category By Category ID    ${cat_id}
    Response Status Code Should Equal    405

TC_ITMWM_00387 DELETE: /categories/:id - delete category by ID more than maximum of long - fail 400
    [Tags]    fail    TC_ITMWM_00387    API_category    ready    phoenix
    ${cat_id}=      Set Variable    9223372036854775808

    # Test Step:
    #Delete cate and check result
    ${response}=    Delete Category By Category ID    ${cat_id}
    Verify Fail Response Status Code and Message    400    error    Long number too large
    ${cat_id}=      Set Variable    ${EMPTY}

TC_ITMWM_00388 DELETE: /categories/:id - delete sub category - success 200
    [Tags]    success    TC_ITMWM_00388    API_category    ready    regression    phoenix
    ${tc_number}=    Get Test Case Number

    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    #.. Create category 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}_1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=      Get Category ID After Creating

    #.. Create sub cat 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}_2_1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_2_1}=      Get Category ID After Creating

    #.. Create sub cat 2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}_2_2"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_2_2}=      Get Category ID After Creating

    # Test Step:
    #Delete sub cat 2 and check result
    ${response}=    Delete Category By Category ID    ${cat_id_2_2}
    Verify Success Response Status Code and Message

    #.. Call API to check parent category (cat 1)
    ${response}=    Get Category By Category ID    ${cat_id_1}
    ${children_order}=      Get Json Value    ${response}    /data/children_order
    Should Be Equal As Strings    "${children_order}"    "["${cat_id_2_1}"]"

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_2_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2_2}    AND    Run keyword If    "${cat_id_2_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2_1}\
    ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}

TC_ITMWM_00389 DELETE: /categories/:id - delete category that has sub category - fail 400
    [Tags]    fail    TC_ITMWM_00389    API_category    ready    phoenix
    ${tc_number}=    Get Test Case Number

    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    #.. Create category 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}_1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=      Get Category ID After Creating

    #.. Create sub cat 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}_2_1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_2_1}=      Get Category ID After Creating

    #.. Create sub cat 2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}_2_2"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_2_2}=    Get Category ID After Creating

    # Test Step:
    # Delete parent cate and check result
    ${response}=    Delete Category By Category ID    ${cat_id_1}
    Verify Fail Response Status Code and Message    400    error    Cannot delete category id ${cat_id_1} with category have children ${cat_id_2_1},${cat_id_2_2}

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_2_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2_2}    AND    Run keyword If    "${cat_id_2_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2_1}\
    ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}
