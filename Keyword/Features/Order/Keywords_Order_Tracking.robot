*** Keywords ***
Get COD Payment Default To Start
	${result}=    get_order_tracking_item_status_is_shipped_payment_method_is_cod
	LOG TO CONSOLE    ${result}
	${receive_date}=    Get From Dictionary    ${result}    received_date
	[return]  ${receive_date}

Get COD Payment Channel Item Status Is Shipped in Order
	${result}=    get_order_tracking_item_status_is_shipped_payment_method_is_cod
	${tracking_number}=    Get From Dictionary    ${result}    tracking_number
	${token}=    Get From Dictionary    ${result}    access_token
	${order_id}=    Get From Dictionary    ${result}    id
	${item_status}=    Get From Dictionary    ${result}    item_status
	Set Test Variable    ${Variable_OrderID}    ${order_id}
	Set Test Variable    ${Variable_Tracking_Number}    ${tracking_number}
	Set Test Variable    ${Variable_Token}    ${token}
	Set Test Variable    ${Variable_Item_Status}    ${item_status}

Get COD Payment Channel Receive Date Is Not Null
	${result}=    get_order_tracking_item_status_is_shipped_payment_method_is_cod_receive_date_is_not_null
	${tracking_number}=    Get From Dictionary    ${result}    tracking_number
	${token}=    Get From Dictionary    ${result}    access_token
	${order_id}=    Get From Dictionary    ${result}    id
	${received_date}=    Get From Dictionary    ${result}    received_date
	${item_status}=    Get From Dictionary    ${result}    item_status
	Set Test Variable    ${Variable_OrderID}    ${order_id}
	Set Test Variable    ${Variable_Tracking_Number}    ${tracking_number}
	Set Test Variable    ${Variable_Token}    ${token}
	Set Test Variable    ${Variable_Item_Status}    ${item_status}
	Set Test Variable    ${Variable_Received_Date_Old}    ${received_date}

Get CCW Payment Channel Item Status Is Shipped in Order
	${result}=    get_order_tracking_item_status_is_shipped_payment_method_is_ccw
	${tracking_number}=    Get From Dictionary    ${result}    tracking_number
	${token}=    Get From Dictionary    ${result}    access_token
	${order_id}=    Get From Dictionary    ${result}    id
	${item_status}=    Get From Dictionary    ${result}    item_status
	Set Test Variable    ${Variable_OrderID}    ${order_id}
	Set Test Variable    ${Variable_Tracking_Number}    ${tracking_number}
	Set Test Variable    ${Variable_Token}    ${token}
	Set Test Variable    ${Variable_Item_Status}    ${item_status}

Get Installment Payment Channel Item Status Is Shipped in Order
	${result}=    get_order_tracking_item_status_is_shipped_payment_method_is_installment
	${tracking_number}=    Get From Dictionary    ${result}    tracking_number
	${token}=    Get From Dictionary    ${result}    access_token
	${order_id}=    Get From Dictionary    ${result}    id
	${item_status}=    Get From Dictionary    ${result}    item_status
	Set Test Variable    ${Variable_OrderID}    ${order_id}
	Set Test Variable    ${Variable_Tracking_Number}    ${tracking_number}
	Set Test Variable    ${Variable_Token}    ${token}
	Set Test Variable    ${Variable_Item_Status}    ${item_status}

Get Counter Service Payment Channel Item Status Is Shipped in Order
	${result}=    get_order_tracking_item_status_is_shipped_payment_method_is_CounterService
	${tracking_number}=    Get From Dictionary    ${result}    tracking_number
	${token}=    Get From Dictionary    ${result}    access_token
	${order_id}=    Get From Dictionary    ${result}    id
	${item_status}=    Get From Dictionary    ${result}    item_status
	Set Test Variable    ${Variable_OrderID}    ${order_id}
	Set Test Variable    ${Variable_Tracking_Number}    ${tracking_number}
	Set Test Variable    ${Variable_Token}    ${token}
	Set Test Variable    ${Variable_Item_Status}    ${item_status}

Get Wallet Payment Channel Item Status Is Shipped in Order
	${result}=    get_order_tracking_item_status_is_delivered_payment_method_is_wallet
	${tracking_number}=    Get From Dictionary    ${result}    tracking_number
	${token}=    Get From Dictionary    ${result}    access_token
	${order_id}=    Get From Dictionary    ${result}    id
	${item_status}=    Get From Dictionary    ${result}    item_status
	Set Test Variable    ${Variable_OrderID}    ${order_id}
	Set Test Variable    ${Variable_Tracking_Number}    ${tracking_number}
	Set Test Variable    ${Variable_Token}    ${token}
	Set Test Variable    ${Variable_Item_Status}    ${item_status}

Get COD Payment Channel Item Status Is Delivered in Order
	${result}=    get_order_tracking_item_status_is_delivered_payment_method_is_cod
	${tracking_number}=    Get From Dictionary    ${result}    tracking_number
	${token}=    Get From Dictionary    ${result}    access_token
	${order_id}=    Get From Dictionary    ${result}    id
	${item_status}=    Get From Dictionary    ${result}    item_status
	Set Test Variable    ${Variable_OrderID}    ${order_id}
	Set Test Variable    ${Variable_Tracking_Number}    ${tracking_number}
	Set Test Variable    ${Variable_Token}    ${token}
	Set Test Variable    ${Variable_Item_Status}    ${item_status}

Get Check Tracking Number
	${result}=    get_check_order_tracking    ${Variable_Tracking_Number}
	${tracking_number}=    Get From Dictionary    ${result}    tracking_number
	${token}=    Get From Dictionary    ${result}    access_token
	${order_id}=    Get From Dictionary    ${result}    id
	${item_status}=    Get From Dictionary    ${result}    item_status
	${received_date}=    Get From Dictionary    ${result}    received_date
	${transaction_time}=    Get From Dictionary    ${result}    transaction_time
	${payment_status}=    Get From Dictionary    ${result}    payment_status
	Set Test Variable    ${Variable_OrderID}    ${order_id}
	Set Test Variable    ${Variable_Tracking_Number}    ${tracking_number}
	Set Test Variable    ${Variable_Token}    ${token}
	Set Test Variable    ${Variable_Item_Status_New}    ${item_status}
	Set Test Variable    ${Variable_Received_Date}    ${received_date}
	Set Test Variable    ${Variable_Transaction_Time}    ${transaction_time}
	Set Test Variable    ${Variable_Payment_Status}    ${payment_status}

Get Tracking Queue    [Arguments]    ${tracking_number}=None
	${result}=    get_check_tracking_queue    ${tracking_number}
	${tracking_number}=    Get From Dictionary    ${result}    tracking_number
	${error_type}=    Get From Dictionary    ${result}    error_type
	Set Test Variable    ${Variable_Tracking_Number}    ${tracking_number}
	Set Test Variable    ${Variable_Error_Type}    ${error_type}

Restore Tracking Queue    [Arguments]    ${tracking_number}=None
	delete_tracking_queue    ${tracking_number}

Restore Receive Date and Item Status
	py_update_receive_date_and_item_status    ${Variable_Tracking_Number}    ${Variable_Item_Status}

Restore Transaction Time
	py_update_transaction_time_is_null    ${Variable_OrderID}    ${Variable_Transaction_Time}

Restore Item status
	py_update_item_status    ${Variable_OrderID}    ${Variable_Item_Status}

Expected Status    [Arguments]    ${expected_status}=None
	${status}=   Get Json Value   ${Variable_Response_Order_Tracking}   /status
	Should be Equal    ${expected_status}    ${status}

Expected Code    [Arguments]    ${expected_code}=None
	${code}=   Get Json Value   ${Variable_Response_Order_Tracking}   /code
	Should be Equal    ${expected_code}    ${code}

Expected Message    [Arguments]    ${expected_message}=None
	${message}=   Get Json Value   ${Variable_Response_Order_Tracking}   /message
	Should be Equal    ${expected_message}    ${message}

Expected Data Tracking    [Arguments]    ${expected_message}=None
	${message}=   Get Json Value   ${Variable_Response_Order_Tracking}   /data/tracking_id
	Should be Equal    ${expected_message}    ${message}

Expected Data Token    [Arguments]    ${expected_message}=None
	${message}=   Get Json Value   ${Variable_Response_Order_Tracking}   /data/token
	Should be Equal    ${expected_message}    ${message}

Expect Receive Date Is Null    [Arguments]    ${expected_receive_date}=None
	${expected_receive_date}=     Convert To String    ${expected_receive_date}
	Should be Equal    ${expected_receive_date}    None

Expect Item Status is Delivered
	Should be Equal    ${Variable_Item_Status_New}    delivered

Expect Payment Status is Success
	Should be Equal    ${Variable_Payment_Status}    success

Expect Received Date is Current Time    [Arguments]    ${date}=None
	${datetime}=	Convert Date	${date}	datetime
	${Variable_Received_Date}=	Convert Date	${Variable_Received_Date}	datetime
	Log to console    ${datetime}
	Should Be Equal As Integers	${datetime.year}    ${Variable_Received_Date.year}
	Should Be Equal As Integers	${datetime.month}   ${Variable_Received_Date.month}
	Should Be Equal As Integers	${datetime.day}     ${Variable_Received_Date.day}
	Should Be Equal As Integers	${datetime.hour}    ${Variable_Received_Date.hour}
	Should Be Equal As Integers	${datetime.minute}  ${Variable_Received_Date.minute}

Expect Transaction Time is Current Time    [Arguments]    ${date}=None
	Log to console    ${Variable_Transaction_Time}
	${datetime}=	Convert Date	${date}	datetime
	Log to console    ${datetime}
	${Variable_Transaction_Time}=	Convert Date	${Variable_Transaction_Time}	datetime
	Should Be Equal As Integers	${datetime.year}    ${Variable_Transaction_Time.year}
	Should Be Equal As Integers	${datetime.month}   ${Variable_Transaction_Time.month}
	Should Be Equal As Integers	${datetime.day}     ${Variable_Transaction_Time.day}
	Should Be Equal As Integers	${datetime.hour}    ${Variable_Transaction_Time.hour}
	Should Be Equal As Integers	${datetime.minute}  ${Variable_Transaction_Time.minute}


Expected Tracking Number In Queue    [Arguments]    ${tracking_number}=None
	Should be Equal    ${tracking_number}    ${Variable_Tracking_Number}
	${Variable_Error_Type}=     Convert To String    ${Variable_Error_Type}
	Should be Equal    2    ${Variable_Error_Type}

Expected Receive Date Not Update    [Arguments]    ${date}=None
	Should Not Be Equal    ${date}    ${Variable_Received_Date}
