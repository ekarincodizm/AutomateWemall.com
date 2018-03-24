*** Setting ***
Force Tags    WLS_PCMS_Category
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           BuiltIn
Library           String
Library           OperatingSystem
Library           Collections
Library           DateTime
Library           DatabaseLibrary
Library           ${CURDIR}/../../../Python_Library/common.py
Library           ${CURDIR}/../../../Python_Library/FileKeyword.py
Library           ${CURDIR}/../../../Python_Library/common/uploadsoperation.py
Library           ${CURDIR}/../../../Python_Library/common/csvlibrary.py
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Database/PDS/keyword_merchant.robot
Resource          ${CURDIR}/../../../Keyword/API/PDS/pds_api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/Keywords_PDS_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/Keywords_PDS_Mass_Upload_Product_To_Category.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/webelement_PCMS_Category_Management.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/webelement_PCMS_Category_Mass_Upload_Product.robot
Resource          ${CURDIR}/../../../Resource/init.robot
Test Setup        Run Keywords    Login Pcms    AND    Maximize Browser Window
Test Teardown     Run Keywords    Run keyword If    "${cat_id}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id}    AND    Close All Browsers

*** Variables ***
${cat_id}       ${EMPTY}
${parent_id}    1
${message_success_template}       Uploaded ??number?? product(s) successfully.
${message_fail_template}          ??number?? row(s) failed
${message_alert_upload_action}    Please select your action before upload file.
${message_alert_choose_file}      Please choose file to upload.
${message_alert_upload_action_and_file}      Please select your action and choose file to upload.

*** Test Cases ***
TC_ITMWM_05115 Mass upload to add product into category: Added a product to category via mass upload - success
    [Tags]    TC_ITMWM_05115    regression    ready    phoenix    WLS_Medium
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    add
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    1
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_success}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Success
    @{file_ver_result}=         Create List    @{file_ver_data_value1}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List    @{data_value1}[1]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey}    ${expected_product_list}

TC_ITMWM_05116 Mass upload to add product into category: Added multiple product to category via mass upload - success
    [Tags]    TC_ITMWM_05116    regression    ready    phoenix    WLS_High
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey}       &{product-disc-2}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    add
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    2
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_success}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Success
    @{file_ver_data_value2}=    Create List    3    @{data_value2}    Success
    @{file_ver_result}=         Create List    @{file_ver_data_value1}    @{file_ver_data_value2}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List    @{data_value1}[1]    @{data_value2}[1]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey}    ${expected_product_list}

TC_ITMWM_05117 Mass upload to add product into category: Added multiple products to multiple categories - success
    [Tags]    TC_ITMWM_05117    regression    ready    phoenix    WLS_High
    ${tc_number}=    Get Test Case Number
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    #.. CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating
    ${cat_pkey_1}=     Get Category Pkey After Creating
    #.. CATEGORY 2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id_2}=     Get Category ID After Creating
    ${cat_pkey_2}=     Get Category Pkey After Creating

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey_1}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey_1}       &{product-disc-2}[pkey]
    @{data_value3}=    Create List    ${cat_pkey_2}       &{product-disc-1}[pkey]
    @{data_value4}=    Create List    ${cat_pkey_2}       &{product-disc-2}[pkey]
    @{data_value5}=    Create List    ${cat_pkey_2}       &{product-disc-3}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}    ${data_value4}    ${data_value5}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    add
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    5
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_success}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Success
    @{file_ver_data_value2}=    Create List    3    @{data_value2}    Success
    @{file_ver_data_value3}=    Create List    4    @{data_value3}    Success
    @{file_ver_data_value4}=    Create List    5    @{data_value4}    Success
    @{file_ver_data_value5}=    Create List    6    @{data_value5}    Success
    @{file_ver_result}=         Create List    @{file_ver_data_value1}    @{file_ver_data_value2}    @{file_ver_data_value3}    @{file_ver_data_value4}    @{file_ver_data_value5}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List    @{data_value1}[1]    @{data_value2}[1]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey_1}    ${expected_product_list}

    ${expected_product_list}=    Create List    @{data_value3}[1]    @{data_value4}[1]    @{data_value5}[1]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey_2}    ${expected_product_list}

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}\
   ...    AND    Run keyword If    "${cat_id_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2}\
   ...    AND    Close All Browsers

TC_ITMWM_05118 Mass upload to add product into category: Added multiple product to category 200 records - success
    [Tags]    TC_ITMWM_05118    ready
    ## Create Varaible List for FOR Loop
    #.. Category ID
    @{cat_id_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    51
    \    Append To List    ${cat_id_list}    cat_id_${index}
    #.. Category Pkey
    @{cat_pkey_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    51
    \    Append To List    ${cat_pkey_list}    cat_pkey_${index}
    #.. Data Value
    @{data_value1_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    51
    \    Append To List    ${data_value1_list}    data_value${index}-1
    @{data_value2_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    51
    \    Append To List    ${data_value2_list}    data_value${index}-2
    @{data_value3_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    51
    \    Append To List    ${data_value3_list}    data_value${index}-3
    @{data_value4_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    51
    \    Append To List    ${data_value4_list}    data_value${index}-4
    ########

    ${tc_number}=    Get Test Case Number
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    #.. CATEGORY 1-50
    :FOR    ${index}    IN RANGE    1    51
    \    ${index}=    Set Variable    ${index}
    \    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-${index}"
    \    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    \    ${response}=    Create Category    ${parent_id}    ${file_data}
    \    ${cat_id}=     Get Category ID After Creating
    \    ${cat_pkey}=     Get Category Pkey After Creating
    \    Set List Value    ${cat_id_list}    ${index}     ${cat_id}
    \    Set List Value    ${cat_pkey_list}    ${index}     ${cat_pkey}
    Log List    ${cat_id_list}
    Log List    ${cat_pkey_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data}=           Create List    ${data_name}
    :FOR    ${index}    IN RANGE    1    51
    \    ${index}=    Set Variable    ${index}
    \    @{data_value-1}=    Create List    @{cat_pkey_list}[${index}]    &{product-disc-1}[pkey]
    \    @{data_value-2}=    Create List    @{cat_pkey_list}[${index}]    &{product-disc-2}[pkey]
    \    @{data_value-3}=    Create List    @{cat_pkey_list}[${index}]    &{product-disc-3}[pkey]
    \    @{data_value-4}=    Create List    @{cat_pkey_list}[${index}]    &{product-disc-4}[pkey]
    \    Set List Value    ${data_value1_list}     ${index}     ${data_value-1}
    \    Set List Value    ${data_value2_list}     ${index}     ${data_value-2}
    \    Set List Value    ${data_value3_list}     ${index}     ${data_value-3}
    \    Set List Value    ${data_value4_list}     ${index}     ${data_value-4}
    \    Append To List    ${data}    @{data_value1_list}[${index}]    @{data_value2_list}[${index}]    @{data_value3_list}[${index}]    @{data_value4_list}[${index}]
    Log List    ${data}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    add
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button
    Mass Upload Product to Category - Wait Until Page Contains File Verification Table    60

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    200
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_success}

    ##.. Provide file verification result
    @{file_ver_result}=    Create List
    ${loop_number}=    Set Variable    0
    ${odd_number}=     Set Variable    1
    :FOR    ${index}    IN RANGE    4    201    4
    \    ${loop_number}=     Evaluate    ${loop_number}+1
    #.. row number in csv file
    \    ${row_number_1}=    Evaluate    (${odd_number}*2)
    \    ${row_number_2}=    Evaluate    (${odd_number}*2)+1
    \    ${row_number_3}=    Evaluate    (${odd_number}*2)+2
    \    ${row_number_4}=    Evaluate    (${odd_number}*2)+3
    \    ${data_1}=          Set Variable    @{data_value1_list}[${loop_number}]
    \    ${data_2}=          Set Variable    @{data_value2_list}[${loop_number}]
    \    ${data_3}=          Set Variable    @{data_value3_list}[${loop_number}]
    \    ${data_4}=          Set Variable    @{data_value4_list}[${loop_number}]
    \    @{file_ver_data_value1}=    Create List    ${row_number_1}    @{data_1}    Success
    \    @{file_ver_data_value2}=    Create List    ${row_number_2}    @{data_2}    Success
    \    @{file_ver_data_value3}=    Create List    ${row_number_3}    @{data_3}    Success
    \    @{file_ver_data_value4}=    Create List    ${row_number_4}    @{data_4}    Success
    \    Append To List    ${file_ver_result}    @{file_ver_data_value1}    @{file_ver_data_value2}    @{file_ver_data_value3}    @{file_ver_data_value4}
    \    ${odd_number}=     Evaluate     ${odd_number}+2
    Log List    ${file_ver_result}

    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    :FOR    ${index}    IN RANGE    1    51
    \    ${index}=    Set Variable    ${index}
    \    ${data_1}=          Set Variable    @{data_value1_list}[${index}]
    \    ${data_2}=          Set Variable    @{data_value2_list}[${index}]
    \    ${data_3}=          Set Variable    @{data_value3_list}[${index}]
    \    ${data_4}=          Set Variable    @{data_value4_list}[${index}]
    \    ${expected_product_list}=    Create List    @{data_1}[1]    @{data_2}[1]    @{data_3}[1]    @{data_4}[1]
    \    Mass Upload Product to Category - Category Should Have Product(s)    @{cat_pkey_list}[${index}]    ${expected_product_list}

    [Teardown]    Run Keywords    Delete 51 Categories    ${cat_id_list}    AND    Close All Browsers

TC_ITMWM_05119 Mass upload to add product into category: Added multiple product to category over 200 records - fail
    [Tags]    TC_ITMWM_05119    ready
    ## Create Varaible List for FOR Loop
    #.. Category ID
    @{cat_id_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    52
    \    Append To List    ${cat_id_list}    cat_id_${index}
    #.. Category Pkey
    @{cat_pkey_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    52
    \    Append To List    ${cat_pkey_list}    cat_pkey_${index}
    #.. Data Value
    @{data_value1_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    52
    \    Append To List    ${data_value1_list}    data_value${index}-1
    @{data_value2_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    52
    \    Append To List    ${data_value2_list}    data_value${index}-2
    @{data_value3_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    52
    \    Append To List    ${data_value3_list}    data_value${index}-3
    @{data_value4_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    52
    \    Append To List    ${data_value4_list}    data_value${index}-4
    ########

    ${tc_number}=    Get Test Case Number
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    #.. CATEGORY 1-50
    :FOR    ${index}    IN RANGE    1    52
    \    ${index}=    Set Variable    ${index}
    \    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-${index}"
    \    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    \    ${response}=    Create Category    ${parent_id}    ${file_data}
    \    ${cat_id}=     Get Category ID After Creating
    \    ${cat_pkey}=     Get Category Pkey After Creating
    \    Set List Value    ${cat_id_list}    ${index}     ${cat_id}
    \    Set List Value    ${cat_pkey_list}    ${index}     ${cat_pkey}
    Log List    ${cat_id_list}
    Log List    ${cat_pkey_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data}=           Create List    ${data_name}
    :FOR    ${index}    IN RANGE    1    52
    \    ${index}=    Set Variable    ${index}
    \    @{data_value-1}=    Create List    @{cat_pkey_list}[${index}]    &{product-disc-1}[pkey]
    \    @{data_value-2}=    Create List    @{cat_pkey_list}[${index}]    &{product-disc-2}[pkey]
    \    @{data_value-3}=    Create List    @{cat_pkey_list}[${index}]    &{product-disc-3}[pkey]
    \    @{data_value-4}=    Create List    @{cat_pkey_list}[${index}]    &{product-disc-4}[pkey]
    \    Set List Value    ${data_value1_list}     ${index}     ${data_value-1}
    \    Set List Value    ${data_value2_list}     ${index}     ${data_value-2}
    \    Set List Value    ${data_value3_list}     ${index}     ${data_value-3}
    \    Set List Value    ${data_value4_list}     ${index}     ${data_value-4}
    \    Append To List    ${data}    @{data_value1_list}[${index}]    @{data_value2_list}[${index}]    @{data_value3_list}[${index}]    @{data_value4_list}[${index}]
    Log List    ${data}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    add
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button
    Sleep    10s
    # Mass Upload Product to Category - Wait Until Page Contains File Verification Table    60

    ##.. Provide message success with row number
    # ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    200
    # Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_success}
    Capture Page Screenshot

    ##.. Verify product under category via GET API
    :FOR    ${index}    IN RANGE    1    51
    \    ${index}=    Set Variable    ${index}
    \    ${expected_product_list}=    Create List
    \    Mass Upload Product to Category - Category Should Have Product(s)    @{cat_pkey_list}[${index}]    ${expected_product_list}

    [Teardown]    Run Keywords    Delete 51 Categories    ${cat_id_list}    AND    Close All Browsers

TC_ITMWM_05120 Mass upload to add product into category: Space in the field - success
    [Tags]    TC_ITMWM_05120    ready    phoenix
    ${tc_number}=    Get Test Case Number
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    #.. CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating
    ${cat_pkey_1}=     Get Category Pkey After Creating
    #.. CATEGORY 2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id_2}=     Get Category ID After Creating
    ${cat_pkey_2}=     Get Category Pkey After Creating

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key                     Product Key
    @{data_value1}=    Create List    ${cat_pkey_1}                    ${SPACE}&{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey_1}                    &{product-disc-2}[pkey]${SPACE}
    @{data_value3}=    Create List    ${cat_pkey_1}                    ${SPACE}&{product-disc-3}[pkey]${SPACE}
    @{data_value4}=    Create List    ${SPACE}${cat_pkey_2}            &{product-disc-1}[pkey]
    @{data_value5}=    Create List    ${cat_pkey_2}${SPACE}            ${SPACE}&{product-disc-2}[pkey]
    @{data_value6}=    Create List    ${SPACE}${cat_pkey_2}${SPACE}    &{product-disc-3}[pkey]
    @{data}=    Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}    ${data_value4}    ${data_value5}    ${data_value6}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    add
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    6
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_success}

    ##.. Provide file verification result
    ${after_trimmed}=     Strip String      @{data_value1}[1]
    Set List Value        ${data_value1}    1    ${after_trimmed}
    ${after_trimmed}=     Strip String      @{data_value2}[1]
    Set List Value        ${data_value2}    1    ${after_trimmed}
    ${after_trimmed}=     Strip String      @{data_value3}[1]
    Set List Value        ${data_value3}    1    ${after_trimmed}
    ${after_trimmed}=     Strip String      @{data_value4}[0]
    Set List Value        ${data_value4}    0    ${after_trimmed}
    ${after_trimmed}=     Strip String      @{data_value5}[0]
    Set List Value        ${data_value5}    0    ${after_trimmed}
    ${after_trimmed}=     Strip String      @{data_value5}[1]
    Set List Value        ${data_value5}    1    ${after_trimmed}
    ${after_trimmed}=     Strip String      @{data_value6}[0]
    Set List Value        ${data_value6}    0    ${after_trimmed}

    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Success
    @{file_ver_data_value2}=    Create List    3    @{data_value2}    Success
    @{file_ver_data_value3}=    Create List    4    @{data_value3}    Success
    @{file_ver_data_value4}=    Create List    5    @{data_value4}    Success
    @{file_ver_data_value5}=    Create List    6    @{data_value5}    Success
    @{file_ver_data_value6}=    Create List    7    @{data_value6}    Success
    @{file_ver_result}=         Create List    @{file_ver_data_value1}    @{file_ver_data_value2}    @{file_ver_data_value3}    @{file_ver_data_value4}    @{file_ver_data_value5}    @{file_ver_data_value6}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List    @{data_value1}[1]    @{data_value2}[1]    @{data_value3}[1]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey_1}    ${expected_product_list}

    ${expected_product_list}=    Create List    @{data_value4}[1]    @{data_value5}[1]    @{data_value6}[1]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey_2}    ${expected_product_list}

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}\
   ...    AND    Run keyword If    "${cat_id_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2}\
   ...    AND    Close All Browsers

TC_ITMWM_05121 Mass upload to add product into category: Product key not exist in system/ Product key deleted - fail
    [Tags]    TC_ITMWM_05121    ready    phoenix
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       ${DELETED-PRODUCT}
    @{data_value2}=    Create List    ${cat_pkey}       ${NOT-EXISED-PRODUCT}
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    add
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    2
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_fail}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Invalid Product Key
    @{file_ver_data_value2}=    Create List    3    @{data_value2}    Invalid Product Key
    @{file_ver_result}=         Create List    @{file_ver_data_value1}    @{file_ver_data_value2}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey}    ${expected_product_list}

TC_ITMWM_05122 Mass upload to add product into category: Category key not exist in system/ Category key deleted - fail
    [Tags]    TC_ITMWM_05122    ready    phoenix
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=     Get Category ID After Creating
    ${cat_pkey_1}=     Get Category Pkey After Creating
    ${cat_pkey_2}=     Evaluate    ${cat_pkey_1} + 100
    #.. Delete category
    Delete Category By Category ID    ${cat_id}
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey_1}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey_2}       &{product-disc-2}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    add
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    2
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_fail}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Invalid Category Key
    @{file_ver_data_value2}=    Create List    3    @{data_value2}    Invalid Category Key
    @{file_ver_result}=         Create List    @{file_ver_data_value1}    @{file_ver_data_value2}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    #Call API for check existing deleted cate
    ${response}=    Get Category By Category ID    ${cat_id}
    Verify Fail Response Status Code and Message    404    error    Not found category

TC_ITMWM_05123 Mass upload to add product into category: empty row - Fail
    [Tags]    TC_ITMWM_05123    ready    phoenix
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key      Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${EMPTY}          ${EMPTY}
    @{data_value3}=    Create List    ${cat_pkey}       &{product-disc-2}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    add
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_fail}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    3    ${EMPTY}    ${EMPTY}    Missing Category Key / Missing Product Key
    @{file_ver_result}=         Create List    @{file_ver_data_value1}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey}    ${expected_product_list}

TC_ITMWM_05124 Mass upload to add product into category: not input product key - Fail
    [Tags]    TC_ITMWM_05124    ready    phoenix
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey}       ${EMPTY}
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    add
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_fail}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    3    @{data_value2}    Missing Product Key
    @{file_ver_result}=         Create List    @{file_ver_data_value1}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey}    ${expected_product_list}

TC_ITMWM_05125 Mass upload to add product into category: not input category key - Fail
    [Tags]    TC_ITMWM_05125    ready    phoenix
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key      Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${EMPTY}          ,&{product-disc-1}[pkey]
    @{data_value3}=    Create List    ${EMPTY}          &{product-disc-2}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    add
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    2
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_fail}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    3    ${EMPTY}    &{product-disc-1}[pkey]    Missing Category Key
    @{file_ver_data_value2}=    Create List    4    &{product-disc-2}[pkey]    ${EMPTY}    Invalid Category Key / Missing Product Key
    @{file_ver_result}=         Create List    @{file_ver_data_value1}    @{file_ver_data_value2}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey}    ${expected_product_list}

TC_ITMWM_05126 Mass upload to add product into category: input product key and category key duplicate - Fail
    [Tags]    TC_ITMWM_05126    ready    phoenix
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    add
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    2
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_success}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Success
    @{file_ver_data_value2}=    Create List    3    @{data_value2}    Success
    @{file_ver_result}=         Create List    @{file_ver_data_value1}    @{file_ver_data_value2}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List    @{data_value1}[1]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey}    ${expected_product_list}

TC_ITMWM_05128 Mass upload to replace product into category: Replace existing product into category via mass upload - success
    [Tags]    TC_ITMWM_05128    regression    ready    phoenix    WLS_Medium
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    #.. Add product to category
    @{response}=    Add Products To Categories    ${file_upload}
    Should Be Equal As Integers    200    @{response}[0]

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    replace
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    1
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_success}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Success
    @{file_ver_result}=         Create List    @{file_ver_data_value1}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List    @{data_value1}[1]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey}    ${expected_product_list}

TC_ITMWM_05129 Mass upload to replace product into category: Replace existing product and add product into category via mass upload - success
    [Tags]    TC_ITMWM_05129    regression    ready    phoenix    WLS_High
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    #.. Add product to category
    @{response}=    Add Products To Categories    ${file_upload}
    Should Be Equal As Integers    200    @{response}[0]

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey}       &{product-disc-2}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    replace
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    2
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_success}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Success
    @{file_ver_data_value2}=    Create List    3    @{data_value2}    Success
    @{file_ver_result}=         Create List    @{file_ver_data_value1}    @{file_ver_data_value2}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List    @{data_value1}[1]    @{data_value2}[1]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey}    ${expected_product_list}

TC_ITMWM_05130 Mass upload to replace product into category: Replace and delete existing product into category via mass upload - success
    [Tags]    TC_ITMWM_05130    regression    ready    phoenix    WLS_Medium
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey}       &{product-disc-2}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    #.. Add product to category
    @{response}=    Add Products To Categories    ${file_upload}
    Should Be Equal As Integers    200    @{response}[0]

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    replace
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    1
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_success}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Success
    @{file_ver_result}=         Create List    @{file_ver_data_value1}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List    @{data_value1}[1]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey}    ${expected_product_list}

TC_ITMWM_05131 Mass upload to replace product into category: Replace and add multiple existing products to multiple categories - success
    [Tags]    TC_ITMWM_05131    regression    ready    phoenix    WLS_High
    ${tc_number}=    Get Test Case Number
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    #.. CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating
    ${cat_pkey_1}=     Get Category Pkey After Creating
    #.. CATEGORY 2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id_2}=     Get Category ID After Creating
    ${cat_pkey_2}=     Get Category Pkey After Creating

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey_1}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey_2}       &{product-disc-2}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #.. Add product to category
    @{response}=    Add Products To Categories    ${file_upload}
    Should Be Equal As Integers    200    @{response}[0]

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey_1}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey_1}       &{product-disc-2}[pkey]
    @{data_value3}=    Create List    ${cat_pkey_2}       &{product-disc-1}[pkey]
    @{data_value4}=    Create List    ${cat_pkey_2}       &{product-disc-2}[pkey]
    @{data_value5}=    Create List    ${cat_pkey_2}       &{product-disc-3}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}    ${data_value4}    ${data_value5}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    replace
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    5
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_success}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Success
    @{file_ver_data_value2}=    Create List    3    @{data_value2}    Success
    @{file_ver_data_value3}=    Create List    4    @{data_value3}    Success
    @{file_ver_data_value4}=    Create List    5    @{data_value4}    Success
    @{file_ver_data_value5}=    Create List    6    @{data_value5}    Success
    @{file_ver_result}=         Create List    @{file_ver_data_value1}    @{file_ver_data_value2}    @{file_ver_data_value3}    @{file_ver_data_value4}    @{file_ver_data_value5}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List    @{data_value1}[1]    @{data_value2}[1]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey_1}    ${expected_product_list}

    ${expected_product_list}=    Create List    @{data_value3}[1]    @{data_value4}[1]    @{data_value5}[1]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey_2}    ${expected_product_list}

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}\
   ...    AND    Run keyword If    "${cat_id_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2}\
   ...    AND    Close All Browsers

TC_ITMWM_05132 Mass upload to replace product into category: Replace multiple product to category 200 records - success
    [Tags]    TC_ITMWM_05132    ready
    ## Create Varaible List for FOR Loop
    #.. Category ID
    @{cat_id_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    51
    \    Append To List    ${cat_id_list}    cat_id_${index}
    #.. Category Pkey
    @{cat_pkey_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    51
    \    Append To List    ${cat_pkey_list}    cat_pkey_${index}
    #.. Data Value
    @{data_value1_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    51
    \    Append To List    ${data_value1_list}    data_value${index}-1
    @{data_value2_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    51
    \    Append To List    ${data_value2_list}    data_value${index}-2
    @{data_value3_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    51
    \    Append To List    ${data_value3_list}    data_value${index}-3
    @{data_value4_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    51
    \    Append To List    ${data_value4_list}    data_value${index}-4
    ########

    ${tc_number}=    Get Test Case Number
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    #.. CATEGORY 1-50
    :FOR    ${index}    IN RANGE    1    51
    \    ${index}=    Set Variable    ${index}
    \    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-${index}"
    \    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    \    ${response}=    Create Category    ${parent_id}    ${file_data}
    \    ${cat_id}=     Get Category ID After Creating
    \    ${cat_pkey}=     Get Category Pkey After Creating
    \    Set List Value    ${cat_id_list}    ${index}     ${cat_id}
    \    Set List Value    ${cat_pkey_list}    ${index}     ${cat_pkey}
    Log List    ${cat_id_list}
    Log List    ${cat_pkey_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data}=           Create List    ${data_name}
    :FOR    ${index}    IN RANGE    1    51
    \    ${index}=    Set Variable    ${index}
    \    @{data_value-1}=    Create List    @{cat_pkey_list}[${index}]    &{product-disc-1}[pkey]
    \    @{data_value-2}=    Create List    @{cat_pkey_list}[${index}]    &{product-disc-2}[pkey]
    \    @{data_value-3}=    Create List    @{cat_pkey_list}[${index}]    &{product-disc-3}[pkey]
    \    @{data_value-4}=    Create List    @{cat_pkey_list}[${index}]    &{product-disc-4}[pkey]
    \    Set List Value    ${data_value1_list}     ${index}     ${data_value-1}
    \    Set List Value    ${data_value2_list}     ${index}     ${data_value-2}
    \    Set List Value    ${data_value3_list}     ${index}     ${data_value-3}
    \    Set List Value    ${data_value4_list}     ${index}     ${data_value-4}
    \    Append To List    ${data}    @{data_value1_list}[${index}]    @{data_value2_list}[${index}]    @{data_value3_list}[${index}]    @{data_value4_list}[${index}]
    Log List    ${data}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    replace
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button
    Mass Upload Product to Category - Wait Until Page Contains File Verification Table    60

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    200
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_success}

    ##.. Provide file verification result
    @{file_ver_result}=    Create List
    ${loop_number}=    Set Variable    0
    ${odd_number}=     Set Variable    1
    :FOR    ${index}    IN RANGE    4    201    4
    \    ${loop_number}=     Evaluate    ${loop_number}+1
    #.. row number in csv file
    \    ${row_number_1}=    Evaluate    (${odd_number}*2)
    \    ${row_number_2}=    Evaluate    (${odd_number}*2)+1
    \    ${row_number_3}=    Evaluate    (${odd_number}*2)+2
    \    ${row_number_4}=    Evaluate    (${odd_number}*2)+3
    \    ${data_1}=          Set Variable    @{data_value1_list}[${loop_number}]
    \    ${data_2}=          Set Variable    @{data_value2_list}[${loop_number}]
    \    ${data_3}=          Set Variable    @{data_value3_list}[${loop_number}]
    \    ${data_4}=          Set Variable    @{data_value4_list}[${loop_number}]
    \    @{file_ver_data_value1}=    Create List    ${row_number_1}    @{data_1}    Success
    \    @{file_ver_data_value2}=    Create List    ${row_number_2}    @{data_2}    Success
    \    @{file_ver_data_value3}=    Create List    ${row_number_3}    @{data_3}    Success
    \    @{file_ver_data_value4}=    Create List    ${row_number_4}    @{data_4}    Success
    \    Append To List    ${file_ver_result}    @{file_ver_data_value1}    @{file_ver_data_value2}    @{file_ver_data_value3}    @{file_ver_data_value4}
    \    ${odd_number}=     Evaluate     ${odd_number}+2
    Log List    ${file_ver_result}

    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    :FOR    ${index}    IN RANGE    1    51
    \    ${index}=    Set Variable    ${index}
    \    ${data_1}=          Set Variable    @{data_value1_list}[${index}]
    \    ${data_2}=          Set Variable    @{data_value2_list}[${index}]
    \    ${data_3}=          Set Variable    @{data_value3_list}[${index}]
    \    ${data_4}=          Set Variable    @{data_value4_list}[${index}]
    \    ${expected_product_list}=    Create List    @{data_1}[1]    @{data_2}[1]    @{data_3}[1]    @{data_4}[1]
    \    Mass Upload Product to Category - Category Should Have Product(s)    @{cat_pkey_list}[${index}]    ${expected_product_list}

    [Teardown]    Run Keywords    Delete 51 Categories    ${cat_id_list}    AND    Close All Browsers


TC_ITMWM_05133 Mass upload to replace product into category: Replace multiple product to category over 200 records - fail
    [Tags]    TC_ITMWM_05133    ready
    ## Create Varaible List for FOR Loop
    #.. Category ID
    @{cat_id_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    52
    \    Append To List    ${cat_id_list}    cat_id_${index}
    #.. Category Pkey
    @{cat_pkey_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    52
    \    Append To List    ${cat_pkey_list}    cat_pkey_${index}
    #.. Data Value
    @{data_value1_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    52
    \    Append To List    ${data_value1_list}    data_value${index}-1
    @{data_value2_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    52
    \    Append To List    ${data_value2_list}    data_value${index}-2
    @{data_value3_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    52
    \    Append To List    ${data_value3_list}    data_value${index}-3
    @{data_value4_list}=    Create List    DummyIndex
    :FOR    ${index}    IN RANGE    1    52
    \    Append To List    ${data_value4_list}    data_value${index}-4
    ########

    ${tc_number}=    Get Test Case Number
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    #.. CATEGORY 1-50
    :FOR    ${index}    IN RANGE    1    52
    \    ${index}=    Set Variable    ${index}
    \    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-${index}"
    \    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    \    ${response}=    Create Category    ${parent_id}    ${file_data}
    \    ${cat_id}=     Get Category ID After Creating
    \    ${cat_pkey}=     Get Category Pkey After Creating
    \    Set List Value    ${cat_id_list}    ${index}     ${cat_id}
    \    Set List Value    ${cat_pkey_list}    ${index}     ${cat_pkey}
    Log List    ${cat_id_list}
    Log List    ${cat_pkey_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data}=           Create List    ${data_name}
    :FOR    ${index}    IN RANGE    1    52
    \    ${index}=    Set Variable    ${index}
    \    @{data_value-1}=    Create List    @{cat_pkey_list}[${index}]    &{product-disc-1}[pkey]
    \    @{data_value-2}=    Create List    @{cat_pkey_list}[${index}]    &{product-disc-2}[pkey]
    \    @{data_value-3}=    Create List    @{cat_pkey_list}[${index}]    &{product-disc-3}[pkey]
    \    @{data_value-4}=    Create List    @{cat_pkey_list}[${index}]    &{product-disc-4}[pkey]
    \    Set List Value    ${data_value1_list}     ${index}     ${data_value-1}
    \    Set List Value    ${data_value2_list}     ${index}     ${data_value-2}
    \    Set List Value    ${data_value3_list}     ${index}     ${data_value-3}
    \    Set List Value    ${data_value4_list}     ${index}     ${data_value-4}
    \    Append To List    ${data}    @{data_value1_list}[${index}]    @{data_value2_list}[${index}]    @{data_value3_list}[${index}]    @{data_value4_list}[${index}]
    Log List    ${data}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    replace
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button
    Sleep    10s
    # Mass Upload Product to Category - Wait Until Page Contains File Verification Table    60

    ##.. Provide message success with row number
    # ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    200
    # Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_success}
    Capture Page Screenshot

    ##.. Verify product under category via GET API
    :FOR    ${index}    IN RANGE    1    51
    \    ${index}=    Set Variable    ${index}
    \    ${expected_product_list}=    Create List
    \    Mass Upload Product to Category - Category Should Have Product(s)    @{cat_pkey_list}[${index}]    ${expected_product_list}

    [Teardown]    Run Keywords    Delete 51 Categories    ${cat_id_list}    AND    Close All Browsers


TC_ITMWM_05134 Mass upload to replace product into category: Space in the field - success
    [Tags]    TC_ITMWM_05134    ready    phoenix
    ${tc_number}=    Get Test Case Number
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    #.. CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating
    ${cat_pkey_1}=     Get Category Pkey After Creating
    #.. CATEGORY 2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id_2}=     Get Category ID After Creating
    ${cat_pkey_2}=     Get Category Pkey After Creating

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey_1}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey_2}       &{product-disc-2}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #.. Add product to category
    @{response}=    Add Products To Categories    ${file_upload}
    Should Be Equal As Integers    200    @{response}[0]

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key                     Product Key
    @{data_value1}=    Create List    ${cat_pkey_1}                    ${SPACE}&{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey_1}                    &{product-disc-2}[pkey]${SPACE}
    @{data_value3}=    Create List    ${cat_pkey_1}                    ${SPACE}&{product-disc-3}[pkey]${SPACE}
    @{data_value4}=    Create List    ${SPACE}${cat_pkey_2}            &{product-disc-1}[pkey]
    @{data_value5}=    Create List    ${cat_pkey_2}${SPACE}            ${SPACE}&{product-disc-2}[pkey]
    @{data_value6}=    Create List    ${SPACE}${cat_pkey_2}${SPACE}    &{product-disc-3}[pkey]
    @{data}=    Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}    ${data_value4}    ${data_value5}    ${data_value6}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    replace
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    6
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_success}

    ##.. Provide file verification result
    ${after_trimmed}=     Strip String      @{data_value1}[1]
    Set List Value        ${data_value1}    1    ${after_trimmed}
    ${after_trimmed}=     Strip String      @{data_value2}[1]
    Set List Value        ${data_value2}    1    ${after_trimmed}
    ${after_trimmed}=     Strip String      @{data_value3}[1]
    Set List Value        ${data_value3}    1    ${after_trimmed}
    ${after_trimmed}=     Strip String      @{data_value4}[0]
    Set List Value        ${data_value4}    0    ${after_trimmed}
    ${after_trimmed}=     Strip String      @{data_value5}[0]
    Set List Value        ${data_value5}    0    ${after_trimmed}
    ${after_trimmed}=     Strip String      @{data_value5}[1]
    Set List Value        ${data_value5}    1    ${after_trimmed}
    ${after_trimmed}=     Strip String      @{data_value6}[0]
    Set List Value        ${data_value6}    0    ${after_trimmed}

    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Success
    @{file_ver_data_value2}=    Create List    3    @{data_value2}    Success
    @{file_ver_data_value3}=    Create List    4    @{data_value3}    Success
    @{file_ver_data_value4}=    Create List    5    @{data_value4}    Success
    @{file_ver_data_value5}=    Create List    6    @{data_value5}    Success
    @{file_ver_data_value6}=    Create List    7    @{data_value6}    Success
    @{file_ver_result}=         Create List    @{file_ver_data_value1}    @{file_ver_data_value2}    @{file_ver_data_value3}    @{file_ver_data_value4}    @{file_ver_data_value5}    @{file_ver_data_value6}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List    @{data_value1}[1]    @{data_value2}[1]    @{data_value3}[1]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey_1}    ${expected_product_list}

    ${expected_product_list}=    Create List    @{data_value4}[1]    @{data_value5}[1]    @{data_value6}[1]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey_2}    ${expected_product_list}

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}\
   ...    AND    Run keyword If    "${cat_id_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2}\
   ...    AND    Close All Browsers

TC_ITMWM_05135 Mass upload to replace product into category: Product key not exist in system/ Product key deleted - fail
    [Tags]    TC_ITMWM_05135    ready    phoenix
    ##.. Still run fail ....
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    #.. Add product to category
    @{response}=    Add Products To Categories    ${file_upload}
    Should Be Equal As Integers    200    @{response}[0]

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       ${DELETED-PRODUCT}
    @{data_value2}=    Create List    ${cat_pkey}       ${NOT-EXISED-PRODUCT}
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    replace
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    2
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_fail}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Invalid Product Key
    @{file_ver_data_value2}=    Create List    3    @{data_value2}    Invalid Product Key
    @{file_ver_result}=         Create List    @{file_ver_data_value1}    @{file_ver_data_value2}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List    &{product-disc-1}[pkey]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey}    ${expected_product_list}

TC_ITMWM_05136 Mass upload to replace product into category: Category key not exist in system/ Category key deleted - fail
    [Tags]    TC_ITMWM_05136    ready    phoenix
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=     Get Category ID After Creating
    ${cat_pkey_1}=     Get Category Pkey After Creating
    ${cat_pkey_2}=     Evaluate    ${cat_pkey_1} + 100

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key     Product Key
    @{data_value1}=    Create List    ${cat_pkey_1}    &{product-disc-1}[pkey]
    @{data}=           Create List    ${data_name}     ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    #.. Add product to category
    @{response}=    Add Products To Categories    ${file_upload}
    Should Be Equal As Integers    200    @{response}[0]

    #.. Delete category
    Delete Category By Category ID    ${cat_id}
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey_1}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey_2}       &{product-disc-2}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    replace
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    2
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_fail}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Invalid Category Key
    @{file_ver_data_value2}=    Create List    3    @{data_value2}    Invalid Category Key
    @{file_ver_result}=         Create List    @{file_ver_data_value1}    @{file_ver_data_value2}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    #Call API for check existing deleted cate
    ${response}=    Get Category By Category ID    ${cat_id}
    Verify Fail Response Status Code and Message    404    error    Not found category

TC_ITMWM_05137 Mass upload to replace product into category: empty row - Fail
    [Tags]    TC_ITMWM_05137    ready    phoenix
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    #.. Add product to category
    @{response}=    Add Products To Categories    ${file_upload}
    Should Be Equal As Integers    200    @{response}[0]

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key      Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${EMPTY}          ${EMPTY}
    @{data_value3}=    Create List    ${cat_pkey}       &{product-disc-2}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    replace
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_fail}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    3    ${EMPTY}    ${EMPTY}    Missing Category Key / Missing Product Key
    @{file_ver_result}=         Create List    @{file_ver_data_value1}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List    &{product-disc-1}[pkey]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey}    ${expected_product_list}

TC_ITMWM_05138 Mass upload to replace product into category: not input product key - Fail
    [Tags]    TC_ITMWM_05138    ready    phoenix
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    #.. Add product to category
    @{response}=    Add Products To Categories    ${file_upload}
    Should Be Equal As Integers    200    @{response}[0]

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey}       ${EMPTY}
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    replace
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_fail}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    3    @{data_value2}    Missing Product Key
    @{file_ver_result}=         Create List    @{file_ver_data_value1}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List    &{product-disc-1}[pkey]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey}    ${expected_product_list}

TC_ITMWM_05139 Mass upload to replace product into category: not input category key - Fail
    [Tags]    TC_ITMWM_05139    ready    phoenix
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    #.. Add product to category
    @{response}=    Add Products To Categories    ${file_upload}
    Should Be Equal As Integers    200    @{response}[0]

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key      Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${EMPTY}          ,&{product-disc-1}[pkey]
    @{data_value3}=    Create List    ${EMPTY}          &{product-disc-2}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    replace
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    2
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_fail}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    3    ${EMPTY}    &{product-disc-1}[pkey]    Missing Category Key
    @{file_ver_data_value2}=    Create List    4    &{product-disc-2}[pkey]    ${EMPTY}    Invalid Category Key / Missing Product Key
    @{file_ver_result}=         Create List    @{file_ver_data_value1}    @{file_ver_data_value2}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List    &{product-disc-1}[pkey]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey}    ${expected_product_list}

TC_ITMWM_05140 Mass upload to add product into category: input product key and category key duplicate - Fail
    [Tags]    TC_ITMWM_05140    ready    phoenix
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    #.. Add product to category
    @{response}=    Add Products To Categories    ${file_upload}
    Should Be Equal As Integers    200    @{response}[0]

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    replace
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    2
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_success}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Success
    @{file_ver_data_value2}=    Create List    3    @{data_value2}    Success
    @{file_ver_result}=         Create List    @{file_ver_data_value1}    @{file_ver_data_value2}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List    @{data_value1}[1]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey}    ${expected_product_list}

TC_ITMWM_05127 Mass upload but not select action - Fail
    [Tags]    TC_ITMWM_05127    regression    ready    phoenix    WLS_Medium
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    1111111111       &{product-disc-1}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}

    ##.. Verify upload action alert result
    Mass Upload Product to Category - Verify Alert For Upload Action and File Result    ${message_alert_upload_action}

TC_ITMWM_05141 Mass upload but not choose any file - Fail
    [Tags]    TC_ITMWM_05141    regression    ready    phoenix    WLS_Medium
    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    add
    Mass Upload Product to Category - Click Upload Button

    ##.. Verify upload action alert result
    Mass Upload Product to Category - Verify Alert For Upload Action and File Result    ${message_alert_choose_file}

TC_ITMWM_0xxxx Mass upload not select action and not choose any file - Fail
    [Tags]    TC_ITMWM_0xxxx    ready    phoenix
    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Click Upload Button

    ##.. Verify upload action alert result
    Mass Upload Product to Category - Verify Alert For Upload Action and File Result    ${message_alert_upload_action_and_file}


*** Keywords ***
Delete 51 Categories
    [Arguments]    ${cat_id_list}
    :FOR    ${index}    IN RANGE    1    52
    \    ${index}=    Set Variable    ${index}
    \    Run keyword If    "@{cat_id_list}[${index}]" != "${EMPTY}"    Permanent Delete Category By Category ID    @{cat_id_list}[${index}]
    \    ...    ELSE    Exit For Loop