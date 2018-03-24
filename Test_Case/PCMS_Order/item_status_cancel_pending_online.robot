*** Settings ***
Force Tags    WLS_PCMS_Order
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
TC_ITMWM_02039 Single item - To verify that item status can change from Order Pending to Pending Shipment if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02039    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    order_pending    ${pcms_email}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02040 Single item - To verify that item status can change from Order Pending to Customer Cancelled if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02040    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    order_pending    ${pcms_email}
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
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02041 Single item - To verify that item status can change from Pending Shipment to Shipped if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02041    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    pending_shipment
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    shipped    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02042 Single item - To verify that item status can change from Pending Shipment to Customer Cancelled if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02042    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    pending_shipment
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
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02043 Single item - To verify that item status can change from Shipped to Delivered if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02043    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    shipped
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02044 Single item - To verify that item status can change from Shipped to Cancel Pending if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02044    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02047 Single item - To verify that item status can change from Cancel Pending to Delivered if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02047    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02048 Single item - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = CCW and system changed operation status to Refund Request.
    [Tags]     regression    ready    TC_ITMWM_02048    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
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
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02049 Single item - To verify that item status can change from Delivered to Customer Cancelled if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02049    WLS_High
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
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02050 Single item - Save all button - To verify that item status can change from Shipped to Cancel Pending if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02050    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    shipped
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02051 Single item - Save all button - To verify that item status can change from Cancel Pending to Delivered if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02051    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02052 Single item - Save all button - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02052    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02053 Single item - Save all button - To verify that item status can change from Delivered to Customer Cancelled if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02053    WLS_High
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
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02083 Multiple items - Change item status some item - Save button - To verify that item status can change from Order Pending to Pending Shipment if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02083    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Order Pending
    \    TrackOrder - Check Item Status on DB    ${item[0]}    order_pending
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    order_pending    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    permanent
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    order_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    order_pending    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[1][0]}    permanent
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02084 Multiple items - Change item status some item - Save button - To verify that item status can change from Order Pending to Customer Cancelled if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02084    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Order Pending
    \    TrackOrder - Check Item Status on DB    ${item[0]}    order_pending
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    order_pending    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    permanent
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cancel
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    order_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    order_pending    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[1][0]}    permanent
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02085 Multiple items - Change item status some item - Save button - To verify that item status can change from Pending Shipment to Shipped if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02085    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Pending Shipment
    \    TrackOrder - Check Item Status on DB    ${item[0]}    pending_shipment
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Verify Log OrderShipment by Api    ${item[0]}    pending_shipment
    \    Verify status in stock hold table    ${item[0]}    cutstock
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    shipped    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Pending Shipment
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02086 Multiple items - Change item status some item - Save button - To verify that item status can change from Pending Shipment to Customer Cancelled if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02086    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Pending Shipment
    \    TrackOrder - Check Item Status on DB    ${item[0]}    pending_shipment
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Verify Log OrderShipment by Api    ${item[0]}    pending_shipment
    \    Verify status in stock hold table    ${item[0]}    cutstock
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Pending Shipment
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02087 Multiple items - Change item status some item - Save button - To verify that item status can change from Shipped to Delivered if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02087    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Shipped
    \    TrackOrder - Check Item Status on DB    ${item[0]}    shipped
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Verify Log OrderShipment by Api    ${item[0]}    shipped
    \    Verify status in stock hold table    ${item[0]}    cutstock
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02088 Multiple items - Change item status some item - Save button - To verify that item status can change from Delivered to Customer Cancelled if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02088    WLS_High
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
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    delivered    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02089 Multiple items - Change item status some item - Save button - To verify that item status can change from Shipped to Cancel Pending if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02089    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Shipped
    \    TrackOrder - Check Item Status on DB    ${item[0]}    shipped
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Verify Log OrderShipment by Api    ${item[0]}    shipped
    \    Verify status in stock hold table    ${item[0]}    cutstock
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02092 Multiple items - Change item status some item - Save button - To verify that item status can change from Cancel Pending to Delivered if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02092    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save all
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Cancel Pending
    \    TrackOrder - Check Item Status on DB    ${item[0]}    cancel_pending
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    cancel_pending    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02093 Multiple items - Change item status some item - Save button - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02093    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save all
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Cancel Pending
    \    TrackOrder - Check Item Status on DB    ${item[0]}    cancel_pending
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    cancel_pending    ${pcms_email}
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
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02094 Multiple items - Change item status some item - Save All button - To verify that item status can change from Shipped to Cancel Pending if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02094    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Shipped
    \    TrackOrder - Check Item Status on DB    ${item[0]}    shipped
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Verify Log OrderShipment by Api    ${item[0]}    shipped
    \    Verify status in stock hold table    ${item[0]}    cutstock
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02095 Multiple items - Change item status some item - Save All button - To verify that item status can change from Cancel Pending to Delivered if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02095    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save all
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Cancel Pending
    \    TrackOrder - Check Item Status on DB    ${item[0]}    cancel_pending
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    cancel_pending    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02096 Multiple items - Change item status some item - Save All button - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02096    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save all
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Cancel Pending
    \    TrackOrder - Check Item Status on DB    ${item[0]}    cancel_pending
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    cancel_pending    ${pcms_email}
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
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02097 Multiple items - Change item status some item - Save All button - To verify that item status can change from Delivered to Customer Cancelled if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02097    WLS_High
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
    #C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    delivered    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
    #C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02141 Multiple items - Change item status all item - To verify that item status can change from Order Pending to Pending Shipment if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02141    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Order Pending
    \    TrackOrder - Check Item Status on DB    ${item[0]}    order_pending
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    order_pending    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    permanent
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Pending Shipment
    \    TrackOrder - Check Item Status on DB    ${item[0]}    pending_shipment
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    pending_shipment    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    #C#\    Verify item status on FMS is not cancel    ${item[0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02142 Multiple items - Change item status all item - To verify that item status can change from Order Pending to Customer Cancelled if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02142    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Order Pending
    \    TrackOrder - Check Item Status on DB    ${item[0]}    order_pending
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    order_pending    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    permanent
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Customer Cancelled
    \    TrackOrder - Check Item Status on DB    ${item[0]}    customer_cancelled
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    customer_cancelled    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cancel
    \    TrackOrder - Check Operation Status on UI    ${item[0]}    Refund Request
    #C#\    Verify item status on FMS    ${item[0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02143 Multiple items - Change item status all item - To verify that item status can change from Pending Shipment to Shipped if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02143    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Pending Shipment
    \    TrackOrder - Check Item Status on DB    ${item[0]}    pending_shipment
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by Api    ${item[0]}    pending_shipment
    \    Verify status in stock hold table    ${item[0]}    cutstock
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Shipped
    \    TrackOrder - Check Item Status on DB    ${item[0]}    shipped
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    shipped    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    #C#\    Verify item status on FMS is not cancel    ${item[0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02144 Multiple items - Change item status all item - To verify that item status can change from Pending Shipment to Customer Cancelled if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02144    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Pending Shipment
    \    TrackOrder - Check Item Status on DB    ${item[0]}    pending_shipment
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by Api    ${item[0]}    pending_shipment
    \    Verify status in stock hold table    ${item[0]}    cutstock
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Customer Cancelled
    \    TrackOrder - Check Item Status on DB    ${item[0]}    customer_cancelled
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    customer_cancelled    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    \    TrackOrder - Check Operation Status on UI    ${item[0]}    Refund Request
    #C#\    Verify item status on FMS    ${item[0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02145 Multiple items - Change item status all item - To verify that item status can change from Shipped to Delivered if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02145    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Shipped
    \    TrackOrder - Check Item Status on DB    ${item[0]}    shipped
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by Api    ${item[0]}    shipped
    \    Verify status in stock hold table    ${item[0]}    cutstock
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Delivered
    \    TrackOrder - Check Item Status on DB    ${item[0]}    delivered
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    delivered    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    #C#\    Verify item status on FMS is not cancel    ${item[0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02146 Multiple items - Change item status all item - To verify that item status can change from Shipped to Cancel Pending if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02146    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Shipped
    \    TrackOrder - Check Item Status on DB    ${item[0]}    shipped
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by Api    ${item[0]}    shipped
    \    Verify status in stock hold table    ${item[0]}    cutstock
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Cancel Pending
    \    TrackOrder - Check Item Status on DB    ${item[0]}    cancel_pending
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    cancel_pending    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    #C#\    Verify item status on FMS is not cancel    ${item[0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02149 Multiple items - Change item status all item - To verify that item status can change from Cancel Pending to Delivered if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02149    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save all
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Cancel Pending
    \    TrackOrder - Check Item Status on DB    ${item[0]}    cancel_pending
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    cancel_pending    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Delivered
    \    TrackOrder - Check Item Status on DB    ${item[0]}    delivered
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    delivered    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    #C#\    Verify item status on FMS is not cancel    ${item[0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02150 Multiple items - Change item status all item - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02150    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save all
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Cancel Pending
    \    TrackOrder - Check Item Status on DB    ${item[0]}    cancel_pending
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    cancel_pending    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Customer Cancelled
    \    TrackOrder - Check Item Status on DB    ${item[0]}    customer_cancelled
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    customer_cancelled    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    \    TrackOrder - Check Operation Status on UI    ${item[0]}    Refund Request
    #C#\    Verify item status on FMS    ${item[0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02151 Multiple items - Change item status all item - To verify that item status can change from Delivered to Customer Cancelled if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02151    WLS_High
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
    #C#    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    delivered
    #C#    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Customer Cancelled
    \    TrackOrder - Check Item Status on DB    ${item[0]}    customer_cancelled
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    customer_cancelled    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    \    TrackOrder - Check Operation Status on UI    ${item[0]}    Refund Request
    #C#\    Verify item status on FMS    ${item[0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02152 Multiple items - Change item status all item - Save all button - To verify that item status can change from Shipped to Cancel Pending if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02152    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Shipped
    \    TrackOrder - Check Item Status on DB    ${item[0]}    shipped
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by Api    ${item[0]}    shipped
    \    Verify status in stock hold table    ${item[0]}    cutstock
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save all
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Cancel Pending
    \    TrackOrder - Check Item Status on DB    ${item[0]}    cancel_pending
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    cancel_pending    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    #C#\    Verify item status on FMS is not cancel    ${item[0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02153 Multiple items - Change item status all item - Save all button - To verify that item status can change from Cancel Pending to Delivered if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02153    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save all
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Cancel Pending
    \    TrackOrder - Check Item Status on DB    ${item[0]}    cancel_pending
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    cancel_pending    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
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
    #C#\    Verify item status on FMS is not cancel    ${item[0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02154 Multiple items - Change item status all item - Save all button - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02154    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save all
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Cancel Pending
    \    TrackOrder - Check Item Status on DB    ${item[0]}    cancel_pending
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    cancel_pending    ${pcms_email}
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
    #C#\    Verify item status on FMS    ${item[0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02155 Multiple items - Change item status all item - Save all button - To verify that item status can change from Delivered to Customer Cancelled if payment channel = CCW.
    [Tags]     regression    ready    TC_ITMWM_02155    WLS_High
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
    #C#\    Verify item status on FMS    ${item[0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers
