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
TC_047 ITMB_1736 Single item - To verify that item status can change from Order Pending to Pending Shipment if payment channel = COD.
    [Tags]    TC_047
    ${order_id}    Create Order API - Guest buy single product success with COD
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    order_pending
    Verify status in stock hold table    ${order_shipment_data[0][0]}    permanent
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_048 ITMB_1736 Single item - To verify that item status can change from Order Pending to Customer Cancelled if payment channel = COD.
    [Tags]    TC_048
    ${order_id}    Create Order API - Guest buy single product success with COD
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    order_pending
    Verify status in stock hold table    ${order_shipment_data[0][0]}    permanent
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_049 ITMB_1736 Single item - To verify that item status can change from Pending Shipment to Shipped if payment channel = COD.
    [Tags]    TC_049
    ${order_id}    Create Order API - Guest buy single product success with COD
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    shipped    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_050 ITMB_1736 Single item - To verify that item status can change from Pending Shipment to Customer Cancelled if payment channel = COD.
    [Tags]    TC_050
    ${order_id}    Create Order API - Guest buy single product success with COD
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_051 ITMB_1736 Single item - To verify that item status can change from Shipped to Delivered if payment channel = COD.
    [Tags]    TC_051
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
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    shipped    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_052 ITMB_1736 Single item - To verify that item status can change from Shipped to Cancel Pending if payment channel = COD.
    [Tags]    TC_052
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
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    shipped    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_055 ITMB_1736 Single item - To verify that item status can change from Cancel Pending to Delivered if payment channel = COD.
    [Tags]    TC_055
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
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_056 ITMB_1736 Single item - To verify that item status can change from Delivered to Customer Cancelled if payment channel = COD.
    [Tags]    TC_056
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
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
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
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_057 ITMB_1736 Single item - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = COD.
    [Tags]    TC_057
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
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    unable_to_refund
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_058 ITMB_1736 Single item - Save all button - To verify that item status can change from Shipped to Cancel Pending if payment channel = COD.
    [Tags]    TC_058
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
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    shipped    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_059 ITMB_1736 Single item - Save all button - To verify that item status can change from Cancel Pending to Delivered if payment channel = COD.
    [Tags]    TC_059
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
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_060 ITMB_1736 Single item - Single item - Save all button - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = COD.
    [Tags]    TC_060
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
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_061 ITMB_1736 Single item - Save all button - To verify that item status can change from Delivered to Customer Cancelled if payment channel = COD.
    [Tags]    TC_061
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
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
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
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_095 ITMB_1736 Multiple items - Change item status some item - Save button - To verify that item status can change from Order Pending to Pending Shipment if payment channel = COD.
    [Tags]    TC_095
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    order_pending
    Verify status in stock hold table    ${order_shipment_data[0][0]}    permanent
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[1][0]}    order_pending
    Verify status in stock hold table    ${order_shipment_data[1][0]}    permanent
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[1][0]}    order_pending
    Verify status in stock hold table    ${order_shipment_data[1][0]}    permanent
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_096 ITMB_1736 Multiple items - Multiple items - Change item status some item - Save button - To verify that all items status will change from Order Pending to Customer Cancelled if payment channel = COD.
    [Tags]    TC_096
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    order_pending
    Verify status in stock hold table    ${order_shipment_data[0][0]}    permanent
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[1][0]}    order_pending
    Verify status in stock hold table    ${order_shipment_data[1][0]}    permanent
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #C#Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_097 ITMB_1736 Multiple items - Change item status some item - Save button - To verify that item status can change from Pending Shipment to Shipped if payment channel = COD.
    [Tags]    TC_097
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    shipped    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[1][0]}    order_pending
    Verify status in stock hold table    ${order_shipment_data[1][0]}    permanent
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_098 ITMB_1736 Multiple items - Change item status some item - Save button - To verify that all items status will change from Pending Shipment to Customer Cancelled if payment channel = COD.
    [Tags]    TC_098
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #C#Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_099 ITMB_1736 Multiple items - Change item status some item - Save button - To verify that item status can change from Shipped to Delivered if payment channel = COD.
    [Tags]    TC_099
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    shipped    ${pcms_email}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[1][0]}    order_pending
    Verify status in stock hold table    ${order_shipment_data[1][0]}    permanent
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_100 ITMB_1736 Multiple items - Change item status some item - Save button - To verify that all items status will change from Shipped to Cancel Pending if payment channel = COD and current item A and B status = shipped.
    [Tags]    TC_100
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 1
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    shipped    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    shipped    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_101 ITMB_1736 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item B status to cancel pending if payment channel = COD and current item A = order pending and B status = shipped.
    [Tags]    TC_101
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 2
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    order_pending
    Verify status in stock hold table    ${order_shipment_data[0][0]}    permanent
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    shipped    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cancel
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_102 ITMB_1736 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to customer cancelled if payment channel = COD and current item A = order pending and B status = shipped.
    [Tags]    TC_102
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 2
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    order_pending
    Verify status in stock hold table    ${order_shipment_data[0][0]}    permanent
    #C#    Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    shipped    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    #C#    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cancel
    #Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    #C#    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_103 ITMB_1736 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to customer cancelled if payment channel = COD and current item A = pending shipment and B status = shipped.
    [Tags]    TC_103
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
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
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
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
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
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
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_104 ITMB_1736 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item B status to cancel pending if payment channel = COD and current item A = pending shipment and B status = shipped.
    [Tags]    TC_104
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
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
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
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
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
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
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_107 ITMB_1736 Multiple items - Change item status some item - Save button - To verify that item status can change from Cancel Pending to Delivered if payment channel = COD.
    [Tags]    TC_107
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
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    delivered    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_108 ITMB_1736 Multiple items - Change item status some item - Save button - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = COD.
    [Tags]    TC_108
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
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
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
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_109 ITMB_1736 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item B status to Customer Cancelled if payment channel = COD and current item A = Order Pending and B status = Delivered.
    [Tags]    TC_109
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
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_110 ITMB_1736 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to Customer Cancelled if payment channel = COD and current item A = Delivered and B status = Pending Shipment.
    [Tags]    TC_110
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
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_111 ITMB_1736 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to Customer Cancelled if payment channel = COD and current item A = Delivered and B status = Shipped.
    [Tags]    TC_111
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
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_112 ITMB_1736 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to Customer Cancelled if payment channel = COD and current item A = Delivered and B status = Cancel Pending.
    [Tags]    TC_112
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
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
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
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_113 ITMB_1736 Multiple items - Change item status some item - Save All button - To verify that all items status will change from Shipped to Cancel Pending if payment channel = COD and current item A and B status = shipped.
    [Tags]    TC_113
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
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    shipped    ${pcms_email}
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
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save all
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
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
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_114 ITMB_1736 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item B status to cancel pending if payment channel = COD and current item A = order pending and B status = shipped.
    [Tags]    TC_114
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
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    shipped    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save all
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
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_115 ITMB_1736 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item A status to customer cancelled if payment channel = COD and current item A = order pending and B status = shipped.
    [Tags]    TC_115
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
    TrackOrder - Click save all
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
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_116 ITMB_1736 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item A status to customer cancelled if payment channel = COD and current item A = pending shipment and B status = shipped.
    [Tags]    TC_116
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
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
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
    TrackOrder - Click save all
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
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_117 ITMB_1736 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item B status to cancel pending if payment channel = COD and current item A = pending shipment and B status = shipped.
    [Tags]    TC_117
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
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
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
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save all
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
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_118 ITMB_1736 Multiple items - Change item status some item - Save All button - To verify that item status can change from Cancel Pending to Delivered if payment channel = COD.
    [Tags]    TC_118
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
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
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
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save all
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
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_119 ITMB_1736 Multiple items - Change item status some item - Save All button - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = COD.
    [Tags]    TC_119
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
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
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
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Click save all
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
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_120 ITMB_1736 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item B status to Customer Cancelled if payment channel = COD and current item A = Order Pending and B status = Delivered.
    [Tags]    TC_120
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
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_121 ITMB_1736 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item A status to Customer Cancelled if payment channel = COD and current item A = Delivered and B status = Pending Shipment.
    [Tags]    TC_121
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
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_122 ITMB_1736 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item A status to Customer Cancelled if payment channel = COD and current item A = Delivered and B status = Shipped.
    [Tags]    TC_122
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
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_123 ITMB_1736 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item A status to Customer Cancelled if payment channel = COD and current item A = Delivered and B status = Cancel Pending.
    [Tags]    TC_123
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
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_157 ITMB_1736 Multiple items - Change item status all item - To verify that item status can change from Order Pending to Pending Shipment if payment channel = COD.
    [Tags]    TC_157
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    order_pending
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[1][0]}    order_pending
    Verify status in stock hold table    ${order_shipment_data[0][0]}    permanent
    Verify status in stock hold table    ${order_shipment_data[1][0]}    permanent
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    pending_shipment    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_158 ITMB_1736 Multiple items - Change item status all item - Save All button - To verify that all items status will change from Order Pending to Customer Cancelled if payment channel = COD.
    [Tags]    TC_158
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    order_pending
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[1][0]}    order_pending
    Verify status in stock hold table    ${order_shipment_data[0][0]}    permanent
    Verify status in stock hold table    ${order_shipment_data[1][0]}    permanent
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    unable_to_refund
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #C# Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #C# Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_159 ITMB_1736 Multiple items - Change item status all item - To verify that item status can change from Pending Shipment to Shipped if payment channel = COD.
    [Tags]    TC_159
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    pending_shipment    ${pcms_email}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    shipped    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    shipped    ${pcms_email}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_160 ITMB_1736 Multiple items - Change item status all item - Save All button - To verify that item status can change from Pending Shipment to Customer Cancelled if payment channel = COD.
    [Tags]    TC_160
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    pending_shipment    ${pcms_email}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
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
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    unable_to_refund
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #C# Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #C# Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_161 ITMB_1736 Multiple items - Change item status all item - To verify that item status can change from Shipped to Delivered if payment channel = COD.
    [Tags]    TC_161
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    shipped    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    shipped    ${pcms_email}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    delivered    ${pcms_email}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_165 ITMB_1736 Multiple items - Change item status all item - To verify that item status can change from Cancel Pending to Delivered if payment channel = COD.
    [Tags]    TC_165
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
    Log To Console    order_id = ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    delivered    ${pcms_email}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_168 ITMB_1736 Multiple items - Change item status all item - To verify that item status can change from Shipped to Cancel Pending if payment channel = COD.
    [Tags]    TC_168
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
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
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    shipped    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    shipped    ${pcms_email}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_169 ITMB_1736 Multiple items - Change item status all item - Save all button - To verify that item status can change from Cancel Pending to Delivered if payment channel = COD.
    [Tags]    TC_169
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
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
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    delivered    ${pcms_email}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_170 ITMB_1736 Multiple items - Change item status all item - Save all button - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = COD.
    [Tags]    TC_170
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
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
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
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
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Unable to Refund
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    unable_to_refund
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    unable_to_refund
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #C# Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #C# Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_171 ITMB_1736 Multiple items - Change item status all item - Save all button - To verify that item status can change from Delivered to Customer Cancelled if payment channel = COD.
    [Tags]    TC_171
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
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
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
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
    #C# Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #C# Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers
