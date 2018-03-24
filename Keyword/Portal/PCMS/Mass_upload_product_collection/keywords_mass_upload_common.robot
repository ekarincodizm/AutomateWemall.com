*** Settings ***
Library           Selenium2Library
Library           String
Library           BuiltIn
Library           Collections
Library           ${CURDIR}/../../../../Python_Library/collection.py
Library           ${CURDIR}/../../../../Python_Library/common.py
Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py
Library           ${CURDIR}/../../../../Python_Library/common/csvlibrary.py

Resource          web_element_mass_upload_common.robot

*** Keywords ***

All history of mass upload
    ${get_text_all_history}=    Get Text    ${text_all_history}
    ${split_get_text_all_history}=    Split String    ${get_text_all_history}    of
    ${get_split_get_text_all_history}=    Get From List    ${split_get_text_all_history}    1
    ${num_all_history}=    Strip String    ${get_split_get_text_all_history}    characters=entries
    ${num_all_history}=    Strip String    ${num_all_history}    mode=left
    ${num_all_history}=    Strip String    ${num_all_history}    mode=right

    Return From Keyword    ${num_all_history}

Get upload histories
    [Arguments]    ${type}=prod_col
    ${result}=    get_upload_history_by_type    ${type}
    Return From Keyword    ${result}

Get upload history result from web page
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

    \  ${display_name_top_bar_length}=    Get Length    ${display_name_top_bar}
    \  ${result_username_no_id}=    Get Substring    ${result_username}    0     ${display_name_top_bar_length}

    \  ${result_index}=    Set Variable    ${INDEX}
    \  Log to console    result_filename::${result_filename}
    \  Log to console    result_username::${result_username}
    \  Log to console    result_username_no_id::${result_username_no_id}

    \  Run Keyword If    '${result_filename}' == '${expected_filename}' and '${result_username_no_id}' == '${display_name_top_bar}'    Exit For Loop

    Should Not Be Equal    ${EMPTY}    ${result_index}

    ${result_index}=    Convert to integer    ${result_index}
    ${result_row_index}=    Evaluate    ${result_index} + 1
    ${get_upload_histories_table_td_elements}=    Get Webelements    ${upload_histories_table_tr_elements}[${result_row_index}]/td

    ${filename}=    Set Variable    ${get_upload_histories_table_td_elements[0].text}
    ${username}=    Set Variable    ${get_upload_histories_table_td_elements[1].text}
    ${status}=    Set Variable    ${get_upload_histories_table_td_elements[2].text}
    ${reason}=    Set Variable    ${get_upload_histories_table_td_elements[3].text}

    ${result_list}=    Create List     ${filename}    ${username}    ${status}    ${reason}
    Log to console    result_list::${result_list}
    [Return]    ${result_list}

Check upload history result with DB
    [Arguments]    ${expected_filename}    ${expected_username}    ${expected_status}    ${expected_reason}    ${num_all_history}    ${type}=prod_col

    Log to console    expected_filename::${expected_filename}
    Log to console    expected_username::${expected_username}

    ${result_upload_history}=    Set Variable    ${EMPTY}
    ${upload_histories}=    Get upload histories    ${type}

    ${upload_histories_length}=    Get Length    ${upload_histories}

    Log to console    upload_histories_length::${upload_histories_length}
    Log to console    num_all_history::${num_all_history}

    ${num_all_history}=    Convert to integer    ${num_all_history}

    Should be equal    ${upload_histories_length}    ${num_all_history}

    :FOR    ${upload_history}    IN    @{upload_histories}
    \  ${file_name}=    Set Variable    ${upload_history[1]}
    \  ${user_name}=    Set Variable    ${upload_history[0]}
    \  Log to console    file_name::${file_name}
    \  Log to console    user_name::${user_name}
    \  ${result_upload_history}=    Set Variable    ${upload_history}
    \  Run Keyword If    '${file_name}' == '${expected_filename}' and '${user_name}' == '${expected_username}'    Exit For Loop

    ${result_filename}=    Set Variable    ${result_upload_history[1]}
    ${result_username}=    Set Variable    ${result_upload_history[0]}
    ${result_status}=    Set Variable    ${result_upload_history[2]}
    ${result_reason}=    Set Variable    ${result_upload_history[3]}

    Should be equal    ${result_filename}    ${expected_filename}
    Should be equal    ${result_username}    ${expected_username}
    Should be equal    ${result_status}    ${expected_status}
    Should be equal    ${result_reason}    ${expected_reason}
    Sleep    5s

Check user in history same the user in top menu
    [Arguments]    ${get_username_history}    ${display_name_top_bar_strip}

    ${display_name_top_bar_strip_length}=    Get Length    ${display_name_top_bar_strip}
    ${get_username_history_length}=    Get Length    ${get_username_history}

    ${get_username_history_no_id}=    Get Substring    ${get_username_history}    0     ${display_name_top_bar_strip_length}
    Log To Console    ${get_username_history_no_id}

    Should Be Equal    ${get_username_history_no_id}    ${display_name_top_bar_strip}
    Sleep    5s


Check all row in history
    [Arguments]     ${num_all_history}
    Log To Console    num_all_history=${num_all_history}
    ${num_page}=     Evaluate    int(__import__('math').ceil(${num_all_history}/20.0))
    ${sum_row}=      Evaluate    0
    Log To Console    ${num_page}
    : FOR    ${index}    IN RANGE    0    ${num_page}
    # \    Run Keyword If       ${btn_next1}==${btn_next2}        Exit For Loop
    \    ${get_row_table}=    Get Matching Xpath Count    //*[@id="DataTables_Table_0"]/tbody/tr
    \    ${sum_row}=    Evaluate    ${get_row_table}+${sum_row}
    \    Click Element    ${btn_next}
    \    Log To Console    ${index}=${sum_row}
    Log To Console     all row=${sum_row}
    ${num_all_history}=    Convert To Integer    ${num_all_history}
    Should Be Equal    ${sum_row}    ${num_all_history}
