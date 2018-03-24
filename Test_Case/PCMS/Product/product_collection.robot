*** Settings ***
Force Tags    WLS_PCMS_Product
Library           Selenium2Library
Library           Collections
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Keywords_Product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/keywords_set_collection.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/keyword_merchant.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Merchant_alias/keywords_alias.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Product/Create_Product.robot
Test Setup        Login Pcms
Test Teardown     Close All Browsers
*** Variables ***
${alias_merchant_name}         Flash shop Robot Automated
${collection_pkey_alias}       9922654321123
${collection_pkey_not_alias}   9966654321246
${product}                     pkey=2393129135716    name=Flash Test Product Mass Product Collections Lv1
${table_id}                    PRODUCT-IN-COLLECTION-TABLE

*** Test Cases ***
TC_iTM_03447 Verify Header at Manage Product's Collection table
    [TAGS]    TC_iTM_03447    ready    regression    product_collection    manage_collection    collection    phoenix
    Collections - Go To Collections Management Page
    Collections - Go To Product In Collection    1
    ${data}=    Get Table Cell    ${PRODUCT-IN-COLLECTION-TABLE}    1    1
    Should Be Equal    ${data}    Product Name
    ${data}=    Get Table Cell    ${PRODUCT-IN-COLLECTION-TABLE}    1    2
    Should Be Equal    ${data}    Name
    ${data}=    Get Table Cell    ${PRODUCT-IN-COLLECTION-TABLE}    1    3
    Should Be Equal    ${data}    Product Key
    ${data}=    Get Table Cell    ${PRODUCT-IN-COLLECTION-TABLE}    1    4
    Should Be Equal    ${data}    Merchant Code/Alias Code
    ${data}=    Get Table Cell    ${PRODUCT-IN-COLLECTION-TABLE}    1    5
    Should Be Equal    ${data}    Merchant Name/Alias Name
    ${data}=    Get Table Cell    ${PRODUCT-IN-COLLECTION-TABLE}    1    6
    Should Be Equal    ${data}    Product Status
    ${data}=    Get Table Cell    ${PRODUCT-IN-COLLECTION-TABLE}    1    7
    Should Be Equal    ${data}    Action

TC_iTM_03448 Verify Merchant Name and Merchant Code at Manage Product's Collection table
    [TAGS]    TC_iTM_03448    ready    regression    product_collection    manage_collection    collection    phoenix
    Collections - Go To Collections Management Page
    Collections - Go To Product In Collection    1
    ${pKey}=    Get Table Cell    ${PRODUCT-IN-COLLECTION-TABLE}    2    3
    ${merchant_code_alias_code_table}=    Get Table Cell    ${PRODUCT-IN-COLLECTION-TABLE}    2    4
    ${merchant_name_alias_name_table}=    Get Table Cell    ${PRODUCT-IN-COLLECTION-TABLE}    2    5
    @{merchant_code_alias_code_table_list}=    Split String    ${merchant_code_alias_code_table}    /
    @{merchant_name_alias_name_table_list}=    Split String    ${merchant_name_alias_name_table}    /

    ${product_alias_code_db}    ${product_alias_name_db}=    Get Product Alias Code and Name from DB by Product pkey    ${pKey}
    ${merchant_code_db}    ${merchant_name_db}=    Get Merchant Code and Name from DB by Product pkey    ${pKey}

    ${merchant_code_valid}=    Run Keyword and return status    Set Variable    @{merchant_code_alias_code_table_list}[0]
    ${merchant_code_table}=    Set Variable If    ${merchant_code_valid}    @{merchant_code_alias_code_table_list}[0]    ${EMPTY}
    ${merchant_name_valid}=    Run Keyword and return status    Set Variable    @{merchant_name_alias_name_table_list}[0]
    ${merchant_name_table}=    Set Variable If    ${merchant_name_valid}    @{merchant_name_alias_name_table_list}[0]    ${EMPTY}

    ${alias_code_valid}=    Run Keyword and return status    Set Variable    @{merchant_code_alias_code_table_list}[1]
    ${product_alias_code}=    Set Variable If    ${alias_code_valid}    @{merchant_code_alias_code_table_list}[1]    ${EMPTY}
    ${alias_name_valid}=    Run Keyword and return status    Set Variable    @{merchant_name_alias_name_table_list}[1]
    ${product_alias_name}=    Set Variable If    ${alias_name_valid}    @{merchant_name_alias_name_table_list}[1]    ${EMPTY}

    ${product_alias_code_db}=    Strip And Convert To Uppercase If variable is String    ${product_alias_code_db}
    ${product_alias_name_db}=    Strip And Convert To Uppercase If variable is String    ${product_alias_name_db}
    ${product_alias_code}=    Strip And Convert To Uppercase If variable is String    ${product_alias_code}
    ${product_alias_name}=    Strip And Convert To Uppercase If variable is String    ${product_alias_name}
    ${merchant_code_table}=    Strip And Convert To Uppercase If variable is String    ${merchant_code_table}
    ${merchant_name_table}=    Strip And Convert To Uppercase If variable is String    ${merchant_name_table}
    ${merchant_code_db}=    Strip And Convert To Uppercase If variable is String    ${merchant_code_db}
    ${merchant_name_db}=    Strip And Convert To Uppercase If variable is String    ${merchant_name_db}

    Should Be Equal    '${product_alias_code}'    '${product_alias_code_db}'
    Should Be Equal    '${product_alias_name}'    '${product_alias_name_db}'
    Should Be Equal    '${merchant_code_table}'    '${merchant_code_db}'
    Should Be Equal    '${merchant_name_table}'    '${merchant_name_db}'

TC_iTM_03440 Show Alias Merchant Code & Alias Merchant Name on Product When Alias Merchant has Product [Manage Collection]
    [TAGS]    TC_iTM_03440    ready    regression    product_collection    manage_collection    collection    phoenix
    ${product}=    Merchant Alias - Get detail products and alias merchant
    ${pkey}=    Set Variable    ${product[0][0]}
    ${name}=    Set Variable    ${product[0][2]}
    ${product_id}=    Set Variable    ${product[0][1]}
    Collections - Create collection by collection collectionkey    ${collection_pkey_alias}    collection for test alias 1

    @{data_name}=       Create List     Collection,Product Key
    @{data_value1}=     Create List     ${collection_pkey_alias},${pkey}

    @{data}=     Create List     ${data_name}     ${data_value1}
    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    Go to mass upload menu
    User browse file for upload product to cate    ${file_upload}
    Collections - Go To Collections Management Page
    Choose product link in collection has alias


    ${pKey}=    Get Table Cell    ${PRODUCT-IN-COLLECTION-TABLE}    2    3
    ${merchant_code_alias_code_table}=    Get Table Cell    ${PRODUCT-IN-COLLECTION-TABLE}    2    4
    ${merchant_name_alias_name_table}=    Get Table Cell    ${PRODUCT-IN-COLLECTION-TABLE}    2    5
    @{merchant_code_alias_code_table_list}=    Split String    ${merchant_code_alias_code_table}    /
    @{merchant_name_alias_name_table_list}=    Split String    ${merchant_name_alias_name_table}    /

    ${product_alias_code_db}    ${product_alias_name_db}=    Get Product Alias Code and Name from DB by Product pkey    ${pKey}
    ${merchant_code_db}    ${merchant_name_db}=    Get Merchant Code and Name from DB by Product pkey    ${pKey}

    ${merchant_code_valid}=    Run Keyword and return status    Set Variable    @{merchant_code_alias_code_table_list}[0]
    ${merchant_code_table}=    Set Variable If    ${merchant_code_valid}    @{merchant_code_alias_code_table_list}[0]    ${EMPTY}
    ${merchant_name_valid}=    Run Keyword and return status    Set Variable    @{merchant_name_alias_name_table_list}[0]
    ${merchant_name_table}=    Set Variable If    ${merchant_name_valid}    @{merchant_name_alias_name_table_list}[0]    ${EMPTY}

    ${alias_code_valid}=    Run Keyword and return status    Set Variable    @{merchant_code_alias_code_table_list}[1]
    ${product_alias_code}=    Set Variable If    ${alias_code_valid}    @{merchant_code_alias_code_table_list}[1]    ${EMPTY}
    ${alias_name_valid}=    Run Keyword and return status    Set Variable    @{merchant_name_alias_name_table_list}[1]
    ${product_alias_name}=    Set Variable If    ${alias_name_valid}    @{merchant_name_alias_name_table_list}[1]    ${EMPTY}

    ${product_alias_code_db}=    Strip And Convert To Uppercase If variable is String    ${product_alias_code_db}
    ${product_alias_name_db}=    Strip And Convert To Uppercase If variable is String    ${product_alias_name_db}
    ${product_alias_code}=       Strip And Convert To Uppercase If variable is String    ${product_alias_code}
    ${product_alias_name}=       Strip And Convert To Uppercase If variable is String    ${product_alias_name}
    ${merchant_code_table}=      Strip And Convert To Uppercase If variable is String    ${merchant_code_table}
    ${merchant_name_table}=      Strip And Convert To Uppercase If variable is String    ${merchant_name_table}
    ${merchant_code_db}=    Strip And Convert To Uppercase If variable is String    ${merchant_code_db}
    ${merchant_name_db}=    Strip And Convert To Uppercase If variable is String    ${merchant_name_db}

    Should Be Equal    '${product_alias_code}'     '${product_alias_code_db}'
    Should Be Equal    '${product_alias_name}'     '${product_alias_name_db}'
    Should Be Equal    '${merchant_code_table}'    '${merchant_code_db}'
    Should Be Equal    '${merchant_name_table}'    '${merchant_name_db}'


TC_iTM_03441 Don't Show Alias Merchant Code & Alias Merchant Name on Product When Alias Merchant has not Product Collection [Manage Collection]
    [TAGS]    TC_iTM_03441    ready    regression    product_collection    manage_collection    collection    phoenix
    ${product}=    Product - Get product not in alias merchant
    ${pkey}=    Set Variable    ${product[0][0]}
    ${name}=    Set Variable    ${product[0][2]}
    ${product_id}=    Set Variable    ${product[0][1]}
    Collections - Create collection by collection collectionkey    ${collection_pkey_not_alias}    collection for test alias 2

    @{data_name}=       Create List     Collection,Product Key
    @{data_value1}=     Create List     ${collection_pkey_not_alias},${pkey}

    @{data}=     Create List     ${data_name}     ${data_value1}
    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}
    Go to mass upload menu
    User browse file for upload product to cate    ${file_upload}
    Collections - Go To Collections Management Page
    Choose product link in collection has not alias


    ${pKey}=    Get Table Cell    ${PRODUCT-IN-COLLECTION-TABLE}    2    3
    ${merchant_code_alias_code_table}=    Get Table Cell    ${PRODUCT-IN-COLLECTION-TABLE}    2    4
    ${merchant_name_alias_name_table}=    Get Table Cell    ${PRODUCT-IN-COLLECTION-TABLE}    2    5
    @{merchant_code_alias_code_table_list}=    Split String    ${merchant_code_alias_code_table}    /
    @{merchant_name_alias_name_table_list}=    Split String    ${merchant_name_alias_name_table}    /

    ${product_alias_code_db}    ${product_alias_name_db}=    Get Product Alias Code and Name from DB by Product pkey    ${pKey}
    ${merchant_code_db}    ${merchant_name_db}=    Get Merchant Code and Name from DB by Product pkey    ${pKey}

    ${merchant_code_valid}=    Run Keyword and return status    Set Variable    @{merchant_code_alias_code_table_list}[0]
    ${merchant_code_table}=    Set Variable If    ${merchant_code_valid}    @{merchant_code_alias_code_table_list}[0]    ${EMPTY}
    ${merchant_name_valid}=    Run Keyword and return status    Set Variable    @{merchant_name_alias_name_table_list}[0]
    ${merchant_name_table}=    Set Variable If    ${merchant_name_valid}    @{merchant_name_alias_name_table_list}[0]    ${EMPTY}

    ${alias_code_valid}=    Run Keyword and return status    Set Variable    @{merchant_code_alias_code_table_list}[1]
    ${product_alias_code}=    Set Variable If    ${alias_code_valid}    @{merchant_code_alias_code_table_list}[1]    ${EMPTY}
    ${alias_name_valid}=    Run Keyword and return status    Set Variable    @{merchant_name_alias_name_table_list}[1]
    ${product_alias_name}=    Set Variable If    ${alias_name_valid}    @{merchant_name_alias_name_table_list}[1]    ${EMPTY}

    ${product_alias_code_db}=    Strip And Convert To Uppercase If variable is String    ${product_alias_code_db}
    ${product_alias_name_db}=    Strip And Convert To Uppercase If variable is String    ${product_alias_name_db}
    ${product_alias_code}=    Strip And Convert To Uppercase If variable is String    ${product_alias_code}
    ${product_alias_name}=    Strip And Convert To Uppercase If variable is String    ${product_alias_name}
    ${merchant_code_table}=    Strip And Convert To Uppercase If variable is String    ${merchant_code_table}
    ${merchant_name_table}=    Strip And Convert To Uppercase If variable is String    ${merchant_name_table}
    ${merchant_code_db}=    Strip And Convert To Uppercase If variable is String    ${merchant_code_db}
    ${merchant_name_db}=    Strip And Convert To Uppercase If variable is String    ${merchant_name_db}

    Should Be Equal    '${product_alias_code}'    '${product_alias_code_db}'
    Should Be Equal    '${product_alias_name}'    '${product_alias_name_db}'
    Should Be Equal    '${merchant_code_table}'    '${merchant_code_db}'
    Should Be Equal    '${merchant_name_table}'    '${merchant_name_db}'