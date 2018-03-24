*** Settings ***
Library           Selenium2Library
Library           String
Library           BuiltIn
Library           Collections
Resource          web_element_collection.robot
Library           ${CURDIR}/../../../../Python_Library/common.py
Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py
Library           ${CURDIR}/../../../../Python_Library/collection.py
Library           ${CURDIR}/../../../../Python_Library/common/csvlibrary.py

*** Variables ***
${upload_error}    Error(s) found. Please re-check your file and try to upload again.
${missing_product_key}    Invalid Collection Key / Missing Product Key
${missing_collect_key}    Missing Collection Key
${invalid_product_key}    Invalid Product Key
${invalid_collection_key}    Invalid Collection Key
${upload_complete}    Mass upload completed.
${eror_empty_row}    Please remove empty row
${filename}       ${CURDIR}/../../../../Resource/TestData/Collection/csv_file/exported_products.csv

*** Keywords ***
Get display name on top bar
    #### mass upload #####
    ${get_text_display_name}=    Get Text    ${text_display_name}
    ${display_name_top_bar}=    Replace String    ${get_text_display_name}    Hello,    ${EMPTY}
    ${display_name_top_bar}=    Strip String    ${display_name_top_bar}    mode=left
    Set Suite Variable    ${display_name_top_bar}

Go to mass upload menu
    Wait Until Element Is Visible    ${collection_menu}    20s
    Click Element    ${collection_menu}
    Wait Until Element Is Visible    ${mass_upload_menu}    20s
    Click Element    ${mass_upload_menu}
    Wait Until Element Is Visible    ${text_menu}    20s
    Location Should Contain    ${PCMS_URL}/collections-products
    ${get_text}=    Get Text    ${text_menu}
    Should Be Equal    ${get_text}    Mass Upload
    ### Browse file ###

User browse file for upload product to cate
    [Arguments]    ${file_upload}
    ${canonicalPath}=    common.Get Canonical Path    ${file_upload}
    Choose File    ${browse_file}    ${canonicalPath}
    Location Should Contain    ${PCMS_URL}/collections-products/verify

Upload result is displayed
    [Arguments]    ${result_upload}
    Wait Until Element Is Visible    ${text_result_upload}    30s
    ${get_text_result_upload}=    Get Text    ${text_result_upload}
    Should Be Equal    ${get_text_result_upload}    ${result_upload}
    Element Should Be Visible    ${link_back}

Result when user does not input product id
    ${get_text_error_found}=    Get Text    ${text_error_found}
    Should Be Equal    ${get_text_error_found}    1 ${upload_error}
    ${get_text_row}=    Get Text    ${table_row}
    Should Be Equal    ${get_text_row}    2
    ${get_text_collection_key}=    Get Text    ${table_collection_key}
    Should Be Equal    ${get_text_collection_key}    3619389223751
    ${get_text_product_key}=    Get Text    ${table_product_key}
    Should Be Equal    ${get_text_product_key}    ${EMPTY}
    ${get_status}=    Get Text    ${table_status_ver}
    Should Be Equal    ${get_status}    ${missing_product_key}

Error message empty row is displayed
    ${get_text_error_found}=    Get Text    ${text_error_found}
    Should Be Equal    ${get_text_error_found}    2 ${upload_error}
    ${get_text_row}=    Get Text    ${table_row}
    Should Be Equal    ${get_text_row}    2
    ${get_text_collection_key}=    Get Text    ${table_collection_key}
    Should Be Equal    ${get_text_collection_key}    ${EMPTY}
    ${get_text_product_key}=    Get Text    ${table_product_key}
    Should Be Equal    ${get_text_product_key}    ${EMPTY}
    ${get_status}=    Get Text    ${table_status_ver}
    Should Be Equal    ${get_status}    ${eror_empty_row}
    ${get_text_row2}=    Get Text    ${table_row2}
    Should Be Equal    ${get_text_row2}    4
    ${get_collection_key2}=    Get Text    ${table_collection_key2}
    Should Be Equal    ${get_collection_key2}    ${EMPTY}
    ${get_text_product_key2}=    Get Text    ${table_product_key2}
    Should Be Equal    ${get_text_product_key2}    ${EMPTY}
    ${get_status2}=    Get Text    ${table_status_ver2}
    Should Be Equal    ${get_status2}    ${eror_empty_row}

User can back to upload file again
    Click Element    ${btn_back}
    Location Should Contain    ${PCMS_URL}/collections-products

Result when user does not input collection pkey
    ${get_text_error_found}=    Get Text    ${text_error_found}
    Should Be Equal    ${get_text_error_found}    1 ${upload_error}
    ${get_text_row}=    Get Text    ${table_row}
    Should Be Equal    ${get_text_row}    2
    ${get_text_collection_key}=    Get Text    ${table_collection_key}
    Should Be Equal    ${get_text_collection_key}    ${EMPTY}
    ${get_text_product_key}=    Get Text    ${table_product_key}
    Should Be Equal    ${get_text_product_key}    2804434080543
    ${get_status}=    Get Text    ${table_status_ver}
    Should Be Equal    ${get_status}    ${missing_collect_key}

Result when product doest not exist in system
    ${get_text_error_found}=    Get Text    ${text_error_found}
    Should Be Equal    ${get_text_error_found}    1 ${upload_error}
    ${get_text_row}=    Get Text    ${table_row}
    Should Be Equal    ${get_text_row}    3
    ${get_text_collection_key}=    Get Text    ${table_collection_key}
    Should Be Equal    ${get_text_collection_key}    9991234567896
    ${get_text_product_key}=    Get Text    ${table_product_key}
    Should Be Equal    ${get_text_product_key}    1111111111111
    ${get_status}=    Get Text    ${table_status_ver}
    Should Be Equal    ${get_status}    ${invalid_product_key}

Result when collection doest not exist in system
    ${get_text_error_found}=    Get Text    ${text_error_found}
    Should Be Equal    ${get_text_error_found}    1 ${upload_error}
    ${get_text_row}=    Get Text    ${table_row}
    Should Be Equal    ${get_text_row}    1
    ${get_text_collection_key}=    Get Text    ${table_collection_key}
    Should Be Equal    ${get_text_collection_key}    1111111111111
    ${get_text_product_key}=    Get Text    ${table_product_key}
    Should Be Equal    ${get_text_product_key}    2804434080543
    ${get_status}=    Get Text    ${table_status_ver}
    Should Be Equal    ${get_status}    ${invalid_collection_key}

User click back to history page
    Click Element    ${link_back}
    Location Should Contain    ${PCMS_URL}/collections-products

Get username of user should upload product to cate
    #[Arguments]    ${get_username_history_table}
    Get display name on top bar
    ${get_username_history_table}=    Get Text    //td[.='product2cate.csv']${table_username}
    #Log To Console    user=${get_username_history_table}
    ${sprit_user_id}=    Split String    ${get_username_history_table}    (
    ${get_username_history}=    Get From List    ${sprit_user_id}    0
    #Log To Console    sprit=${get_username_history}
    Return From Keyword    ${get_username_history}

Check user in history same the user in top menu
    [Arguments]    ${get_username_history}
    #Get username of user should upload product to cate
    ${get_text_display_name}=    Get Text    ${text_display_name}
    ${display_name_top_bar}=    Replace String    ${get_text_display_name}    Hello,    ${EMPTY}
    ${display_name_top_bar_strip} =    Strip String    ${display_name_top_bar}
    Should Be Equal    ${get_username_history}    ${display_name_top_bar_strip}

History for mass upload product to category is displayed
    Wait Until Element Is Visible    //td[.='product2cate.csv']    20s
    Element Should Be Visible    //td[.='product2cate.csv']
    Element Should Be Visible    //td[.='product2cate.csv']${table_username}
    Element Should Be Visible    //td[.='product2cate.csv']${table_status}
    ${get_text_status}=    Get Text    //td[.='product2cate.csv']${table_status}
    Should Be Equal    ${get_text_status}    success
    Element Should Be Visible    //td[.='product2cate.csv']${table_reason}
    ${get_reason}=    Get Text    //td[.='product2cate.csv']${table_reason}
    Should Be Equal    ${get_reason}    -
    Element Should Be Visible    //td[.='product2cate.csv']${table_date_time}

Delete user after upload success
    [Arguments]    ${filename}
    ${userId}=    Get Text    //td[.='product2cate.csv']${table_username}
    Log To Console    ${userId}
    delete_history_massupload_by_user_and_type    ${userId}    ${filename}    col_prod
    ######## Export product from collection ############

All history of mass upload
    ${get_text_all_history}=    Get Text    ${text_all_history}
    #Log To Console    ${get_text_all_history}
    ${split_get_text_all_history}=    Split String    ${get_text_all_history}    of
    #Log To Console    ${split_get_text_all_history}
    ${get_split_get_text_all_history}=    Get From List    ${split_get_text_all_history}    1
    #Log To Console    test=${get_split_get_text_all_history}
    ${num_all_history}=    Strip String    ${get_split_get_text_all_history}    characters=entries
    #Log To Console    ${num_all_history}
    ${num_all_history}=    Strip String    ${num_all_history}    mode=left
    ${num_all_history}=    Strip String    ${num_all_history}    mode=right
    #Log To Console    ${num_all_history}
    Return From Keyword    ${num_all_history}

Check all row in history
    [Arguments]    ${num_all_history}
    Log To Console    test2=${num_all_history}
    ${num_page}=    Evaluate    ${num_all_history}/20+1
    ${sum_row}=    Evaluate    0
    Log To Console    ${num_page}
    : FOR    ${index}    IN RANGE    0    ${num_page}
    \    # \    Run Keyword If    ${btn_next1}==${btn_next2}    Exit For Loop
    \    ${get_row_table}=    Get Matching Xpath Count    //*[@id="DataTables_Table_0"]/tbody/tr
    \    ${sum_row}=    Evaluate    ${get_row_table}+${sum_row}
    \    Click Element    ${btn_next}
    \    Log To Console    ${index}=${sum_row}
    Log To Console    all row=${sum_row}
    ${num_all_history}=    Convert To Integer    ${num_all_history}
    Should Be Equal    ${sum_row}    ${num_all_history}

User download templete
    Click Element    ${link_templete}
    ${ipHost}=    Get Ip From Url    ${PCMS_URL_HTTP}
    ${cookies}    Get Cookies
    write download file    ${cookies}    http://${PCMS_URL_HTTP}/collections-products/example-csv-file    ${filename}
    Return From Keyword    ${filename}

Templete is correctly
    [Arguments]    ${filename}
    ${verify}=    verify exported templete    ${filename}
    Log To Console    verify=${verify}
    Should Be Equal    True    ${verify}
    ######## Export product from collection ############

Go to manage collection menu
    Wait Until Element Is Visible    ${menu_manage_collection}    15s
    Click Element    ${menu_manage_collection}
    # Wait Until Element Is Visible    ${text_menu}    15s
    ${result}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${text_menu}    5s
    Run Keyword If    ${result} == False    Sleep    3s
    Wait Until Element Is Visible    ${text_menu}    30s
    Location Should Contain    ${PCMS_URL}/collections
    ${get_text}=    Get Text    ${text_menu}
    Should Be Equal    ${get_text}    Collections Management

Choose product link in collection
    Wait Until Element Is Visible    ${choose_sub_collection1}    30s
    Click Element    ${choose_sub_collection1}
    Wait Until Element Is Visible    ${choose_sub_collection2}    30s
    Click Element    ${choose_sub_collection2}
    Wait Until Element Is Visible    ${text_menu}    30s
    Click Element    ${choose_product}

Choose product link in category
    Wait Until Element Is Visible    ${choose_product_category}    15s
    Click Element    ${choose_product_category}

Check product under category
    [Arguments]    ${product_pkey}
    Wait Until Element Is Visible    //td[.='${product_pkey}']    20s
    ${get_product_key}=    Get Text    //td[.='${product_pkey}']
    Should Be Equal    ${get_product_key}    ${product_pkey}

Export products choose select all
    Wait Until Element Is Visible    ${choose_select_all}    180s
    Click Element    ${choose_select_all}
    ${collectionID}=    Selenium2Library.Get Element Attribute    ${get_collection_id}@value
    ${productID}=    Selenium2Library.Get Element Attribute    ${get_product_ids}@value
    Wait Until Element Is Visible    ${export_button}    15s
    Wait Until Element Is Enabled    ${export_button}    15s
    Click Element    ${export_button}
    ${cookies}    Get Cookies
    sleep    10s
    Write Download File Post    ${cookies}    http://${PCMS_URL_HTTP}/collections-products/export    ${filename}    ${productID}    ${collectionID}
    ${verify}=    Verify Exported Product Csv    ${filename}
    Log To Console    verify=${verify}
    Should Be Equal    True    ${verify}

Export products choose select one
    Wait Until Element Is Visible    ${choose_select_one}    15s
    Click Element    ${choose_select_one}
    ${collectionID}=    Selenium2Library.Get Element Attribute    ${get_collection_id}@value
    ${productID}=    Selenium2Library.Get Element Attribute    ${get_product_ids}@value
    Wait Until Element Is Visible    ${export_button}    15s
    Wait Until Element Is Enabled    ${export_button}    15s
    Click Element    ${export_button}
    ${cookies}    Get Cookies
    Write Download File Post    ${cookies}    http://${PCMS_URL_HTTP}/collections-products/export    ${filename}    ${productID}    ${collectionID}
    ${verify}=    Verify Exported Product Csv    ${filename}
    Log To Console    verify=${verify}
    Should Be Equal    True    ${verify}

Create category and collection
    insert collection for product upload

Count collection by pkey
    [Arguments]    ${CollectionPkey}
    Connect DB ITM
    ${total_row_colelction}=    Query    SELECT count(id) FROM `collections` where`pkey` ='${CollectionPkey}'
    Log To Console    test=${total_row_colelction[0][0]}
    [Return]    ${total_row_colelction[0][0]}

Create category and collection with param
    [Arguments]    ${parent_id}    ${pkey}    ${collection_name}    ${slug}    ${is_category}    ${category_id}
    ...    ${pds_collection}
    ${parent_id}=    Convert To Integer    ${parent_id}
    ${pkey}=    Convert To Integer    ${pkey}
    ${collection_id}=    collection.create_collection    ${parent_id}    ${pkey}    ${collection_name}    ${slug}    ${is_category}
    ...    ${category_id}    ${pds_collection}
    [Return]    ${collection_id}

Delete collection by collection id
    [Arguments]    ${collection_id}
    ${collection_id}=    delete_collection_by_collection_id    ${collection_id}

Export product button is disable
    Sleep    1s
    Element Should Be Disabled    ${export_button}
    #acl

Message cannot access is displayed
    [Arguments]    ${text_cannot_access}
    Wait Until Element Is Visible    ${text_body}    15s
    ${get_text_body}=    Get Text    ${text_body}
    Should Be Equal    ${get_text_body}    ${text_cannot_access}

Location varify
    Location Should Contain    ${PCMS_URL}/collections-products/verify

Location mass upload
    Location Should Contain    ${PCMS_URL}/collections-products

Header messege cannot access is displayed
    [Arguments]    ${text_header_cannot_access}
    Wait Until Element Is Visible    ${text_header}    15s
    ${get_text_header}=    Get Text    ${text_header}
    Should Be Equal    ${get_text_header}    ${text_header_cannot_access}

Get collection key delete at
    Connect DB ITM
    ${product_pkey}=    Query    SELECT pkey FROM `collections` where `deleted_at` is not null LIMIT 1 ;
    #log    ${CollectionID[0][0]}
    [Return]    ${product_pkey[0][0]}

Set product key and collection key in file csv product to collection
    [Arguments]    ${data}
    ${path_file}=    Set Variable    ${CURDIR}/../../../../Resource/TestData/Product/csv_file/mass_upload_product_to_collection_up.csv
    csvlibrary.create_file    ${path_file}    ${data}
    [Return]    ${path_file}

Collection - Error message is displayed when upload failed
    [Arguments]    ${result_header_fail}
    Wait Until Element Is Visible    ${text_error_found}    15s
    ${get_text_result}=    Get Text    ${text_error_found}
    Log To Console    error message=${get_text_result}
    Should Be Equal    ${get_text_result}    ${result_header_fail}

Collection - Get result in file verification table
    ${count_row}    Get Matching Xpath Count    ${xpath_count_row_td}
    ${count_hd_td}    Get Matching Xpath Count    ${xpath_hd_td}
    ${message}=    Create List
    : FOR    ${i}    IN RANGE    1    ${count_hd_td} * ${count_row} + 1
    \    ${name}=    Get Text    xpath=(${xptah_td})[${i}]
    \    Append To List    ${message}    ${name}
    [Return]    ${message}

Collection - Verify result when upload product to collection is failed
    [Arguments]    ${product_key}    ${collection_key}    ${row}    ${message_status}    ${message}
    ${string_product_key}=    Convert To String    ${product_key}
    ${string_collection_key}=    Convert To String    ${collection_key}
    ${data_list}=    Create List    ${row}    ${string_product_key}    ${string_collection_key}    ${message_status}
    Log To Console    \n    data list=${data_list}
    Should Be Equal    ${message}    ${data_list}
