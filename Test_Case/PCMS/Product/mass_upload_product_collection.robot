*** Settings ***
Library           Selenium2Library
Resource          ${CURDIR}/../../../Resource/Init.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Product/Create_Product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Mass_upload_product_collection/keywords_mass_upload_product_collection.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_c_page/keyword_level_c.robot

Test Setup        Login Pcms
Test Teardown     Close All Browsers

*** Variables ***
${level1_collection_pkey}     1122334455
${level2_collection_pkey}     11223344551
${result_header_fail}         Error(s) found. Please re-check your file and try to upload again.
${message_missing_collection_key}    Missing Collection Key
${message_missing_collection_key_and_invalid_product_key}    Missing Collection Key / Invalid Product Key
${invalid_product_key}        Invalid Product Key
${invalid_collection_key}     Invalid Collection Key
${empty_row}                  Please remove empty row
${message_success}            Mass upload completed. 2 row(s) processed.
${product_name_retail}        Product For flash Test Automate retail5

*** Test Cases ***
TC_iTM_02488 Mass upload product collections - Success
    [Documentation]    To verify that the upload product to collections via mass upload successfully.
    [Tags]     TC_iTM_02488    ready    Mass_Upload_Product_Collection    flash
    ${level1_collection_pkey}=    Set Variable    1122334455
    ${level2_collection_pkey}=    Set Variable    11223344551

    ${level1_collection_id}=    Create collection level1 for mass upload    0    ${level1_collection_pkey}
    ${level2_collection_id}=    Create collection level2 for mass upload    ${level1_collection_id}    ${level2_collection_pkey}
    ${product1_pkey}=       Insert product with retail type
    ${product2_pkey}=       Insert product with marketplace type

    @{data_name}=       Create List     Product Key         Collection Key
    @{data_value1}=     Create List     ${product1_pkey}    ${level2_collection_pkey}
    @{data_value2}=     Create List     ${product2_pkey}    ${level2_collection_pkey}
    @{data}=            Create List     ${data_name}        ${data_value1}      ${data_value2}
    Log To Console     data mass=${data}
    ${path_file}=      Set product key and collection key in file csv product collection     ${data}
    Log To Console     path_file::${path_file}
    ${file_upload}=       common.Get Canonical Path    ${path_file}

    Log To Console     file_upload::${file_upload}

    ${filename}=    Get file name from canonical path    ${file_upload}

    Log to console    filename::${filename}

    Go to mass upload product collection menu
    User browse file for mass upload product collection     ${file_upload}
    Mass upload product collection - Message success is displayed    ${message_success}
    Click back button
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}
    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}
    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Log To Console    user=${username_in_history}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Delete user after upload success    ${username_in_history}    ${filename}

    Open ITM level C Web With URI     /category/${level2_collection_pkey}.html
    level C page - Display products under category     ${product_name_retail}     Product For flash Test Automate merket place5

TC_iTM_02490 Space in the field - Success
    [Tags]     TC_iTM_02490    ready    Mass_Upload_Product_Collection    flash
    ${level1_collection_pkey}=    Set Variable    1122334455
    ${level2_collection_pkey}=    Set Variable    11223344551

    ${level1_collection_id}=    Create collection level1 for mass upload    0    ${level1_collection_pkey}
    ${level2_collection_id}=    Create collection level2 for mass upload    ${level1_collection_id}    ${level2_collection_pkey}
    ${product1_pkey}=       Insert product with retail type
    ${product2_pkey}=       Insert product with marketplace type

    ${product1_pkey_space}=    Catenate    ${product1_pkey}    ${EMPTY}
    ${product2_pkey_space}=    Catenate    ${product2_pkey}    ${EMPTY}
    ${space_level2_collection_pkey}=    Catenate    ${EMPTY}    ${level2_collection_pkey}

    Log to console    product1_pkey_space::${product1_pkey_space}
    Log to console    product2_pkey_space::${product2_pkey_space}
    Log to console    space_level2_collection_pkey::${space_level2_collection_pkey}

    @{data_name}=       Create List     Product Key         Collection Key
    @{data_value1}=     Create List     ${product1_pkey_space}    ${space_level2_collection_pkey}
    @{data_value2}=     Create List     ${product2_pkey_space}    ${space_level2_collection_pkey}
    @{data}=            Create List     ${data_name}        ${data_value1}      ${data_value2}
    Log To Console     ${data}
    ${path_file}=      Set product key and collection key in file csv product collection     ${data}
    Log To Console     path_file::${path_file}
    ${file_upload}=       common.Get Canonical Path    ${path_file}

    Log To Console     file_upload::${file_upload}

    ${filename}=    Get file name from canonical path    ${file_upload}

    Log to console    filename::${filename}

    Go to mass upload product collection menu
    User browse file for mass upload product collection     ${file_upload}
    Mass upload product collection - Message success is displayed    ${message_success}
    Click back button
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}
    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}
    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Log To Console    user=${username_in_history}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Delete user after upload success    ${username_in_history}    ${filename}

    Open ITM level C Web With URI     /category/${level2_collection_pkey}.html
    level C page - Display products under category     ${product_name_retail}     Product For flash Test Automate merket place5

TC_iTM_02491 Download templete mass upload - Success
    [Tags]    TC_iTM_02491    Mass_Upload_Product_Collection    ready    flash
    Go to mass upload product collection menu
    ${filename}=    User download template
    Check template is correctly    ${filename}


TC_iTM_02492 Upload product to collection deleted in system - Fail
    [Tags]    TC_iTM_02492    Mass_Upload_Product_Collection    ready    flash
    ${message_invalid_product_key}=     Set Variable     Invalid Collection Key
    ${row}=     Set Variable    1
    ${product_key}=       Insert product with retail type
    ${collection_key}=    Get collection key delete at
    Log To Console    collection pkey=${collection_key}

    @{data_name}=       Create List     Product Key    Collection Key
    @{data_value1}=     Create List     ${product_key}    ${collection_key}
    @{data}=     Create List     ${data_name}     ${data_value1}
    Log To Console   data list=${data}

    ${path_file}=      Set product key and collection key in file csv product collection     ${data}
    # Log To Console     path file=${path_file}
    # ${file_upload}=       common.Get Canonical Path    ${path_file}

    Go to mass upload product collection menu
    User browse file for mass upload product collection     ${path_file}
    Mass upload product collection - Error message is displayed when upload fail    1 ${result_header_fail}
    ${data_fail}=    Mass upload product collection - Get result in file verification table
    Verify result when upload product collection is fail    ${product_key}    ${collection_key}
    ...    ${message_invalid_product_key}    ${row}    ${data_fail}


TC_iTM_02493 User does not input Product Key
    [Documentation]    To verify that the upload product to collections via mass upload successfully.
    [Tags]    TC_iTM_02493    ready    Mass_Upload_Product_Collection    flash
    ${row}=                       Set Variable    1
    ${level1_collection_pkey}=    Set Variable    1122334455
    ${level2_collection_pkey}=    Set Variable    11223344551

    ${level1_collection_id}=    Create collection level1 for mass upload    0    ${level1_collection_pkey}
    ${level2_collection_id}=    Create collection level2 for mass upload    ${level1_collection_id}    ${level2_collection_pkey}


    ${blank_product_pkey}=    Set Variable
    ${product_key_string_blank}=    Convert To String    ${blank_product_pkey}

    @{data_name}=       Create List     Product Key                    Collection Key
    @{data_value1}=     Create List     ${product_key_string_blank}    ${level2_collection_id}
    @{data}=            Create List     ${data_name}     ${data_value1}
    # Log To Console     ${data}
    ${path_file}=       Set product key and collection key in file csv product collection     ${data}
    # Log To Console     ${path_file}
    # ${file_upload}=       common.Get Canonical Path    ${path_file}

    Go to mass upload product collection menu
    User browse file for mass upload product collection     ${path_file}
    Mass upload product collection - Error message is displayed when upload fail    1 ${result_header_fail}
    ${data_fail}=    Mass upload product collection - Get result in file verification table
    Verify result when upload product collection is fail    ${level2_collection_id}    ${product_key_string_blank}
    ...    ${message_missing_collection_key_and_invalid_product_key}    ${row}    ${data_fail}

TC_iTM_02494 User does not input collection key - Fail
    [Tags]    TC_iTM_02494    Mass_Upload_Product_Collection    ready    flash
    ${row}=    Set Variable    1

    ${product_key}=         Get product key is publish status
    ${collection_blank}=     Set Variable
    ${collection_string_blank}=    Convert To String    ${collection_blank}
    @{data_name}=       Create List     Product Key    Collection Key
    @{data_value1}=     Create List     ${product_key}    ${collection_string_blank}
    @{data}=            Create List     ${data_name}     ${data_value1}
    Log To Console    data=${data}

    ${path_file}=      Set product key and collection key in file csv product collection     ${data}
    Log To Console    path=${path_file}

    Go to mass upload product collection menu
    User browse file for mass upload product collection     ${path_file}
    Mass upload product collection - Error message is displayed when upload fail    1 ${result_header_fail}
    ${data_fail}=    Mass upload product collection - Get result in file verification table
    Verify result when upload product collection is fail    ${product_key}    ${collection_string_blank}
    ...    ${message_missing_collection_key}    ${row}    ${data_fail}

TC_iTM_02495 Blank row in the input csv - Fail
    [Tags]     TC_iTM_02495    Mass_Upload_Product_Collection    ready    flash
    ${row}=    Set Variable    2
    #create data in csv file
    ${product_pkey}=         Get product key is publish status
    ${collection_key}=       Get collection key was displayed on web
    ${collection_blank}=     Set Variable
    ${collection_string_blank}=    Convert To String    ${collection_blank}
    ${product_blank}=        Set Variable
    ${product_string_blank}=    Convert To String    ${product_blank}
    @{data_name}=       Create List     Product Key    Collection Key
    @{data_value1}=     Create List     ${product_pkey}    ${collection_key}
    @{data_value2}=     Create List     ${product_string_blank}    ${collection_string_blank}
    @{data_value3}=     Create List     ${product_pkey}    ${collection_key}
    @{data}=            Create List     ${data_name}     ${data_value1}    ${data_value2}     ${data_value3}
    # Log To Console    data=${data}

    ${path_file}=      Set product key and collection key in file csv product collection     ${data}
    #Log To Console    path=${path_file}

    Go to mass upload product collection menu
    User browse file for mass upload product collection     ${path_file}
    Mass upload product collection - Error message is displayed when upload fail    1 ${result_header_fail}
    ${message}=    Mass upload product collection - Get result in file verification table
    Verify result when upload product collection is fail    ${product_string_blank}    ${collection_string_blank}
    ...    ${empty_row}    ${row}    ${message}

TC_iTM_02496 Product id not exist in system - Fail
    [Tags]    TC_iTM_02496    Mass_Upload_Product_Collection    ready    flash
    ${row}=    Set Variable    1
    ${product_key}=    Set Variable    1234567890
    ${collection_key}=       Get collection key was displayed on web
    @{data_name}=       Create List     Product Key    Collection Key
    @{data_value1}=     Create List     ${product_key}    ${collection_key}
    @{data}=            Create List     ${data_name}       ${data_value1}
    Log To Console    data=${data}

    ${path_file}=      Set product key and collection key in file csv product collection     ${data}
    Go to mass upload product collection menu
    User browse file for mass upload product collection     ${path_file}
    Mass upload product collection - Error message is displayed when upload fail    1 ${result_header_fail}
    ${message}=    Mass upload product collection - Get result in file verification table
    Log To Console    message=${message}
    Verify result when upload product collection is fail    ${product_key}    ${collection_key}
    ...    ${invalid_product_key}    ${row}    ${message}

TC_iTM_02497 Collection id not exist in system - Fail
    [Tags]    TC_iTM_02497    Mass_Upload_Product_Collection    ready    flash
    ${row}=    Set Variable    1
    ${product_key}=       Get product key is publish status
    ${collection_key}=    Set Variable    345678901234
    @{data_name}=       Create List     Product Key    Collection Key
    @{data_value1}=     Create List     ${product_key}    ${collection_key}
    @{data}=            Create List     ${data_name}       ${data_value1}
    Log To Console    data=${data}

    ${path_file}=      Set product key and collection key in file csv product collection     ${data}
    Go to mass upload product collection menu
    User browse file for mass upload product collection     ${path_file}
    Mass upload product collection - Error message is displayed when upload fail    1 ${result_header_fail}
    ${message}=    Mass upload product collection - Get result in file verification table
    Log To Console    message=${message}
    Verify result when upload product collection is fail    ${product_key}    ${collection_key}
    ...    ${invalid_collection_key}    ${row}    ${message}