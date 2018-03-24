*** Settings ***
Force Tags    WLS_Return_Refund_Replacement
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/WebElement_order.robot
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track_order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Item_status/update_item_status.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot

*** Variables ***
${email-guest}    test@domain.com
${inventory_id}    INAAC1112611

*** Test Cases ***
TC_ITMWM_01863 Order pending - Payment success (CCW) - 1 item
    [Tags]     regression    TC_ITMWM_01863    ready
    #${order_id}=    Guest Buy Product Success with CCW    ${email-guest}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    refund_request
    [Teardown]    Close All Browsers

TC_ITMWM_01864 Order pending - Payment success (CCW) - some item
    [Tags]     regression    TC_ITMWM_01864    ready
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email-guest}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${number_item}=    Get Length    ${item_id}
    : FOR    ${INDEX}    IN RANGE    1    ${number_item+1}
    \    Log To Console    Round ${INDEX}
    \    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Order Pending
    \    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    order_pending
    \    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Set Item status    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Click save    ${item_id[${INDEX}-1][0]}
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Order Pending
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    order_pending
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Customer Cancelled
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    refund_request
    [Teardown]    Close All Browsers

TC_ITMWM_01865 Order pending - Payment success (CCW) - All items
    [Tags]     regression    TC_ITMWM_01865    ready
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email-guest}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${number_item}=    Get Length    ${item_id}
    : FOR    ${INDEX}    IN RANGE    1    ${number_item+1}
    \    Log To Console    Round ${INDEX}
    \    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Order Pending
    \    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    order_pending
    \    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    \    TrackOrder - Set Item status    ${item_id[${INDEX}-1][0]}    customer_cancelled
    TrackOrder - Click save all
    : FOR    ${INDEX}    IN RANGE    1    ${number_item+1}
    \    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Customer Cancelled
    \    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    refund_request
    [Teardown]    Close All Browsers

TC_ITMWM_01866 Order pending - Payment is not success (COD) - 1 item
    [Tags]     regression    TC_ITMWM_01866    ready
    ${order_id}    Create Order API - Guest buy single product success with COD
    Log To Console    order_id = ${order_id}
    Close All Browsers
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    unable_to_refund
    [Teardown]    Close All Browsers

TC_ITMWM_01867 Order pending - Payment is not success (COD) - some item
    [Tags]     regression    TC_ITMWM_01867    ready
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${number_item}=    Get Length    ${item_id}
    : FOR    ${INDEX}    IN RANGE    1    ${number_item+1}
    \    Log To Console    Round ${INDEX}
    \    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Order Pending
    \    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Payment Pending
    \    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    order_pending
    \    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    payment_pending
    \    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Set Item status    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Click save    ${item_id[${INDEX}-1][0]}
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Order Pending
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Payment Pending
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    order_pending
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    payment_pending
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Customer Cancelled
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Payment Pending
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    payment_pending
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    unable_to_refund
    [Teardown]    Close All Browsers

TC_ITMWM_01868 Order pending - Payment is not success (COD) - All items
    [Tags]     regression    TC_ITMWM_01868    ready
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${number_item}=    Get Length    ${item_id}
    : FOR    ${INDEX}    IN RANGE    1    ${number_item+1}
    \    Log To Console    Round ${INDEX}
    \    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Order Pending
    \    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Payment Pending
    \    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    order_pending
    \    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    payment_pending
    \    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    \    TrackOrder - Set Item status    ${item_id[${INDEX}-1][0]}    customer_cancelled
    TrackOrder - Click save all
    : FOR    ${INDEX}    IN RANGE    1    ${number_item+1}
    \    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Customer Cancelled
    \    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Payment Pending
    \    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    payment_pending
    \    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    unable_to_refund
    [Teardown]    Close All Browsers

TC_ITMWM_01869 Pending shipment - Payment success (CCW) - 1 item
    [Tags]     regression    TC_ITMWM_01869    ready
    #${order_id}=    Guest Buy Product Success with CCW    ${email-guest}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order_id = ${order_id}
    ${sap_material_code}    Set Variable    robot_sap_code_123
    ${material_id}    Set Variable    robot_material_id_123
    LOGIN PCMS
    # DB get order shipment item id
    ${item_id}=    get order shipment item data    ${order_id}
    # update status picked packed
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${item_id}    1
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    pending_shipment
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    refund_request
    [Teardown]    Close All Browsers

TC_ITMWM_01870 Pending shipment - Payment success (CCW) - some item
    [Tags]     regression    TC_ITMWM_01870    ready
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email-guest}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order_id = ${order_id}
    ${sap_material_code}    Set Variable    robot_sap_code_123
    ${material_id}    Set Variable    robot_material_id_123
    LOGIN PCMS
    # DB get order shipment item id
    ${item_id}=    get order shipment item data    ${order_id}
    # update status picked packed
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${item_id}    1
    Send Api update status    ${body}
    ${number_item}=    Get Length    ${item_id}
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${INDEX}    IN RANGE    1    ${number_item+1}
    \    Log To Console    Round ${INDEX}
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Pending Shipment
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    pending_shipment
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Order Pending
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    order_pending
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Set Item status    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Click save    ${item_id[${INDEX}-1][0]}
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Customer Cancelled
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    refund_request
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Order Pending
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    order_pending
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    [Teardown]    Close All Browsers

TC_ITMWM_01871 Pending shipment - Payment success (CCW) - All items
    [Tags]     regression    TC_ITMWM_01871    ready
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email-guest}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${number_item}=    Get Length    ${item_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number in case refund for Multi-item    ${order_id}    ${item_id}    ${number_item}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${INDEX}    IN RANGE    1    ${number_item+1}
    \    Log To Console    Round ${INDEX}
    \    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Pending Shipment
    \    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    pending_shipment
    \    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    \    TrackOrder - Set Item status    ${item_id[${INDEX}-1][0]}    customer_cancelled
    TrackOrder - Click save all
    : FOR    ${INDEX}    IN RANGE    1    ${number_item+1}
    \    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Customer Cancelled
    \    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    refund_request
    [Teardown]    Close All Browsers

TC_ITMWM_01872 Pending shipment - Payment is not success (COD) - 1 item
    [Tags]     regression    TC_ITMWM_01872    ready
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Log To Console    order_id = ${order_id}
    ${sap_material_code}    Set Variable    robot_sap_code_123
    ${material_id}    Set Variable    robot_material_id_123
    LOGIN PCMS
    # DB get order shipment item id
    ${item_id}=    get order shipment item data    ${order_id}
    # update status picked packed
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${item_id}    1
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    pending_shipment
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    unable_to_refund
    [Teardown]    Close All Browsers

TC_ITMWM_01873 Pending shipment - Payment is not success (COD) - some item
    [Tags]     regression    TC_ITMWM_01873    ready
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Log To Console    order_id = ${order_id}
    ${sap_material_code}    Set Variable    robot_sap_code_123
    ${material_id}    Set Variable    robot_material_id_123
    LOGIN PCMS
    # DB get order shipment item id
    ${item_id}=    get order shipment item data    ${order_id}
    # update status picked packed
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${item_id}    1
    Send Api update status    ${body}
    ${number_item}=    Get Length    ${item_id}
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${INDEX}    IN RANGE    1    ${number_item+1}
    \    Log To Console    Round ${INDEX}
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Pending Shipment
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Payment Pending
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    pending_shipment
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    payment_pending
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Set Item status    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Click save    ${item_id[${INDEX}-1][0]}
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Customer Cancelled
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Payment Pending
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    payment_pending
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    unable_to_refund
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Customer Cancelled
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Payment Pending
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    payment_pending
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    unable_to_refund
    #\    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Order Pending
    #\    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Payment Pending
    #\    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    order_pending
    #\    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    payment_pending
    #\    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    [Teardown]    Close All Browsers

TC_ITMWM_01874 Pending shipment - Payment is not success (COD) - All items
    [Tags]     regression    TC_ITMWM_01874    ready
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${number_item}=    Get Length    ${item_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number in case refund for Multi-item    ${order_id}    ${item_id}    2
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${INDEX}    IN RANGE    1    ${number_item+1}
    \    Log To Console    Round ${INDEX}
    \    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Pending Shipment
    \    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Payment Pending
    \    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    pending_shipment
    \    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    payment_pending
    \    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    \    TrackOrder - Set Item status    ${item_id[${INDEX}-1][0]}    customer_cancelled
    TrackOrder - Click save all
    : FOR    ${INDEX}    IN RANGE    1    ${number_item+1}
    \    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Customer Cancelled
    \    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Payment Pending
    \    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    payment_pending
    \    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    unable_to_refund
    [Teardown]    Close All Browsers

TC_ITMWM_01875 Order pending - Payment success (CS) - 1 item
    [Tags]     regression    TC_ITMWM_01875    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    refund_request
    [Teardown]    Close All Browsers

TC_ITMWM_01876 Order pending - Payment success (CS) - some item
    [Tags]     regression    TC_ITMWM_01876    ready
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${number_item}=    Get Length    ${item_id}
    : FOR    ${INDEX}    IN RANGE    1    ${number_item+1}
    \    Log To Console    Round ${INDEX}
    \    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Order Pending
    \    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    order_pending
    \    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Set Item status    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Click save    ${item_id[${INDEX}-1][0]}
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Order Pending
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    order_pending
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Customer Cancelled
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    refund_request
    [Teardown]    Close All Browsers

TC_ITMWM_01877 Order pending - Payment success (CS) - All items
    [Tags]     regression    TC_ITMWM_01877    ready
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${number_item}=    Get Length    ${item_id}
    : FOR    ${INDEX}    IN RANGE    1    ${number_item+1}
    \    Log To Console    Round ${INDEX}
    \    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Order Pending
    \    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    order_pending
    \    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    \    TrackOrder - Set Item status    ${item_id[${INDEX}-1][0]}    customer_cancelled
    TrackOrder - Click save all
    : FOR    ${INDEX}    IN RANGE    1    ${number_item+1}
    \    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Customer Cancelled
    \    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    refund_request
    [Teardown]    Close All Browsers

TC_ITMWM_01878 Pending shipment - Payment success (CS) - 1 item
    [Tags]     regression    TC_ITMWM_01878    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    ${sap_material_code}    Set Variable    robot_sap_code_123
    ${material_id}    Set Variable    robot_material_id_123
    LOGIN PCMS
    # DB get order shipment item id
    ${item_id}=    get order shipment item data    ${order_id}
    # update status picked packed
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${item_id}    1
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    pending_shipment
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    refund_request
    [Teardown]    Close All Browsers

TC_ITMWM_01879 Pending shipment - Payment success (CS) - some item
    [Tags]     regression    TC_ITMWM_01879    ready
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    ${sap_material_code}    Set Variable    robot_sap_code_123
    ${material_id}    Set Variable    robot_material_id_123
    LOGIN PCMS
    # DB get order shipment item id
    ${item_id}=    get order shipment item data    ${order_id}
    # update status picked packed
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${item_id}    1
    Send Api update status    ${body}
    ${number_item}=    Get Length    ${item_id}
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${INDEX}    IN RANGE    1    ${number_item+1}
    \    Log To Console    Round ${INDEX}
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Pending Shipment
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    pending_shipment
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Order Pending
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    order_pending
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Set Item status    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Click save    ${item_id[${INDEX}-1][0]}
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Customer Cancelled
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    Run Keyword If    1 == ${INDEX}    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    refund_request
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Order Pending
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    order_pending
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    Run Keyword If    2 == ${INDEX}    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    [Teardown]    Close All Browsers

TC_ITMWM_01880 Pending shipment - Payment success (CS) - All items
    [Tags]     regression    TC_ITMWM_01880    ready
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${number_item}=    Get Length    ${item_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number in case refund for Multi-item    ${order_id}    ${item_id}    2
    Send Api update status    ${body}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${INDEX}    IN RANGE    1    ${number_item+1}
    \    Log To Console    Round ${INDEX}
    \    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Pending Shipment
    \    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    pending_shipment
    \    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    none
    \    TrackOrder - Set Item status    ${item_id[${INDEX}-1][0]}    customer_cancelled
    TrackOrder - Click save all
    : FOR    ${INDEX}    IN RANGE    1    ${number_item+1}
    \    TrackOrder - Check Item Status on UI    ${item_id[${INDEX}-1][0]}    Customer Cancelled
    \    TrackOrder - Check Payment Status on UI    ${item_id[${INDEX}-1][0]}    Success
    \    TrackOrder - Check Item Status on DB    ${item_id[${INDEX}-1][0]}    customer_cancelled
    \    TrackOrder - Check Payment Status on DB    ${item_id[${INDEX}-1][0]}    success
    \    TrackOrder - Check Operation Status on DB    ${item_id[${INDEX}-1][0]}    refund_request
    [Teardown]    Close All Browsers
