*** Settings ***
# Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
# Resource          ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
# Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track_Order/Keywords_TrackOrder.robot
# Resource          ${CURDIR}/../../Keyword/API/common/api_keywords.robot
# Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/update_stock.robot
# Resource          ${CURDIR}/../../Keyword/API/PCMS/Item_status/update_item_status.robot
# Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
# Resource          ${CURDIR}/../../Keyword/Features/Create_Order/WebElement_order.robot
# Resource          ${CURDIR}/../../Keyword/API/FMS/FMS_ORDER.robot
# Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Order_together/keywords_order_together.robot
# Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track Order/keywords_ApiTrackOrder.robot
Library           ${CURDIR}/../../../../Python_Library/excel.py
Resource          ${CURDIR}/web_element_upload_operation_status.robot

*** Keywords ***
Excel Management - Append Order Id
    [Arguments]    ${content}    ${position_row}    ${value}
    ${position_append}=    Evaluate    ${position_row}-1
    Append To List    ${content}    ${position_append}    0    ${value}
    [Return]    ${content}

Excel Management - Append Item Id
    [Arguments]    ${content}    ${position_row}    ${value}
    ${position_append}=    Evaluate    ${position_row}-1
    Append To List    ${content}    ${position_append}    1    ${value}
    [Return]    ${content}

Excel Management - Append TMN Payment Ref Id
    [Arguments]    ${content}    ${position_row}    ${value}
    ${position_append}=    Evaluate    ${position_row}-1
    Append To List    ${content}    ${position_append}    2    ${value}
    [Return]    ${content}

Go to Upload Operation Status menu
    Go To    ${PCMS_URL}/orders/upload-operation-status

############################## Refund Request To Pending TMN #################################

Refund Request To Pending TMN - Verify Section Appear
    Wait Until Element Is Visible    id=${frame_refund_request_to_pending_tmn}    20s

Refund Request To Pending TMN - Upload excel file
	[Arguments]    ${file}
    Wait Until Element Is Visible    id=${button_submit_upload_refund_request}    60s
	${excel_file_full}    common.get_canonical_path    ${path_excel_file}/${file}
    Log To Console   excel_file_full=${excel_file_full}
    Choose File    id=${browse_refund_request}    ${excel_file_full}

Refund Request To Pending TMN - Click Upload Button
	Wait Until Element is ready and click    id=${button_submit_upload_refund_request}    60s

Refund Request To Pending TMN - Append Header To List
	@{content}    Create List
    Append To List    ${content}    0    0    Order Id
    Append To List    ${content}    0    1    Item Id
	[Return]    ${content}

Refund Request To Pending TMN - Append Data
	[Arguments]    ${items_id}    ${order_id}    ${content}
	${index}=    Set Variable    1
	:FOR    ${item_id}    IN    @{items_id}
    \    Append To List    ${content}    ${index}    0    ${order_id}
    \    Append To List    ${content}    ${index}    1    ${item_id[0]}
	\    ${index}=    Evaluate    ${index}+1
	[Return]    ${content}

Refund Request To Pending TMN - Create Excel File
	[Arguments]    ${content}
	Create And Write To Excel File    ${path_excel_file}/${refund_request_to_pending_tmn_excel_file_name}    ${content}

Refund Request To Pending TMN - Upload Operation Status - Verify error message - Required field
    Common Upload Error message
    ${result}=    Get Text    //div[@class='alert error alert-error']/ul/li
    Log To Console    result = ${result}
    Should Be Equal    ${result}    ${error_msg_required_field_upload_file_refund_request_to_pending_tmn}


Refund Request To Pending TMN - Upload Operation Status - Verify error message - No file uploaded
    Common Upload Error message
    ${result}=    Get Text    //div[@class='alert error alert-error']/ul/li
    # Log To Console    result = ${result}
    Should Be Equal    ${result}    ${error_no_file_upload}

Refund Request To Pending TMN - Append items to content
    [Arguments]    ${order_id}    ${items_id}    ${content}    ${index}
    :FOR    ${item_id}    IN    @{items_id}
    \    Append To List    ${content}    ${index}    0    ${order_id}
    \    Append To List    ${content}    ${index}    1    ${item_id[0]}
    \    ${index}=    Evaluate    ${index}+1
    [Return]    ${index}

Refund Request To Pending TMN - Append Data Multiple Orders
    [Arguments]    ${orders_id}    ${content}
    ${index}=    Set Variable    1
    :FOR    ${order_id}    IN    @{orders_id}
    \    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    \    ${index}=    Refund Request To Pending TMN - Append items to content    ${order_id}    ${items_id}    ${content}    ${index}
    # Log To Console    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    [Return]    ${content}

Refund Request To Pending TMN - Excel Edit Order Id
    [Arguments]    ${content}    ${position}    ${new_order_id}
    ${position_edit}=    Evaluate    ((${position}-1)*6)+2
    Set List Value    ${content}    ${position_edit}    ${new_order_id}
    [Return]    ${content}

Refund Request To Pending TMN - Excel Edit Item Id
    [Arguments]    ${content}    ${position}    ${new_item_id}
    ${position_edit}=    Evaluate    ((${position}-1)*6)+5
    Set List Value    ${content}    ${position_edit}    ${new_item_id}
    [Return]    ${content}

############################## Pending TMN To Refund Complete #################################

Pending TMN To Refund Complete- Verify Section Appear
    Wait Until Element Is Visible    id=${frame_pending_tmn_to_refund_complete}    20s

Pending TMN To Refund Complete - Upload excel file
    [Arguments]    ${file}
    Wait Until Element Is Visible    id=${button_submit_upload_pending_tmn}    60s
    ${excel_file_full}    common.get_canonical_path    ${path_excel_file}/${file}
    Choose File    id=${browse_pending_tmn}    ${excel_file_full}

Pending TMN To Refund Complete - Click Upload Button
    Wait Until Element is ready and click    id=${button_submit_upload_pending_tmn}    60s

Pending TMN To Refund Complete - Append Header To List
    @{content}    Create List
    Append To List    ${content}    0    0    Order Id
    Append To List    ${content}    0    1    Item Id
    Append To List    ${content}    0    2    TMN Payment Ref
    [Return]    ${content}

Pending TMN To Refund Complete - Append Data
    [Arguments]    ${items_id}    ${order_id}    ${content}
    ${index}=    Set Variable    1
    :FOR    ${item_id}    IN    @{items_id}
    \    Append To List    ${content}    ${index}    0    ${order_id}
    \    Append To List    ${content}    ${index}    1    ${item_id[0]}
    \    Append To List    ${content}    ${index}    2    ${bank_ref_tmn}
    \    ${index}=    Evaluate    ${index}+1
    [Return]    ${content}

Pending TMN To Refund Complete - Create Excel File
    [Arguments]    ${content}
    Create And Write To Excel File    ${path_excel_file}/${pending_tmn_to_refund_complete_excel_file_name}    ${content}

Pending TMN To Refund Complete - Upload Operation Status - Verify error message - Required field
    Common Upload Error message
    ${result}=    Get Text    //div[@class='alert error alert-error']/ul/li
    Log To Console    result = ${result}
    Should Be Equal    ${result}    ${error_msg_required_field_upload_file_pending_tmn_to_refund_complete}

Pending TMN To Refund Complete - Upload Operation Status - Verify error message - No file uploaded
    Common Upload Error message
    ${result}=    Get Text    //div[@class='alert error alert-error']/ul/li
    # Log To Console    result = ${result}
    Should Be Equal    ${result}    ${error_no_file_upload}

Pending TMN To Refund Complete - Append items to content
    [Arguments]    ${order_id}    ${items_id}    ${content}    ${index}
    :FOR    ${item_id}    IN    @{items_id}
    \    Append To List    ${content}    ${index}    0    ${order_id}
    \    Append To List    ${content}    ${index}    1    ${item_id[0]}
    \    Append To List    ${content}    ${index}    2    ${bank_ref_tmn}
    \    ${index}=    Evaluate    ${index}+1
    [Return]    ${index}

Pending TMN To Refund Complete - Append Data Multiple Orders
    [Arguments]    ${orders_id}    ${content}
    ${index}=    Set Variable    1
    :FOR    ${order_id}    IN    @{orders_id}
    \    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    \    ${index}=    Pending TMN To Refund Complete - Append items to content    ${order_id}    ${items_id}    ${content}    ${index}
    # Log To Console    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    [Return]    ${content}

Pending TMN To Refund Complete - Excel Edit Order Id
    [Arguments]    ${content}    ${position}    ${new_order_id}
    ${position_edit}=    Evaluate    ((${position}-1)*9)+2
    Set List Value    ${content}    ${position_edit}    ${new_order_id}
    [Return]    ${content}

Pending TMN To Refund Complete - Excel Edit Item Id
    [Arguments]    ${content}    ${position}    ${new_item_id}
    ${position_edit}=    Evaluate    ((${position}-1)*9)+5
    Set List Value    ${content}    ${position_edit}    ${new_item_id}
    [Return]    ${content}

Pending TMN To Refund Complete - Excel Edit Payment Ref
    [Arguments]    ${content}    ${position}    ${new_item_id}
    ${position_edit}=    Evaluate    ((${position}-1)*9)+8
    Set List Value    ${content}    ${position_edit}    ${new_item_id}
    [Return]    ${content}

####################################### Verify #########################################

Upload Operation Status - Verify pop up error message - Incorrect file type
	${result}=    Get Alert Message
	Log To Console    result = ${result}
	Should Be Equal    ${result}    ${error_incorrect_file_type}

Upload Operation Status - Verify pop up error message - Order id not found
    [Arguments]    ${list_error_line_order_not_found}
    Upload Operation Status - Verify dialog result is visible
    ${get_error_message_order_not_found}=     Get Text    ${error_message_order_not_found}
    Should Be Equal    ${get_error_message_order_not_found}    ${text_error_message_order_not_found}
    ${get_error_line_order_not_found}=    Get Text    ${error_line_order_not_found}
    Should Be Equal    ${get_error_line_order_not_found}    ${list_error_line_order_not_found}

Upload Operation Status - Verify pop up error message - Item id not found
    [Arguments]     ${list_error_line_item_not_found}
    Upload Operation Status - Verify dialog result is visible
    ${get_error_message_item_not_found}=    Get Text    ${error_message_item_not_found}
    Should Be Equal    ${get_error_message_item_not_found}    ${text_error_message_item_not_found}
    ${get_error_line_item_not_found}=    Get Text    ${error_line_item_not_found}
    Should Be Equal     ${get_error_line_item_not_found}    ${list_error_line_item_not_found}

Upload Operation Status - Verify pop up error message - TMN Payment Ref not found
    [Arguments]     ${list_error_line_TMN_payment_ref_not_found}
    Upload Operation Status - Verify dialog result is visible
    ${get_error_message_TMN_payment_ref_not_found}=    Get Text    ${error_message_required_TMN_payment_ref}
    Should Be Equal    ${get_error_message_TMN_payment_ref_not_found}    ${text_error_message_required_TMN_payment_ref}
    ${get_error_line_TMN_payment_ref_not_found}=    Get Text    ${error_line_required_TMN_payment_ref}
    Should Be Equal     ${get_error_line_TMN_payment_ref_not_found}    ${list_error_line_TMN_payment_ref_not_found}

Upload Operation Status - Verify pop up error message - Item not match with order id
    [Arguments]    ${list_error_line_item_id_not_match}
    Upload Operation Status - Verify dialog result is visible
    ${get_error_message_item_id_not_match}=     Get Text    ${error_message_item_id_not_match}
    Should Be Equal    ${get_error_message_item_id_not_match}    ${text_error_message_item_id_not_match}
    ${get_error_line_item_id_not_match}=     Get Text    ${error_line_item_id_not_match}
    Should Be Equal    ${get_error_line_item_id_not_match}    ${list_error_line_item_id_not_match}

Upload Operation Status - Verify pop up error message - Incorrect payment channel
    [Arguments]    ${list_error_line_incorrect_payment_channel}
    Upload Operation Status - Verify dialog result is visible
    ${get_error_message_incorrect_payment_channel}=    Get Text    ${error_message_incorrect_payment_channel}
    Should Be Equal    ${get_error_message_incorrect_payment_channel}    ${text_error_message_incorrect_payment_channel}
    ${get_error_line_incorrect_payment_channel}=     Get Text    ${error_line_incorrect_payment_channel}
    Should Be Equal    ${get_error_line_incorrect_payment_channel}    ${list_error_line_incorrect_payment_channel}

Upload Operation Status - Verify pop up error message - Incorrect operation status
    [Arguments]    ${list_error_line_incorrect_operation_status}
    Upload Operation Status - Verify dialog result is visible
    ${get_error_message_incorrect_operation_status}=     Get Text    ${error_message_incorrect_operation_status}
    Should Be Equal     ${get_error_message_incorrect_operation_status}     ${text_error_message_incorrect_operation_status}
    ${get_error_line_incorrect_operation_status}=    Get Text    ${error_line_incorrect_operation_status}
    Should Be Equal    ${get_error_line_incorrect_operation_status}    ${list_error_line_incorrect_operation_status}

Upload Operation Status - Verify pop up error message - Cannot change operation status
    [Arguments]    ${list_error_line_cannot_change_operation_status}
    Upload Operation Status - Verify dialog result is visible
    ${get_error_message_cannot_change_operation_status}=     Get Text     ${error_message_cannot_change_operation_status}
    Should Be Equal     ${get_error_message_cannot_change_operation_status}    ${text_error_message_cannot_change_operation_status}
    ${get_error_line_cannot_change_operation_status}=     Get Text    ${error_line_cannot_change_operation_status}
    Should Be Equal    ${get_error_line_cannot_change_operation_status}    ${list_error_line_cannot_change_operation_status}

Upload Operation Status - Verify pop up error message - Required TMN payment ref.
    [Arguments]    ${list_error_line_required_TMN_payment_ref}
    Upload Operation Status - Verify dialog result is visible
    ${get_error_message_required_TMN_payment_ref}=     Get Text     ${error_message_required_TMN_payment_ref}
    Should Be Equal    ${get_error_message_required_TMN_payment_ref}    ${text_error_message_required_TMN_payment_ref}
    ${get_error_line_required_TMN_payment_ref}=     Get Text     ${error_line_required_TMN_payment_ref}
    Should Be Equal    ${get_error_line_required_TMN_payment_ref}     ${list_error_line_required_TMN_payment_ref}

Upload Operation Status - Verify pop up error message - Duplicate records
    [Arguments]    ${list_error_line_duplicate_records}
    Upload Operation Status - Verify dialog result is visible
    ${get_error_message_duplicate_records}=     Get Text     ${error_message_duplicate_records}
    Should Be Equal    ${get_error_message_duplicate_records}    ${text_error_message_duplicate_records}
    ${get_error_line_duplicate_records}=     Get Text     ${error_line_required_duplicate_records}
    Should Be Equal    ${get_error_line_duplicate_records}     ${list_error_line_duplicate_records}

Upload Operation Status - Verify dialog result is visible
    Wait Until Element Is Visible    ${dialog_result}    15s

Upload Operation Status - Set line error format
    [Arguments]    @{error_line}
    ${final_error}=    Set Variable    line no. :
    :FOR    ${error_format}    IN    @{error_line}
    \    ${final_error}=    Set Variable    ${final_error}, ${error_format}
    \    ${final_error}=    Replace String    ${final_error}    :,    :
    [Return]    ${final_error}

Common Upload Error message
    ${result}=    Get Text    //div[@class='alert error alert-error']
    Log To Console    result = ${result}
    Should Contain    ${result}    ${common_upload_file_error_msg}

Refund Request To Pending TMN - Upload Operation Status - Verify error message - Empty file
    Common Upload Error message
    ${result}=    Get Text    //div[@class='alert error alert-error']/ul/li
    Log To Console    result = ${result}
    Should Be Equal    ${result}    ${error_empty_file}

Upload Operation Status - verify success and duplicate message
    [Arguments]    ${total_success}    ${total_duplicate}
    ${total_success}=    Set Variable    Success : ${total_success}
    ${total_duplicate}=    Set Variable    Duplicate : ${total_duplicate}
    Upload Operation Status - Verify dialog result is visible
    ${get_success_message}=    Get Text    ${success_message}
    Should Be Equal    ${get_success_message}    ${total_success}
    ${get_duplicate_message}=    Get Text    ${duplicate_message}
    Should Be Equal    ${get_duplicate_message}    ${total_duplicate}

Upload Operation Status - verify success only
    [Arguments]    ${total_success}
    ${total_success}=    Set Variable    Success : ${total_success}
    Upload Operation Status - Verify dialog result is visible
    ${get_success_message}=    Get Text    ${success_message}
    Should Be Equal    ${get_success_message}    ${total_success}

