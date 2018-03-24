*** Settings ***
Force Tags    WLS_PCMS_Product
Library           Selenium2Library
Library           Collections
Resource          ${CURDIR}/../../../Resource/Init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Keywords_Product.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Product/keywords_product.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/keyword_merchant.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Merchant_alias/keywords_alias.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Merchant_alias/keywords_mass_upload_product_merchant_alias.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Merchant_alias/keywords_mass_delete_product_merchant_alias.robot

Test setup        Login Pcms
Test Teardown     Close All Browsers

*** Test Cases ***
TC_iTM_03442 Verify Header at Set Product Price table
    [TAGS]    TC_iTM_03442    ready    regression    set_price    product    phoenix

    Go To Product Set Price Page
    ${data}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    1    1
    Should Be Equal    ${data}    Brand
    ${data}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    1    2
    Should Be Equal    ${data}    Product Name
    ${data}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    1    3
    Should Be Equal    ${data}    Inventory Id
    ${data}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    1    4
    Should Be Equal    ${data}    Merchant Code/Alias Code
    ${data}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    1    5
    Should Be Equal    ${data}    Merchant Name/Alias Name
    ${data}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    1    6
    Should Be Equal    ${data}    Net. Price
    ${data}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    1    7
    Should Be Equal    ${data}    Special Price
    ${data}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    1    8
    Should Be Equal    ${data}    ${EMPTY}

TC_iTM_03443 Verify Merchant Name and Merchant Code at Set Product Price table
    [TAGS]    TC_iTM_03443    ready    regression    set_price    product    phoenix

    Go To Product Set Price Page
    ${Inventory_ID}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    3    3
    Log To Console   inven=${Inventory_ID}
    ${merchant_code_table}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    3    4
    Log To Console    merchant code=${merchant_code_table}
    ${merchant_name_table}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    3    5
    Log To Console    name=${merchant_name_table}
    # ${merchant_code_table}=    Convert To Uppercase    ${merchant_code_table}
    # ${merchant_name_table}=    Convert To Uppercase    ${merchant_name_table}

    ${merchant_code_db}    ${merchant_name_db}=    Get Merchant Code and Name from DB by Inventory id    ${Inventory_ID}
    Should Be Equal    '${merchant_code_table}'    '${merchant_code_db}'
    Should Be Equal    '${merchant_name_table}'    '${merchant_name_db}'

TC_iTM_03444 Show alias merchant code & alias merchant name on product when alias merchant has product [Set price page]
    [TAGS]    TC_iTM_03444    set_price    product    regression    ready    phoenix

    ${product}=    Merchant Alias - Get detail products and alias merchant
    ${pkey}=    Set Variable    ${product[0][0]}
    ${name}=    Set Variable    ${product[0][2]}
    ${product_id}=    Set Variable    ${product[0][1]}
    ${product_alias_code}=    Set Variable    ${product[0][4]}
    ${product_alias_name}=    Set Variable    ${product[0][5]}

    #check product detail
    Go To Product Set Price Page
    Search product by product name    ${name}
    ${code}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    2    3
    ${name}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    2    4
    ${Inventory_ID}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    3    3
    ${merchant_code_table}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    3    4
    ${merchant_name_table}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    3    5

    ${merchant_code_db}    ${merchant_name_db}=    Get Merchant Code and Name from DB by Inventory id    ${Inventory_ID}

    ${product_merchant_and_alias_code}=      Split String    ${code}       ${SPACE}/${SPACE}
    ${product_merchant_and_alias_name}=      Split String    ${name}       ${SPACE}/${SPACE}

    ${merchant_code}=    Set Variable      ${product_merchant_and_alias_code[0]}
    ${merchant_name}=    Set Variable      ${product_merchant_and_alias_name[0]}

    ${alias_code}=    Set Variable     ${product_merchant_and_alias_code[1]}
    ${alias_name}=    Set Variable     ${product_merchant_and_alias_name[1]}

    #layer product
    Should Be Equal    '${alias_code}'       '${product_alias_code}'
    Should Be Equal    '${alias_name}'       '${product_alias_name}'
    Should Be Equal    '${merchant_code}'    '${merchant_code_db}'
    Should Be Equal    '${merchant_name}'    '${merchant_name_db}'

    #layer sku
    Should Be Equal    '${merchant_code_table}'    '${merchant_code_db}'
    Should Be Equal    '${merchant_name_table}'    '${merchant_name_db}'

TC_iTM_03445 Don't Show Alias Merchant Code & Alias Merchant Name on Product When Alias Merchant has not Product [Set Price]
    [TAGS]    TC_iTM_03445    set_price    product    regression    ready    phoenix

    ${product}=    Product - Get product not in alias merchant
    Log To Console    product=${product}
    ${pkey}=    Set Variable    ${product[0][0]}
    ${name}=    Set Variable    ${product[0][2]}
    ${product_id}=    Set Variable    ${product[0][1]}

    #check product detail
    Go To Product Set Price Page
    Search product by product name    ${name}
    ${code}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    2    3
    ${name}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    2    4
    ${Inventory_ID}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    3    3
    ${merchant_code_table}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    3    4
    ${merchant_name_table}=    Get Table Cell    ${PRODUCT-LIST-ALL-TABLES}    3    5

    ${merchant_code_db}    ${merchant_name_db}=    Get Merchant Code and Name from DB by Inventory id    ${Inventory_ID}

    #layer product
    Should Be Equal    '${code}'    '${merchant_code_db}'
    Should Be Equal    '${name}'    '${merchant_name_db}'

    #layer sku
    Should Be Equal    '${merchant_code_table}'    '${merchant_code_db}'
    Should Be Equal    '${merchant_name_table}'    '${merchant_name_db}'