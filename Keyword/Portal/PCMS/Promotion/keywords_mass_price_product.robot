*** Settings ***
Library           HttpLibrary.HTTP
Library           Selenium2Library
Library           ${CURDIR}/../../../../Python_Library/common.py
Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py
Library           ${CURDIR}/../../../../Python_Library/common/csvlibrary.py
Resource          ${CURDIR}/web_element_mass_price_product.robot
Resource          ${CURDIR}/../../../../Keyword/Portal/PCMS/Mass_upload_product_collection/keywords_mass_upload_common.robot

*** Keywords ***
Go to mass price and product menu
    Go To    ${PCMS_URL}/campaigns/mass-upload

Cannot see mass price and product menu
    Wait Until Element Is Visible    ${promotion_menu}     15s
    Click Element     ${promotion_menu}
    Element Should Not Be Visible    ${mass_price_product_menu}    15s

Cannot see promotion menu
    Element Should Not Be Visible    ${promotion_menu}

Mass Price Product - verify success message
    [Arguments]    ${success_message}
    ${get_text_success_message}=    Get Text    ${text_message}
    Should Be Equal    ${get_text_success_message}    ${success_message}

Mass Price Product - verify upload result message
    [Arguments]    ${message}
    ${get_text_message}=    Get Text    ${text_message}
    Should Be Equal    ${get_text_message}    ${message}

Mass Price Product - verify fail result
    [Arguments]    ${message_fail}    ${result}
    ${get_text_message}=    Get Text    ${text_message_fail}
    Should Be Equal    ${get_text_message}    ${message_fail}
    ${result_number_of_row}=    Get Length    ${result}
    ${actual_number_of_row}=    Get Matching Xpath Count    ${fail_result_table}/tbody/tr
    Should Be Equal    "${actual_number_of_row}"    "${result_number_of_row}"
    :FOR    ${index}    IN RANGE    ${actual_number_of_row}
    \    ${result_record}=    Set Variable    @{result}[${index}]
    \    ${table_row_number}=    Evaluate     ${index}+1
    \    ${row_number}=        Get Text    ${fail_result_table}/tbody/tr[${table_row_number}]/td[1]
    \    ${camp_id}=           Get Text    ${fail_result_table}/tbody/tr[${table_row_number}]/td[2]
    \    ${sku_id}=            Get Text    ${fail_result_table}/tbody/tr[${table_row_number}]/td[3]
    \    ${discount_price}=    Get Text    ${fail_result_table}/tbody/tr[${table_row_number}]/td[4]
    \    ${status}=            Get Text    ${fail_result_table}/tbody/tr[${table_row_number}]/td[5]
    \    Should Be Equal    "${row_number}"        "@{result_record}[0]"
    \    Run Keyword If    "@{result_record}[1]" == ","    Should Be Empty    ${camp_id}
    \    ...    ELSE     Should Be Equal    "${camp_id}"    "@{result_record}[1]"
    \    Run Keyword If    "@{result_record}[2]" == ","    Should Be Empty    ${sku_id}
    \    ...    ELSE     Should Be Equal    "${sku_id}"    "@{result_record}[2]"
    \    Run Keyword If    "@{result_record}[3]" == ","    Should Be Empty    ${discount_price}
    \    ...    ELSE     Should Be Equal    "${discount_price}"    "@{result_record}[3]"
    \    Should Be Equal    "${status}"            "@{result_record}[4]"

Mass Price Product - User click back button to mass upload price and product page
    Click Element    ${btn_back}

Mass Price Product - User click back link to mass upload price and product page
    Click Element    ${link_back}

Mass Price Product - error message is displayed
    [Arguments]    ${result_header_fail}
    ${get_text_result}=     Get Text    ${text_result}
    Log To Console    message=${get_text_result}
    Should Be Equal    ${get_text_result}    ${result_header_fail}

Mass Price Product - verify result on verification page when upload fail
    [Arguments]    ${data_fail}
    ${count_row}    Get Matching Xpath Count    ${xpath_count_row_td}
    ${count_hd_td}    Get Matching Xpath Count    ${xpath_hd_td}
    ${message}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count_hd_td} * ${count_row} + 1
    \    ${name}=    Get Text    xpath=(${xpath_td})[${i}]
    \    Append To List    ${message}    ${name}
    Should Be Equal     ${message}    ${data_fail}

User browse file for mass upload price and product
    [Arguments]    ${file_upload}
    ${canonicalPath}=    common.Get Canonical Path    ${file_upload}
    Choose File          ${browse_file}    ${canonicalPath}
    Location Should Contain     ${PCMS_URL}/campaigns/mass-upload/verify

Set campaign ID SKU ID and discount price in file csv
    [Arguments]    ${data}
    ${path_file}=     Set Variable     ${CURDIR}/../../../../Resource/TestData/Promotion/Discount_Campaign/csv_file/mass_upload_price_product_up.csv
    csvlibrary.create_file    ${path_file}    ${data}
    [Return]     ${path_file}

Mass Price Product - Delete history record by username after upload success
    [Arguments]    ${user_name}    ${filename}
    delete_history_massupload_by_user_and_type   ${user_name}    ${filename}    camp_prc_pro

Mass Price Product - verify cannot access mass price and product for discount campaign menu
    [Arguments]    ${text_header_can_not_access}    ${text_cannot_mass_price_product}
    ${get_text_header}=    Get Text    ${text_header}
    Should Be Equal    ${get_text_header}    ${text_header_can_not_access}
    ${get_text_can_not_access}=     Get Text    ${text_can_not_access}
    Should Be Equal     ${get_text_can_not_access}    ${text_cannot_mass_price_product}