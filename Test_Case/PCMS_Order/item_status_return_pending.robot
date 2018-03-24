*** Settings ***
Force Tags    WLS_PCMS_Order
Resource          ${CURDIR}/../../Resource/init.robot
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
TC_ITMWM_02504 [CS - Mutiple items - Change some item - Save] - To verify that system automatically change item status to Return Pending when user change operation status to Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02504    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    21
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02505 [CS - Mutiple items - Change some item - Save all] - To verify that system automatically change item status to Return Pending when user change operation status to Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02505    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    21
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02506 COD - Mutiple items - Change some item - Save - Delivered to Customer Cancelled - A = Order Pending and B = Delivered.
    [Tags]    regression     ready    TC_ITMWM_02506    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    21
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02507 COD - Mutiple items - Change some item - Save - Delivered to Customer Cancelled - A = Delivered and B = Pending Shipment.
    [Tags]    regression     ready    TC_ITMWM_02507    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    1
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02508 COD - Mutiple items - Change some item - Save - Delivered to Customer Cancelled - A = Delivered and B = Shipped.
    [Tags]    regression     ready    TC_ITMWM_02508    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    21
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02509 COD - Mutiple items - Change some item - Save - Delivered to Customer Cancelled - A = Delivered and B = Cancel Pending.
    [Tags]    regression     ready    TC_ITMWM_02509    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    21
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_cancel_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02510 COD - Mutiple items - Change some item - Save all - Delivered to Customer Cancelled - A = Order Pending and B = Delivered.
    [Tags]    regression     ready    TC_ITMWM_02510    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    21
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02511 COD - Mutiple items - Change some item - Save all - Delivered to Customer Cancelled - A = Delivered and B = Pending Shipment.
    [Tags]    regression     ready    TC_ITMWM_02511    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    1
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02512 COD - Mutiple items - Change some item - Save all - Delivered to Customer Cancelled - A = Delivered and B = Shipped.
    [Tags]    regression     ready    TC_ITMWM_02512    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    21
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02513 COD - Mutiple items - Change some item - Save all - Delivered to Customer Cancelled - A = Delivered and B = Cancel Pending.
    [Tags]    regression     ready    TC_ITMWM_02513    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    21
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_cancel_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02514 shipped, order pending, delivered : delivered => customer cancelled : operation status = Return Refund Request : payment channel = COD
    [Tags]    regression     ready    TC_ITMWM_02514    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}
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
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    shipped    ${pcms_email}
    # verify 2nd item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    order_pending
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[1][0]}    order_pending
    # verify 3rd item should be Delivered
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[2][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[2][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02515 delivered, cancel pending : delivered => customer cancelled : operation status = Return Refund Request : payment channel = COD
    [Tags]    regression     ready    TC_ITMWM_02515    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    Verify item status on FMS should not be    ${order_shipment_data[1][0]}    ${item_status_fms_return_pending}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${order_shipment_data[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${order_shipment_data[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
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
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02516 shipped, delivered : delivered => customer cancelled : operation status = Return Refund Request : payment channel = COD
    [Tags]    regression     ready    TC_ITMWM_02516    WLS_High
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
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    # verify 1st item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    shipped
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    Verify item status on FMS is not cancel    ${item_id[0][0]}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    shipped    ${pcms_email}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02517 shipped, order pending, delivered : delivered => customer cancelled : operation status = Return Refund Request : payment channel = CCW
    [Tags]    regression     ready    TC_ITMWM_02517    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}
    ${order_id}=    Guest Buy Product Success with CCW by Inventory Id List    ${email}    ${inv_ids}
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
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    shipped    ${pcms_email}
    # verify 2nd item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    order_pending
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[1][0]}    order_pending
    # verify 3rd item should be Delivered
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[2][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[2][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02518 delivered, cancel pending : delivered => customer cancelled : operation status = Return Refund Request : payment channel = CCW
    [Tags]    regression     ready    TC_ITMWM_02518    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    CCW
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    CCW
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    Verify item status on FMS should not be    ${order_shipment_data[1][0]}    ${item_status_fms_return_pending}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    CCW
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${order_shipment_data[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${order_shipment_data[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02519 shipped, delivered : delivered => customer cancelled : operation status = Return Refund Request : payment channel = CCW
    [Tags]    regression     ready    TC_ITMWM_02519    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
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
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    # verify 1st item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    shipped
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    Verify item status on FMS is not cancel    ${item_id[0][0]}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    shipped    ${pcms_email}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02520 shipped, order pending, delivered : delivered => customer cancelled : operation status = Return Refund Request : payment channel = CS
    [Tags]    regression     ready    TC_ITMWM_02520    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}
    ${order_id}=    Guest Buy Product Success with CS by Inventory Id List    ${email}    ${inv_ids}
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
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    shipped    ${pcms_email}
    # verify 2nd item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    order_pending
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    # verify 3rd item should be Delivered
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[2][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[2][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02521 delivered, cancel pending : delivered => customer cancelled : operation status = Return Refund Request : payment channel = CS
    [Tags]    regression     ready    TC_ITMWM_02521    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    # DB get order shipment item id
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    CS
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    CS
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    Verify item status on FMS should not be    ${order_shipment_data[1][0]}    ${item_status_fms_return_pending}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    CCW
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${order_shipment_data[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${order_shipment_data[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02522 shipped, delivered : delivered => customer cancelled : operation status = Return Refund Request : payment channel = CS
    [Tags]    regression     ready    TC_ITMWM_02522    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
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
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    # verify 1st item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    shipped
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    Verify item status on FMS is not cancel    ${item_id[0][0]}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    shipped    ${pcms_email}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02496 [CCW - Single item - Save] - To verify that system automatically change item status to Return Pending when user change operation status to Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02496    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    21
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02497 [CCW - Single item - Save all] - To verify that system automatically change item status to Return Pending when user change operation status to Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02497    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    21
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02498 [CS - Single item - Save] - To verify that system automatically change item status to Return Pending when user change operation status to Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02498    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    21
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02499 [CS - Single item - Save all] - To verify that system automatically change item status to Return Pending when user change operation status to Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02499    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    21
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02500 [COD - Single item - Save] - To verify that system automatically change item status to Return Pending when user change operation status to Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02500    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    18
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02501 [COD - Single item - Save all] - To verify that system automatically change item status to Return Pending when user change operation status to Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02501    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    18
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02502 [CCW - Mutiple items - Change some item - Save] - To verify that system automatically change item status to Return Pending when user change operation status to Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02502    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02503 [CCW - Mutiple items - Change some item - Save all] - To verify that system automatically change item status to Return Pending when user change operation status to Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02503    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02523 [CCW - Mutiple items - Change all items - Save] - To verify that system automatically change item status to Return Pending when user change operation status to Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02523    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    18
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02524 [CCW - Mutiple items - Change all items - Save all] - To verify that system automatically change item status to Return Pending when user change operation status to Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02524    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    18
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02525 [CS - Mutiple items - Change all items - Save] - To verify that system automatically change item status to Return Pending when user change operation status to Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02525    WLS_High
    Create Order API - Guest buy multi product success with CS     ${default_inventoryID_cs}     ${default_inventoryID_cs}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    18
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02526 [CS - Mutiple items - Change all items - Save all] - To verify that system automatically change item status to Return Pending when user change operation status to Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02526    WLS_High
    Create Order API - Guest buy multi product success with CS     ${default_inventoryID_cs}     ${default_inventoryID_cs}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    18
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02527 [COD - Mutiple items - Change all items - Save] - To verify that system automatically change item status to Return Pending when user change operation status to Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02527    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    18
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02528 [COD - Mutiple items - Change all items - Save all] - To verify that system automatically change item status to Return Pending when user change operation status to Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02528    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    18
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02529 COD - Save - To verify that system doesn't change item status from Return Pending to another status if user change item status of another item from Order Pending to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02529    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}
    ${order_id}=    Guest Buy Product Success with COD by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[4][0]}    1
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[2][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[3][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_unable_to_refund}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_unable_to_refund}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_unable_to_refund}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_unable_to_refund}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_unable_to_refund}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_unable_to_refund}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    cancelled
    Verify item status on FMS    ${item_id[1][0]}    cancelled
    Verify item status on FMS    ${item_id[2][0]}    cancelled
    Verify item status on FMS should not be    ${item_id[3][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02530 COD - Save all - To verify that system doesn't change item status from Return Pending to another status if user change item status of another item from Order Pending to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02530    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}
    ${order_id}=    Guest Buy Product Success with COD by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[4][0]}    1
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[2][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[3][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_unable_to_refund}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_unable_to_refund}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_unable_to_refund}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_unable_to_refund}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_unable_to_refund}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_unable_to_refund}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    cancelled
    Verify item status on FMS    ${item_id[1][0]}    cancelled
    Verify item status on FMS    ${item_id[2][0]}    cancelled
    Verify item status on FMS should not be    ${item_id[3][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02531 COD - Save - To verify that system doesn't change item status from Return Pending to another status if user change item status of another item from Shipped to Cancel Pending.
    [Tags]    regression     ready    TC_ITMWM_02531    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}
    ${order_id}=    Guest Buy Product Success with COD by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[4][0]}    1
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[2][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[3][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Set Cancel Reason    ${item_id[2][0]}    18
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_cancel_pending}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_unable_to_refund}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_unable_to_refund}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_unable_to_refund}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_unable_to_refund}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    cancelled
    Verify item status on FMS    ${item_id[1][0]}    cancelled
    Verify item status on FMS is not cancel    ${item_id[2][0]}
    Verify item status on FMS should not be    ${item_id[3][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02532 COD - Save all - To verify that system doesn't change item status from Return Pending to another status if user change item status of another item from Shipped to Cancel Pending.
    [Tags]    regression     ready    TC_ITMWM_02532    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}
    ${order_id}=    Guest Buy Product Success with COD by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[4][0]}    1
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[2][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[3][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Set Cancel Reason    ${item_id[2][0]}    18
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_cancel_pending}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_unable_to_refund}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_unable_to_refund}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_unable_to_refund}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_unable_to_refund}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    cancelled
    Verify item status on FMS    ${item_id[1][0]}    cancelled
    Verify item status on FMS is not cancel    ${item_id[2][0]}
    Verify item status on FMS should not be    ${item_id[3][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02533 COD - Save - To verify that system doesn't change item status from Return Pending to another status if user change item status of another item from Delivered to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02533    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}
    ${order_id}=    Guest Buy Product Success with COD by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[4][0]}    1
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[2][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[3][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[3][0]}    18
    TrackOrder - Set Operation Status    ${item_id[3][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS is not cancel    ${item_id[0][0]}
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    Verify item status on FMS is not cancel    ${item_id[2][0]}
    Verify item status on FMS    ${item_id[3][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[3][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[3][0]}    ${item_status_db_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02534 COD - Save all - To verify that system doesn't change item status from Return Pending to another status if user change item status of another item from Delivered to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02534    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}
    ${order_id}=    Guest Buy Product Success with COD by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[4][0]}    1
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[2][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[3][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[3][0]}    18
    TrackOrder - Set Operation Status    ${item_id[3][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS is not cancel    ${item_id[0][0]}
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    Verify item status on FMS is not cancel    ${item_id[2][0]}
    Verify item status on FMS    ${item_id[3][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[3][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[3][0]}    ${item_status_db_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02535 CS - Save - To verify that system doesn't change item status from Return Pending to another status if user change item status of another item from Order Pending to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02535    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cs}    ${default_inventoryID_cs}    ${default_inventoryID_cs}    ${default_inventoryID_cs}    ${default_inventoryID_cs}
    ${order_id}=    Guest Buy Product Success with CS by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[4][0]}    1
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[2][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[3][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    cancelled
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    Verify item status on FMS is not cancel    ${item_id[2][0]}
    Verify item status on FMS is not cancel    ${item_id[3][0]}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    customer_cancelled    ${pcms_email}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02536 CS - Save all - To verify that system doesn't change item status from Return Pending to another status if user change item status of another item from Shipped to Cancel Pending.
    [Tags]    regression     ready    TC_ITMWM_02536    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cs}    ${default_inventoryID_cs}    ${default_inventoryID_cs}    ${default_inventoryID_cs}    ${default_inventoryID_cs}
    ${order_id}=    Guest Buy Product Success with CS by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[4][0]}    1
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[2][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[3][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Set Cancel Reason    ${item_id[2][0]}    18
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_cancel_pending}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS is not cancel    ${item_id[0][0]}
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    Verify item status on FMS is not cancel    ${item_id[2][0]}
    Verify item status on FMS is not cancel    ${item_id[3][0]}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02537 CCW - Save - To verify that system doesn't change item status from Return Pending to another status if user change item status of another item from Shipped to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02537    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}
    ${order_id}=    Guest Buy Product Success with CCW by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[4][0]}    1
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[2][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[3][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[2][0]}    18
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS is not cancel    ${item_id[0][0]}
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    Verify item status on FMS    ${item_id[2][0]}    cancelled
    Verify item status on FMS is not cancel    ${item_id[3][0]}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02538 CCW - Save all - To verify that system doesn't change item status from Return Pending to another status if user change item status of another item from Order Pending to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02538    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}
    ${order_id}=    Guest Buy Product Success with CCW by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[4][0]}    1
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS should not be    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[2][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[3][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    18
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    cancelled
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    Verify item status on FMS is not cancel    ${item_id[2][0]}
    Verify item status on FMS is not cancel    ${item_id[3][0]}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers
