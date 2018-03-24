*** Settings ***
Resource     web_element_track_orders.robot

*** Keywords ***
Track Orders - Go To Order Tracker
    Go To     ${PCMS_URL}/orders

Track Orders - Input Search By Order ID
    [Arguments]      ${order_id}
    Input Text      ${textbox_search_by_order}      ${order_id}

Track Orders - Click Search Button On Order Tracker Page
    Click Element       ${button_search}

Track Orders - Click View Shipment Detail
    [Arguments]      ${order_id}
    Wait Until Element Is Visible     jquery=a[href$='/orders/detail/${order_id}']    10s
    Click Element       jquery=a[href$='/orders/detail/${order_id}']
    Select Window       url=${PCMS_URL}/orders/detail/${order_id}
    Wait Until Element Is Visible             ${icon_truck}    10s

Track Orders - Input Search By Order Date From
    [Arguments]      ${order_date_from}
    Input Text      ${text_box_search_by_order_date_from}      ${order_date_from}
    Click Element    ${text_box_search_by_order_date_from}
