*** Settings ***
Force Tags    WLS_PCMS_Product
Library    Selenium2Library
Resource   ${CURDIR}/../../../Resource/init.robot
Resource   ${CURDIR}/../../../Keyword/Features/Create_Product/Create_Product.robot
Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Merchant_alias/keywords_alias.robot
Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Merchant_alias/keywords_mass_upload_product_merchant_alias.robot
# Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot

Library    ${CURDIR}/../../../Python_Library/alias_merchant.py

Test Setup        Login Pcms

*** Variables ***
${alias_merchant_name}         Flash shop Robot Automated
${merchant_code}               FL00001
${result_verify_success}       Mass upload completed. 1 row(s) processed.
${history_type}                ali_add
${result_header_fail}          Error(s) found. Please re-check your file and try to upload again.
${result_no_content}           No content in csv file.


*** Test Cases ***
TC_iTM_03131 Upload product to alias merchant via mass upload - Success
    [Tags]    TC_iTM_03131    Mass_upload_product_alias_merchant     product     regression    flash    ready
    #prepare data product key in csv file
    ${pkey}=    Insert products by name with retail type    Product retail Test Automate upload to alias merchant2
    Log To Console    ${pkey}

    ${product_id}=    Get product id form product pkey    ${pkey}
    Delete product from alias merchant by product id      ${product_id}

    @{data_name}=     Create List     Product Key
    @{data_value}=    Create List     ${pkey}
    @{data}=    Create List    ${data_name}    ${data_value}
    Log To Console    data=${data}

    #step test
    Merchant Alias - Go To Create Merchant Alias Page
    Merchant Alias - User Enter Alias Name    ${alias_merchant_name}
    Merchant Alias - User Click Save Button
    Merchant Alias - Edit Alias Page Is Opened
    Merchant Alias - Should Create Merchant Success
    Merchant Alias - User click mass upload product

    ${path_file}=      Merchant Alias - Set product key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    Merchant Alias - User browse file for mass upload product    ${file_upload}
    Merchant Alias - Mass upload product result is displayed    ${result_verify_success}
    Merchant Alias - User click back to history page

    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Merchant Alias - Get upload history result from web page    ${filename}    ${display_name_top_bar}
    Should be equal    ${display_name_top_bar}    ${result_row_from_web[1]}
    Should be equal    success    ${result_row_from_web[2]}
    Should be equal    -    ${result_row_from_web[3]}

    ${alias_merchant_id}=    Merchant Alias - Get Merchant ID From History Page
    Merchant Alias - Verify Alias Merchant ID in History Table    ${alias_merchant_id}

    ${num_all_history}=    Merchant Alias - Get Number of History Rows
    Merchant Alias - Verify Number of History Rows on UI    ${num_all_history}
    Merchant Alias - Verify Number of History Rows with DB    ${alias_merchant_id}    ${history_type}    ${num_all_history}

    # ${Product_URL}=    Set Variable     ${ITM_URL}/products/item-${pkey}.html
    # Open Browser      ${Product_URL}    chrome
    # Maximize Browser Window
    # Sleep    3s
    # Level D - Level D Is Opened

    #clear data
    [TearDown]    Run Keywords    Delete product from alias merchant by product id      ${product_id}    AND
    ...    Delete alias merchant by id    ${alias_merchant_id}   AND
    ...    Close All Browsers

TC_iTM_03133 Space in the field for mass upload - Success
    [Tags]    TC_iTM_03133    Mass_upload_product_alias_merchant     product     regression    flash    ready

    #prepare data product key in csv file
    ${pkey}=    Insert products by name with retail type    Product retail Test Automate upload to alias merchant2
    ${product_key}=    Set Variable    ${SPACE}${pkey}${SPACE}
    Log To Console    ${product_key}

    ${product_id}=    Get product id form product pkey    ${pkey}
    Delete product from alias merchant by product id      ${product_id}

    @{data_name}=     Create List     Product Key
    @{data_value}=    Create List     ${product_key}
    @{data}=    Create List    ${data_name}    ${data_value}
    Log To Console    data=${data}

    #step test
    Merchant Alias - Go To Create Merchant Alias Page
    Merchant Alias - User Enter Alias Name    ${alias_merchant_name}
    Merchant Alias - User Click Save Button
    Merchant Alias - Edit Alias Page Is Opened
    Merchant Alias - Should Create Merchant Success
    Merchant Alias - User click mass upload product

    ${path_file}=      Merchant Alias - Set product key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    Merchant Alias - User browse file for mass upload product    ${file_upload}
    Merchant Alias - Mass upload product result is displayed    ${result_verify_success}
    Merchant Alias - User click back to history page

    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Merchant Alias - Get upload history result from web page    ${filename}    ${display_name_top_bar}
    Should be equal    ${display_name_top_bar}    ${result_row_from_web[1]}
    Should be equal    success    ${result_row_from_web[2]}
    Should be equal    -    ${result_row_from_web[3]}

    ${alias_merchant_id}=    Merchant Alias - Get Merchant ID From History Page
    Merchant Alias - Verify Alias Merchant ID in History Table    ${alias_merchant_id}

    ${num_all_history}=    Merchant Alias - Get Number of History Rows
    Merchant Alias - Verify Number of History Rows on UI    ${num_all_history}
    Merchant Alias - Verify Number of History Rows with DB    ${alias_merchant_id}    ${history_type}    ${num_all_history}

    # ${Product_URL}=    Set Variable     ${ITM_URL}/products/item-${pkey}.html
    # Open Browser      ${Product_URL}    chrome
    # Maximize Browser Window
    # Sleep    3s
    # Level D - Level D Is Opened

    #clear data
    Log To Console    $id=${alias_merchant_id}
    [TearDown]    Run Keywords    Delete product from alias merchant by product id      ${product_id}    AND
    ...    Delete alias merchant by id    ${alias_merchant_id}    AND    Close All Browsers

TC_iTM_03134 Download templete for mass upload - Success
    [Tags]    TC_iTM_03134    Mass_upload_product_alias_merchant     product     regression    flash

    Merchant Alias - Go To Create Merchant Alias Page
    Merchant Alias - User Enter Alias Name    ${alias_merchant_name}
    Merchant Alias - User Click Save Button
    Merchant Alias - Edit Alias Page Is Opened
    Merchant Alias - Should Create Merchant Success
    Merchant Alias - User click mass upload product

    ${filename}=    Download template mass upload alias merchant
    Verify mass upload alias merchant template    ${filename}
    ${alias_merchant_id}=    Merchant Alias - Get Merchant ID From History Page
    Log To Console    $id=${alias_merchant_id}
    [TearDown]    Run Keywords    Delete alias merchant by id    ${alias_merchant_id}     AND    Close All Browsers

TC_iTM_03135 A product under many alias merchant - Fail
    [Tags]    TC_iTM_03135    Mass_upload_product_alias_merchant     product     regression    flash

    #prepare data product key in csv file
    ${pkey}=    Insert products by name with retail type    Product retail Test Automate upload to alias merchant2
    Log To Console    ${pkey}

    ${product_id}=    Get product id form product pkey    ${pkey}
    Delete product from alias merchant by product id      ${product_id}

    @{data_name}=     Create List     Product Key
    @{data_value}=    Create List     ${pkey}
    @{data}=    Create List    ${data_name}    ${data_value}
    Log To Console    data=${data}

    #step test
    Merchant Alias - Go To Create Merchant Alias Page
    Merchant Alias - User Enter Alias Name    ${alias_merchant_name}
    Merchant Alias - User Click Save Button
    Merchant Alias - Edit Alias Page Is Opened
    Merchant Alias - Should Create Merchant Success
    Merchant Alias - User click mass upload product

    ${path_file}=      Merchant Alias - Set product key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    Merchant Alias - User browse file for mass upload product    ${file_upload}
    Merchant Alias - Mass upload product result is displayed    ${result_verify_success}
    Merchant Alias - User click back to history page

    ${alias_merchant_id}=    Merchant Alias - Get Merchant ID From History Page
    Merchant Alias - Verify Alias Merchant ID in History Table    ${alias_merchant_id}

    #upload round 2
    ${path_file}=      Merchant Alias - Set product key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    Merchant Alias - User browse file for mass upload product    ${file_upload}
    Merchant Alias - Error message is displayed when upload fail    1 ${result_header_fail}

    ${pkey_string}=     Convert To String    ${pkey}
    ${data_fail}=    Merchant Alias - Get result in file verification table
    ${data_list}=    Create List     1    ${pkey_string}    Product is already linked to an alias.
    Should Be Equal    ${data_fail}    ${data_list}

    #clear data
    [TearDown]    Run Keywords    Delete product from alias merchant by product id      ${product_id}    AND
    ...    Delete alias merchant by id    ${alias_merchant_id}    AND
    ...    Close All Browsers

TC_iTM_03136 User does not input product Key for mass upload - Fail
    [Tags]    TC_iTM_03136    Mass_upload_product_alias_merchant     product     regression    flash    ready

    @{data_name}=     Create List     Product Key
    @{data}=    Create List    ${data_name}
    Log To Console    data=${data}

    #step test
    Merchant Alias - Go To Create Merchant Alias Page
    Merchant Alias - User Enter Alias Name    ${alias_merchant_name}
    Merchant Alias - User Click Save Button
    Merchant Alias - Edit Alias Page Is Opened
    Merchant Alias - Should Create Merchant Success
    Merchant Alias - User click mass upload product

    ${path_file}=      Merchant Alias - Set product key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    Merchant Alias - User browse file for mass upload product    ${file_upload}
    Merchant Alias - Error message is displayed when upload fail    ${result_no_content}
    Merchant Alias - User click link back to history page
    ${alias_merchant_id}=    Merchant Alias - Get Merchant ID From History Page

    #clear data
    [TearDown]    Run Keywords    Delete alias merchant by id    ${alias_merchant_id}    AND
    ...    Close All Browsers

TC_iTM_03137 Blank row in the input csv for mass upload - Fail
    [Tags]    TC_iTM_03137    Mass_upload_product_alias_merchant     product     regression    flash
    #prepare data product key in csv file
    ${pkey}=    Insert products by name with retail type    Product retail Test Automate upload to alias merchant2
    Log To Console    ${pkey}

    ${product_id}=    Get product id form product pkey    ${pkey}
    Delete product from alias merchant by product id      ${product_id}

    @{data_name}=      Create List     Product Key
    @{data_value1}=    Create List     ${SPACE}
    @{data_value2}=    Create List     ${pkey}
    @{data}=           Create List    ${data_name}     @{data_value1}     ${data_value2}
    Log To Console    data=${data}

    #step test
    Merchant Alias - Go To Create Merchant Alias Page
    Merchant Alias - User Enter Alias Name    ${alias_merchant_name}
    Merchant Alias - User Click Save Button
    Merchant Alias - Edit Alias Page Is Opened
    Merchant Alias - Should Create Merchant Success
    Merchant Alias - User click mass upload product

    ${path_file}=      Merchant Alias - Set product key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    Merchant Alias - User browse file for mass upload product    ${file_upload}
    ${data_fail}=    Merchant Alias - Get result in file verification table
    ${data_list}=    Create List     1    ${EMPTY}    Please remove empty row.
    Should Be Equal    ${data_fail}    ${data_list}

    Merchant Alias - User click link back to history page
    ${alias_merchant_id}=    Merchant Alias - Get Merchant ID From History Page

    #clear data
    [TearDown]    Run Keywords    Delete product from alias merchant by product id      ${product_id}    AND
    ...    Delete alias merchant by id    ${alias_merchant_id}    AND
    ...    Close All Browsers

TC_iTM_03138 Product key not exist in system/ Product key deleted - Fail
    [Tags]    TC_iTM_03138    Mass_upload_product_alias_merchant     product     regression    TC_iTM_03138    flash    ready
    ${product_key_not_exist}=      Set Variable    12345678
    ${product_key_deleted}=        Get product key delete at
    ${str_product_key_deleted}=    Convert To String    ${product_key_deleted}

    #prepare data product key in csv file
    @{data_name}=       Create List     Product Key
    @{data_value1}=     Create List     ${product_key_not_exist}
    @{data_value2}=     Create List     ${str_product_key_deleted}
    @{data}=            Create List     ${data_name}     ${data_value1}    ${data_value2}
    Log To Console   data list=${data}

    #step test
    Merchant Alias - Go To Create Merchant Alias Page
    Merchant Alias - User Enter Alias Name    ${alias_merchant_name}
    Merchant Alias - User Click Save Button
    Merchant Alias - Edit Alias Page Is Opened
    Merchant Alias - Should Create Merchant Success
    Merchant Alias - User click mass upload product

    ${path_file}=      Merchant Alias - Set product key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    Merchant Alias - User browse file for mass upload product    ${file_upload}
    ${data_fail}=    Merchant Alias - Get result in file verification table
    ${product_key_deleted_str}=      Convert to string      ${product_key_deleted}
    @{data_list1}=    Create List     1    ${product_key_not_exist}      Invalid Product Key.
    @{data_list2}=    Create List     2    ${product_key_deleted_str}    Invalid Product Key.
    ${data_list}=    Create List    @{data_list1}     @{data_list2}
    Should Be Equal    ${data_fail}    ${data_list}

    Merchant Alias - User click link back to history page
    ${alias_merchant_id}=    Merchant Alias - Get Merchant ID From History Page

    #clear data
    [TearDown]    Run Keywords    Delete alias merchant by id    ${alias_merchant_id}    AND
    ...    Close All Browsers