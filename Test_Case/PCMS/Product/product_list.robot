*** Settings ***
Force Tags    WLS_PCMS_Product
Library           Selenium2Library
Library           Collections
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Keywords_Product.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Product/keywords_product.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/keyword_merchant.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Product/Create_Product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Merchant_alias/keywords_alias.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Merchant_alias/keywords_mass_upload_product_merchant_alias.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Merchant_alias/keywords_mass_delete_product_merchant_alias.robot
Resource          ${CURDIR}/../../../Resource/Config/${env}/env_config.robot
Resource          ${CURDIR}/../../../Resource/Config/${env}/database.robot
Resource          ${CURDIR}/../../../Resource/TestData/${env}/test_data.robot

*** Variables ***
${alias_merchant_name}         Flash shop Robot Automated
${table_id}                    productListTable
${result_verify_success}       Mass upload completed. 1 row(s) processed.
${result_verify_success_delete}       Mass delete completed. 1 row(s) processed.
*** Test Cases ***
TC_iTM_03430 Verify Header at Product List table
    [TAGS]    TC_iTM_03430    ready    regression    product_list    product    phoenix
    Login Pcms
    GO TO PRODUCT List PAGE
    ${data}=    Get Table Cell    ${PRODUCT-LIST-TABLE}    2    1
    Should Be Equal    ${data}    Brand Name
    ${data}=    Get Table Cell    ${PRODUCT-LIST-TABLE}    2    2
    Should Be Equal    ${data}    Product Name
    ${data}=    Get Table Cell    ${PRODUCT-LIST-TABLE}    2    3
    Should Be Equal    ${data}    Product Key/Inventory Id
    ${data}=    Get Table Cell    ${PRODUCT-LIST-TABLE}    2    4
    Should Be Equal    ${data}    Alias Code/Merchant Code
    ${data}=    Get Table Cell    ${PRODUCT-LIST-TABLE}    2    5
    Should Be Equal    ${data}    Alias Name/Merchant Name
    ${data}=    Get Table Cell    ${PRODUCT-LIST-TABLE}    2    6
    Should Be Equal    ${data}    Stock
    ${data}=    Get Table Cell    ${PRODUCT-LIST-TABLE}    2    7
    Should Be Equal    ${data}    Action

    [Teardown]    Close All Browsers

TC_iTM_03431 Verify Merchant Name and Merchant Code at Product List table
    [TAGS]    TC_iTM_03431    ready    regression    product_list    product    phoenix
    Login Pcms
    GO TO PRODUCT List PAGE
    ${pKey}=    Get Table Cell    ${PRODUCT-LIST-TABLE}    3    3
    ${product_alias_code}=    Get Table Cell    ${PRODUCT-LIST-TABLE}    3    4
    ${product_alias_name}=    Get Table Cell    ${PRODUCT-LIST-TABLE}    3    5
    ${merchant_code_table}=    Get Table Cell    ${PRODUCT-LIST-TABLE}    4    4
    ${merchant_name_table}=    Get Table Cell    ${PRODUCT-LIST-TABLE}    4    5
    ${product_alias_code_db}    ${product_alias_name_db}=    Get Product Alias Code and Name from DB by Product pkey    ${pKey}
    ${merchant_code_db}    ${merchant_name_db}=    Get Merchant Code and Name from DB by Product pkey    ${pKey}

    ${product_alias_code}=    Convert To Uppercase If variable is String    ${product_alias_code}
    ${product_alias_name}=    Convert To Uppercase If variable is String    ${product_alias_name}
    ${product_alias_code_db}=    Convert To Uppercase If variable is String    ${product_alias_code_db}
    ${product_alias_name_db}=    Convert To Uppercase If variable is String    ${product_alias_name_db}

    ${merchant_code_table}=    Convert To Uppercase    ${merchant_code_table}
    ${merchant_name_table}=    Convert To Uppercase    ${merchant_name_table}
    ${merchant_code_db}=    Convert To Uppercase    ${merchant_code_db}
    ${merchant_name_db}=    Convert To Uppercase    ${merchant_name_db}

    Should Be Equal    '${merchant_code_table}'    '${merchant_code_db}'
    Should Be Equal    '${merchant_name_table}'    '${merchant_name_db}'

    [Teardown]    Close All Browsers

TC_iTM_03432 Show Alias Merchant Code & Alias Merchant Name on Product When Alias Merchant has Product [Product List]
    [TAGS]    TC_iTM_03432    ready    regression    product_list    product    phoenix
    Login Pcms
    ${product}=    Merchant Alias - Get detail products and alias merchant
    ${pkey}=    Set Variable    ${product[0][0]}
    ${name}=    Set Variable    ${product[0][2]}
    ${product_id}=    Set Variable    ${product[0][1]}
    ${alias_code}=    Set Variable    ${product[0][4]}
    ${alias_merchant_name}=    Set Variable    ${product[0][5]}

    #check product detail
    GO TO PRODUCT List PAGE
    Search product with product name    ${name}    ${table_id}
    ${product_alias_code}=    Get Table Cell    ${PRODUCT-LIST-TABLE}    3    4
    ${product_alias_name}=    Get Table Cell    ${PRODUCT-LIST-TABLE}    3    5

    Should Be Equal    '${alias_code}'    '${product_alias_code}'
    Should Be Equal    '${alias_merchant_name}'    '${product_alias_name}'

    [Teardown]    Close All Browsers

TC_iTM_03433 Don't Show Alias Merchant Code & Alias Merchant Name on Product When Alias Merchant has not Product [Product List]
    [TAGS]    TC_iTM_03433    ready    regression    product_list    product    phoenix
    Login Pcms
    ${product}=    Product - Get product not in alias merchant
    ${pkey}=    Set Variable    ${product[0][0]}
    ${name}=    Set Variable    ${product[0][2]}
    ${product_id}=    Set Variable    ${product[0][1]}

    #check product datail
    GO TO PRODUCT List PAGE
    Search product with product name    ${name}    ${table_id}
    ${product_alias_code}=    Get Table Cell    ${PRODUCT-LIST-TABLE}    3    4
    ${product_alias_name}=    Get Table Cell    ${PRODUCT-LIST-TABLE}    3    5

    Should Be Equal    ''    '${product_alias_code}'
    Should Be Equal    ''    '${product_alias_name}'

    [Teardown]    Close All Browsers
