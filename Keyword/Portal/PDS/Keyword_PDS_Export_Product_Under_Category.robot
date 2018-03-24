*** Settings ***
Library           HttpLibrary.HTTP
Library           Selenium2Library
Library           ${CURDIR}/../../../Python_Library/common.py
Library           ${CURDIR}/../../../Python_Library/DatabaseData.py
Library           ${CURDIR}/../../../Python_Library/common/csvlibrary.py
Resource          web_element_PDS_Export_Product_Under_Category.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../../Keyword/API/PDS/pds_api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Database/PDS/keyword_variant.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Product/keywords_product.robot

*** Variables ***
${filename}       ${CURDIR}/../../../../../Resource/TestData/Product/csv_file/exported_products_download.csv
${template_}      ${CURDIR}/../../../../../Resource/TestData/Product/csv_file/

*** Keywords ***
Verify Products Under Categories
    [Arguments]    ${export_data_dict_list}    ${selected_category_pkey}    ${expect_data_list}    ${expect_data_dict}

    ${count_dict_list}=    Get Length    ${export_data_dict_list}
    ${count_expect_list}=    Get Length    ${expect_data_list}

    Should Be Equal    ${count_dict_list}    ${count_expect_list}

    Log To Console    export_data_dict_list=${export_data_dict_list}

    ${header_data_dict}=    Get From List    ${export_data_dict_list}    0

    ${header_category_key}=    Get From Dictionary    ${header_data_dict}    category_key
    ${header_product_key}=    Get From Dictionary    ${header_data_dict}    product_key
    ${header_category_name_trail}=    Get From Dictionary    ${header_data_dict}    category_name_trail
    ${header_product_name}=    Get From Dictionary    ${header_data_dict}    product_name
    ${header_exported_category_key}=    Get From Dictionary    ${header_data_dict}    exported_category_key
    ${header_exported_category_name_trail}=    Get From Dictionary    ${header_data_dict}    exported_category_name_trail
    ${header_merchant_or_alias_code}=    Get From Dictionary    ${header_data_dict}    merchant_or_alias_code
    ${header_merchant_or_alias_name}=    Get From Dictionary    ${header_data_dict}    merchant_or_alias_name
    ${header_product_status}=    Get From Dictionary    ${header_data_dict}    product_status

    Should Be Equal    ${header_category_key}    Category Key
    Should Be Equal    ${header_product_key}    Product Key
    Should Be Equal    ${header_category_name_trail}    Product Category
    Should Be Equal    ${header_product_name}    Product Name
    Should Be Equal    ${header_exported_category_key}    Exported Category Key
    Should Be Equal    ${header_exported_category_name_trail}    Exported Product Category
    Should Be Equal    ${header_merchant_or_alias_code}    Merchant/Alias Code
    Should Be Equal    ${header_merchant_or_alias_name}    Merchant/Alias Name
    Should Be Equal    ${header_product_status}    Product Status

    # Get Products from DB by Category ID

    ${tmp_category_key}=     Set Variable    ${EMPTY}
    ${tmp_product_index}=    Set Variable    0

    ${count}=    Get Length    ${export_data_dict_list}
    : FOR    ${INDEX}    IN RANGE    1    ${count}
    \    ${data_dict}=    Get From List    ${export_data_dict_list}    ${INDEX}
    \    ${category_key}=    Get From Dictionary    ${data_dict}    category_key
    \    ${product_key}=    Get From Dictionary    ${data_dict}    product_key
    \    ${category_name_trail}=    Get From Dictionary    ${data_dict}    category_name_trail
    \    ${product_name}=    Get From Dictionary    ${data_dict}    product_name
    \    ${exported_category_key}=    Get From Dictionary    ${data_dict}    exported_category_key
    \    ${exported_category_name_trail}=    Get From Dictionary    ${data_dict}    exported_category_name_trail
    \    ${merchant_or_alias_code}=    Get From Dictionary    ${data_dict}    merchant_or_alias_code
    \    ${merchant_or_alias_name}=    Get From Dictionary    ${data_dict}    merchant_or_alias_name
    \    ${product_status}=    Get From Dictionary    ${data_dict}    product_status
    \    ${stock}=    Get From Dictionary    ${data_dict}    stock
    \    ${stock_int}=    Convert To Integer    ${stock}

    # Get From Dictionary${expect_data_dict}

	# \    ${keys=    Get Dictionary Keys    ${expect_data_dict}
    # ${expect_data_list}

    \    ${expect_product_key_list}=    Get From Dictionary    ${expect_data_dict}    ${category_key}

    \    List Should Contain Value    ${expect_product_key_list}    ${product_key}

    \    ${db_category_name}=    Get Category Name from DB by Category pkey    ${selected_category_pkey}
    \    ${tmp_product_index_evaluate}=    Evaluate    ${tmp_product_index} + 1
    \    ${tmp_product_index}=     Set Variable If    '${tmp_category_key}'!='${category_key}'    0    ${tmp_product_index_evaluate}
    \    ${tmp_category_key}=    Set Variable    ${category_key}
    \    ${db_product_name}=    Get Title from DB by Product pkey    ${expect_product_key_list[${tmp_product_index}]}
    \    ${db_owner}=    Get Category Owner from DB by Category pkey    ${selected_category_pkey}
    \    ${db_merchant_id}    ${db_merchant_name}=    Get Merchant ID and Merchant Name from DB by Merchant Code    ${db_owner}
    \    ${db_merchant_alias_id}    ${db_merchant_alias_name}=    Get Merchant Alias ID and Merchant Alias Name from DB by Merchant Code    ${db_owner}

    \    ${db_product_status}=     Get Active Status from DB by Product pkey    ${expect_product_key_list[${tmp_product_index}]}
    # \    Log to console    print_data====+++${keys[${INDEX}]}
    # \    Should Be Equal    ${category_key}    ${selected_category_pkey}
    \    Should Be Equal    ${category_key}    ${expect_data_list[${INDEX}]}
    \    Should Be Equal    ${product_key}    ${expect_product_key_list[${tmp_product_index}]}
    \    Should Contain    ${category_name_trail}    ${db_category_name}
    \    Should Be Equal    ${product_name}    ${db_product_name}
    \    Should Be Equal    ${exported_category_key}    ${selected_category_pkey}
    \    Should Contain    ${exported_category_name_trail}    ${db_category_name}
    \    Should Be Equal    ${merchant_or_alias_code}    ${db_owner}

    \    ${db_merchant_name_actual}=    Set Variable If    '${db_merchant_name}'=='${EMPTY}'    ${db_merchant_alias_name}    ${db_merchant_name}
    \    Should Be Equal    ${merchant_or_alias_name}    ${db_merchant_name_actual}

    \    Should Be Equal    ${product_status}    ${db_product_status}

    \    ${sum_stock}=    Sum stock remaining for product    ${product_key}
    \    Should Be Equal    ${sum_stock}    ${stock_int}

Get data from CSV file
    [Arguments]    ${selected_category_pkey}

    ${filename}=    Set Variable    ${CURDIR}/../../../Resource/TestData/Category/csv_file/merchant_categories_export_product_under_category.csv

    ${cookies}    Get Cookies
    sleep    10s
    ${export_url}=    Set Variable    ${API_GATEWAY}${PDS-API-URI}/categories/${selected_category_pkey}/products/export

    write_download_file    ${cookies}    ${export_url}    ${filename}

    ${export_data_dict_list}=    get_exported_products_under_merchant_categories_data_csv    ${filename}
    Return From Keyword    ${export_data_dict_list}