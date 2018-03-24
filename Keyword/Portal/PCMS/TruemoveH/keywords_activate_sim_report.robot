*** Settings ***
Library           Selenium2Library
Library           String
Resource          web_element_activate_sim_report.robot

*** Keywords ***
Activate Sim Report - Login PCMS
    [Arguments]     ${Text_Email}=${PCMS_USERNAME}    ${Text_Password}=${PCMS_PASSWORD}
    Open Browser                        ${PCMS_URL}         ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible       ${xpath-login-email}
    Input Text                          ${xpath-login-email}        ${Text_Email}
    Input Text                          ${xpath-login-password}     ${Text_Password}
    Click Element                       ${xpath-login-button}
    Wait Until Element Is Visible       ${xpath-link-logout}    30s

Activate Sim Report - Go To TruemoveH Activate Sim Report
    Go To    ${PCMS_URL}/truemoveh/activate-report
    Wait Until Element Is Visible    ${tmvh_textbox_search_by_order}    30s

Activate Sim Report - Input Search By Order ID
    [Arguments]    ${order_id}
    Wait Until Element Is Visible    ${tmvh_textbox_search_by_order}    30s
    Input Text    ${tmvh_textbox_search_by_order}    ${order_id}

Activate Sim Report - Click Search Button
    Click Element    ${tmvh_button_search}

Activate Sim Report - Change Activate Status To Success
    [Arguments]    ${item_id}    ${tcc_order}
    ${element}=    Replace String    ${tmvh_cbo_activate_status}    ^^ITEM_ID^^    ${item_id}
    Wait Until Element Is Visible    ${element}    15s
    Select From List By Value    ${element}    success
    Wait Until Element Is Visible    ${tmvh_input_tcc_order}    60s
    Input Text    ${tmvh_input_tcc_order}    ${tcc_order}
    Wait Until Element Is Visible    ${tmvh_confirm_ok}    15s
    Click Element    ${tmvh_confirm_ok}

Activate Sim Report - Change Activate Status To Blacklist
    [Arguments]    ${item_id}    ${remark}
    ${element}=    Replace String    ${tmvh_cbo_activate_status}    ^^ITEM_ID^^    ${item_id}
    Log To Console    ${element}
    Wait Until Element Is Visible    ${element}    15s
    Select From List By Value    ${element}    fail
    Wait Until Element Is Visible    ${tmvh_input_remark}    60s
    Input Text    ${tmvh_input_remark}    ${remark}
    Wait Until Element Is Visible    ${tmvh_confirm_ok}    15s
    Click Element    ${tmvh_confirm_ok}

Activate Sim Report - Dropdown Search By Dealer
    [Arguments]    ${dealer_id}
    Wait Until Element Is Visible    ${tmvh_dropdown_search_by_dealer}    30s
    Select From List    ${tmvh_dropdown_search_by_dealer}    ${dealer_id}

Activate Sim Report - Default Value
    Wait Until Element Is Visible    ${tmvh_textbox_search_by_order}                    30s
    Input Text       ${tmvh_textbox_search_by_order}                ${EMPTY}
    Wait Until Element Is Visible    ${tmvh_textbox_search_by_created_at_start}         10s
    Input Text       ${tmvh_textbox_search_by_created_at_start}     ${EMPTY}
    Wait Until Element Is Visible    ${tmvh_textbox_search_by_created_at_end}           10s
    Input Text       ${tmvh_textbox_search_by_created_at_end}       ${EMPTY}
    Wait Until Element Is Visible    ${tmvh_textbox_search_by_transaction_time_start}   10s
    Input Text    ${tmvh_textbox_search_by_transaction_time_start}  ${EMPTY}
    Wait Until Element Is Visible    ${tmvh_textbox_search_by_transaction_time_end}     10s
    Input Text    ${tmvh_textbox_search_by_transaction_time_end}    ${EMPTY}
    Wait Until Element Is Visible    ${tmvh_dropdown_search_by_payment_status}          10s
    click element    ${tmvh_dropdown_search_by_payment_status}/option[1]
    Wait Until Element Is Visible    ${tmvh_dropdown_search_by_verify_status}           10s
    click element    ${tmvh_dropdown_search_by_verify_status}/option[1]
    Wait Until Element Is Visible    ${tmvh_dropdown_search_by_item_status}             10s
    click element    ${tmvh_dropdown_search_by_item_status}/option[1]
    Wait Until Element Is Visible    ${tmvh_dropdown_search_by_verify_status}           10s
    click element    ${tmvh_dropdown_search_by_activate_status}/option[1]
    Wait Until Element Is Visible    ${tmvh_dropdown_search_by_activate_status}         10s
    click element    ${tmvh_dropdown_search_by_dealer}/option[1]

Activate Sim Report - Check Data
    [Arguments]    ${order_id}   ${item_id}   ${mobile_no}   ${dealer_name}
    ${item_id_str}=     Convert To String   ${item_id}
    Wait Until Element Is Visible    //h4[@id="order_id_${order_id}"]       30s
    Wait Until Element Is Visible    //td[@id="item_id_${order_id}"]        10s
    Wait Until Element Is Visible    //td[@id="mobile_${order_id}"]         10s
    Wait Until Element Is Visible    //td[@id="merchant_id_${order_id}"]    10s
    ${check_order_id}=             Get Text     //h4[@id="order_id_${order_id}"]
    ${check_item_id}=              Get Text     //td[@id="item_id_${order_id}"]
    ${check_mobile}=               Get Text     //td[@id="mobile_${order_id}"]
    ${check_merchant_id}=          Get Text     //td[@id="merchant_id_${order_id}"]
    Should Be Equal     ${check_order_id}           Order ID : ${order_id}
    Should Be Equal     ${check_item_id}            ${item_id_str}
    Should Be Equal     ${check_mobile}             ${mobile_no}
    Should Be Equal     ${check_merchant_id}        ${dealer_name}

Activate Sim Report - Input Search By Order Date
    [Arguments]    ${create_at}
    Wait Until Element Is Visible    ${tmvh_textbox_search_by_created_at_start}    30s
    Input Text    ${tmvh_textbox_search_by_created_at_start}    ${create_at}
    Wait Until Element Is Visible    ${tmvh_textbox_search_by_created_at_end}      10s
    Input Text    ${tmvh_textbox_search_by_created_at_end}      ${create_at}

Activate Sim Report - Input Search By Payment Date
    [Arguments]    ${transaction_time}
    Wait Until Element Is Visible    ${tmvh_textbox_search_by_transaction_time_start}    30s
    Input Text    ${tmvh_textbox_search_by_transaction_time_start}    ${transaction_time}
    Wait Until Element Is Visible    ${tmvh_textbox_search_by_transaction_time_end}      10s
    Input Text    ${tmvh_textbox_search_by_transaction_time_end}      ${transaction_time}

Activate Sim Report - Select Value Dropdown
    [Arguments]     ${option_payment_status}   ${option_verify_status}   ${option_item_status}   ${option_ativate_status}   ${option_dealer}
    Wait Until Element Is Visible    ${tmvh_dropdown_search_by_payment_status}      30s
    Select From List    ${tmvh_dropdown_search_by_payment_status}       ${option_payment_status}
    Wait Until Element Is Visible    ${tmvh_dropdown_search_by_verify_status}       10s
    Select From List    ${tmvh_dropdown_search_by_verify_status}        ${option_verify_status}
    Wait Until Element Is Visible    ${tmvh_dropdown_search_by_item_status}         10s
    Select From List    ${tmvh_dropdown_search_by_item_status}          ${option_item_status}
    Wait Until Element Is Visible    ${tmvh_dropdown_search_by_verify_status}       10s
    Select From List    ${tmvh_dropdown_search_by_activate_status}      ${option_ativate_status}
    Wait Until Element Is Visible    ${tmvh_dropdown_search_by_activate_status}     10s
    Select From List    ${tmvh_dropdown_search_by_dealer}               ${option_dealer}