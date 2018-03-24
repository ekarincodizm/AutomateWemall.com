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
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot

*** Variable ***
${email}          guest@email.com
${material_id}    robot_material_id_123
${serial_number}    123456
${pcms_email}     admin@domain.com
${pcms_password}    12345

*** Test Cases ***
TC_ITMWM_02054 Single item - To verify that item status can change from Order Pending to Pending Shipment if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02054    WLS_High
	# ITM buy item payment success
	${order_id}    Create Order API - Guest buy single product success with CS
	Create_order.Set Payment Success For CS    ${order_id}
	# DB get order shipment item id
	${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
	LOGIN PCMS    ${pcms_email}    ${pcms_password}
	TrackOrder - Go To Order Detail Page    ${order_id}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
	Verify status in stock hold table    ${order_shipment_data[0][0]}    permanent
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

TC_ITMWM_02055 Single item - To verify that item status can change from Order Pending to Customer Cancelled if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02055    WLS_High
	# ITM buy item payment success
	${order_id}    Create Order API - Guest buy single product success with CS
	Create_order.Set Payment Success For CS    ${order_id}
	Close All Browsers
	# DB get order shipment item id
	${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
	LOGIN PCMS    ${pcms_email}    ${pcms_password}
	TrackOrder - Go To Order Detail Page    ${order_id}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
	Verify status in stock hold table    ${order_shipment_data[0][0]}    permanent
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
	#C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02056 Single item - To verify that item status can change from Pending Shipment to Shipped if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02056    WLS_High
	# ITM buy item payment success
	${order_id}    Create Order API - Guest buy single product success with CS
	Create_order.Set Payment Success For CS    ${order_id}
	Close All Browsers
	# DB get order shipment item id
	${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
	LOGIN PCMS    ${pcms_email}    ${pcms_password}
	TrackOrder - Go To Order Detail Page    ${order_id}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    pending_shipment
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    shipped    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02057 Single item - To verify that item status can change from Pending Shipment to Customer Cancelled if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02057    WLS_High
	# ITM buy item payment success
	${order_id}    Create Order API - Guest buy single product success with CS
	Create_order.Set Payment Success For CS    ${order_id}
	Close All Browsers
	# DB get order shipment item id
	${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
	LOGIN PCMS    ${pcms_email}    ${pcms_password}
	TrackOrder - Go To Order Detail Page    ${order_id}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    pending_shipment
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
	#C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02058 Single item - To verify that item status can change from Shipped to Delivered if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02058    WLS_High
	# ITM buy item payment success
	${order_id}    Create Order API - Guest buy single product success with CS
	Create_order.Set Payment Success For CS    ${order_id}
	Close All Browsers
	# DB get order shipment item id
	${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
	LOGIN PCMS    ${pcms_email}    ${pcms_password}
	TrackOrder - Go To Order Detail Page    ${order_id}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    shipped    ${pcms_email}
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

TC_ITMWM_02059 Single item - To verify that item status can change from Shipped to Cancel Pending if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02059    WLS_High
	# ITM buy item payment success
	${order_id}    Create Order API - Guest buy single product success with CS
	Create_order.Set Payment Success For CS    ${order_id}
	Close All Browsers
	# DB get order shipment item id
	${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
	LOGIN PCMS    ${pcms_email}    ${pcms_password}
	TrackOrder - Go To Order Detail Page    ${order_id}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    shipped    ${pcms_email}
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02062 Single item - To verify that item status can change from Cancel Pending to Delivered if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02062    WLS_High
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
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02063 Single item - To verify that item status can change from Delivered to Customer Cancelled if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02063    WLS_High
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
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
	#C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02064 Single item - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02064    WLS_High
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
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
	#C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02065 Single item - Save all button - To verify that item status can change from Shipped to Cancel Pending if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02065    WLS_High
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
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
	TrackOrder - Click save all
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02066 Single item - Save all button - To verify that item status can change from Cancel Pending to Delivered if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02066    WLS_High
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
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
	TrackOrder - Click save all
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02068 Single item - Save all button - To verify that item status can change from Delivered to Customer Cancelled if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02068    WLS_High
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
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
	#C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02098 Multiple Some item - To verify that item status can change from Order Pending to Pending Shipment if payment channel = CS
	[Tags]    regression     ready    TC_ITMWM_02098    WLS_High
	${order_id}    Create Order API - Guest buy multi product success with CS
	Create_order.Set Payment Success For CS    ${order_id}
	Close All Browsers
	${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
	Log To Console    ${order_id}
	Log To Console    ${order_shipment_data}
	LOGIN PCMS    ${pcms_email}    ${pcms_password}
	TrackOrder - Go To Order Detail Page    ${order_id}
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
	TrackOrder - Click save    ${order_shipment_data[1][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
	Verify status in stock hold table    ${order_shipment_data[0][0]}    permanent
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Pending Shipment
	TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    pending_shipment
	Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    pending_shipment    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02099 Multiple Some item - To verify that item status can change from Order Pending to Customer Cancelled if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02099    WLS_High
	${order_id}    Create Order API - Guest buy multi product success with CS
	Create_order.Set Payment Success For CS    ${order_id}
	Close All Browsers
	Log to console    ${order_id}
	${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
	LOGIN PCMS    ${pcms_email}    ${pcms_password}
	TrackOrder - Go To Order Detail Page    ${order_id}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Order Pending
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Order Pending
	TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    order_pending
	TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
	TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
	TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
	TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
	Verify status in stock hold table    ${order_shipment_data[0][0]}    cancel
	Verify status in stock hold table    ${order_shipment_data[1][0]}    permanent
	#C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02100 Multiple some item - To verify that item status can change from Pending Shipment to Shipped if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02100    WLS_High
	${order_id}    Create Order API - Guest buy multi product success with CS
	Create_order.Set Payment Success For CS    ${order_id}
	Close All Browsers
	${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
	Log To Console    ${order_id}
	Log To Console    ${order_shipment_data}
	${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    2
	Send Api update status    ${body}
	LOGIN PCMS    ${pcms_email}    ${pcms_password}
	TrackOrder - Go To Order Detail Page    ${order_id}
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Pending Shipment
	TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    pending_shipment
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    shipped    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02101 Multiple some item - To verify that item status can change from Pending Shipment to Customer Cancelled if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02101    WLS_High
	${order_id}    Create Order API - Guest buy multi product success with CS
	Create_order.Set Payment Success For CS    ${order_id}
	Close All Browsers
	${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
	Log To Console    ${order_id}
	Log To Console    ${order_shipment_data}
	${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    2
	Send Api update status    ${body}
	LOGIN PCMS    ${pcms_email}    ${pcms_password}
	TrackOrder - Go To Order Detail Page    ${order_id}
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Pending Shipment
	TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    pending_shipment
	TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
	TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
	#C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02102 Multiple item - To verify that item status can change from Shipped to Delivered if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02102    WLS_High
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
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
	TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    shipped
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02103 Multiple items - Change item status some item - Save button - To verify that item status can change from Delivered to Customer Cancelled if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02103    WLS_High
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
	TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
	#C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02104 Multiple Some item - To verify that item status can change from Shipped to Cancel Pending if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02104    WLS_High
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
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
	TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    shipped
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02107 Multiple item - Save button - To verify that item status can change from Cancel Pending to Delivered if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02107    WLS_High
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
	TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
	TrackOrder - Click save all
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
	TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02108 Multiple item - Save button - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02108    WLS_High
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
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
	TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
	TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
	TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
	#C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02109 Multiple item - Save All button - To verify that item status can change from Shipped to Cancel Pending if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02109    WLS_High
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
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
	TrackOrder - Click save all
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
	TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02110 Multiple item - To verify that item status can change from Cancel Pending to Delivered if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02110    WLS_High    WLS_High
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
	TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
	TrackOrder - Click save all
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
	TrackOrder - Click save all
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
	TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02111 Multiple items - Change item status some item - Save all button - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02111    WLS_High
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
	TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
	TrackOrder - Click save all
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
	TrackOrder - Click save all
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
	TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
	TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
	TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
	#C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02112 Multiple items - Change item status some item - Save all button - To verify that item status can change from Delivered to Customer Cancelled if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02112    WLS_High
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
	TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
	#C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02156 Multiple item - To verify that item status can change from Order Pending to Pending Shipment if payment channel = CS
	[Tags]    regression     ready    TC_ITMWM_02156    WLS_High
	${order_id}    Create Order API - Guest buy multi product success with CS
	Create_order.Set Payment Success For CS    ${order_id}
	Close All Browsers
	${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
	Log To Console    ${order_id}
	Log To Console    ${order_shipment_data}
	LOGIN PCMS    ${pcms_email}    ${pcms_password}
	TrackOrder - Go To Order Detail Page    ${order_id}
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
	TrackOrder - Click save    ${order_shipment_data[1][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    pending_shipment
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Pending Shipment
	TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    pending_shipment
	Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
	Verify status in stock hold table    ${order_shipment_data[1][0]}    cutstock
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    pending_shipment    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02157 Multiple item - To verify that item status can change from Order Pending to Customer Cancelled if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02157    WLS_High
	${order_id}    Create Order API - Guest buy multi product success with CS
	Create_order.Set Payment Success For CS    ${order_id}
	Close All Browsers
	Log to console    ${order_id}
	${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
	LOGIN PCMS    ${pcms_email}    ${pcms_password}
	TrackOrder - Go To Order Detail Page    ${order_id}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Order Pending
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
	Verify status in stock hold table    ${order_shipment_data[0][0]}    cancel
	#C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
	Verify status in stock hold table    ${order_shipment_data[1][0]}    cancel
	#C#Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02158 Multiple item - To verify that item status can change from Pending Shipment to Shipped if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02158    WLS_High
	${order_id}    Create Order API - Guest buy multi product success with CS
	Create_order.Set Payment Success For CS    ${order_id}
	Close All Browsers
	${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
	Log To Console    ${order_id}
	Log To Console    ${order_shipment_data}
	${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    2
	Send Api update status    ${body}
	LOGIN PCMS    ${pcms_email}    ${pcms_password}
	TrackOrder - Go To Order Detail Page    ${order_id}
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
	TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
	TrackOrder - Click save all
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
	TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    shipped
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    shipped    ${pcms_email}
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    shipped    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02159 Multiple item - To verify that item status can change from Pending Shipment to Customer Cancelled if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02159    WLS_High
	${order_id}    Create Order API - Guest buy multi product success with CS
	Create_order.Set Payment Success For CS    ${order_id}
	Close All Browsers
	${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
	Log To Console    ${order_id}
	Log To Console    ${order_shipment_data}
	${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    2
	Send Api update status    ${body}
	LOGIN PCMS    ${pcms_email}    ${pcms_password}
	TrackOrder - Go To Order Detail Page    ${order_id}
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
	#C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
	#C#Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02160 Multiple item - To verify that item status can change from Shipped to Delivered if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02160    WLS_High
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
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
	TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
	TrackOrder - Click save all
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
	TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    delivered
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    delivered    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02161 Multiple item - To verify that item status can change from Shipped to Cancel Pending if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02161    WLS_High
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
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
	TrackOrder - Click save    ${order_shipment_data[1][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
	TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02164 Multiple item - To verify that item status can change from Cancel Pending to Delivered if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02164    WLS_High
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
	TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
	TrackOrder - Click save all
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
	TrackOrder - Click save    ${order_shipment_data[0][0]}
	TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
	TrackOrder - Click save    ${order_shipment_data[1][0]}
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
	TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    delivered
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    delivered    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02165 Multiple item - To verify that item status can change from Cancel Pending to Delivered and to Customer Cancelled if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02165    WLS_High
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
	#C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
	#C#Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02166 Multiple item - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02166    WLS_High
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
	#C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
	#C#Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02167 Multiple item - Save all button - To verify that item status can change from Shipped to Cancel Pending if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02167    WLS_High
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
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
	TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
	TrackOrder - Click save all
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
	TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
	TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
	TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
	TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
	TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02168 Multiple item - Save all button - To verify that item status can change from Cancel Pending to Delivered if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02168    WLS_High
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
	TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
	TrackOrder - Click save all
	${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
	TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
	TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
	TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
	TrackOrder - Click save all
	TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
	TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
	TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
	TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    delivered
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    delivered    ${pcms_email}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
	#C#Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02169 Multiple items - Change item status all item - Save all button - To verify that item status can change from Cancel Pending to Customer Cancelled if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02169    WLS_High
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
	TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
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
	TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
	TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Refund Request
	TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
	#C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
	#C#Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}     None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}     None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers

TC_ITMWM_02170 Multiple items - Change item status all item - Save all button - To verify that item status can change from Delivered to Customer Cancelled if payment channel = CS.
	[Tags]    regression     ready    TC_ITMWM_02170    WLS_High
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
	TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
	TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Refund Request
	TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
	TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
	#C#Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
	#C#Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
	#    Item: 4 = cancel item
	#    Order: 1 = cancel    ::    2 = Refund
	Open PCMS And Sync Order Together
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
	Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
	Order - Together Check Order Status In DB    ${order_id}    0
	[Teardown]    Close All Browsers
