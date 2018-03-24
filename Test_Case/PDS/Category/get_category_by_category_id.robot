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
Test Teardown     Run keyword If    "${cat_id}" != "${EMPTY}"    Run Keywords    Log    ${cat_id}    AND    Permanent Delete Category By Category ID    ${cat_id}

*** Variables ***
${parent_id}     1
${cat_id}        ${EMPTY}

*** Test Cases ***
TC_ITMWM_00646 GET: /categories/:id - get category that has no product by category ID - success 200
    [Tags]    success    TC_ITMWM_00646    API_category    ready    regression    phoenix
    # Prerequisite: There is category that has no product on system
    ${tc_number}=    Get Test Case Number
    @{expected_name_trail}=                Create List    ${tc_number}
    @{expected_name_translation_trail}=    Create List    ${tc_number}-EN
    ${expected_display_image_desktop}=     Set Variable    image_url_desktop-${tc_number}
    ${expected_display_image_mobile}=      Set Variable    image_url_mobile-${tc_number}

    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=               Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=      Get Category ID After Creating
    ${data}=        Get Json Value and Convert to List    ${response}    /data
    ${pkey}=        Get From Dictionary    ${data}     pkey

    @{expected_slug_trail}=    Create List    ${tc_number}-slug-${pkey}

    # Test Step:
    ${response}=    Get Category By Category ID    ${cat_id}

    Verify Success Response Status Code and Message
    Verify Products From Response is Empty    ${response}
    ${data}=    Get Json Value and Convert to List    ${response}    /data

    Verify Categories Between Data From Response and DB    ${data}
    Verify Category Name Trail From Response Data Should Be Equal    ${response}    ${expected_name_trail}    ${expected_name_translation_trail}    ${cat_id}
    Verify Display Image From Response Data Should Be Equal    ${response}    ${expected_display_image_desktop}    ${expected_display_image_mobile}    ${cat_id}

TC_ITMWM_00647 GET: /categories/:id - get category that has no sub category by category ID - success 200
    [Tags]    success    TC_ITMWM_00647    API_category    ready    regression    phoenix
    # Prerequisite: There is category that has no sub category on system
    ${tc_number}=    Get Test Case Number
    @{expected_name_trail}=                Create List    ${tc_number}
    @{expected_name_translation_trail}=    Create List    ${tc_number}-EN
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=      Get Category ID After Creating

    # Test Step:
    ${response}=    Get Category By Category ID    ${cat_id}
    Verify Success Response Status Code and Message
    Verify Sub Category From Response is Empty    ${response}
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    Verify Categories Between Data From Response and DB    ${data}
    Verify Category Name Trail From Response Data Should Be Equal    ${response}    ${expected_name_trail}    ${expected_name_translation_trail}    ${cat_id}

TC_ITMWM_00648 GET: /categories/:id - get category that has 1-5 sub category level by category ID - success 200
    [Tags]    success    TC_ITMWM_00648    API_category    ready    regression    phoenix
    # Prerequisite: There is category that has 1-5 sub category level on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    #..CATEGORY 1

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=      Get Category ID After Creating

    # Test Step:
    #..CATEGORY 1
    ${level}=    Set Variable    2
    ${response_1}=    Get Category By Category ID    ${cat_id_1}
    Verify Success Response Status Code and Message
    Verify Number of Sub Category And Level from Response    ${response_1}    0    ${level}
    ${data_1}=    Get Json Value and Convert to List    ${response_1}    /data
    ${pkey_1}=    Get From Dictionary    ${data_1}     pkey
    Verify Categories Between Data From Response and DB    ${data_1}

    #..CATEGORY 1-1 sub level 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-1}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1-1}=      Get Category ID After Creating
    ${data_1-1}=        Get Json Value and Convert to List    ${response_1-1}    /data
    ${pkey_1-1}=        Get From Dictionary    ${data_1-1}     pkey

    # Test Step:
    #..CATEGORY 1-1 sub level 1
    ${level}=    Set Variable    2
    : FOR    ${cat_id}    ${number_of_sub_cat}    IN    ${cat_id_1}    1    ${cat_id_1-1}    0
    \    ${response_item}=    Get Category By Category ID    ${cat_id}
    \    Verify Success Response Status Code and Message
    \    Verify Number of Sub Category And Level from Response    ${response_item}    ${number_of_sub_cat}   ${level}
    \    ${data_item}=    Get Json Value and Convert to List    ${response_item}    /data
    \    Verify Categories Between Data From Response and DB    ${data_item}
    \    ${level}=    Evaluate    ${level}+1

    #..CATEGORY 1-2 sub level 2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-1-2"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-2}=    Create Category    ${cat_id_1-1}    ${file_data}
    ${cat_id_1-2}=      Get Category ID After Creating
    ${data_1-2}=        Get Json Value and Convert to List    ${response_1-2}    /data
    ${pkey_1-2}=        Get From Dictionary    ${data_1-2}     pkey

    # Test Step:
    #..CATEGORY 1-2 sub level 2
    ${level}=    Set Variable    2
    : FOR    ${cat_id}    ${number_of_sub_cat}    IN    ${cat_id_1}    1    ${cat_id_1-1}    1    ${cat_id_1-2}    0
    \    ${response_item}=    Get Category By Category ID    ${cat_id}
    \    Verify Success Response Status Code and Message
    \    Verify Number of Sub Category And Level from Response    ${response_item}    ${number_of_sub_cat}    ${level}
    \    ${data_item}=    Get Json Value and Convert to List    ${response_item}    /data
    \    Verify Categories Between Data From Response and DB    ${data_item}
    \    ${level}=    Evaluate    ${level}+1

    #..CATEGORY 1-3 sub level 3
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-1-3"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-3}=    Create Category    ${cat_id_1-2}    ${file_data}
    ${cat_id_1-3}=      Get Category ID After Creating
    ${data_1-3}=        Get Json Value and Convert to List    ${response_1-3}    /data
    ${pkey_1-3}=        Get From Dictionary    ${data_1-3}     pkey

    # Test Step:
    #..CATEGORY 1-3 sub level 3
    ${level}=    Set Variable    2
    : FOR    ${cat_id}    ${number_of_sub_cat}    IN    ${cat_id_1}    1    ${cat_id_1-1}    1    ${cat_id_1-2}    1    ${cat_id_1-3}    0
    \    ${response_item}=    Get Category By Category ID    ${cat_id}
    \    Verify Success Response Status Code and Message
    \    Verify Number of Sub Category And Level from Response    ${response_item}    ${number_of_sub_cat}    ${level}
    \    ${data_item}=    Get Json Value and Convert to List    ${response_item}    /data
    \    Verify Categories Between Data From Response and DB    ${data_item}
    \    ${level}=    Evaluate    ${level}+1

    #..CATEGORY 1-4 sub level 4
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-1-4"
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-4}=    Create Category    ${cat_id_1-3}    ${file_data}
    ${cat_id_1-4}=      Get Category ID After Creating
    ${data_1-4}=        Get Json Value and Convert to List    ${response_1-4}    /data
    ${pkey_1-4}=        Get From Dictionary    ${data_1-4}     pkey

    # Test Step:
    #..CATEGORY 1-4 sub level 4
    ${level}=    Set Variable    2
    : FOR    ${cat_id}    ${number_of_sub_cat}    IN    ${cat_id_1}    1    ${cat_id_1-1}    1    ${cat_id_1-2}    1    ${cat_id_1-3}    1    ${cat_id_1-4}    0
    \    ${response_item}=    Get Category By Category ID    ${cat_id}
    \    Verify Success Response Status Code and Message
    \    Verify Number of Sub Category And Level from Response    ${response_item}    ${number_of_sub_cat}    ${level}
    \    ${data_item}=    Get Json Value and Convert to List    ${response_item}    /data
    \    Verify Categories Between Data From Response and DB    ${data_item}
    \    ${level}=    Evaluate    ${level}+1

    #..CATEGORY 1-5 sub level 5
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-1-5"
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-5}=    Create Category    ${cat_id_1-4}    ${file_data}
    ${cat_id_1-5}=      Get Category ID After Creating
    ${data_1-5}=        Get Json Value and Convert to List    ${response_1-5}    /data
    ${pkey_1-5}=        Get From Dictionary    ${data_1-5}     pkey

    # Test Step:
    #..CATEGORY 1-5 sub level 5
    ${level}=    Set Variable    2
    : FOR    ${cat_id}    ${number_of_sub_cat}    IN    ${cat_id_1}    1    ${cat_id_1-1}    1    ${cat_id_1-2}    1    ${cat_id_1-3}    1    ${cat_id_1-4}    1    ${cat_id_1-5}    0
    \    ${response_item}=    Get Category By Category ID    ${cat_id}
    \    Verify Success Response Status Code and Message
    \    Verify Number of Sub Category And Level from Response    ${response_item}    ${number_of_sub_cat}    ${level}
    \    ${data_item}=    Get Json Value and Convert to List    ${response_item}    /data
    \    Verify Categories Between Data From Response and DB    ${data_item}
    \    ${level}=    Evaluate    ${level}+1

    @{expected_name_trail}=    Create List    ${tc_number}-CAT1    ${tc_number}-CAT1-1    ${tc_number}-CAT1-1-2    ${tc_number}-CAT1-1-3    ${tc_number}-CAT1-1-4    ${tc_number}-CAT1-1-5
    @{expected_name_translation_trail}=    Create List    ${tc_number}-EN    ${tc_number}-EN    ${tc_number}-EN    ${tc_number}-EN    ${tc_number}-EN    ${tc_number}-EN
    ${expected_display_image_desktop}=     Set Variable    image_url_desktop-${tc_number}
    ${expected_display_image_mobile}=      Set Variable    image_url_mobile-${tc_number}
    @{expected_slug_trail}=                Create List     ${tc_number}-slug-${pkey_1}    ${tc_number}-slug-${pkey_1-1}    ${tc_number}-slug-${pkey_1-2}    ${tc_number}-slug-${pkey_1-3}    ${tc_number}-slug-${pkey_1-4}    ${tc_number}-slug-${pkey_1-5}

    Verify Category Name Trail From Response Data Should Be Equal    ${response_1-5}    ${expected_name_trail}    ${expected_name_translation_trail}    ${cat_id_1-5}
    Verify Display Image From Response Data Should Be Equal    ${response_1-5}    ${expected_display_image_desktop}    ${expected_display_image_mobile}    ${cat_id_1-5}
    Dictionary Should Not Contain Key    ${data_1-5}    image_url_desktop
    Dictionary Should Not Contain Key    ${data_1-5}    image_url_mobile
    Verify Slug Trail From Response Data Should Be Equal    ${response_1-5}    ${expected_slug_trail}    ${cat_id_1-5}

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1-5}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1-5}    AND    Run keyword If    "${cat_id_1-4}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1-4}\
    ...    AND     Run keyword If    "${cat_id_1-3}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1-3}\
    ...    AND     Run keyword If    "${cat_id_1-2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1-2}\
    ...    AND     Run keyword If    "${cat_id_1-1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1-1}\
    ...    AND     Run keyword If    "${cat_id_1}" != "${EMPTY}"      Permanent Delete Category By Category ID    ${cat_id_1}

TC_ITMWM_00649 GET: /categories/:id - get category by non-existing category ID - fail 404
    [Tags]    fail    TC_ITMWM_00649    API_category    ready    regression    phoenix
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=      Get Category ID After Creating
    ${non_cat_id}=    Evaluate    ${cat_id}+100

    # Test Step:
    ${response}=    Get Category By Category ID    ${non_cat_id}
    Verify Fail Response Status Code and Message    404    error    Not found category

TC_ITMWM_00650 GET: /categories/:id - get category that was deleted by category ID - fail 404
    [Tags]    fail    TC_ITMWM_00650    API_category    ready    regression    phoenix
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=      Get Category ID After Creating

    # Test Step:
    ${response}=    Get Category By Category ID    ${cat_id}
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data

    #.. delete category
    Delete Category By Category ID    ${cat_id}

    ${response}=    Get Category By Category ID    ${cat_id}
    Verify Fail Response Status Code and Message    404    error    Not found category

TC_ITMWM_00651 GET: /categories/:id - get category by String - fail 400
    [Tags]    fail    TC_ITMWM_00651    API_category    ready    regression    phoenix
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=      Get Category ID After Creating

    # Test Step:
    ${response}=    Get Category By Category ID    ${cat_id}
    Verify Success Response Status Code and Message

    ${response}=    Get Category By Category ID    ()_&
    Verify Fail Response Status Code and Message    400    error    Id should be number

    ${response}=    Get Category By Category ID    %20${cat_id}
    Verify Fail Response Status Code and Message    400    error    Id should be number

    ${response}=    Get Category By Category ID    ${SPACE}${cat_id}
    Verify Fail Response Status Code and Message    400    error    Id should be number