*** Settings ***
# Resource   ${CURDIR}/../../../../../Resource/Config/pcms_uri_endpoint.robot
Resource   ${CURDIR}/web_elements_mass_upload_product_alias_merchant.robot
Library    ${CURDIR}/../../../../../Python_Library/alias_merchant.py
Library    ${CURDIR}/../../../../../Python_Library/common.py
Library    ${CURDIR}/../../../../../Python_Library/common/csvlibrary.py
Library    ${CURDIR}/../../../../../Python_Library/dbclass/database_class.py

*** Variables ***
${file_name}         mass_alias_upload.csv
${file_template}     ${CURDIR}/../../../../../Resource/TestData/Product/csv_file/template_mass_alias_upload.csv
${path_file}         ${CURDIR}/../../../../../Resource/TestData/Product/csv_file/${file_name}

*** Keywords ***

Merchant Alias - User click mass upload product
    Click Element     ${btn_mass_upload}
    Location Should Contain    ${PCMS_URL}/products/alias-merchant/mass-upload/

Merchant Alias - Set product key in file csv
    [Arguments]    ${data}
    csvlibrary.create_file    ${path_file}    ${data}
    [Return]     ${path_file}

Merchant Alias - User browse file for mass upload product
    [Arguments]    ${file_upload}
    ${canonicalPath}=    common.Get Canonical Path    ${file_upload}
    Choose File          ${browse_file}    ${canonicalPath}
    Location Should Contain     ${PCMS_URL}/products/alias-merchant/mass-upload/verify

Merchant Alias - Mass upload product result is displayed
    [Arguments]    ${result_upload}
    Wait Until Element Is Visible    ${text_result_upload}    15s
    ${get_text_result_upload}=       Get Text    ${text_result_upload}
    Log To Console    get text result=${get_text_result_upload}
    Should Be Equal    ${get_text_result_upload}    ${result_upload}

Merchant Alias - Prepare data alias merchant
    [Arguments]    ${alias_merchant_name}    ${merchant_code}
    ${alias_id}=     create_alias_merchant    ${alias_merchant_name}    ${merchant_code}
    Log To Console    alias id=${alias_id}
    [Return]     ${alias_id}

Merchant Alias - User click back to history page
    Click Element    ${link_back}
    Location Should Contain    ${PCMS_URL}/products/alias-merchant/mass-upload

Merchant Alias - User click link back to history page
    Click Element    ${link_back_upload}
    Location Should Contain    ${PCMS_URL}/products/alias-merchant/mass-upload

Merchant Alias - Get upload history result from web page
    [Arguments]    ${expected_filename}    ${display_name_top_bar}
    ${result_index}=    Set Variable    ${EMPTY}

    ${get_upload_histories_table_filename_elements}=    Get Webelements    ${upload_histories_table_filename_elements}
    ${get_upload_histories_table_username_elements}=    Get Webelements    ${upload_histories_table_username_elements}

    ${get_upload_histories_table_filename_elements_length}=    Get Length    ${get_upload_histories_table_filename_elements}

    Log to console    expected_filename::${expected_filename}
    Log to console    display_name_top_bar::${display_name_top_bar}

    : FOR    ${INDEX}    IN RANGE    0    ${get_upload_histories_table_filename_elements_length}
    \  ${filename_element}=    Get From List    ${get_upload_histories_table_filename_elements}    ${INDEX}
    \  ${username_element}=    Get From List    ${get_upload_histories_table_username_elements}    ${INDEX}

    \  ${result_filename}=    Set Variable    ${filename_element.text}
    \  ${result_username}=    Set Variable    ${username_element.text}

    \  ${expected_filename_length}=    Get Length    ${expected_filename}
    \  ${result_filename_no_id}=    Get Substring    ${result_filename}    0     ${expected_filename_length}

    \  ${display_name_top_bar_length}=    Get Length    ${display_name_top_bar}
    \  ${result_username_no_id}=    Get Substring    ${result_username}    0     ${display_name_top_bar_length}

    \  ${result_index}=    Set Variable    ${INDEX}
    \  Log to console    result_filename::${result_filename}
    \  Log to console    result_filename_no_id::${result_filename_no_id}
    \  Log to console    result_username::${result_username}
    \  Log to console    result_username_no_id::${result_username_no_id}

    \  Run Keyword If    '${result_filename_no_id}' == '${expected_filename}' and '${result_username_no_id}' == '${display_name_top_bar}'    Exit For Loop

    Should Not Be Equal    ${EMPTY}    ${result_index}
    Should Not Be Equal    ${EMPTY}    ${result_filename_no_id}
    Should Not Be Equal    ${EMPTY}    ${result_username_no_id}

    ${result_index}=    Convert to integer    ${result_index}
    ${result_row_index}=    Evaluate    ${result_index} + 1
    ${get_upload_histories_table_td_elements}=    Get Webelements    ${upload_histories_table_tr_elements}[${result_row_index}]/td

    ${filename}=    Set Variable    ${result_filename_no_id}
    ${username}=    Set Variable    ${result_username_no_id}
    ${status}=    Set Variable    ${get_upload_histories_table_td_elements[2].text}
    ${reason}=    Set Variable    ${get_upload_histories_table_td_elements[3].text}

    ${result_list}=    Create List     ${filename}    ${username}    ${status}    ${reason}
    Log to console    result_list::${result_list}
    [Return]    ${result_list}

Merchant Alias - Get Number of History Rows
    ${get_text_all_history}=    Get Text    ${text_all_history}
    ${split_get_text_all_history}=    Split String     ${get_text_all_history}    of
    ${split_get_text_all_history}=    Get From List    ${split_get_text_all_history}    1
    ${split_get_text_all_history}=    Split String     ${split_get_text_all_history}    entries
    ${split_get_text_all_history}=    Get From List    ${split_get_text_all_history}    0
    ${num_all_history}=    Strip String    ${split_get_text_all_history}    mode=left
    ${num_all_history}=    Strip String    ${num_all_history}    mode=right
    Return From Keyword    ${num_all_history}

Merchant Alias - Verify Number of History Rows on UI
    [Arguments]     ${num_all_history}
    ${num_page}=     Evaluate    ${num_all_history}/20+1
    ${sum_row}=      Evaluate    0
    Log To Console    ${num_page}
    : FOR    ${index}    IN RANGE    0    ${num_page}
    \    ${get_row_table}=    Get Matching Xpath Count    //*[@id="DataTables_Table_0"]/tbody/tr
    \    ${sum_row}=    Evaluate    ${get_row_table}+${sum_row}
    \    Click Element    ${btn_next}
    ${sum_row}=    Convert To String    ${sum_row}
    Log To Console     all row=${sum_row}
    Should Be Equal    ${sum_row}    ${num_all_history}

#type is ali_add or ali_del
Merchant Alias - Verify Number of History Rows with DB
    [Arguments]    ${alias_merchant_id}    ${type}    ${expected_number}
    ${expected_number}=    Convert to Integer    ${expected_number}
    ${rows}=    database_class.execute    SELECT COUNT(*) FROM upload_history WHERE filename LIKE '%${alias_merchant_id}%' AND type='${type}'
    Should Not Be Equal    ${EMPTY}    ${rows}
    Should Be Equal    ${rows[0][0]}    ${expected_number}

Merchant Alias - Get Merchant ID From History Page
    ${alias_merchant_id_unicode}=    Selenium2Library.Get Element Attribute    ${alias_merchant_id_element}
    ${alias_merchant_id}=    Convert To Integer    ${alias_merchant_id_unicode}
    [Return]    ${alias_merchant_id}

Merchant Alias - Get Merchant Code From Merchant ID
    [Arguments]    ${alias_merchant_id}
    ${rows}=    database_class.execute    SELECT merchant_code FROM merchant_alias WHERE id=${alias_merchant_id}
    Should Not Be Equal    ${EMPTY}    ${rows}
    ${merchant_code}=    Set Variable    ${rows[0][0]}
    [Return]    ${merchant_code}

Merchant Alias - Verify Alias Merchant ID in Header
    [Arguments]    ${alias_merchant_id}
    ${merchant_code}=    Merchant Alias - Get Merchant Code From Merchant ID    ${alias_merchant_id}
    Log to Console    alias_merchant_code=${merchant_code}

    ${mass_upload_header_elements}=    Get Webelements    ${header_mass_upload}
    Should Contain    ${mass_upload_header_elements}    [Alias Code : ${merchant_code}]

Merchant Alias - Verify Alias Merchant ID in History Table
    [Arguments]    ${alias_merchant_id}
    ${merchant_code}=    Merchant Alias - Get Merchant Code From Merchant ID    ${alias_merchant_id}
    Log to Console    alias_merchant_code=${merchant_code}

    ${get_upload_histories_table_filename_elements}=    Get Webelements    ${upload_histories_table_filename_elements}
    ${get_upload_histories_table_filename_elements_length}=    Get Length    ${get_upload_histories_table_filename_elements}

    : FOR    ${INDEX}    IN RANGE    0    ${get_upload_histories_table_filename_elements_length}
    \  ${filename_element}=    Get From List    ${get_upload_histories_table_filename_elements}    ${INDEX}
    \  ${result_filename}=    Set Variable    ${filename_element.text}
    \  Should Contain    ${result_filename}    [Alias Code : ${merchant_code}]

Verify mass upload alias merchant template
    [Arguments]    ${filename}
    ${file}=     common.Get Canonical Path    ${filename}
    ${verify}=     verify_exported_templete_product_collection     ${file}
    Log To Console     verify=${verify}
    Should Be Equal    True    ${verify}

Download template mass upload alias merchant
    Wait Until Element Is Visible    ${link_example_file}    15s
    Click Element    ${link_example_file}
    ${cookies}       Get Cookies
    write download file    ${cookies}    http://${PCMS_URL_HTTP}/products/alias-merchant/mass-upload/example-csv-file      ${file_template}
    Return From Keyword    ${file_template}

Merchant Alias - Error message is displayed when upload fail
    [Arguments]    ${result_header_fail}
    Wait Until Element Is Visible     ${text_result}    15s
    ${get_text_result}=     Get Text    ${text_result}
    Log To Console    ${get_text_result}
    Should Be Equal    ${get_text_result}    ${result_header_fail}

Merchant Alias - Get result in file verification table
    ${count_row}    Get Matching Xpath Count    ${xpath_count_row_td}
    ${count_hd_td}    Get Matching Xpath Count    ${xpath_hd_td}
    ${message}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count_hd_td} * ${count_row} + 1
    \    ${name}=    Get Text    xpath=(${xpath_td})[${i}]
    \    Append To List    ${message}    ${name}
    [Return]     ${message}