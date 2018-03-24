*** Settings ***
Library           Selenium2Library
Library           String
Library           BuiltIn
Library           Collections
Library           ${CURDIR}/../../../../Python_Library/collection.py
Library           ${CURDIR}/../../../../Python_Library/common.py
Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py
Library           ${CURDIR}/../../../../Python_Library/common/csvlibrary.py

Resource          ${CURDIR}/keywords_mass_upload_common.robot
Resource          web_element_mass_upload_product_collection.robot

*** Keywords ***

Go to mass upload product collection menu
    Wait Until Element Is Visible    ${product_menu}    20s
    Click Element    ${product_menu}
    Wait Until Element Is Visible    ${mass_upload_product_collection_menu}    20s
    Click Element    ${mass_upload_product_collection_menu}
    Mass upload product collection - Location mass upload
    Wait Until Element Is Visible    ${breadcrumb_mass_upload_product_collection}    15s
    ${get_breadcrumb}=    Get Text    ${breadcrumb_mass_upload_product_collection}
    Should Be Equal    ${get_breadcrumb}    Mass Upload Products Collections

Mass upload product collection - Message success is displayed
    [Arguments]    ${message_success}
    Location varify
    Wait Until Element Is Visible    ${message_success_element}    20s
    ${get_message_success}=    Get Text    ${message_success_element}
    Should Be Equal    ${get_message_success}    ${message_success}
    Wait Until Element Is Visible    ${btn_back}

Click back button
    Click Element    ${btn_back}
    # Get display name in top menu
    #    ${get_text_display_name}=    Get Text    ${text_display_name}
    #    ${display_name_top_bar}=    Replace String    ${get_text_display_name}    Hello,    ${EMPTY}
    #    ${display_name_top_bar_strip} =    Strip String    ${display_name_top_bar}
    #    Log To Console    user top bar=${display_name_top_bar_strip}
    #    [Return]    ${display_name_top_bar_strip}

#acl
Mass upload product collection - Message cannot access is displayed
    [Arguments]    ${text_cannot_access}
    Wait Until Element Is Visible    ${text_body}    15s
    ${get_text_body}=    Get Text    ${text_body}
    Should Be Equal    ${get_text_body}    ${text_cannot_access}

Location varify
    Location Should Contain    ${PCMS_URL}/products/mass-upload-products-collections/verify

Mass upload product collection - Location mass upload
    Location Should Contain    ${PCMS_URL}/products/mass-upload-products-collections

Mass upload product collection - Header messege cannot access is displayed
    [Arguments]    ${text_header_cannot_access}
    Wait Until Element Is Visible    ${text_header}    15s
    ${get_text_header}=    Get Text    ${text_header}
    Should Be Equal    ${get_text_header}    ${text_header_cannot_access}

Cannot see mass upload product collection menu
    Wait Until Element Is Visible    ${product_menu}    15s
    Click Element    ${product_menu}
    Wait Until Element Is Not Visible    ${mass_upload_product_collection_menu}    15s

Create collection level1 for mass upload
    [Arguments]    ${parent_id}    ${pkey}
    ${parent_id}=    Convert To Integer    ${parent_id}
    ${pkey}=    Convert To Integer    ${pkey}
    ${collection_id}=    create_collection    ${parent_id}    ${pkey}    Flash Test Product Mass Product Collections Lv1    flash-test-product-mass-product-collections-lv1    1
    ...    FLASHTEST01    1
    [Return]    ${collection_id}

Create collection level2 for mass upload
    [Arguments]    ${parent_id}    ${pkey}
    ${parent_id}=    Convert To Integer    ${parent_id}
    ${pkey}=    Convert To Integer    ${pkey}
    ${collection_id}=    create_collection    ${parent_id}    ${pkey}    Flash Test Product Mass Product Collections Lv2    flash-test-product-mass-product-collections-lv2    1
    ...    FLASHTEST0101    1
    [Return]    ${collection_id}

Delete collection
    [Arguments]    ${collection_id}
    ${collection_id}=    delete_collection_by_collection_id    ${collection_id}

Get collection key delete at
    Connect DB ITM
    ${product_pkey}=    Query    SELECT pkey FROM `collections` where `deleted_at` is not null LIMIT 1 ;
    #log    ${CollectionID[0][0]}
    [Return]    ${product_pkey[0][0]}

Get collection key was displayed on web
    Connect DB ITM
    ${collection_pkey}=    Query    SELECT pkey FROM `collections` where `deleted_at` is null and `is_category` = '1' LIMIT 1 ;
    [Return]    ${collection_pkey[0][0]}

Get product key is publish status
    Connect DB ITM
    ${product_pkey}=    Query    SELECT pkey FROM `products` where `status` = 'publish' and `deleted_at` is null LIMIT 1 ;
    #log    ${CollectionID[0][0]}
    [Return]    ${product_pkey[0][0]}

Mass upload product collection - Error message is displayed when upload fail
    [Arguments]    ${result_header_fail}
    Wait Until Element Is Visible    ${text_result}    15s
    ${get_text_result}=    Get Text    ${text_result}
    Log To Console    error message=${get_text_result}
    Should Be Equal    ${get_text_result}    ${result_header_fail}

Mass upload product collection - Get result in file verification table
    ${count_row}    Get Matching Xpath Count    ${xpath_count_row_td}
    ${count_hd_td}    Get Matching Xpath Count    ${xpath_hd_td}
    ${message}=    Create List
    : FOR    ${i}    IN RANGE    1    ${count_hd_td} * ${count_row} + 1
    \    ${name}=    Get Text    xpath=(${xptah_td})[${i}]
    \    Append To List    ${message}    ${name}
    [Return]    ${message}

Verify result when upload product collection is fail
    [Arguments]    ${product_key}    ${collection_key}    ${message_status}    ${row}    ${message}
    ${string_product_key}=    Convert To String    ${product_key}
    ${string_collection_key}=    Convert To String    ${collection_key}
    ${data_list}=    Create List    ${row}    ${string_product_key}    ${string_collection_key}    ${message_status}
    Log To Console    \n    data list=${data_list}
    Should Be Equal    ${message}    ${data_list}

Set product key and collection key in file csv product collection
    [Arguments]    ${data}
    ${path_file}=    Set Variable    ${CURDIR}/../../../../Resource/TestData/Product/csv_file/mass_upload_product_collection_up.csv
    csvlibrary.create_file    ${path_file}    ${data}
    [Return]    ${path_file}

User browse file for mass upload product collection
    [Arguments]    ${file_upload}
    ${canonicalPath}=    common.Get Canonical Path    ${file_upload}
    Choose File    ${browse_file}    ${canonicalPath}
    Location Should Contain    ${PCMS_URL}/products/mass-upload-products-collections/verify

User download template
    ${filename}=    Set Variable    ${CURDIR}/../../../../Resource/TestData/Collection/csv_file/template_product_collection_upload.csv
    Click Element    ${link_templete}
    ${ipHost}=    Get Ip From Url    ${PCMS_URL_HTTP}
    ${cookies}    Get Cookies
    write download file    ${cookies}    http://${PCMS_URL_HTTP}/products/mass-upload-products-collections/example-csv-file    ${filename}
    Return From Keyword    ${filename}

Check template is correctly
    [Arguments]    ${filename}
    ${verify}=    verify_example_template_of_mass_upload_product_collection    ${filename}
    Log To Console    verify=${verify}
    Should Be Equal    True    ${verify}

Delete user after upload success
    [Arguments]    ${user_name}    ${filename}
    delete_history_massupload_by_user_and_type   ${user_name}    ${filename}    prod_col

# Get file name from canonical path
#     [Arguments]    ${canonical_path}
#     ${replaced_string}=    Replace String    ${canonical_path}    \\    /
#     ${split_result}=    Split String    ${replaced_string}    /
#     ${split_result_length}=    Get Length    ${split_result}
#     ${file_name_index}=    Evaluate    ${split_result_length}-1
#     [Return]    ${split_result[${file_name_index}]}