*** Settings ***
Library           Selenium2Library    #Library | ${CURDIR}/../../../Python_Library/DatabaseData.py

*** Keywords ***
Order - Get Order data
    [Arguments]    ${order_id}
    ${order_data}=    get_1order_data    ${order_id}
    [Return]    ${order_data}

Order - Go to Order Page
    Go To    ${PCMS_URL}/orders/

Order - Go to Order Detail Page
    [Arguments]    ${order_id}
    Go To    ${PCMS_URL}/orders/detail/${order_id}

Order - Search - Set Order Id
    [Arguments]    ${order_id}
    Input Text    ${text_box_search_by_order_id}    ${order_id}

Order - Search - Set Booking Id
    [Arguments]    ${booking_id}
    Input Text    ${text_box_search_by_booking_id}    ${booking_id}

Order - Search - Set App
    [Arguments]    ${app}
    Select From List    ${select_box_app}    ${app}

Order - Search - Set Payment Status
    [Arguments]    ${payment_status}
    Select From List    ${select_box_payment_status}    ${payment_status}

Order - Search - Set Item Status
    [Arguments]    ${item_status}
    Select From List    ${select_box_item_status}    ${item_status}

Order - Search - Set Payment Method
    [Arguments]    ${payment_method}
    Select From List    ${select_box_payment_method}    ${payment_method}

Order - Search - Set Order Date From
    [Arguments]    ${date_time}
    Input Text    ${text_box_search_by_order_date_from}    ${date_time}

Order - Search - Set Order Date To
    [Arguments]    ${date_time}
    Input Text    ${text_box_search_by_order_date_to}    ${date_time}

Order - Search - Set Payment Date From
    [Arguments]    ${date_time}
    Input Text    ${text_box_search_by_payment_date_from}    ${date_time}

Order - Search - Set Payment Date To
    [Arguments]    ${date_time}
    Input Text    ${text_box_search_by_payment_date_to}    ${date_time}

Order - Search - Set Expired Date From
    [Arguments]    ${date_time}
    Input Text    ${text_box_search_by_expired_date_from}    ${date_time}

Order - Search - Set Expired Date To
    [Arguments]    ${date_time}
    Input Text    ${text_box_search_by_expired_date_to}    ${date_time}

Order - Search - Set Operation Status
    [Arguments]    ${operation_status}
    Select From List    ${select_box_operation_status}    ${operation_status}

Order - Search - Set Operation Status Date From
    [Arguments]    ${date_time}
    Input Text    ${select_box_search_by_operation_status_date_from}    ${date_time}

Order - Search - Set Operation Status Date To
    [Arguments]    ${date_time}
    Input Text    ${select_box_search_by_operation_status_date_to}    ${date_time}

Order - Search - Set SLA Operation Status
    [Arguments]    ${sla}
    Select From List By Value    ${select_box_sla_operation_status}    ${sla}

Order - Search - Set Stock Type
    [Arguments]    ${stock_type}
    Select From List    ${select_box_stock_type}    ${stock_type}

Order - Search - Click Search
    Click Element    ${button_search}

Order - Search - Click Reset
    Click Element    ${button_reset}

Order - Verify Search Found by Order Id
    [Arguments]    ${order_id}
    Wait Until Element Is Visible    //*[@id="DataTables_Table_0"]/tbody/tr[1]/td[2]    60
    ${order_id}    Convert To String    ${order_id}
    Element Should Contain    id=DataTables_Table_0    ${order_id}

Order - Verify Search Not Found by Order Id
    [Arguments]    ${order_id}
    Wait Until Element Is Visible    //*[@id="DataTables_Table_0"]/tbody/tr[1]/td[1]    60
    ${order_id}    Convert To String    ${order_id}
    Element Should Not Contain    id=DataTables_Table_0    ${order_id}

Order - Search - Click box Search By Order ID
    Click Element    ${text_box_search_by_order_id}