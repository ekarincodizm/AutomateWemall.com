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
Library           ${CURDIR}/../../../Python_Library/Category.py

Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/Keywords_PDS_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/Keyword_PDS_Export_Product_Under_Category.robot
Resource          ${CURDIR}/../../../Keyword/API/PDS/pds_api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/Keywords_PDS_Common.robot
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/webelement_PCMS_Category_Management.robot
Resource          ${CURDIR}/../../../Keyword/Database/PDS/keyword_merchant.robot
Resource          ${CURDIR}/../../../Keyword/Database/PDS/keyword_categories.robot
Resource          ${CURDIR}/../../../Keyword/Database/PDS/keyword_products.robot

Test Setup        Run Keywords    Login Pcms    AND    Maximize Browser Window
# Test Teardown     Close All Browsers

*** Test Cases ***
TC_ITMWM_05056 - Export product under category that has no product - success
    [Tags]    TC_ITMWM_05056    regression    ready    phoenix    WLS_Medium
    #Prerequisite:

    ##..Create new merchant
    ${tc_number}=    Get Test Case Number
    ${merchant_code}=    Set Variable    ${tc_number}
    ${merchant_name}=    Set Variable    Name-${tc_number}
    ${merchant_shop_id}=     Create Merchant in DB    "${merchant_name}"    "${merchant_code}"

    ##..Create merchant's categories
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner         "${merchant_code}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type    "merchant"

    ###.. CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    1    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating
    ${cat_pkey_1}=     Get Category Pkey After Creating

    ###.. CATEGORY 1-1.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-1_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_1_1}=     Get Category ID After Creating
    ${cat_pkey_1_1_1}=     Get Category Pkey After Creating
    #End Prerequisite

    Go To Category Management Page
    Go To Category Management Tab

    ${drop_down_select_merchant}=    Set Variable    //select[@id='selectMerchant']
    Wait Until Element Is Visible    ${drop_down_select_merchant}    60s

    Sleep    3s
    Select Merchant / Alias By Name    ${merchant_name}

    ${cate_id_1_action_button}=    Set Variable    //button[@id='single-button-${cat_id_1}']
    ${cat_id_1_1_1_action_button}=    Set Variable    //button[@id='single-button-${cat_id_1_1_1}']

    ${cate_id_1_export_button}=    Set Variable    //li[@id='btn-export-products-${cat_id_1}']/a
    ${cat_id_1_1_1_export_button}=    Set Variable    //li[@id='btn-export-products-${cat_id_1_1_1}']/a

    Expand or Collapse Sub-Categories under Category    1

    Wait Until Element Is Enabled    ${cat_id_1_1_1_action_button}    45
    Click Element    ${cat_id_1_1_1_action_button}
    Element Should Not Be Visible    ${cat_id_1_1_1_export_button}

    Click Element    ${cate_id_1_action_button}
    Element Should Not Be Visible    ${cate_id_1_export_button}

    [Teardown]    Run Keywords    Delete Merchant From DB    ${merchant_shop_id}
   ...    AND    Run keyword If    "${cat_id_1_1_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_1_1}\
   ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}\
   ...    AND    Close All Browsers

TC_ITMWM_05057 - Export product under category that has products - success
    [Tags]    TC_ITMWM_05057    regression    ready    phoenix    WLS_Medium
    #Prerequisite:

    ##..Create new merchant
    ${tc_number}=    Get Test Case Number
    ${merchant_code}=    Set Variable    ${tc_number}
    ${merchant_name}=    Set Variable    Name-${tc_number}
    ${merchant_shop_id}=     Create Merchant in DB    "${merchant_name}"    "${merchant_code}"

    ##..Create merchant's categories
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner         "${merchant_code}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type    "merchant"

    ###.. CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    1    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating
    ${cat_pkey_1}=     Get Category Pkey After Creating


    ${product_pkey_1}=     Set Variable    &{product-disc-1}[pkey]

    ###.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey_1}    ${product_pkey_1}
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Log to console    response==@{response}
    #End Prerequisite


    Go To Category Management Page
    Go To Category Management Tab

    ${drop_down_select_merchant}=    Set Variable    //select[@id='selectMerchant']
    Wait Until Element Is Visible    ${drop_down_select_merchant}    60s

    Sleep    3s
    Select Merchant / Alias By Name    ${merchant_name}

    ${cate_id_1_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_1}

    ${cate_id_1_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_1}

    Wait Until Element Is Enabled    ${cate_id_1_action_button}    45
    Click Element    ${cate_id_1_action_button}
    Click Element    ${cate_id_1_export_button}

    #Handle CSV file
    ${filename}=    Set Variable    ${CURDIR}/../../../Resource/TestData/Category/csv_file/merchant_categories_export_product_under_category.csv

    ${cookies}    Get Cookies
    sleep    10s
    ${export_url}=    Set Variable    ${API_GATEWAY}${PDS-API-URI}/categories/${cat_pkey_1}/products/export
    Log to console    export_url==${export_url}
    Log to console    cat_pkey_1==${cat_pkey_1}
    write_download_file    ${cookies}    ${export_url}    ${filename}

    #Get data from CSV file
    ${export_data_dict_list}=    get_exported_products_under_merchant_categories_data_csv    ${filename}

    #Prepare data for verify
    ${product_pkey_list}=    Create List    ${product_pkey_1}
    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_1}=${product_pkey_list}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_1}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_1}    ${expect_data_list}    ${expect_data_dict}

    [Teardown]    Run Keywords    Delete Merchant From DB    ${merchant_shop_id}
   ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}\
   ...    AND    Close All Browsers

TC_ITMWM_05058 - Export product under sub category that has products - success
    [Tags]    TC_ITMWM_05058    regression    ready    phoenix    WLS_Medium
    #Prerequisite:

    ##..Create new merchant
    ${tc_number}=    Get Test Case Number
    ${merchant_code}=    Set Variable    ${tc_number}
    ${merchant_name}=    Set Variable    Name-${tc_number}
    ${merchant_shop_id}=     Create Merchant in DB    "${merchant_name}"    "${merchant_code}"

    ##..Create merchant's categories
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner         "${merchant_code}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type    "merchant"

    ###.. CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    1    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating
    ${cat_pkey_1}=     Get Category Pkey After Creating

    ###.. CATEGORY 2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_2}=     Get Category ID After Creating
    ${cat_pkey_2}=     Get Category Pkey After Creating

    ###.. CATEGORY 3
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_2}    ${file_data}
    ${cat_id_3}=     Get Category ID After Creating
    ${cat_pkey_3}=     Get Category Pkey After Creating

    ###.. CATEGORY 4
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-4"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3}    ${file_data}
    ${cat_id_4}=     Get Category ID After Creating
    ${cat_pkey_4}=     Get Category Pkey After Creating

    ###.. CATEGORY 5
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-5"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_4}    ${file_data}
    ${cat_id_5}=     Get Category ID After Creating
    ${cat_pkey_5}=     Get Category Pkey After Creating

    ###.. CATEGORY 6
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-6"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_5}    ${file_data}
    ${cat_id_6}=     Get Category ID After Creating
    ${cat_pkey_6}=     Get Category Pkey After Creating


    ${product_pkey_1}=     Set Variable    &{product-disc-1}[pkey]
    ${product_pkey_2}=     Set Variable    &{product-disc-2}[pkey]
    ${product_pkey_3}=     Set Variable    &{product-disc-3}[pkey]
    ${product_pkey_4}=     Set Variable    &{product-disc-4}[pkey]
    ${product_pkey_5}=     Set Variable    &{product-disc-5}[pkey]
    ${product_pkey_6}=     Set Variable    &{product-disc-6}[pkey]

    ###.. Generate CSV file to be uploaded

    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey_1}    ${product_pkey_1}
    @{data_value2}=    Create List    ${cat_pkey_2}    ${product_pkey_2}
    @{data_value3}=    Create List    ${cat_pkey_3}    ${product_pkey_3}
    @{data_value4}=    Create List    ${cat_pkey_4}    ${product_pkey_4}
    @{data_value5}=    Create List    ${cat_pkey_5}    ${product_pkey_5}
    @{data_value6}=    Create List    ${cat_pkey_6}    ${product_pkey_6}

    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}    ${data_value4}    ${data_value5}    ${data_value6}

    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Log to console    response==@{response}
    #End Prerequisite

    Go To Category Management Page
    Go To Category Management Tab

    ${drop_down_select_merchant}=    Set Variable    //select[@id='selectMerchant']
    Wait Until Element Is Visible    ${drop_down_select_merchant}    60s

    Sleep    3s
    Select Merchant / Alias By Name    ${merchant_name}

    Expand or Collapse Sub-Categories under Category    1
    Expand or Collapse Sub-Categories under Category    1    1.1
    Expand or Collapse Sub-Categories under Category    1    2.1
    Expand or Collapse Sub-Categories under Category    1    3.1
    Expand or Collapse Sub-Categories under Category    1    4.1

    ###Test Export Level 2
    ${cate_id_2_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_2}
    ${cate_id_2_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_2}

    Wait Until Element Is Enabled    ${cate_id_2_action_button}    45
    Click Element    ${cate_id_2_action_button}
    Click Element    ${cate_id_2_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_2}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_2_list}=    Create List    ${product_pkey_2}   ${product_pkey_3}   ${product_pkey_4}   ${product_pkey_5}    ${product_pkey_6}

    ${product_pkey_in_cate_lv_3_list}=    Create List    ${product_pkey_3}   ${product_pkey_4}   ${product_pkey_5}   ${product_pkey_6}

    ${product_pkey_in_cate_lv_4_list}=    Create List   ${product_pkey_4}   ${product_pkey_5}   ${product_pkey_6}
    ${product_pkey_in_cate_lv_5_list}=    Create List   ${product_pkey_5}   ${product_pkey_6}
    ${product_pkey_in_cate_lv_6_list}=    Create List    ${product_pkey_6}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_2}    ${cat_pkey_3}    ${cat_pkey_4}    ${cat_pkey_5}    ${cat_pkey_6}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_2}=${product_pkey_in_cate_lv_2_list}    ${cat_pkey_3}=${product_pkey_in_cate_lv_3_list}    ${cat_pkey_4}=${product_pkey_in_cate_lv_4_list}    ${cat_pkey_5}=${product_pkey_in_cate_lv_5_list}    ${cat_pkey_6}=${product_pkey_in_cate_lv_6_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_2}    ${expect_data_list}    ${expect_data_dict}


    ###Test Export Level 3
    ${cate_id_3_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_3}
    ${cate_id_3_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_3}

    Wait Until Element Is Enabled    ${cate_id_3_action_button}    45
    Click Element    ${cate_id_3_action_button}
    Click Element    ${cate_id_3_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_3}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_3_list}=    Create List    ${product_pkey_3}   ${product_pkey_4}   ${product_pkey_5}   ${product_pkey_6}

    ${product_pkey_in_cate_lv_4_list}=    Create List   ${product_pkey_4}   ${product_pkey_5}   ${product_pkey_6}
    ${product_pkey_in_cate_lv_5_list}=    Create List   ${product_pkey_5}   ${product_pkey_6}
    ${product_pkey_in_cate_lv_6_list}=    Create List    ${product_pkey_6}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_3}    ${cat_pkey_4}    ${cat_pkey_5}    ${cat_pkey_6}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_3}=${product_pkey_in_cate_lv_3_list}    ${cat_pkey_4}=${product_pkey_in_cate_lv_4_list}    ${cat_pkey_5}=${product_pkey_in_cate_lv_5_list}    ${cat_pkey_6}=${product_pkey_in_cate_lv_6_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_3}    ${expect_data_list}    ${expect_data_dict}

    ###Test Export Level 4
    ${cate_id_4_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_4}
    ${cate_id_4_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_4}

    Wait Until Element Is Enabled    ${cate_id_4_action_button}    45
    Click Element    ${cate_id_4_action_button}
    Click Element    ${cate_id_4_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_4}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_4_list}=    Create List   ${product_pkey_4}   ${product_pkey_5}   ${product_pkey_6}
    ${product_pkey_in_cate_lv_5_list}=    Create List   ${product_pkey_5}   ${product_pkey_6}
    ${product_pkey_in_cate_lv_6_list}=    Create List    ${product_pkey_6}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_4}    ${cat_pkey_5}    ${cat_pkey_6}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_4}=${product_pkey_in_cate_lv_4_list}    ${cat_pkey_5}=${product_pkey_in_cate_lv_5_list}    ${cat_pkey_6}=${product_pkey_in_cate_lv_6_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_4}    ${expect_data_list}    ${expect_data_dict}

    ###Test Export Level 5
    ${cate_id_5_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_5}
    ${cate_id_5_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_5}

    Wait Until Element Is Enabled    ${cate_id_5_action_button}    45
    Click Element    ${cate_id_5_action_button}
    Click Element    ${cate_id_5_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_5}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_5_list}=    Create List   ${product_pkey_5}   ${product_pkey_6}
    ${product_pkey_in_cate_lv_6_list}=    Create List    ${product_pkey_6}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_5}    ${cat_pkey_6}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_5}=${product_pkey_in_cate_lv_5_list}    ${cat_pkey_6}=${product_pkey_in_cate_lv_6_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_5}    ${expect_data_list}    ${expect_data_dict}


    ###Test Export Level 6
    ${cate_id_6_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_6}
    ${cate_id_6_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_6}

    Wait Until Element Is Enabled    ${cate_id_6_action_button}    45
    Click Element    ${cate_id_6_action_button}
    Click Element    ${cate_id_6_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_6}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_6_list}=    Create List    ${product_pkey_6}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_6}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_6}=${product_pkey_in_cate_lv_6_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_6}    ${expect_data_list}    ${expect_data_dict}

    [Teardown]    Run Keywords    Delete Merchant From DB    ${merchant_shop_id}
   ...    AND    Run keyword If    "${cat_id_6}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_6}\
   ...    AND    Run keyword If    "${cat_id_5}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_5}\
   ...    AND    Run keyword If    "${cat_id_4}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_4}\
   ...    AND    Run keyword If    "${cat_id_3}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3}\
   ...    AND    Run keyword If    "${cat_id_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2}\
   ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}\
   ...    AND    Close All Browsers

TC_ITMWM_05059 - Export product under category that has own products and some same products from its sub categories - success
    [Tags]    TC_ITMWM_05059    regression    ready    phoenix    WLS_Medium
    #Prerequisite:

    ##..Create new merchant
    ${tc_number}=    Get Test Case Number
    ${merchant_code}=    Set Variable    ${tc_number}
    ${merchant_name}=    Set Variable    Name-${tc_number}
    ${merchant_shop_id}=     Create Merchant in DB    "${merchant_name}"    "${merchant_code}"

    ##..Create merchant's categories
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner         "${merchant_code}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type    "merchant"

    ###.. CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    1    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating
    ${cat_pkey_1}=     Get Category Pkey After Creating

    ###.. CATEGORY 2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_2}=     Get Category ID After Creating
    ${cat_pkey_2}=     Get Category Pkey After Creating

    ###.. CATEGORY 3
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_2}    ${file_data}
    ${cat_id_3}=     Get Category ID After Creating
    ${cat_pkey_3}=     Get Category Pkey After Creating

    ###.. CATEGORY 4
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-4"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3}    ${file_data}
    ${cat_id_4}=     Get Category ID After Creating
    ${cat_pkey_4}=     Get Category Pkey After Creating

    ###.. CATEGORY 5
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-5"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_4}    ${file_data}
    ${cat_id_5}=     Get Category ID After Creating
    ${cat_pkey_5}=     Get Category Pkey After Creating

    ###.. CATEGORY 6
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-6"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_5}    ${file_data}
    ${cat_id_6}=     Get Category ID After Creating
    ${cat_pkey_6}=     Get Category Pkey After Creating


    ${product_pkey_1}=     Set Variable    &{product-disc-1}[pkey]
    ${product_pkey_2}=     Set Variable    &{product-disc-2}[pkey]
    ${product_pkey_3}=     Set Variable    &{product-disc-3}[pkey]
    ${product_pkey_4}=     Set Variable    &{product-disc-4}[pkey]

    ###.. Generate CSV file to be uploaded

    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey_1}    ${product_pkey_1}
    @{data_value2}=    Create List    ${cat_pkey_2}    ${product_pkey_2}
    @{data_value3}=    Create List    ${cat_pkey_3}    ${product_pkey_1}
    @{data_value4}=    Create List    ${cat_pkey_3}    ${product_pkey_3}
    @{data_value5}=    Create List    ${cat_pkey_5}    ${product_pkey_3}
    @{data_value6}=    Create List    ${cat_pkey_6}    ${product_pkey_2}
    @{data_value7}=    Create List    ${cat_pkey_6}    ${product_pkey_4}

    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}    ${data_value4}    ${data_value5}    ${data_value6}    ${data_value7}

    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Log to console    response==@{response}
    #End Prerequisite

    Go To Category Management Page
    Go To Category Management Tab

    ${drop_down_select_merchant}=    Set Variable    //select[@id='selectMerchant']
    Wait Until Element Is Visible    ${drop_down_select_merchant}    60s

    Sleep    3s
    Select Merchant / Alias By Name    ${merchant_name}

    Expand or Collapse Sub-Categories under Category    1
    Expand or Collapse Sub-Categories under Category    1    1.1
    Expand or Collapse Sub-Categories under Category    1    2.1
    Expand or Collapse Sub-Categories under Category    1    3.1
    Expand or Collapse Sub-Categories under Category    1    4.1

	###Test Export Level 2
    ${cate_id_2_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_2}
    ${cate_id_2_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_2}

    Wait Until Element Is Enabled    ${cate_id_2_action_button}    45
    Click Element    ${cate_id_2_action_button}
    Click Element    ${cate_id_2_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_2}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_2_list}=    Create List    ${product_pkey_2}   ${product_pkey_1}   ${product_pkey_3}   ${product_pkey_4}

    ${product_pkey_in_cate_lv_3_list}=    Create List    ${product_pkey_1}   ${product_pkey_3}   ${product_pkey_2}   ${product_pkey_4}

    ${product_pkey_in_cate_lv_4_list}=    Create List   ${product_pkey_3}   ${product_pkey_2}   ${product_pkey_4}
    ${product_pkey_in_cate_lv_5_list}=    Create List   ${product_pkey_3}   ${product_pkey_2}   ${product_pkey_4}
    ${product_pkey_in_cate_lv_6_list}=    Create List    ${product_pkey_2}   ${product_pkey_4}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_2}    ${cat_pkey_3}    ${cat_pkey_3}    ${cat_pkey_5}    ${cat_pkey_6}    ${cat_pkey_6}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_2}=${product_pkey_in_cate_lv_2_list}    ${cat_pkey_3}=${product_pkey_in_cate_lv_3_list}    ${cat_pkey_4}=${product_pkey_in_cate_lv_4_list}    ${cat_pkey_5}=${product_pkey_in_cate_lv_5_list}    ${cat_pkey_6}=${product_pkey_in_cate_lv_6_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_2}    ${expect_data_list}    ${expect_data_dict}


    ###Test Export Level 3
    ${cate_id_3_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_3}
    ${cate_id_3_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_3}

    Wait Until Element Is Enabled    ${cate_id_3_action_button}    45
    Click Element    ${cate_id_3_action_button}
    Click Element    ${cate_id_3_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_3}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_3_list}=    Create List    ${product_pkey_1}   ${product_pkey_3}   ${product_pkey_2}   ${product_pkey_4}

    ${product_pkey_in_cate_lv_4_list}=    Create List   ${product_pkey_3}   ${product_pkey_2}   ${product_pkey_4}
    ${product_pkey_in_cate_lv_5_list}=    Create List   ${product_pkey_3}   ${product_pkey_2}   ${product_pkey_4}
    ${product_pkey_in_cate_lv_6_list}=    Create List    ${product_pkey_2}   ${product_pkey_4}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_3}    ${cat_pkey_3}    ${cat_pkey_5}    ${cat_pkey_6}    ${cat_pkey_6}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_3}=${product_pkey_in_cate_lv_3_list}    ${cat_pkey_4}=${product_pkey_in_cate_lv_4_list}    ${cat_pkey_5}=${product_pkey_in_cate_lv_5_list}    ${cat_pkey_6}=${product_pkey_in_cate_lv_6_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_3}    ${expect_data_list}    ${expect_data_dict}

    ###Test Export Level 4
    ${cate_id_4_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_4}
    ${cate_id_4_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_4}

    Wait Until Element Is Enabled    ${cate_id_4_action_button}    45
    Click Element    ${cate_id_4_action_button}
    Click Element    ${cate_id_4_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_4}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_4_list}=    Create List   ${product_pkey_3}   ${product_pkey_2}   ${product_pkey_4}
    ${product_pkey_in_cate_lv_5_list}=    Create List   ${product_pkey_3}   ${product_pkey_2}   ${product_pkey_4}
    ${product_pkey_in_cate_lv_6_list}=    Create List    ${product_pkey_2}   ${product_pkey_4}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_5}    ${cat_pkey_6}    ${cat_pkey_6}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_4}=${product_pkey_in_cate_lv_4_list}    ${cat_pkey_5}=${product_pkey_in_cate_lv_5_list}    ${cat_pkey_6}=${product_pkey_in_cate_lv_6_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_4}    ${expect_data_list}    ${expect_data_dict}

    ###Test Export Level 5
    ${cate_id_5_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_5}
    ${cate_id_5_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_5}

    Wait Until Element Is Enabled    ${cate_id_5_action_button}    45
    Click Element    ${cate_id_5_action_button}
    Click Element    ${cate_id_5_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_5}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_5_list}=    Create List   ${product_pkey_3}   ${product_pkey_2}   ${product_pkey_4}
    ${product_pkey_in_cate_lv_6_list}=    Create List    ${product_pkey_2}   ${product_pkey_4}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_5}    ${cat_pkey_6}    ${cat_pkey_6}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_5}=${product_pkey_in_cate_lv_5_list}    ${cat_pkey_6}=${product_pkey_in_cate_lv_6_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_5}    ${expect_data_list}    ${expect_data_dict}


    ###Test Export Level 6
    ${cate_id_6_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_6}
    ${cate_id_6_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_6}

    Wait Until Element Is Enabled    ${cate_id_6_action_button}    45
    Click Element    ${cate_id_6_action_button}
    Click Element    ${cate_id_6_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_6}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_6_list}=    Create List    ${product_pkey_2}   ${product_pkey_4}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_6}    ${cat_pkey_6}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_6}=${product_pkey_in_cate_lv_6_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_6}    ${expect_data_list}    ${expect_data_dict}


    [Teardown]    Run Keywords    Delete Merchant From DB    ${merchant_shop_id}
   ...    AND    Run keyword If    "${cat_id_6}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_6}\
   ...    AND    Run keyword If    "${cat_id_5}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_5}\
   ...    AND    Run keyword If    "${cat_id_4}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_4}\
   ...    AND    Run keyword If    "${cat_id_3}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3}\
   ...    AND    Run keyword If    "${cat_id_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2}\
   ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}\
   ...    AND    Close All Browsers

TC_ITMWM_05622 - Export product under category that has own products and some products from its sub categories with some stock - success
    [Tags]    TC_ITMWM_05622    regression    ready    phoenix    WLS_Medium
    #Prerequisite:

    ##..Create new merchant
    ${tc_number}=    Get Test Case Number
    ${merchant_code}=    Set Variable    ${tc_number}
    ${merchant_name}=    Set Variable    Name-${tc_number}
    ${merchant_shop_id}=     Create Merchant in DB    "${merchant_name}"    "${merchant_code}"

    ##..Create merchant's categories
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner         "${merchant_code}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type    "merchant"

    ###.. CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    1    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating
    ${cat_pkey_1}=     Get Category Pkey After Creating

    ###.. CATEGORY 2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_2}=     Get Category ID After Creating
    ${cat_pkey_2}=     Get Category Pkey After Creating

    ###.. CATEGORY 3
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_2}    ${file_data}
    ${cat_id_3}=     Get Category ID After Creating
    ${cat_pkey_3}=     Get Category Pkey After Creating

    ###.. CATEGORY 4
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-4"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3}    ${file_data}
    ${cat_id_4}=     Get Category ID After Creating
    ${cat_pkey_4}=     Get Category Pkey After Creating

    ###.. CATEGORY 5
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-5"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_4}    ${file_data}
    ${cat_id_5}=     Get Category ID After Creating
    ${cat_pkey_5}=     Get Category Pkey After Creating

    ###.. CATEGORY 6
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-6"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_5}    ${file_data}
    ${cat_id_6}=     Get Category ID After Creating
    ${cat_pkey_6}=     Get Category Pkey After Creating


    ${product_pkey_1}=     Set Variable    &{product-disc-1}[pkey]
    ${product_pkey_2}=     Set Variable    &{product-disc-2}[pkey]
    ${product_pkey_3}=     Set Variable    &{product-disc-3}[pkey]
    ${product_pkey_4}=     Set Variable    &{product-disc-4}[pkey]

    ###.. Generate CSV file to be uploaded

    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey_1}    ${product_pkey_1}
    @{data_value2}=    Create List    ${cat_pkey_2}    ${product_pkey_2}
    @{data_value3}=    Create List    ${cat_pkey_3}    ${product_pkey_1}
    @{data_value4}=    Create List    ${cat_pkey_3}    ${product_pkey_3}
    @{data_value5}=    Create List    ${cat_pkey_5}    ${product_pkey_3}
    @{data_value6}=    Create List    ${cat_pkey_6}    ${product_pkey_2}
    @{data_value7}=    Create List    ${cat_pkey_6}    ${product_pkey_4}

    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}    ${data_value4}    ${data_value5}    ${data_value6}    ${data_value7}

    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Log to console    response==@{response}

    ###..Set stock for product
    Increase Stock By Inventory ID    &{product-disc-1}[sku]    10
    Increase Stock By Inventory ID    &{product-disc-2}[sku]    0
    Increase Stock By Inventory ID    &{product-disc-3}[sku]    2
    Increase Stock By Inventory ID    &{product-disc-4}[sku]    5
    #End Prerequisite

    Go To Category Management Page
    Go To Category Management Tab

    ${drop_down_select_merchant}=    Set Variable    //select[@id='selectMerchant']
    Wait Until Element Is Visible    ${drop_down_select_merchant}    60s

    Sleep    3s
    Select Merchant / Alias By Name    ${merchant_name}

    Expand or Collapse Sub-Categories under Category    1
    Expand or Collapse Sub-Categories under Category    1    1.1
    Expand or Collapse Sub-Categories under Category    1    2.1
    Expand or Collapse Sub-Categories under Category    1    3.1
    Expand or Collapse Sub-Categories under Category    1    4.1

    ###Test Export Level 2
    ${cate_id_2_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_2}
    ${cate_id_2_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_2}

    Click Element    ${cate_id_2_action_button}
    Click Element    ${cate_id_2_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_2}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_2_list}=    Create List    ${product_pkey_2}   ${product_pkey_1}   ${product_pkey_3}   ${product_pkey_4}

    ${product_pkey_in_cate_lv_3_list}=    Create List    ${product_pkey_1}   ${product_pkey_3}   ${product_pkey_2}   ${product_pkey_4}

    ${product_pkey_in_cate_lv_4_list}=    Create List   ${product_pkey_3}   ${product_pkey_2}   ${product_pkey_4}
    ${product_pkey_in_cate_lv_5_list}=    Create List   ${product_pkey_3}   ${product_pkey_2}   ${product_pkey_4}
    ${product_pkey_in_cate_lv_6_list}=    Create List    ${product_pkey_2}   ${product_pkey_4}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_2}    ${cat_pkey_3}    ${cat_pkey_3}    ${cat_pkey_5}    ${cat_pkey_6}    ${cat_pkey_6}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_2}=${product_pkey_in_cate_lv_2_list}    ${cat_pkey_3}=${product_pkey_in_cate_lv_3_list}    ${cat_pkey_4}=${product_pkey_in_cate_lv_4_list}    ${cat_pkey_5}=${product_pkey_in_cate_lv_5_list}    ${cat_pkey_6}=${product_pkey_in_cate_lv_6_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_2}    ${expect_data_list}    ${expect_data_dict}


    ###Test Export Level 3
    ${cate_id_3_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_3}
    ${cate_id_3_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_3}

    Click Element    ${cate_id_3_action_button}
    Click Element    ${cate_id_3_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_3}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_3_list}=    Create List    ${product_pkey_1}   ${product_pkey_3}   ${product_pkey_2}   ${product_pkey_4}

    ${product_pkey_in_cate_lv_4_list}=    Create List   ${product_pkey_3}   ${product_pkey_2}   ${product_pkey_4}
    ${product_pkey_in_cate_lv_5_list}=    Create List   ${product_pkey_3}   ${product_pkey_2}   ${product_pkey_4}
    ${product_pkey_in_cate_lv_6_list}=    Create List    ${product_pkey_2}   ${product_pkey_4}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_3}    ${cat_pkey_3}    ${cat_pkey_5}    ${cat_pkey_6}    ${cat_pkey_6}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_3}=${product_pkey_in_cate_lv_3_list}    ${cat_pkey_4}=${product_pkey_in_cate_lv_4_list}    ${cat_pkey_5}=${product_pkey_in_cate_lv_5_list}    ${cat_pkey_6}=${product_pkey_in_cate_lv_6_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_3}    ${expect_data_list}    ${expect_data_dict}

    ###Test Export Level 4
    ${cate_id_4_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_4}
    ${cate_id_4_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_4}

    Click Element    ${cate_id_4_action_button}
    Click Element    ${cate_id_4_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_4}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_4_list}=    Create List   ${product_pkey_3}   ${product_pkey_2}   ${product_pkey_4}
    ${product_pkey_in_cate_lv_5_list}=    Create List   ${product_pkey_3}   ${product_pkey_2}   ${product_pkey_4}
    ${product_pkey_in_cate_lv_6_list}=    Create List    ${product_pkey_2}   ${product_pkey_4}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_5}    ${cat_pkey_6}    ${cat_pkey_6}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_4}=${product_pkey_in_cate_lv_4_list}    ${cat_pkey_5}=${product_pkey_in_cate_lv_5_list}    ${cat_pkey_6}=${product_pkey_in_cate_lv_6_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_4}    ${expect_data_list}    ${expect_data_dict}

    ###Test Export Level 5
    ${cate_id_5_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_5}
    ${cate_id_5_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_5}

    Click Element    ${cate_id_5_action_button}
    Click Element    ${cate_id_5_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_5}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_5_list}=    Create List   ${product_pkey_3}   ${product_pkey_2}   ${product_pkey_4}
    ${product_pkey_in_cate_lv_6_list}=    Create List    ${product_pkey_2}   ${product_pkey_4}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_5}    ${cat_pkey_6}    ${cat_pkey_6}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_5}=${product_pkey_in_cate_lv_5_list}    ${cat_pkey_6}=${product_pkey_in_cate_lv_6_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_5}    ${expect_data_list}    ${expect_data_dict}


    ###Test Export Level 6
    ${cate_id_6_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_6}
    ${cate_id_6_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_6}

    Click Element    ${cate_id_6_action_button}
    Click Element    ${cate_id_6_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_6}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_6_list}=    Create List    ${product_pkey_2}   ${product_pkey_4}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_6}    ${cat_pkey_6}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_6}=${product_pkey_in_cate_lv_6_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_6}    ${expect_data_list}    ${expect_data_dict}


    [Teardown]    Run Keywords    Delete Merchant From DB    ${merchant_shop_id}
   ...    AND    Run keyword If    "${cat_id_6}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_6}\
   ...    AND    Run keyword If    "${cat_id_5}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_5}\
   ...    AND    Run keyword If    "${cat_id_4}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_4}\
   ...    AND    Run keyword If    "${cat_id_3}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3}\
   ...    AND    Run keyword If    "${cat_id_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2}\
   ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}\
   ...    AND    Close All Browsers

TC_ITMWM_05623 - Export product under category that has product at the same category branch but different level
    [Tags]    TC_ITMWM_05623    regression    ready    phoenix    WLS_Medium
    #Prerequisite:

    ##..Create new merchant
    ${tc_number}=    Get Test Case Number
    ${merchant_code}=    Set Variable    ${tc_number}
    ${merchant_name}=    Set Variable    Name-${tc_number}
    ${merchant_shop_id}=     Create Merchant in DB    "${merchant_name}"    "${merchant_code}"

    ##..Create merchant's categories
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner         "${merchant_code}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type    "merchant"

    ###.. CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    1    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating
    ${cat_pkey_1}=     Get Category Pkey After Creating

    ###.. CATEGORY 2.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_2-1}=     Get Category ID After Creating
    ${cat_pkey_2-1}=     Get Category Pkey After Creating

    ${product_pkey_1}=     Set Variable    &{product-disc-1}[pkey]

    ###.. Generate CSV file to be uploaded

    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey_1}    ${product_pkey_1}
    @{data_value2}=    Create List    ${cat_pkey_2-1}    ${product_pkey_1}

    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}

    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Log to console    response==@{response}

    ###..Set stock for product
    Increase Stock By Inventory ID    &{product-disc-1}[sku]    10
    #End Prerequisite

    Go To Category Management Page
    Go To Category Management Tab

    ${drop_down_select_merchant}=    Set Variable    //select[@id='selectMerchant']
    Wait Until Element Is Visible    ${drop_down_select_merchant}    60s

    Sleep    3s
    Select Merchant / Alias By Name    ${merchant_name}

    Expand or Collapse Sub-Categories under Category    1
    # Expand or Collapse Sub-Categories under Category    1    1.1
    # Expand or Collapse Sub-Categories under Category    1    1.2

    ###Test Export Level 1
    ${cate_id_1_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_1}
    ${cate_id_1_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_1}

    Click Element    ${cate_id_1_action_button}
    Click Element    ${cate_id_1_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_1}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_1_list}=    Create List    ${product_pkey_1}

    ${product_pkey_in_cate_lv_2-1_list}=    Create List    ${product_pkey_1}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_1}    ${cat_pkey_2-1}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_1}=${product_pkey_in_cate_lv_1_list}    ${cat_pkey_2-1}=${product_pkey_in_cate_lv_2-1_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_1}    ${expect_data_list}    ${expect_data_dict}

    ###Test Export Level 2.1
    ${cate_id_2-1_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_2-1}
    ${cate_id_2-1_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_2-1}

    Click Element    ${cate_id_2-1_action_button}
    Click Element    ${cate_id_2-1_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_2-1}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_2-1_list}=    Create List    ${product_pkey_1}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_2-1}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_2-1}=${product_pkey_in_cate_lv_2-1_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_2-1}    ${expect_data_list}    ${expect_data_dict}

    [Teardown]    Run Keywords    Delete Merchant From DB    ${merchant_shop_id}
   ...    AND    Run keyword If    "${cat_id_2-1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2-1}\
   ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}\
   ...    AND    Close All Browsers

TC_ITMWM_05624 - Export product under category that has product at the different category branch but same level
    [Tags]    TC_ITMWM_05624    regression    ready    phoenix    WLS_Medium
    #Prerequisite:

    ##..Create new merchant
    ${tc_number}=    Get Test Case Number
    ${merchant_code}=    Set Variable    ${tc_number}
    ${merchant_name}=    Set Variable    Name-${tc_number}
    ${merchant_shop_id}=     Create Merchant in DB    "${merchant_name}"    "${merchant_code}"

    ##..Create merchant's categories
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner         "${merchant_code}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type    "merchant"

    ###.. CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    1    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating
    ${cat_pkey_1}=     Get Category Pkey After Creating

    ###.. CATEGORY 2.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_2-1}=     Get Category ID After Creating
    ${cat_pkey_2-1}=     Get Category Pkey After Creating

    ###.. CATEGORY 2.2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2-2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_2-2}=     Get Category ID After Creating
    ${cat_pkey_2-2}=     Get Category Pkey After Creating

    ${product_pkey_1}=     Set Variable    &{product-disc-1}[pkey]

    ###.. Generate CSV file to be uploaded

    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey_1}    ${product_pkey_1}
    @{data_value2}=    Create List    ${cat_pkey_2-1}    ${product_pkey_1}
    @{data_value3}=    Create List    ${cat_pkey_2-2}    ${product_pkey_1}

    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}

    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Log to console    response==@{response}

    ###..Set stock for product
    Increase Stock By Inventory ID    &{product-disc-1}[sku]    10
    #End Prerequisite

    Go To Category Management Page
    Go To Category Management Tab

    ${drop_down_select_merchant}=    Set Variable    //select[@id='selectMerchant']
    Wait Until Element Is Visible    ${drop_down_select_merchant}    60s

    Sleep    3s
    Select Merchant / Alias By Name    ${merchant_name}

    Expand or Collapse Sub-Categories under Category    1
    # Expand or Collapse Sub-Categories under Category    1    1.1
    # Expand or Collapse Sub-Categories under Category    1    1.2

    ###Test Export Level 1
    ${cate_id_1_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_1}
    ${cate_id_1_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_1}

    Click Element    ${cate_id_1_action_button}
    Click Element    ${cate_id_1_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_1}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_1_list}=    Create List    ${product_pkey_1}

    ${product_pkey_in_cate_lv_2-1_list}=    Create List    ${product_pkey_1}

    ${product_pkey_in_cate_lv_2-2_list}=    Create List    ${product_pkey_1}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_1}    ${cat_pkey_2-1}    ${cat_pkey_2-2}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_1}=${product_pkey_in_cate_lv_1_list}    ${cat_pkey_2-1}=${product_pkey_in_cate_lv_2-1_list}    ${cat_pkey_2-2}=${product_pkey_in_cate_lv_2-2_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_1}    ${expect_data_list}    ${expect_data_dict}

    ###Test Export Level 2.1
    ${cate_id_2-1_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_2-1}
    ${cate_id_2-1_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_2-1}

    Click Element    ${cate_id_2-1_action_button}
    Click Element    ${cate_id_2-1_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_2-1}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_2-1_list}=    Create List    ${product_pkey_1}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_2-1}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_2-1}=${product_pkey_in_cate_lv_2-1_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_2-1}    ${expect_data_list}    ${expect_data_dict}


    ###Test Export Level 2.2
    ${cate_id_2-2_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_2-2}
    ${cate_id_2-2_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_2-2}

    Click Element    ${cate_id_2-2_action_button}
    Click Element    ${cate_id_2-2_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_2-2}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_2-2_list}=    Create List    ${product_pkey_1}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_2-2}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_2-2}=${product_pkey_in_cate_lv_2-2_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_2-2}    ${expect_data_list}    ${expect_data_dict}

    [Teardown]    Run Keywords    Delete Merchant From DB    ${merchant_shop_id}
   ...    AND    Run keyword If    "${cat_id_2-2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2-2}\
   ...    AND    Run keyword If    "${cat_id_2-1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2-1}\
   ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}\
#   ...    AND    Close All Browsers

TC_ITMWM_05625 - Export product under category that has product at the different category branch and different level

    [Tags]    TC_ITMWM_05625    regression    ready    phoenix    WLS_Medium
    #Prerequisite:

    ##..Create new merchant
    ${tc_number}=    Get Test Case Number
    ${merchant_code}=    Set Variable    ${tc_number}
    ${merchant_name}=    Set Variable    Name-${tc_number}
    ${merchant_shop_id}=     Create Merchant in DB    "${merchant_name}"    "${merchant_code}"

    ##..Create merchant's categories
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner         "${merchant_code}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type    "merchant"

    ###.. CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    1    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating
    ${cat_pkey_1}=     Get Category Pkey After Creating

    ###.. CATEGORY 2.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_2-1}=     Get Category ID After Creating
    ${cat_pkey_2-1}=     Get Category Pkey After Creating

    ###.. CATEGORY 2.2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2-2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_2-2}=     Get Category ID After Creating
    ${cat_pkey_2-2}=     Get Category Pkey After Creating

    ###.. CATEGORY 3.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_2-2}    ${file_data}
    ${cat_id_3-1}=     Get Category ID After Creating
    ${cat_pkey_3-1}=     Get Category Pkey After Creating

    ${product_pkey_1}=     Set Variable    &{product-disc-1}[pkey]

    ###.. Generate CSV file to be uploaded

    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey_1}    ${product_pkey_1}
    @{data_value2}=    Create List    ${cat_pkey_2-1}    ${product_pkey_1}
    @{data_value3}=    Create List    ${cat_pkey_2-2}    ${product_pkey_1}
    @{data_value4}=    Create List    ${cat_pkey_3-1}    ${product_pkey_1}

    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}

    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Log to console    response==@{response}

    ###..Set stock for product
    Increase Stock By Inventory ID    &{product-disc-1}[sku]    10
    #End Prerequisite

    Go To Category Management Page
    Go To Category Management Tab

    ${drop_down_select_merchant}=    Set Variable    //select[@id='selectMerchant']
    Wait Until Element Is Visible    ${drop_down_select_merchant}    60s

    Sleep    3s
    Select Merchant / Alias By Name    ${merchant_name}

    Expand or Collapse Sub-Categories under Category    1
    # Expand or Collapse Sub-Categories under Category    1    1.1
    Expand or Collapse Sub-Categories under Category    1    1.2

    ###Test Export Level 1
    ${cate_id_1_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_1}
    ${cate_id_1_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_1}

    Click Element    ${cate_id_1_action_button}
    Click Element    ${cate_id_1_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_1}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_1_list}=    Create List    ${product_pkey_1}

    ${product_pkey_in_cate_lv_2-1_list}=    Create List    ${product_pkey_1}

    ${product_pkey_in_cate_lv_2-2_list}=    Create List    ${product_pkey_1}

    ${product_pkey_in_cate_lv_3-1_list}=    Create List    ${product_pkey_1}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_1}    ${cat_pkey_2-1}    ${cat_pkey_2-2}    ${cat_pkey_3-1}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_1}=${product_pkey_in_cate_lv_1_list}    ${cat_pkey_2-1}=${product_pkey_in_cate_lv_2-1_list}    ${cat_pkey_2-2}=${product_pkey_in_cate_lv_2-2_list}    ${cat_pkey_3-1}=${product_pkey_in_cate_lv_3-1_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_1}    ${expect_data_list}    ${expect_data_dict}

    ###Test Export Level 2.1
    ${cate_id_2-1_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_2-1}
    ${cate_id_2-1_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_2-1}

    Click Element    ${cate_id_2-1_action_button}
    Click Element    ${cate_id_2-1_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_2-1}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_2-1_list}=    Create List    ${product_pkey_1}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_2-1}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_2-1}=${product_pkey_in_cate_lv_2-1_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_2-1}    ${expect_data_list}    ${expect_data_dict}


    ###Test Export Level 2.2
    ${cate_id_2-2_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_2-2}
    ${cate_id_2-2_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_2-2}

    Click Element    ${cate_id_2-2_action_button}
    Click Element    ${cate_id_2-2_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_2-2}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_2-2_list}=    Create List    ${product_pkey_1}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_2-2}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_2-2}=${product_pkey_in_cate_lv_2-2_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_2-2}    ${expect_data_list}    ${expect_data_dict}

    ###Test Export Level 3.1
    ${cate_id_3-1_action_button}=    Replace String Using Regexp    ${action_button}    \\?\\?.+\\?\\?    ${cat_id_3-1}
    ${cate_id_3-1_export_button}=    Replace String Using Regexp    ${export_button}    \\?\\?.+\\?\\?    ${cat_id_3-1}

    Click Element    ${cate_id_3-1_action_button}
    Click Element    ${cate_id_3-1_export_button}

    #Get data from CSV file
    ${export_data_dict_list}=    Get data from CSV file    ${cat_pkey_3-1}

    #Prepare data for verify
    ${product_pkey_in_cate_lv_3-1_list}=    Create List    ${product_pkey_1}

    ${expect_data_list}=    Create List    "pkey_header"    ${cat_pkey_3-1}

    ${expect_data_dict}=    Create Dictionary    "pkey_header"="pkey_header_list"    ${cat_pkey_3-1}=${product_pkey_in_cate_lv_3-1_list}

    #Verify data
    Verify Products Under Categories    ${export_data_dict_list}    ${cat_pkey_3-1}    ${expect_data_list}    ${expect_data_dict}

    [Teardown]    Run Keywords    Delete Merchant From DB    ${merchant_shop_id}
   ...    AND    Run keyword If    "${cat_id_3-1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3-1}\
   ...    AND    Run keyword If    "${cat_id_2-2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2-2}\
   ...    AND    Run keyword If    "${cat_id_2-1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2-1}\
   ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}\
   ...    AND    Close All Browsers