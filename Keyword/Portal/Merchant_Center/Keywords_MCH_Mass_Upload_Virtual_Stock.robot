*** Keywords ***
MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page
    [Arguments]    ${wait_time}=20
    MCH Common - Go To Merchant Center Report Page
    Click Element    ${upload_stock_menu}
    Wait Until Page Contains Element    ${upload_button}    ${wait_time}

MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product
    [Arguments]    ${file_upload}
    ${canonicalPath}=    common.Get Canonical Path    ${file_upload}
    Choose File    ${choose_file_input}    ${canonicalPath}

MCH Mass Upload Virtual Stock - Click Upload Button
    Click Element    ${upload_button}
    MCH Mass Upload Virtual Stock - Wait Until Page Contains File Verification Table

MCH Mass Upload Virtual Stock - Click Close Button
    Click Element    ${close_file_verification_button}
    Wait Until Page Contains Element    ${upload_button}    ${wait_time}

MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    [Arguments]    @{data}
    ${content_list}=    Create List
    :FOR     ${col_index}    ${value}    IN    @{data}
    \    ${content}=    Create List    ${col_index}    ${value}
    \    Append To List    ${content_list}    ${content}
    Return From Keyword    ${content_list}

MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    [Arguments]    @{data}
    ${file_ver_result}=    Create List
    :FOR    ${row}    ${sku}    ${qty}    ${status}    IN    @{data}
    \    ${file_ver_data_value}=    Create List    ${row}    ${sku}    ${qty}    ${status}
    \    Append To List    ${file_ver_result}    @{file_ver_data_value}
    Return From Keyword    ${file_ver_result}

MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel
    [Arguments]    ${content_list}=${EMPTY}
    ${path_file}=     Set Variable     ${CURDIR}/../../../Resource/TestData/merchant/mass_upload_virtual_stock.xlsx
    ${full_path_file}=     common.get_canonical_path    ${path_file}
    Set Sku And Qty in File Excel    ${full_path_file}    ${content_list}
    Return From Keyword    ${full_path_file}

MCH Mass Upload Virtual Stock - Get Remaining Stock From PCMS Remaining API
    [Arguments]    ${sku_id}
    ${response}=    Get Remaining Stock By Inventory ID    ${sku_id}
    ${remaining}=    Get Json Value    ${response}    /data/remaining/${sku_id}
    Return From Keyword    ${remaining}

MCH Mass Upload Virtual Stock - Get Stock Sum From PCMS Remaining API
    [Arguments]    ${sku_id}
    ${response}=    Get Remaining Stock By Inventory ID    ${sku_id}
    ${stock_sum}=    Get Json Value    ${response}    /data/stock/${sku_id}
    Return From Keyword    ${stock_sum}

MCH Mass Upload Virtual Stock - Get Hold Stock From PCMS Remaining API
    [Arguments]    ${sku_id} 
    ${response}=    Get Remaining Stock By Inventory ID    ${sku_id}
    ${hold}=    Get Json Value    ${response}    /data/hold/${sku_id}
    Return From Keyword    ${hold}

MCH Mass Upload Virtual Stock - Keep Stock Sum For Each Sku
    [Arguments]    @{sku_id_list}
    ${stock_dict}=    Create Dictionary
    :FOR    ${sku_id}    IN     @{sku_id_list}
    \    ${stock_sum}=    MCH Mass Upload Virtual Stock - Get Stock Sum From PCMS Remaining API    ${sku_id}
    \    Set To Dictionary    ${stock_dict}    ${sku_id}=${stock_sum}
    Set Test Variable     ${existing_stock_sum_sku_dict}    ${stock_dict}

MCH Mass Upload Virtual Stock - Roll Back Stock Sum For Each Sku
    ${sku_id_list}=    Get Dictionary Keys    ${existing_stock_sum_sku_dict}
    :FOR    ${sku_id}    IN     @{sku_id_list}
    \    ${stock_value}=    Get From Dictionary    ${existing_stock_sum_sku_dict}    ${sku_id}
    \    Stock - Increase Stock By Inventory Id    ${sku_id}    ${stock_value}

MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API
    [Arguments]    ${sku_id}    ${expected_stock_sum}
    ${response}=    Get Remaining Stock By Inventory ID    ${sku_id}
    ${stock_sum}=    Get Json Value    ${response}    /data/stock/${sku_id}
    Should Be Equal As Integers    ${stock_sum}    ${expected_stock_sum}

MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result
    [Arguments]    ${expected_result}
    Wait Until Element Is Visible     ${alert_file_verification_result}    20s
    ${alert_file_ver_result}=    Get Text    ${alert_file_verification_result}
    Should Be Equal    ${alert_file_ver_result}    ${expected_result}

MCH Mass Upload Virtual Stock - Verify File Verification Result
    [Arguments]    ${expected_result}
    ${index_loop}=    Set Variable    1
    :FOR    ${number}    ${sku}    ${qty}    ${status}    IN
    ...     row          A         B         ${EMPTY}
    ...     1            SKU       QTY       Status
    \    ${row_col1}=    Get Table Cell    ${file_verification_table}    ${index_loop}    1
    \    ${row_col2}=    Get Table Cell    ${file_verification_table}    ${index_loop}    2
    \    ${row_col3}=    Get Table Cell    ${file_verification_table}    ${index_loop}    3
    \    ${row_col4}=    Get Table Cell    ${file_verification_table}    ${index_loop}    4
    \    Should Be Equal    ${number}    ${row_col1}
    \    Should Be Equal    ${sku}       ${row_col2}
    \    Should Be Equal    ${qty}       ${row_col3}
    \    Should Be Equal    ${status}    ${row_col4}
    \    ${index_loop}=    Evaluate    ${index_loop}+1

    ${length_expected_result}=    Get Length    ${expected_result}
    ${current_page}=    Set Variable    1
    ${index_loop}=      Set Variable    3
    :FOR    ${number}    ${sku}    ${qty}    ${status}    IN    @{expected_result}
    \    ${row_col1}=    Get Table Cell    ${file_verification_table}    ${index_loop}    1
    \    ${row_col2}=    Get Table Cell    ${file_verification_table}    ${index_loop}    2
    \    ${row_col3}=    Get Table Cell    ${file_verification_table}    ${index_loop}    3
    \    ${row_col4}=    Get Table Cell    ${file_verification_table}    ${index_loop}    4
    \    Should Be Equal As Strings    ${number}    ${row_col1}
    \    Should Be Equal As Strings    ${sku}       ${row_col2}
    \    Should Be Equal As Strings    ${qty}       ${row_col3}
    \    Should Be Equal As Strings    ${status}    ${row_col4}
    \    ${index_loop}=    Evaluate    ${index_loop}+1
    \    ${index_page}=    Evaluate    int((${index_loop}+7)/10)
    \    ${is_current_page}=    Run Keyword And Return Status    Should Be Equal As Integers    ${index_page}    ${current_page}
    \    ${is_last_element}=    Run Keyword And Return Status    Should Be Equal As Integers    ${index_loop}    ${length_expected_result}
    \    Run Keyword Unless    ${is_last_element}    Run Keyword Unless    ${is_current_page}    Click Element    ${next_page_button}
    \    ${index_loop}=    Set Variable If    ${is_current_page}    ${index_loop}    3

MCH Mass Upload Virtual Stock - Wait Until Page Contains File Verification Table
    [Arguments]    ${wait_time}=30
    Wait Until Page Contains Element    ${file_verification_table}    ${wait_time}

MCH Mass Upload Virtual Stock - Click Download Template -- unavailable
    Wait Until Element Is Visible    ${download_template_link}    20s
    Click Element    ${download_template_link}

MCH Mass Upload Virtual Stock - Set SKU and QTY in file csv
    [Arguments]    ${data}
    ${path_file}=    Set Variable    ${CURDIR}/../../../Resource/TestData/merchant/mass_upload_virtual_stock_csv.csv
    csvlibrary.create_file    ${path_file}    ${data}
    [Return]    ${path_file}

Download template
    Wait Until Element Is Visible    ${download_template_link}    15s
    Click Element    ${download_template_link}
    ${cookies}=    Get Cookies
    ${accessToken}=     Get Cookie Value     x-wm-accessToken
    ${refreshToken}=    Get Cookie Value     x-wm-refreshToken
    ${header_dict}=     Create Dictionary    x-wm-accessToken=${accessToken}    x-wm-refreshToken=${refreshToken}
    log     cookies${cookies}
    write_download_with_headers    ${MERCHANT_CENTER_URL_API}/bis/v1/replace/stock/template    ${filename}     ${header_dict}
    Return From Keyword    ${filename}

Check template is correctly
    [Arguments]    ${filename}
    ${verify}=     verify_example_template_of_mass_upload_virtual_stock     ${filename}
    Log To Console     verify=${verify}
    Should Be Equal    True    ${verify}
