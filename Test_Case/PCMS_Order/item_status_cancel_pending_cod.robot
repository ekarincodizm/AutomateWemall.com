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
${email}            guest@email.com
${material_id}      robot_material_id_123
${serial_number}    123456
${pcms_email}       admin@domain.com
${pcms_password}    12345

*** Test Cases ***
TC_ITMWM_02069 Single item - To verify that item status can change from Order Pending to Pending Shipment if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02069
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02070 Single item - To verify that item status can change from Order Pending to Customer Cancelled if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02070
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02071 Single item - To verify that item status can change from Pending Shipment to Shipped if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02071
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02072 Single item - To verify that item status can change from Pending Shipment to Customer Cancelled if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02072
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02073 Single item - To verify that item status can change from Shipped to Delivered if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02073
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02074 Single item - To verify that item status can change from Shipped to Cancel Pending if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02074
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02076 Single item - To verify that item status can change from Cancel Pending to Delivered if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02076
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02077 Single item - To verify that item status can change from Delivered to Customer Cancelled if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02077
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02078 Single item - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02078
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02079 Single item - Save all button - To verify that item status can change from Shipped to Cancel Pending if payment channel = COD.
    [Tags]    ready    regression   TC_ITMWM_02079
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02080 Single item - Save all button - To verify that item status can change from Cancel Pending to Delivered if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02080
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02081 Single item - Single item - Save all button - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02081
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02082 Single item - Save all button - To verify that item status can change from Delivered to Customer Cancelled if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02082
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02113 Multiple items - Change item status some item - Save button - To verify that item status can change from Order Pending to Pending Shipment if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02113
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02114 Multiple items - Multiple items - Change item status some item - Save button - To verify that all items status will change from Order Pending to Customer Cancelled if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02114
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02115 Multiple items - Change item status some item - Save button - To verify that item status can change from Pending Shipment to Shipped if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02115
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02116 Multiple items - Change item status some item - Save button - To verify that all items status will change from Pending Shipment to Customer Cancelled if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02116
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02117 Multiple items - Change item status some item - Save button - To verify that item status can change from Shipped to Delivered if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02117
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02118 Multiple items - Change item status some item - Save button - To verify that all items status will change from Shipped to Cancel Pending if payment channel = COD and current item A and B status = shipped.
    [Tags]    ready    regression    TC_ITMWM_02118
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02119 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item B status to cancel pending if payment channel = COD and current item A = order pending and B status = shipped.
    [Tags]    ready    regression    TC_ITMWM_02119
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02120 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to customer cancelled if payment channel = COD and current item A = order pending and B status = shipped.
    [Tags]    ready    regression    TC_ITMWM_02120
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
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
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Unable to Refund
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    #C#    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02121 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to customer cancelled if payment channel = COD and current item A = pending shipment and B status = shipped.
    [Tags]    ready    regression    TC_ITMWM_02121
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
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
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Unable to Refund
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    unable_to_refund
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02122 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item B status to cancel pending if payment channel = COD and current item A = pending shipment and B status = shipped.
    [Tags]    ready    regression    TC_ITMWM_02122
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02124 Multiple items - Change item status some item - Save button - To verify that item status can change from Cancel Pending to Delivered if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02124
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02125 Multiple items - Change item status some item - Save button - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02125
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02126 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item B status to Customer Cancelled if payment channel = COD and current item A = Order Pending and B status = Delivered.
    [Tags]    ready    regression    TC_ITMWM_02126
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

TC_ITMWM_02127 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to Customer Cancelled if payment channel = COD and current item A = Delivered and B status = Pending Shipment.
    [Tags]    ready    regression    TC_ITMWM_02127
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

TC_ITMWM_02128 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to Customer Cancelled if payment channel = COD and current item A = Delivered and B status = Shipped.
    [Tags]    ready    regression    TC_ITMWM_02128
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

TC_ITMWM_02129 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to Customer Cancelled if payment channel = COD and current item A = Delivered and B status = Cancel Pending.
    [Tags]    ready    regression    TC_ITMWM_02129
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

TC_ITMWM_02130 Multiple items - Change item status some item - Save All button - To verify that all items status will change from Shipped to Cancel Pending if payment channel = COD and current item A and B status = shipped.
    [Tags]    ready    regression    TC_ITMWM_02130
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02131 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item B status to cancel pending if payment channel = COD and current item A = order pending and B status = shipped.
    [Tags]    ready    regression    TC_ITMWM_02131
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02132 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item A status to customer cancelled if payment channel = COD and current item A = order pending and B status = shipped.
    [Tags]    ready    regression    TC_ITMWM_02132
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02133 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item A status to customer cancelled if payment channel = COD and current item A = pending shipment and B status = shipped.
    [Tags]    ready    regression    TC_ITMWM_02133
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02134 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item B status to cancel pending if payment channel = COD and current item A = pending shipment and B status = shipped.
    [Tags]    ready    regression    TC_ITMWM_02134
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02135 Multiple items - Change item status some item - Save All button - To verify that item status can change from Cancel Pending to Delivered if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02135
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02136 Multiple items - Change item status some item - Save All button - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02136
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    #    ITEM 2
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02137 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item B status to Customer Cancelled if payment channel = COD and current item A = Order Pending and B status = Delivered.
    [Tags]    ready    regression    TC_ITMWM_02137
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

TC_ITMWM_02138 Multiple items - Change item status some item - Save All button - Change item A status to Customer Cancelled if payment channel = COD and current item A = Delivered and B status = Pending Shipment.
    [Tags]    ready    regression    TC_ITMWM_02138
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

TC_ITMWM_02139 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item A status to Customer Cancelled if payment channel = COD and current item A = Delivered and B status = Shipped.
    [Tags]    ready    regression    TC_ITMWM_02139
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

TC_ITMWM_02140 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item A status to Customer Cancelled if payment channel = COD and current item A = Delivered and B status = Cancel Pending.
    [Tags]    ready    regression    TC_ITMWM_02140
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

TC_ITMWM_02171 Multiple items - Change item status all item - To verify that item status can change from Order Pending to Pending Shipment if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02171
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02172 Multiple items - Change item status all item - Save All button - To verify that all items status will change from Order Pending to Customer Cancelled if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02172
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02173 Multiple items - Change item status all item - To verify that item status can change from Pending Shipment to Shipped if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02173
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02174 Multiple items - Change item status all item - Save All button - To verify that item status can change from Pending Shipment to Customer Cancelled if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02174
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02175 Multiple items - Change item status all item - To verify that item status can change from Shipped to Delivered if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02175
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02177 Multiple items - Change item status all item - To verify that item status can change from Cancel Pending to Delivered if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02177
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02178 Multiple items - Change item status all item - To verify that item status can change from Shipped to Cancel Pending if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02178
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02179 Multiple items - Change item status all item - Save all button - To verify that item status can change from Cancel Pending to Delivered if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02179
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02180 Multiple items - Change item status all item - Save all button - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02180
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02181 Multiple items - Change item status all item - Save all button - To verify that item status can change from Delivered to Customer Cancelled if payment channel = COD.
    [Tags]    ready    regression    TC_ITMWM_02181
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
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
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
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_172 ITMB_1736 Multiple items - Change item status all item - To verify that item status can change from Delivered to Customer Cancelled if payment channel = COD.
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
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #C# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
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
    #C# Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #C# Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers
