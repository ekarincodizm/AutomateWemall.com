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
${table_id}                    productSetContentTable
${result_verify_success}       Mass upload completed. 1 row(s) processed.
${result_verify_success_delete}       Mass delete completed. 1 row(s) processed.

*** Test Cases ***
TC_iTM_03434 Verify Header at Set Product Content table
    [TAGS]    TC_iTM_03434    ready    regression    set_content    product    phoenix
    Login Pcms
    Go To Product Set Content Page
    ${data}=    Get Table Cell    ${PRODUCT-SET-CONTENT-TABLE}    1    1
    Should Be Equal    ${data}    Product Name
    ${data}=    Get Table Cell    ${PRODUCT-SET-CONTENT-TABLE}    1    2
    Should Be Equal    ${data}    Styles
    ${data}=    Get Table Cell    ${PRODUCT-SET-CONTENT-TABLE}    1    3
    Should Be Equal    ${data}    Product Key/Inventory Id
    ${data}=    Get Table Cell    ${PRODUCT-SET-CONTENT-TABLE}    1    4
    Should Be Equal    ${data}    Alias Code/Merchant Code
    ${data}=    Get Table Cell    ${PRODUCT-SET-CONTENT-TABLE}    1    5
    Should Be Equal    ${data}    Alias Name/Merchant Name
    ${data}=    Get Table Cell    ${PRODUCT-SET-CONTENT-TABLE}    1    6
    Should Be Equal    ${data}    Contents
    ${data}=    Get Text    ${PRODUCT-SET-CONTENT-TABLE}/thead/tr[2]/th[1]
    Should Be Equal    ${data}    Key Feature
    ${data}=    Get Text    ${PRODUCT-SET-CONTENT-TABLE}/thead/tr[2]/th[2]
    Should Be Equal    ${data}    Description
    ${data}=    Get Text    ${PRODUCT-SET-CONTENT-TABLE}/thead/tr[2]/th[3]
    Should Be Equal    ${data}    Media
    ${data}=    Get Table Cell    ${PRODUCT-SET-CONTENT-TABLE}    1    7
    Should Be Equal    ${data}    Actions

    [Teardown]    Close All Browsers

TC_iTM_03435 Verify Merchant Name and Merchant Code at Set Product Content table
    [TAGS]    TC_iTM_03435    ready    regression    set_content    product    phoenix
    Login Pcms
    Go To Product Set Content Page
    ${pKey}=    Get Table Cell    ${PRODUCT-SET-CONTENT-TABLE}    3    3
    ${product_alias_code}=    Get Table Cell    ${PRODUCT-SET-CONTENT-TABLE}    3    4
    ${product_alias_name}=    Get Table Cell    ${PRODUCT-SET-CONTENT-TABLE}    3    5
    ${merchant_code_table}=    Get Table Cell    ${PRODUCT-SET-CONTENT-TABLE}    4    3
    ${merchant_name_table}=    Get Table Cell    ${PRODUCT-SET-CONTENT-TABLE}    4    4
    ${product_alias_code_db}    ${product_alias_name_db}=    Get Product Alias Code and Name from DB by Product pkey    ${pKey}
    ${merchant_code_db}    ${merchant_name_db}=    Get Merchant Code and Name from DB by Product pkey    ${pKey}

    ${product_alias_code}=    Convert To Uppercase If variable is String    ${product_alias_code}
    ${product_alias_name}=    Convert To Uppercase If variable is String    ${product_alias_name}
    ${product_alias_code_db}=    Convert To Uppercase If variable is String    ${product_alias_code_db}
    ${product_alias_name_db}=    Convert To Uppercase If variable is String    ${product_alias_name_db}

    ${merchant_code_table}=    Convert To Uppercase If variable is String    ${merchant_code_table}
    ${merchant_name_table}=    Convert To Uppercase If variable is String    ${merchant_name_table}
    ${merchant_code_db}=    Convert To Uppercase If variable is String    ${merchant_code_db}
    ${merchant_name_db}=    Convert To Uppercase If variable is String    ${merchant_name_db}

    Should Be Equal    '${product_alias_code}'    '${product_alias_code_db}'
    Should Be Equal    '${product_alias_name}'    '${product_alias_name}'
    Should Be Equal    '${merchant_code_table}'    '${merchant_code_db}'
    Should Be Equal    '${merchant_name_table}'    '${merchant_name_db}'

    [Teardown]    Close All Browsers

TC_iTM_03436 Show Alias Merchant Code & Alias Merchant Name on Product When Alias Merchant has Product [Set Content]
    [TAGS]    TC_iTM_03436    ready    regression    set_content    product    phoenix
    Login Pcms
    ${product}=    Merchant Alias - Get detail products and alias merchant
    ${pkey}=    Set Variable    ${product[0][0]}
    ${name}=    Set Variable    ${product[0][2]}
    ${product_id}=    Set Variable    ${product[0][1]}
    ${alias_code}=    Set Variable    ${product[0][4]}
    ${alias_merchant_name}=    Set Variable    ${product[0][5]}

    #check product detail
    Go To Product Set Content Page
    Search product with product name    ${name}    ${table_id}
    ${product_alias_code}=    Get Table Cell    ${PRODUCT-SET-CONTENT-TABLE}    3    4
    ${product_alias_name}=    Get Table Cell    ${PRODUCT-SET-CONTENT-TABLE}    3    5

    Should Be Equal    '${alias_code}'    '${product_alias_code}'
    Should Be Equal    '${alias_merchant_name}'    '${product_alias_name}'

    [Teardown]    Close All Browsers

TC_iTM_03437 Don't Show Alias Merchant Code & Alias Merchant Name on Product When Alias Merchant has not Product [Set Content]
    [TAGS]    TC_iTM_03437    ready    regression    set_content    product    phoenix
    Login Pcms
    ${product}=    Product - Get product not in alias merchant
    ${pkey}=    Set Variable    ${product[0][0]}
    ${name}=    Set Variable    ${product[0][2]}
    ${product_id}=    Set Variable    ${product[0][1]}

    #check product datail
    Go To Product Set Content Page
    Search product with product name    ${name}    ${table_id}
    ${product_alias_code}=    Get Table Cell    ${PRODUCT-SET-CONTENT-TABLE}    3    4
    ${product_alias_name}=    Get Table Cell    ${PRODUCT-SET-CONTENT-TABLE}    3    5

    Should Be Equal    ''    '${product_alias_code}'
    Should Be Equal    ''    '${product_alias_name}'

    [Teardown]    Close All Browsers

