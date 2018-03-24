*** Settings ***
Force Tags    WLS_PCMS_Product
Library           Selenium2Library
Resource          ${CURDIR}/../../../Resource/Init.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Product/Create_Product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Collection/keyword_collection.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Mass_active_product/keywords_mass_active_product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Keywords_Product.robot

Test Setup        Login Pcms
Test Teardown     Close All Browsers

*** Variables ***
${result_verify_success_1_row}     Mass active products completed. 1 row(s) processed.
${result_verify_success_2_row}     Mass active products completed. 2 row(s) processed.
${result_no_content}               No content in csv file
${result_header_fail}              Error(s) found. Please re-check your file and try to upload again.
${product_name_marketplace_1}      product test mass active product marketplace1 robot
${product_name_marketplace_2}      product test mass active product marketplace2
${product_name_retail_1}           product test mass active product retail1 robot
${product_name_retail_2}           product test mass active product retail2
${collection_key}                  9123456789123

*** Test Cases ***
tc1
    [Tags]    tc1
    Insert products by name and collection with retail type    phoenix_wow_retail2     3431763361672

TC_iTM_02565 Mass active products - Success
    [Tags]    TC_iTM_02565    ready    Product    mass_active_Product    regression    flash
    Create collection
    ${pkey1}=       Insert products by name and collection with marketplace type     ${product_name_marketplace_1}    ${collection_key}
    ${pkey2}=       Insert products by name and collection with retail type     ${product_name_retail_1}    ${collection_key}
    @{data_name}=       Create List     Product Key
    @{data_value1}=     Create List     ${pkey1}
    @{data_value2}=     Create List     ${pkey2}
    @{data}=     Create List     ${data_name}     ${data_value1}     ${data_value2}
    # Log To Console     data=${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    Go to mass active product menu
    User browse file for mass active product collection     ${file_upload}
    Mass active product result is displayed    ${result_verify_success_2_row}

    ${product_name1}=    Get product name by product key    ${pkey1}
    ${product_name2}=    Get product name by product key    ${pkey2}

    Go To Product List Page
    Search product by name     ${product_name1}
    ${product_id1}=     Get product id form product pkey    ${pkey1}
    Edit product     ${product_id1}
    Check status product

    Go To Product List Page
    Search product by name     ${product_name2}
    ${product_id2}=     Get product id form product pkey    ${pkey2}
    Edit product     ${product_id2}
    Check status product

    result in displayed on web    ${pkey1}    ${product_name1}
    result in displayed on web    ${pkey2}    ${product_name2}

TC_iTM_02567 Space in the product key field - Success
    [Tags]    TC_iTM_02567    ready    Product    mass_active_Product    regression    flash
    Create collection
    ${pkey}=       Insert products by name and collection with marketplace type     ${product_name_marketplace_1}    ${collection_key}
    ${product_key}=    Set Variable    ${SPACE}${pkey}
    Log To Console      ${product_key}

    @{data_name}=       Create List     Product Key
    @{data_value}=     Create List     ${product_key}
    @{data}=     Create List     ${data_name}     ${data_value}
    Log To Console     data=${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    Go to mass active product menu
    User browse file for mass active product collection     ${file_upload}
    Mass active product result is displayed    ${result_verify_success_1_row}

    ${product_name}=    Get product name by product key    ${pkey}

    Go To Product List Page
    Search product by name     ${product_name}
    ${product_id}=     Get product id form product pkey    ${pkey}
    Edit product     ${product_id}
    Check status product

    result in displayed on web    ${pkey}    ${product_name}

TC_iTM_02568 Can download templete upload product list - Success
    [Tags]    TC_iTM_02568    ready    Product    mass_active_Product    regression    flash
    Go to mass active product menu
    ${filename}=    Download template mass active product
    Verify mass active product template    ${filename}

TC_iTM_02569 Mass upload product is deleted - Fail
    [Tags]    TC_iTM_02569    ready    Product    mass_active_Product     regression    flash
    ${pkey}=     Get product key delete at
    @{data_name}=       Create List     Product Key
    @{data_value}=     Create List     ${pkey}
    @{data}=     Create List     ${data_name}     ${data_value}
    Log To Console     data=${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    Go to mass active product menu
    User browse file for mass active product collection     ${file_upload}
    Error message is displayed when upload fail    1 ${result_header_fail}

    ${pkey_string}=     Convert To String    ${pkey}
    ${data_fail}=    Get result in file verification table
    ${data_list}=    Create List     1    ${pkey_string}    Invalid Product Key
    Should Be Equal    ${data_fail}    ${data_list}

TC_iTM_02570 User does not input product Key - Fail
    [Tags]    TC_iTM_02570    ready    Product    mass_active_Product     regression    flash
    @{data_name}=      Create List     Product Key
    @{data}=     Create List     ${data_name}
    Log To Console     Header file=${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    Go to mass active product menu
    User browse file for mass active product collection     ${file_upload}
    No content result is displayed    ${result_no_content}

TC_iTM_02571 Product id not exist in system - Fail
    [Tags]    TC_iTM_02571    ready    Product    mass_active_Product    flash
    @{data_name}=      Create List     Product Key
    @{data_value}=     Create List     1234567890123
    @{data}=     Create List     ${data_name}     ${data_value}
    Log To Console     ${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    Go to mass active product menu
    User browse file for mass active product collection     ${file_upload}
    Error message is displayed when upload fail    1 ${result_header_fail}

    ${data_fail}=    Get result in file verification table
    ${data_list}=    Create List     1    1234567890123    Invalid Product Key
    Should Be Equal    ${data_fail}    ${data_list}