*** Keywords ***
Mass Upload Product to Category - Select Upload Action
    [Arguments]    ${action}
    Run Keyword If    "${action}"=="add"    Select From List    ${UPLOAD-ACTION-SELECTOR}    Add new products into catagories
    ...    ELSE IF    "${action}"=="replace"    Select From List    ${UPLOAD-ACTION-SELECTOR}    Replace existing products in catagories
    ...    ELSE      Error - Action should be : add | replace

Mass Upload Product to Category - Choose File For Mass Upload Product
    [Arguments]    ${file_upload}
    ${canonicalPath}=    common.Get Canonical Path    ${file_upload}
    Choose File    ${CHOOSE-FILE-INPUT}    ${canonicalPath}

Mass Upload Product to Category - Click Upload Button   
    Click Element    ${UPLOAD-BUTTON}
    Sleep    3s

Mass Upload Product to Category - Verify Alert For Upload Action and File Result
    [Arguments]    ${expected_result}
    ${alert_act_file_result}=    Get Text    ${ALERT-UPLOAD-ACTION-AND-FILE-RESULT}
    ${alert_act_file_result}=    Strip String    ${alert_act_file_result}
    Should Contain    ${alert_act_file_result}    ${expected_result}

Mass Upload Product to Category - Verify Alert For File Verification Result
    [Arguments]    ${expected_result}
    ${alert_file_ver_result}=    Get Text    ${ALERT-FILE-VERIFICATION-RESULT}
    ${alert_file_ver_result}=    Strip String    ${alert_file_ver_result}
    Should Contain    ${alert_file_ver_result}    ${expected_result}

Mass Upload Product to Category - Verify File Verification Result
    [Arguments]    ${expected_result}
    ${index_loop}=    Set Variable    1
    :FOR    ${number}    ${category_pkey}    ${product_pkey}    ${status}    IN
    ...     ${EMPTY}     A                   B                  ${EMPTY}
    ...     1            Category Key        Product Key        Status
    \    ${row_col1}=    Get Table Cell    ${FILE-VERIFICATION-TABLE}    ${index_loop}    1
    \    ${row_col2}=    Get Table Cell    ${FILE-VERIFICATION-TABLE}    ${index_loop}    2
    \    ${row_col3}=    Get Table Cell    ${FILE-VERIFICATION-TABLE}    ${index_loop}    3
    \    ${row_col4}=    Get Table Cell    ${FILE-VERIFICATION-TABLE}    ${index_loop}    4
    \    Should Be Equal    ${number}           ${row_col1}
    \    Should Be Equal    ${category_pkey}    ${row_col2}
    \    Should Be Equal    ${product_pkey}     ${row_col3}
    \    Should Be Equal    ${status}           ${row_col4}
    \    ${index_loop}=    Evaluate    ${index_loop}+1

    ${length_expected_result}=    Get Length    ${expected_result}
    ${current_page}=    Set Variable    1
    ${index_loop}=      Set Variable    3
    :FOR    ${number}    ${category_pkey}    ${product_pkey}    ${status}    IN    @{expected_result}
    \    ${row_col1}=    Get Table Cell    ${FILE-VERIFICATION-TABLE}    ${index_loop}    1
    \    ${row_col2}=    Get Table Cell    ${FILE-VERIFICATION-TABLE}    ${index_loop}    2
    \    ${row_col3}=    Get Table Cell    ${FILE-VERIFICATION-TABLE}    ${index_loop}    3
    \    ${row_col4}=    Get Table Cell    ${FILE-VERIFICATION-TABLE}    ${index_loop}    4
    \    Should Be Equal As Strings    ${number}           ${row_col1}
    \    Should Be Equal As Strings    ${category_pkey}    ${row_col2}
    \    Should Be Equal As Strings    ${product_pkey}     ${row_col3}
    \    Should Be Equal As Strings    ${status}           ${row_col4}
    \    ${index_loop}=    Evaluate    ${index_loop}+1
    \    ${index_page}=    Evaluate    int((${index_loop}+7)/10)
    \    ${is_current_page}=    Run Keyword And Return Status    Should Be Equal As Integers    ${index_page}    ${current_page}
    \    ${is_last_element}=    Run Keyword And Return Status    Should Be Equal As Integers    ${index_loop}    ${length_expected_result}
    \    Run Keyword Unless    ${is_last_element}    Run Keyword Unless    ${is_current_page}    Click Element    ${NEXT-PAGE-LINK}
    \    ${index_loop}=    Set Variable If    ${is_current_page}    ${index_loop}    3

Mass Upload Product to Category - Category Should Have Product(s)
    [Arguments]    ${cat_pkey}    ${expected_product_list}
    ${response}=    Get Category By Category Pkey    ${cat_pkey}
    ${total_product}=    Get Json Value and Convert to List    ${response}    /data/total_product
    ${products}=    Get Json Value and Convert to List    ${response}    /data/products
    Log List    ${products}
    ${expected_total_product}=    Get Length    ${expected_product_list}
    Should Be Equal As Integers    ${expected_total_product}    ${total_product}
    :FOR    ${index}    IN RANGE    ${expected_total_product}
    \    Should Be Equal As Strings    @{expected_product_list}[${index}]    @{products}[${index}]

Mass Upload Product to Category - Wait Until Page Contains File Verification Table
    [Arguments]    ${wait_time}=30
    Wait Until Page Contains Element    ${FILE-VERIFICATION-TABLE}    ${wait_time}
