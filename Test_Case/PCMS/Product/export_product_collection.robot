*** Settings ***
Force Tags    WLS_PCMS_Product
Library           Selenium2Library
Resource          ${CURDIR}/../../../Resource/Init.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Product/Create_Product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Export_product_collection/keywords_export_product_collection.robot
Test Setup        Login Pcms
Test Teardown     Close All Browsers

*** Variables ***
${result_verify}         Upload passed. Please waiting download
${result_success}        Download success
${result_no_content}     No content in csv file
${result_header_fail}    Error(s) found. Please re-check your file and try to upload again.


*** Test Cases ***
TC_iTM_02471 Export products collection - Success
    [Tags]    regression     Export_Product_Collection     Success    TC_iTM_02471    ready    flash
    ## prepare data
    Insert collection
    ${pkey}=        Insert product with retail type
    ${pkey1}=       Insert product with retail type
    ${pkey2}=       Insert product with marketplace type
    @{data_name}=       Create List     Product Key
    @{data_value1}=     Create List     ${pkey1}
    @{data_value2}=     Create List     ${pkey2}
    @{data}=     Create List     ${data_name}     ${data_value1}     ${data_value2}
    Log To Console     ${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    ## step test
    Go to export product collection menu
    User browse file for upload export product collection     ${file_upload}
    Upload result is displayed    ${result_verify}
    downloaded result is displayed    ${result_success}
    ${cookies}    Get Cookies
    check file download    ${cookies}

TC_iTM_02473 Space in the product key field - Success
    [Tags]    regression     Export_Product_Collection     Success    TC_iTM_02473    ready   flash
    ## prepare data
    Insert collection

    ${pkey}=       Insert product with retail type
    ${product_key}=    Set Variable    ${SPACE}${pkey}
    Log To Console    pkey space=${product_key}

    @{data_name}=      Create List     Product Key
    @{data_value}=     Create List     ${product_key}
    @{data}=     Create List     ${data_name}     ${data_value}
    Log To Console     ${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    ## step test
    Go to export product collection menu
    User browse file for upload export product collection     ${file_upload}
    Upload result is displayed    ${result_verify}
    downloaded result is displayed    ${result_success}
    ${cookies}    Get Cookies
    check file download    ${cookies}

TC_iTM_02474 Can download templete import product list - Success
    [Tags]    regression     Export_Product_Collection     Success    TC_iTM_02474    ready   flash
    Go to export product collection menu
    ${filename}=    Download template
    Verify export product collection template    ${filename}

TC_iTM_02484 Cannot export product deleted status- Fail
    [Tags]    Export_Product_Collection     Fail    TC_iTM_02484    ready   flash    regression
    # ${result_header_fail}=    Set Variable       1 Error(s) found. Please re-check your file and try to upload again.

    ${pkey}=       Get product key delete at
    Log To Console    pkey=${pkey}

    @{data_name}=      Create List     Product Key
    @{data_value}=     Create List     ${pkey}
    @{data}=     Create List     ${data_name}     ${data_value}
    Log To Console     ${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    Go to export product collection menu
    User browse file for upload export product collection     ${file_upload}
    Error message is displayed when upload fail    1 ${result_header_fail}

    ${pkey_string}=     Convert To String    ${pkey}
    ${data_fail}=    Get result in file verification table
    ${data_list}=    Create List     1    ${pkey_string}    Invalid Product Key
    Should Be Equal    ${data_fail}    ${data_list}

TC_iTM_02485 User does not input product Key - Fail
    [Tags]    Export_Product_Collection     product    Fail    TC_iTM_02485    ready    regression    flash
    @{data_name}=      Create List     Product Key
    @{data}=     Create List     ${data_name}
    Log To Console     Header file=${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    Go to export product collection menu
    User browse file for upload export product collection     ${file_upload}
    No content result is displayed    ${result_no_content}

TC_iTM_02486 Product id not exist in system - Fail
    [Tags]    Export_Product_Collection    product    TC_iTM_02486    Fail    ready    flash
    @{data_name}=      Create List     Product Key
    @{data_value}=     Create List     1234567890123
    @{data}=     Create List     ${data_name}     ${data_value}
    Log To Console     ${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    Go to export product collection menu
    User browse file for upload export product collection     ${file_upload}
    Error message is displayed when upload fail    1 ${result_header_fail}

    ${data_fail}=    Get result in file verification table
    ${data_list}=    Create List     1    1234567890123    Invalid Product Key
    Should Be Equal    ${data_fail}    ${data_list}

TC_iTM_02487 Blank row in the input csv file - Fail
    [Tags]    Export_Product_Collection    product    TC_iTM_02487    ready    Fail    flash    regression
    Insert collection

    ${pkey}=       Insert product with retail type
    ${pkey2}=      Insert product with marketplace type
    # ${product_key}=     Set Variable    ${pkey}

    @{data_name}=      Create List     Product Key
    @{data_value1}=    Create List     ${pkey}
    @{data_value2}=    Create List     ${SPACE}
    @{data_value3}=    Create List     ${pkey2}
    @{data}=     Create List     ${data_name}     ${data_value1}     ${data_value2}    ${data_value3}
    Log To Console     data in list=${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    Go to export product collection menu
    User browse file for upload export product collection     ${file_upload}
    Error message is displayed when upload fail    1 ${result_header_fail}

    ${data_fail}=     Get result in file verification table
    ${data_blank}=    Set Variable
    ${string_blank}=    Convert To String    ${data_blank}
    ${data_list}=     Create List     2    ${string_blank}    Please remove empty row
    Should Be Equal    ${data_fail}    ${data_list}
