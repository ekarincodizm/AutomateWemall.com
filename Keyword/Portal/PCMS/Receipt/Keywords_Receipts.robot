*** Settings ***
Library           Selenium2Library
Library           String
Library           DatabaseLibrary
Library           ../../../../Python_Library/dbclass/database_class.py
Resource          ../../../Common/Keywords_Common.robot
Resource          WebElement_Receipt.robot

*** Keywords ***
Receipt - Verify Receipt
    [Arguments]    ${order_id}
    Go To    ${PCMS_URL}/order-receipt
    Input Text    ${Input_OrderID}    ${order_id}
    Click Element    ${Input_PCMSOrderID}
    Retry Order ID    ${order_id}
    Click Element    ${Search_Order}
    ${element_Table_Corder_id}=    Replace String    ${Selected_Order}    REPLACE_ME    ${order_id}
    Wait Until Element Is Visible    ${element_Table_Corder_id}    20s
    Click Element    ${element_Table_Corder_id}
    Click Element    ${View_Receipt_Order}

Retry Order ID
    [Arguments]    ${order_id}
    ${verify_OrderID}    Get Text    ${Input_OrderID}
    ${present_OrderID}=    Run Keyword And Return Status    Should Be Empty    ${verify_OrderID}
    Run Keyword If    ${present_OrderID}    Reattempt to Input Order ID    ${order_id}

Reattempt to Input Order ID
    [Arguments]    ${order_id}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${Input_OrderID}    ${order_id}
    \    Click Element    ${Input_PCMSOrderID}
    \    ${verify_OrderID}    Get Text    ${Input_OrderID}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${verify_OrderID}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Go To order receipt page
    [Arguments]    ${order_id}
    Go To    ${PCMS_URL}/order-receipt
    Input Text    ${Input_OrderID}    ${order_id}
    Click Element    ${Input_PCMSOrderID}
    Retry Order ID    ${order_id}
    Click Element    ${Search_Order}
    ${element_Table_Corder_id}=    Replace String    ${Selected_Order}    REPLACE_ME    ${order_id}
    Wait Until Element Is Visible    ${element_Table_Corder_id}    20s

Go to order reciept page
    [Arguments]    ${order_id}
    Go To    ${PCMS_URL}/order-receipt
    Wait Until Element Is Visible    ${Input_OrderID}    15s

Receipt - Seach order reciept
    [Arguments]    ${order_id}
    Input Text    ${Input_OrderID}    ${order_id}
    Click Element    ${Input_PCMSOrderID}
    Retry Order ID    ${order_id}
    Click Element    ${Search_Order}
    ${element_Table_Corder_id}=    Replace String    ${Selected_Order_receipt}    REPLACE_ME    ${order_id}
    Wait Until Element Is Visible    ${element_Table_Corder_id}    20s

Click expand order detail
    Click Element    ${expand_plus}

Merchant type(market place) is displayed
    [Arguments]    ${SKU_ID}
    Click expand order detail
    Wait Until Element Is Visible    ${order_detail}    15s

Get inventory ids and merchant from receipt page
    ${get_inventory_id_elements}=    Get Web Elements    ${receipt_inventory_id_elements}
    ${get_merchant_elements}=    Get Web Elements    ${receipt_merchant_elements}
    ${get_inventory_id_elements_length}=    Get Length    ${get_inventory_id_elements}
    ${get_merchant_elements_length}=    Get Length    ${get_merchant_elements}
    ${inventory_ids}=    Create List
    ${inventory_merchant_dicts_list}=    Create List
    : FOR    ${INDEX}    IN RANGE    0    ${get_inventory_id_elements_length}
    \    # :FOR    ${element}    IN    @{elements}
    \    ${inventory_id_element}=    Get From List    ${get_inventory_id_elements}    ${INDEX}
    \    ${merchant_element}=    Get From List    ${get_merchant_elements}    ${INDEX}
    \    ${inventory_merchant_dict}=    Create Dictionary
    \    Set To Dictionary    ${inventory_merchant_dict}    inventory_id=${inventory_id_element.text}    merchant=${merchant_element.text}
    \    Append To List    ${inventory_ids}    ${inventory_id_element.text}
    \    Append To List    ${inventory_merchant_dicts_list}    ${inventory_merchant_dict}
    Log to console    inventory_ids::${inventory_ids}
    Log to console    inventory_merchant_dicts_list::${inventory_merchant_dicts_list}
    [Return]    ${inventory_merchant_dicts_list}

Check inventory ids and merchant type case same merchant type
    [Arguments]    ${tracking_inventory_ids_list}    ${receipt_inventory_merchant_dicts_list}    ${display_merchant_type}
    ${tracking_inventory_ids_length}=    Get Length    ${tracking_inventory_ids_list}
    ${receipt_inventory_ids_length}=    Get Length    ${receipt_inventory_merchant_dicts_list}
    Log to console    tracking_invenotry_ids_length:: ${tracking_inventory_ids_length}
    Should be equal    ${tracking_inventory_ids_length}    ${receipt_inventory_ids_length}
    : FOR    ${INDEX}    IN RANGE    0    ${tracking_inventory_ids_length}
    \    Log to console    forIndex:${INDEX}
    \    ${tracking_inventory_id}=    Get From List    ${tracking_inventory_ids_list}    ${INDEX}
    \    ${receipt_inventory_merchant_dict}=    Get From List    ${receipt_inventory_merchant_dicts_list}    ${INDEX}
    \    ${receipt_inventory_id}=    Get From Dictionary    ${receipt_inventory_merchant_dict}    inventory_id
    \    ${merchant}=    Get From Dictionary    ${receipt_inventory_merchant_dict}    merchant
    \    Should Contain    ${tracking_inventory_id}    ${receipt_inventory_id}
    \    Should be equal    ${merchant}    ${display_merchant_type}

Check inventory ids and merchant type case mixed merchant type
    [Arguments]    ${display_merchant_type}    ${expected_display_merchant_type}
    Should be equal    ${display_merchant_type}    ${expected_display_merchant_type}

Get order shipment items from DB
    [Arguments]    ${get_order_id}
    ${records}=    Get order shipment item merchant type    ${get_order_id}
    [Return]    ${records}

Get together order items from DB
    [Arguments]    ${get_order_id}
    ${records}=    Get together order items merchant type    ${get_order_id}
    [Return]    ${records}

Check merchant type of order items
    [Arguments]    ${merchant_type}    ${expected_merchant_type}
    Should be equal    ${merchant_type}    ${expected_merchant_type}

Check display stock type of order items
    [Arguments]    ${merchant_type}    ${expected_merchant_type}
    Should be equal    ${merchant_type}    ${expected_merchant_type}

Go To Receipt Detail Page as PDF
    [Arguments]    ${order_id}
    Login Pcms    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    Go To order receipt page    ${order_id}
    Wait Until Element Is Visible    //table[@id='tb-order']/tbody/tr/td[2]
    Select Checkbox    //table[@id='tb-order']/tbody/tr/td[2]/input
    Click Element    //*[@id="footbox"]/div[1]/input[3]

Click Print Copy Receipt Button
    Wait Until Element Is Visible    ${XPATH_PCMS.btn_copy_receipt}
    Click Element    ${XPATH_PCMS.btn_copy_receipt}

Click Print Receipt Button
    Wait Until Element Is Visible    ${XPATH_PCMS.btn_receipt}
    Click Element    ${XPATH_PCMS.btn_receipt}

Verify Print Copy Receipt Button is NOT Visible
    Element Should Not Be Visible    ${XPATH_PCMS.btn_copy_receipt}

Verify Print Receipt Button is NOT Visible
    Element Should Not Be Visible    ${XPATH_PCMS.btn_receipt}

Get SKU from Order Shipment Item ID
    [Arguments]    ${order_shipment_item_id}
    ${cursor}=    Execute    Select inventory_id from order_shipment_items where id=${order_shipment_item_id}
    [Return]    ${cursor[0][0]}
