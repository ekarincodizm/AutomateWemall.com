*** Settings ***
Resource     web_element_order_detail.robot

*** Keywords ***
Order Detail - Change All Items Status To Shipped
    [Arguments]      ${order_id}
    Wait Until Element Is Visible             ${icon_truck}    10s
    ${webElement}=    Get Webelements    jquery=table.dataTable td.table-center:first-child
    :FOR    ${element}    IN    @{webElement}
    \    Select From List By Value       css=#status_item${element.text}    shipped
    \    Select From List By Value       css=#third_pl${element.text}       1
    Click Element     ${button_orders_detail_save_all}
    Confirm Action

Order Detail - Change All Items Status To Delivered
    [Arguments]      ${order_id}
    Wait Until Element Is Visible             ${icon_truck}    10s
    ${webElement}=    Get Webelements    jquery=table.dataTable td.table-center:first-child
    :FOR    ${element}    IN    @{webElement}
    \    Select From List By Value       css=#status_item${element.text}    delivered
    Click Element     ${button_orders_detail_save_all}
    Confirm Action

Order Detail - Change All Items Status To Pending Shipment
    [Arguments]      ${order_id}
    Wait Until Element Is Visible             ${icon_truck}    10s
    ${webElement}=    Get Webelements    jquery=table.dataTable td.table-center:first-child
    :FOR    ${element}    IN    @{webElement}
    \    Select From List By Value       css=#status_item${element.text}    pending_shipment
    Click Element     ${button_orders_detail_save_all}     ${TRUE}
    Confirm Action

Order Detail - Change All Items Status To Customer Cancel
    [Arguments]      ${order_id}
    Wait Until Element Is Visible             ${icon_truck}    10s
    ${webElement}=    Get Webelements    jquery=table.dataTable td.table-center:first-child
    :FOR    ${element}    IN    @{webElement}
    \    Select From List By Value       css=#status_item${element.text}    customer_cancelled
    \    Select From List By Value       css=#dropdown_cancel_reason_${element.text}    3
    Click Element     ${button_orders_detail_save_all}
    Confirm Action
Order Detail - Change Shipment Status By Order Id List
    ${order_counts}=        Get Length    ${ORDER_IDS}
    :FOR    ${index}    IN RANGE    0    ${order_counts}
    \       ${order_id}=    Get Data From List By Index     ${ORDER_IDS}    ${index}
    \       Change Shipment Status By Order Id      ${order_id}

Order Detail - Change Shipment Status By Order Id
    [Arguments]      ${order_id}
    Go To Order Tracker
    Input Search By Order ID    ${order_id}
    Track Orders - Click Search Button On Order Tracker Page
    ${old_window}=      Get Location
    Click View Shipment Detail      ${order_id}
    Change All Items Status To Pending Shipment          ${order_id}
    Change All Items Status To Shipped      ${order_id}
    Change All Items Status To Delivered    ${order_id}
    Close Window
    Select Window      url=${old_window}

Order Detail - Order Display Payment Status Success
    ${element}=     Replace String      ${lbl_payment_status}       ^^payment_status^^     success
    Wait Until Element Is Visible       ${element}                  15s
    Element Should Be Visible           ${element}
    ${payment_status}=                  Get Text                    ${element}
    Should Be Equal                     ${payment_status}           ${MSG_ORDER_DETAIL.payment_status_success}

Order Detail - Order Display Payment Status Waiting
    ${element}=     Replace String      ${lbl_payment_status}       ^^payment_status^^     waiting
    Wait Until Element Is Visible       ${element}                  15s
    Element Should Be Visible           ${element}
    ${payment_status}=                  Get Text                    ${element}
    Should Be Equal                     ${payment_status}           ${MSG_ORDER_DETAIL.payment_status_waiting}

Order Detail - Count Order Item Type Normal
    [Arguments]      ${expect_qty}=1
    ${element}=      Replace String     ${lbl_item_camp_type}       ^^camp_type^^         none
    Wait Until Element Is Visible       ${element}                  15s
    ${count_element}=                   Get Matching Xpath Count    ${element}
    Should Be Equal As Integers         ${count_element}            ${expect_qty}

Order Detail - Count Order Item Type Freebie
    [Arguments]      ${expect_qty}=1
    ${element}=      Replace String     ${lbl_item_camp_type}      ^^camp_type^^         freebie
    Wait Until Element Is Visible       ${element}          10s
    ${count_element}=                   Get Matching Xpath Count        ${element}
    Should Be Equal As Integers         ${count_element}                ${expect_qty}

Order Detail - Display Promotion Camp Logs
    Wait Until Element Is Visible    ${table_promotion_camp_logs}   10
    Element Should Be Visible        ${table_promotion_camp_logs}

Order Detail - Find Camp ID On Promotion Camp Logs
    [Arguments]         ${camp_id}=None
    ${element}=         Replace String      ${camp_log_camp_id}   ^^camp_id^^    ${camp_id}
    Log to console      ${element}
    Wait Until Element Is Visible           ${element}   10

Order Detail - Go to Order Detail Page
    [Arguments]    ${order_id}
    Go To    ${PCMS_URL}/orders/detail/${order_id}

Order Detail - Input Customer Address
    [Arguments]    ${order_id}      ${customer_address}
    ${element}=         Replace String     ${textarea_cusotmer_address}      REPLACE_ORDER_ID        ${order_id}
    Wait Until Element Is Visible       ${element}          10s
    Input Text      ${element}      ${customer_address}

Order Detail - Save Customer Info
    Wait Until Element Is Visible       ${btn_save_customer_address}          10s
    Click Element                       ${btn_save_customer_address}
