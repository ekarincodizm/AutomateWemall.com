*** Settings ***
Force Tags    WLS_PCMS_Product
Library           Selenium2Library
Resource          ${CURDIR}/../../../Resource/Init.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Product/Create_Product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Merchant_alias/keywords_alias.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Merchant_alias/keywords_mass_upload_product_merchant_alias.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Merchant_alias/keywords_mass_delete_product_merchant_alias.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Export_product_merchant_alias/keywords_export_product_merchant_alias.robot
Test Setup        Login Pcms
Test Teardown     Close All Browsers

*** Variables ***
${alias_merchant_name}         Flash shop Robot Automated
${merchant_code}               FL00001
${result_verify_success}       Mass upload completed. 1 row(s) processed.
${history_type}                ali_add
${result_header_fail}          Error(s) found. Please re-check your file and try to upload again.
${result_no_content}           No content in csv file.


*** Test Cases ***
TC_iTM_03528 Product - Export Product Alias Merchant - Success
    [Tags]    TC_iTM_03528    export_product_alias_merchant     product     regression    phoenix    ready
    #prepare data product key in csv file
    ${pkey}=    Insert products by name with retail type    Product retail Test Automate export product to alias merchant
    Log To Console    ${pkey}
    # ${pkey}=       Set Variable       2106374239768

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

    #export
    Merchant Alias - User click link edit alias merchant
    ${filename}=      Merchant Alias - User click export product merchant alias
    Merchant Alias - Verify export product merchant alias     ${filename}

    #clear data
    [TearDown]    Run Keywords    Delete product from alias merchant by product id      ${product_id}    AND
    ...    Delete alias merchant by id    ${alias_merchant_id}   AND
    ...    Close All Browsers
TC_iTM_03529 Export Product alias merchant - Success
    [Tags]    TC_iTM_03529    export_product_alias_merchant     product     regression    phoenix    ready
    #prepare data product key in csv file
    ${pkey}=    Insert products by name with retail type    Product retail Test Automate export product to alias merchant
    Log To Console    ${pkey}
    # ${pkey}=       Set Variable       2106374239768

    ${product_id}=    Get product id form product pkey    ${pkey}
    Delete product from alias merchant by product id      ${product_id}

    #step test
    Merchant Alias - Go To Create Merchant Alias Page
    Merchant Alias - User Enter Alias Name    ${alias_merchant_name}
    Merchant Alias - User Click Save Button
    Merchant Alias - Edit Alias Page Is Opened
    Merchant Alias - Should Create Merchant Success

    #export
    Merchant Alias - Check button export disable
    ${alias_id}=      Merchant Alias - Get merchant alias id from url
    ${alias_merchant_id}=      Convert To Number     ${alias_id}
    Log To Console       alias_merchant_id=${alias_merchant_id}

    [TearDown]    Run Keywords    Delete product from alias merchant by product id      ${product_id}    AND
    ...    Delete alias merchant by id    ${alias_merchant_id}   AND
    ...    Close All Browsers
