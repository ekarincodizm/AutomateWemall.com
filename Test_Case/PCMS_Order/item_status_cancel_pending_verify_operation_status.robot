*** Settings ***
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track_Order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Item_status/update_item_status.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/WebElement_order.robot
Resource          ${CURDIR}/../../Keyword/API/FMS/FMS_ORDER.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Order_together/keywords_order_together.robot
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot

*** Variable ***
${email}          guest@email.com
${material_id}    robot_material_id_123
${serial_number}    123456
${pcms_email}     admin@domain.com
${pcms_password}    12345

*** Test Cases ***
TC_ITMWM_02049 Single item - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Refund Request if payment channel = CCW.
    [Tags]    TC_ITMWM_02049
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02053 Single item - Single item - Save all button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Refund Request if payment channel = CCW.
    [Tags]    TC_ITMWM_02053
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02063 Single item - To verify that item status can change from Delivered and Customer Cancelled and Operation Status = Refund Request if payment channel = CS.
    [Tags]    TC_ITMWM_02063
    # ITM buy item payment success
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${order_id}
    Log To Console    ${order_shipment_data}
    # FMS update status picked packed shipped
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    Send Api update status    ${body}
    # Update item status to Cancel Pending
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    Item: 4 = cancel item
    #    Order: 1 = cancel    ::    2 = Refund
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02068 Single item - Save all button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Refund Request if payment channel = CS.
    [Tags]    TC_ITMWM_02068
    # ITM buy item payment success
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${order_id}
    Log To Console    ${order_shipment_data}
    # FMS update status picked packed shipped
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    Send Api update status    ${body}
    # Update item status to Cancel Pending
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    Item: 4 = cancel item
    #    Order: 1 = cancel    ::    2 = Refund
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02077 Single item - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Refund Request if payment channel = COD.
    [Tags]    TC_ITMWM_02077
    ${order_id}    Create Order API - Guest buy single product success with COD
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02082 Single item - Save all button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Refund Request if payment channel = COD.
    [Tags]    TC_ITMWM_02082
    ${order_id}    Create Order API - Guest buy single product success with COD
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02088 Multiple items - Change item status some item - Save button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Refund Request if payment channel = CCW.
    [Tags]    TC_ITMWM_02088
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save all
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Delivered
    \    TrackOrder - Check Item Status on DB    ${item[0]}    delivered
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    delivered    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    delivered    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02097 Multiple items - Change item status some item - Save All button - To verify that item status can change from Delivered to Customer Cancelled if payment channel = CCW.
    [Tags]    TC_ITMWM_02097
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save all
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Delivered
    \    TrackOrder - Check Item Status on DB    ${item[0]}    delivered
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    delivered    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    delivered    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02103 Multiple items - Change item status some item - Save button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Refund Request if payment channel = CS.
    [Tags]    TC_ITMWM_02103
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${order_id}
    Log To Console    ${order_shipment_data}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    2
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    Item: 4 = cancel item
    #    Order: 1 = cancel    ::    2 = Refund
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02112 Multiple items - Change item status some item - Save All button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Refund Request if payment channel = CS.
    [Tags]    TC_ITMWM_02112
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${order_id}
    Log To Console    ${order_shipment_data}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    2
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    Item: 4 = cancel item
    #    Order: 1 = cancel    ::    2 = Refund
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02126 ITMB_1754 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item B status to Customer Cancelled if payment channel = COD and current item A = Order Pending and B status = Delivered.
    [Tags]    TC_ITMWM_02126
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    delivered    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Refund Request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02127 ITMB_1754 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to Customer Cancelled if payment channel = COD and current item A = Delivered and B status = Pending Shipment.
    [Tags]    TC_ITMWM_02127
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    pending_shipment    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    pending_shipment    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02128 ITMB_1754 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to Customer Cancelled if payment channel = COD and current item A = Delivered and B status = Shipped.
    [Tags]    TC_ITMWM_02128
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    shipped    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    shipped    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02129 ITMB_1754 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to Customer Cancelled if payment channel = COD and current item A = Delivered and B status = Cancel Pending.
    [Tags]    TC_ITMWM_02129
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02137 ITMB_1754 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item B status to Customer Cancelled if payment channel = COD and current item A = Order Pending and B status = Delivered.
    [Tags]    TC_ITMWM_02137
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    order_pending
    Verify status in stock hold table    ${order_shipment_data[0][0]}    permanent
    #    Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    delivered    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Click save all
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    order_pending
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Refund Request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02138 Multiple items - Change item status some item - Save All button - Change item A status to Customer Cancelled and Operation Status = Refund Request if payment channel = COD and current item A = Delivered and B status = Pending Shipment.
    [Tags]    TC_ITMWM_02138
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    order_pending
    Verify status in stock hold table    ${order_shipment_data[0][0]}    permanent
    #    Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    delivered    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Click save all
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    order_pending
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Refund Request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02139 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item A status to Customer Cancelled and Operation Status = Refund Request if payment channel = COD and current item A = Delivered and B status = Shipped.
    [Tags]    TC_ITMWM_02139
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    shipped    ${pcms_email}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save all
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    shipped    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02140 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item A status to Customer Cancelled and Operation Status = Refund Request if payment channel = COD and current item A = Delivered and B status = Cancel Pending.
    [Tags]    TC_ITMWM_02140
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save all
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02151 Multiple items - Change item status all item - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Refund Request if payment channel = CCW.
    [Tags]    TC_ITMWM_02151
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save all
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Delivered
    \    TrackOrder - Check Item Status on DB    ${item[0]}    delivered
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    delivered    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    delivered
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Customer Cancelled
    \    TrackOrder - Check Item Status on DB    ${item[0]}    customer_cancelled
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    customer_cancelled    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    \    TrackOrder - Check Operation Status on UI    ${item[0]}    Refund Request
    \    TrackOrder - Check Operation Status on DB    ${item[0]}    refund_request
    \    Verify item status on FMS    ${item[0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02155 Multiple items - Change item status all item - Save all button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Refund Request if payment channel = CCW.
    [Tags]    TC_ITMWM_02155
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save all
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Delivered
    \    TrackOrder - Check Item Status on DB    ${item[0]}    delivered
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    delivered    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Click save all
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Customer Cancelled
    \    TrackOrder - Check Item Status on DB    ${item[0]}    customer_cancelled
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    customer_cancelled    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    \    TrackOrder - Check Operation Status on UI    ${item[0]}    Refund Request
    \    TrackOrder - Check Operation Status on DB    ${item[0]}    refund_request
    \    Verify item status on FMS    ${item[0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02802 Multiple items - Change item status all item - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Refund Request if payment channel = CS.
    [Tags]    TC_ITMWM_02802
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${order_id}
    Log To Console    ${order_shipment_data}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    2
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    Item: 4 = cancel item
    #    Order: 1 = cancel    ::    2 = Refund
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02170 Multiple items - Change item status all item - Save all button - To verify that item status can change from Delivered to Customer Cancelled if payment channel = CS.
    [Tags]    TC_ITMWM_02170
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${order_id}
    Log To Console    ${order_shipment_data}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    2
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    refund_request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    #    Item: 4 = cancel item
    #    Order: 1 = cancel    ::    2 = Refund
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02804 Multiple items - Change item status all item - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Refund Request if payment channel = COD.
    [Tags]    TC_ITMWM_02804
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    delivered    ${pcms_email}
    Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Refund Request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02181 Multiple items - Change item status all item - Save all button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Refund Request if payment channel = COD.
    [Tags]    TC_ITMWM_02181
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    delivered    ${pcms_email}
    Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Refund Request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02165 Multiple items - Change item status all item - To verify that item status can change from Cancel Pending to Delivered and to Customer Cancelled if payment channel = CS.
    [Tags]    TC_ITMWM_02165
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${order_id}
    Log To Console    ${order_shipment_data}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    2
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Refund Request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    #    Item: 4 = cancel item
    #    Order: 1 = cancel    ::    2 = Refund
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_1754_104 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item B status to customer cancelled if payment channel = COD and current item A = shipped and B status = delivered. (operation status = Refund Request)
    [Tags]    TC_104
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # set all item status until Shipped
    TrackOrder - Set Item status    ${item_id[0][0]}    pending_shipment
    TrackOrder - Set Item status    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    shipped
    TrackOrder - Set Item status    ${item_id[1][0]}    shipped
    TrackOrder - Click save all
    # set 2nd item to Delivered
    TrackOrder - Set Item status    ${item_id[1][0]}    delivered
    TrackOrder - Click save    ${item_id[1][0]}
    # verify current status on both items
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    shipped
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    delivered
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    # cencelled 1st item
    TrackOrder - Set Item status    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[1][0]}
    # verify 1st item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    shipped
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    Verify item status on FMS is not cancel    ${item_id[0][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    shipped    ${pcms_email}
    # verify 2nd items should be Delivered
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    refund_request
    Verify item status on FMS    ${item_id[1][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    customer_cancelled    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_1754_105 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item B status to customer cancelled if payment channel = COD and current item A = order pending ,B status = shipped and C status = delivered. (operation status = Return Refund Request)
    [Tags]    TC_105
    ${inv_1}=    Get One Inventory ID
    ${inv_2}=    Get One Inventory ID
    ${inv_3}=    Get One Inventory ID
    ${inv_ids}=    Create List    ${inv_1}    ${inv_2}    ${inv_3}
    ${order_id}=    Guest Buy Product Success with COD by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # set 1st item to Shipped
    TrackOrder - Set Item status    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    shipped
    # 2nd item should be Order Pending
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    order_pending
    # set 3rd item to Delivered
    TrackOrder - Set Item status    ${item_id[2][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    shipped
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    delivered
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    delivered
    # cancelled 3rd item
    TrackOrder - Set Item status    ${item_id[2][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[2][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[2][0]}
    # verify 1st item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    shipped
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    Verify item status on FMS is not cancel    ${item_id[0][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    shipped    ${pcms_email}
    # verify 2nd item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    order_pending
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[1][0]}    order_pending
    # verify 3rd item should be Delivered
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Return Pending
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    return_pending
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[2][0]}    return pending
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    return_pending    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    [Teardown]    Close All Browsers

TC_1754_106 delivered, cancel pending : delivered => customer cancelled
    [Tags]    TC_106
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers
