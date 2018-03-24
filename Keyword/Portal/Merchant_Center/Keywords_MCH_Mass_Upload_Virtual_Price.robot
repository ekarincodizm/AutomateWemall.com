*** Settings ***
Library           ${CURDIR}/../../../Python_Library/xlsx_library.py

*** Keywords ***
MCH Mass Upload Virtual Price - Go To Merchant Center Report Upload Price Page
    [Arguments]    ${wait_time}=20
    MCH Common - Go To Merchant Center Report Page
    Click Element    //*[@id="uploadPrice"]/a
    Wait Until Page Contains Element    ${upload_button}    ${wait_time}

MCH Mass Upload Virtual Price - Choose File For Mass Upload Product
    [Arguments]    ${file_upload}
    ${canonicalPath}=    common.Get Canonical Path    ${file_upload}
    Choose File    ${choose_file_input}    ${canonicalPath}

MCH Mass Upload Virtual Price - Click Upload Button
    Click Element    ${upload_button}
    MCH Mass Upload Virtual Price - Wait Until Page Contains File Verification Table

MCH Mass Upload Virtual Price - Click Close Button
    Click Element    ${close_file_verification_button}
    Wait Until Page Contains Element    ${upload_button}    ${wait_time}

MCH Mass Upload Virtual Price - Generate Excel File to be Uploaded
    [Arguments]    @{data}
    ${content_list}=    Create List
    :FOR     ${col_index}    ${value}    IN    @{data}
    \    ${content}=    Create List    ${col_index}    ${value}
    \    Append To List    ${content_list}    ${content}
    Return From Keyword    ${content_list}

MCH Mass Upload Virtual Price - Generate Expected Result for Verification
    [Arguments]    @{data}
    ${file_ver_result}=    Create List
    :FOR    ${row}    ${sku}    ${normal_price}    ${special_price}    ${status}    IN    @{data}
    \    ${file_ver_data_value}=    Create List    ${row}    ${sku}    ${normal_price}    ${special_price}    ${status}
    \    Append To List    ${file_ver_result}    @{file_ver_data_value}
    Return From Keyword    ${file_ver_result}

MCH Mass Upload Virtual Price - Set SKU and Price in file excel
    [Arguments]    ${content_list}=${EMPTY}
    ${path_file}=     Set Variable     ${CURDIR}/../../../Resource/TestData/merchant/mass_upload_virtual_price.xlsx
    ${full_path_file}=     common.get_canonical_path    ${path_file}
    Set Sku And Price In File Excel    ${full_path_file}    ${content_list}
    Return From Keyword    ${full_path_file}

MCH Mass Upload Virtual Price - Roll Back Price Sum For Each Sku
    ${sku_id_list}=    Get Dictionary Keys    ${existing_Price_sum_sku_dict}
    :FOR    ${sku_id}    IN     @{sku_id_list}
    \    ${Price_value}=    Get From Dictionary    ${existing_Price_sum_sku_dict}    ${sku_id}
    \    Price - Increase Price By Inventory Id    ${sku_id}    ${Price_value}

MCH Mass Upload Virtual Price - Verify Price From PCMS Remaining API
    [Arguments]    ${sku_id}    ${expected_normal_price}    ${expected_special_price}
    ${response}=    Get Price By Inventory ID    ${sku_id}
    ${normal_price}=    Get Json Value    ${response}    /data/normal_price
    ${special_price}=    Get Json Value    ${response}    /data/price
    ${normal_price}=    Replace String    ${normal_price}    "    ${EMPTY}
    ${special_price}=    Replace String    ${special_price}    "    ${EMPTY}
    Should Be Equal    ${normal_price}    ${expected_normal_price}
    Should Be Equal    ${special_price}    ${expected_special_price}

MCH Mass Upload Virtual Price - Verify Alert For File Verification Result
    [Arguments]    ${expected_result}
    Wait Until Element Is Visible     ${alert_file_verification_result}    20s
    ${alert_file_ver_result}=    Get Text    ${alert_file_verification_result}
    Should Be Equal    ${alert_file_ver_result}    ${expected_result}

MCH Mass Upload Virtual Price - Verify File Verification Result
    [Arguments]    ${expected_result}
    ${index_loop}=    Set Variable    1
    :FOR    ${number}    ${sku}    ${normal_price}    ${special_price}    ${status}    IN
    ...     row          A         B         C         ${EMPTY}
    ...     1            SKU       Normal Price       Special Price       Status
    \    ${row_col1}=    Get Table Cell    ${file_verification_table}    ${index_loop}    1
    \    ${row_col2}=    Get Table Cell    ${file_verification_table}    ${index_loop}    2
    \    ${row_col3}=    Get Table Cell    ${file_verification_table}    ${index_loop}    3
    \    ${row_col4}=    Get Table Cell    ${file_verification_table}    ${index_loop}    4
    \    ${row_col5}=    Get Table Cell    ${file_verification_table}    ${index_loop}    5
    \    Should Be Equal    ${number}    ${row_col1}
    \    Should Be Equal    ${sku}       ${row_col2}
    \    Should Be Equal    ${normal_price}       ${row_col3}
    \    Should Be Equal    ${special_price}       ${row_col4}
    \    Should Be Equal    ${status}    ${row_col5}
    \    ${index_loop}=    Evaluate    ${index_loop}+1

    ${index_loop}=      Set Variable    3
    :FOR    ${number}    ${sku}    ${normal_price}    ${special_price}    ${status}    IN    @{expected_result}
    \    ${row_col1}=    Get Table Cell    ${file_verification_table}    ${index_loop}    1
    \    ${row_col2}=    Get Table Cell    ${file_verification_table}    ${index_loop}    2
    \    ${row_col3}=    Get Table Cell    ${file_verification_table}    ${index_loop}    3
    \    ${row_col4}=    Get Table Cell    ${file_verification_table}    ${index_loop}    4
    \    ${row_col5}=    Get Table Cell    ${file_verification_table}    ${index_loop}    5
    \    Should Be Equal    ${number}    ${row_col1}
    \    Should Be Equal    ${sku}    ${row_col2}
    \    ${row_col3}=    Replace String    ${row_col3}    ,    ${EMPTY}
    \    ${row_col4}=    Replace String    ${row_col4}    ,    ${EMPTY}
    \    ${normal_price}=    Replace String    ${normal_price}    .00    ${EMPTY}
    \    ${special_price}=    Replace String    ${special_price}    .00    ${EMPTY}
    \    Should Be Equal    ${normal_price}    ${row_col3}
    \    Should Be Equal    ${special_price}    ${row_col4}
    \    Should Be Equal    ${status}    ${row_col5}
    \    ${index_loop}=    Evaluate    ${index_loop}+1

MCH Mass Upload Virtual Price - Verify File Verification Result From History File
    [Arguments]    ${expected_result}
    Should Be Equal    success    @{expected_result}[7]
    Should Be Equal    success    @{expected_result}[11]
    Should Be Equal    success    @{expected_result}[15]

MCH Mass Upload Virtual Price - Wait Until Page Contains File Verification Table
    [Arguments]    ${wait_time}=30
    Wait Until Page Contains Element    ${file_verification_table}    ${wait_time}

MCH Mass Upload Virtual Price - Click Download Template -- unavailable
    Wait Until Element Is Visible    ${download_template_link}    20s
    Click Element    ${download_template_link}

Download template
    Wait Until Element Is Visible    ${download_template_link}    15s
    Click Element    ${download_template_link}
    ${cookies}=    Get Cookies
    ${accessToken}=     Get Cookie Value     x-wm-accessToken
    ${refreshToken}=    Get Cookie Value     x-wm-refreshToken
    ${header_dict}=     Create Dictionary    x-wm-accessToken=${accessToken}    x-wm-refreshToken=${refreshToken}
    log     cookies${cookies}
    write_download_with_headers    ${MERCHANT_CENTER_URL_API}/bis/v1/replace/Price/template    ${filename}     ${header_dict}
    Return From Keyword    ${filename}

Check template is correctly
    [Arguments]    ${filename}
    ${verify}=     verify_example_template_of_mass_upload_virtual_Price     ${filename}
    Log To Console     verify=${verify}
    Should Be Equal    True    ${verify}

Go To Mass Upload Price
    MCH Common - Open Merchant Center Page And Login
    Sleep    5
    Wait Until Element Is Visible    //input[@class='search']    ${wait_time}
    Click Element    //input[@class='search']
    Wait Until Element Is Visible    //div[@class='item'][@data-value="ITM"]    ${wait_time}
    Click Element    //div[@class='item'][@data-value="ITM"]
    Sleep    5
    MCH Common - Go To Merchant Center Report Page
