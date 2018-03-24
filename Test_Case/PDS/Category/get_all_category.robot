*** Setting ***
Force Tags    WLS_PDS_Category
Library           HttpLibrary.HTTP
Library           Collections
Library           DatabaseLibrary
Library           String
Library           ${CURDIR}/../../../Python_Library/FileKeyword.py
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Database/PDS/keyword_categories.robot
Resource          ${CURDIR}/../../../Keyword/API/PDS/pds_api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/Keywords_PDS_Common.robot

*** Variables ***
${parent_id}     1

*** Test Cases ***
TC_ITMWM_00644 GET: /categories - get all categories - success 200
    [Tags]    success    TC_ITMWM_00644    API_category    ready    regression    phoenix
    # # Prerequisite: There are some categories on system
    ${cat_id_1}=     Set Variable       ${EMPTY}
    ${cat_id_2}=     Set Variable       ${EMPTY}
    ${tc_number}=    Get Test Case Number
    @{expected_name_trail}=                Create List    ${tc_number}-1
    @{expected_name_trail_translate}=      Create List    ${tc_number}trans-1
    @{expected_name_trail2}=               Create List    ${tc_number}-2
    @{expected_name_trail_translate2}=     Create List    ${tc_number}trans-2

    ${expected_display_image_desktop}=     Set Variable    image_url_desktop-${tc_number}
    ${expected_display_image_mobile}=      Set Variable    image_url_mobile-${tc_number}

    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate    "${tc_number}trans-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate    "${tc_number}trans-2"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id_2}=     Get Category ID After Creating
    ${data}=         Get Json Value and Convert to List    ${response}    /data
    ${pkey}=         Get From Dictionary    ${data}     pkey

    @{expected_slug_trail}=    Create List    ${tc_number}-slug-${pkey}

    #..step test
    ${response}=    Get All Category
    Verify Success Response Status Code and Message
    Verify Response Data From Get All Categories
    Verify Category Name Trail From Response Data Should Be Equal    ${response}    ${expected_name_trail}    ${expected_name_trail_translate}    ${cat_id_1}
    Verify Category Name Trail From Response Data Should Be Equal    ${response}    ${expected_name_trail2}    ${expected_name_trail_translate2}    ${cat_id_2}
    Verify Display Image From Response Data Should Be Equal    ${response}    ${expected_display_image_desktop}    ${expected_display_image_mobile}    ${cat_id_2}
    Verify Slug Trail From Response Data Should Be Equal    ${response}    ${expected_slug_trail}    ${cat_id_2}

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}    AND    Run keyword If    "${cat_id_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2}

TC_ITMWM_00645 GET: /categories - get empty category - success 200
    [Tags]    success     TC_ITMWM_00645    ready    API_category
    # Prerequisite: There is no any category on system
    ${response}=    Get All Category
    Verify Success Response Status Code and Message
    Verify Response is Empty Data From Get All Categories