*** Settings ***
Library           Selenium2Library
Library           String
Resource          web_element_verify_thai_id.robot

*** Keywords ***
Activate Sim Report - Go To TruemoveH Activate Sim Report
    Go To    ${PCMS_URL}/truemoveh/activate-report
    Wait Until Element Is Visible    ${tmvh_textbox_search_by_order}    30s

MNP1 has Reject Thai ID
    [Arguments]     ${order_id}
    Go To    ${PCMS_URL}/truemoveh/verify?pcms_order_id=${order_id}
    Click Element    ${button_rejejct}
    Click Element   ${button_submit}

MNP1 has Customer Cancel
    [Arguments]     ${order_id}
    Go To    ${PCMS_URL}/truemoveh/verify?pcms_order_id=${order_id}
    Click Element    ${button_customer_cancel}
    Click Element    ${button_submit}

MNP1 has Approve
    [Arguments]     ${order_id}
    Go To    ${PCMS_URL}/truemoveh/verify?pcms_order_id=${order_id}
    Click Element    ${button_approve}
    Click Element    ${button_submit}

Set Item Status Customer Cancel
    [Arguments]     ${order_id}
    Go To    ${PCMS_URL}/orders/detail/${order_id}
