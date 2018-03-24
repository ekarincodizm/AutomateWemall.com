*** Settings ***
Library           Selenium2Library
Library           String
Resource          web_element_order_report.robot

*** Keywords ***
TMVH Order Report - Go To TruemoveH Order Report
    Go To    ${PCMS_URL}/truemoveh/orders
    Wait Until Element Is Visible    ${tmvh_textbox_search_by_order}    30s

TMVH Order Report - Input Search By Order ID
    [Arguments]    ${order_id}
    Wait Until Element Is Visible    ${tmvh_textbox_search_by_order}    30s
    Input Text    ${tmvh_textbox_search_by_order}    ${order_id}

TMVH Order Report - Click Search Button On Order Tracker Page
    Click Element    ${tmvh_button_search}

TMVH Order Report - Click View Shipment Detail
    [Arguments]    ${order_id}
    Wait Until Element Is Visible    jquery=a[href$='/orders/detail/${order_id}']    10s
    Click Element    jquery=a[href$='/orders/detail/${order_id}']
    Select Window    url=${PCMS_URL}/orders/detail/${order_id}
    Wait Until Element Is Visible    ${tmvh_icon_truck}    10s

TMVH Order Report - Click Verify Thai ID
    [Arguments]    ${order_id}
    Wait Until Element Is Visible    jquery=a[href$='/truemoveh/verify?pcms_order_id=${order_id}']    10s
    Click Element    jquery=a[href$='/truemoveh/verify?pcms_order_id=${order_id}']
    Select Window    url=${PCMS_URL}/truemoveh/verify?pcms_order_id=${order_id}
    Wait Until Element Is Visible    jquery=a[href$='/truemoveh/verify/display?pcms_order_id=${order_id}']    10s

TMVH Verify Thai ID - Click Approve
    Wait Until Element Is Visible    jquery=a[href$='/truemoveh/verify/success']    30s
    Click Element    jquery=a[href$='truemoveh/verify/success']
    Wait Until Element Is Visible    ${tmvh_confirm_ok}    15s
    Click Element    ${tmvh_confirm_ok}
