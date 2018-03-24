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
TC_ITMWM_02625 [CCW - Single item - Save] - To verify that system can change item status from Return Pending to Return Received when operation status = Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02625    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    5
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    return_received    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02626 [CCW - Single item - Save all] - To verify that system can change item status from Return Pending to Return Received when operation status = Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02626    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02627 [CS - Single item - Save] - To verify that system can change item status from Return Pending to Return Received when operation status = Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02627    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    2
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    return_received    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02628 [CS - Single item - Save all] - To verify that system can change item status from Return Pending to Return Received when operation status = Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02628    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    3
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    return_received    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02629 [COD - Single item - Save] - To verify that system can change item status from Return Pending to Return Received when operation status = Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02629    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    4
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    return_received    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02630 [COD - Single item - Save all] - To verify that system can change item status from Return Pending to Return Received when operation status = Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02630    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    return_received    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02631 [CCW - Mutiple items - Change some item - Save] - To verify that system can change item status from Return Pending to Return Received when operation status = Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02631    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    7
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    return_received    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02632 [CCW - Mutiple items - Change some item - Save all] - To verify that system can change item status from Return Pending to Return Received when operation status = Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02632    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    8
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    return_received    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02633 [CS - Mutiple items - Change some item - Save] - To verify that system can change item status from Return Pending to Return Received when operation status = Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02633    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    9
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[1][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    return_received    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02634 [CS - Mutiple items - Change some item - Save all] - To verify that system can change item status from Return Pending to Return Received when operation status = Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02634    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    10
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[1][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    return_received    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02635 [COD - Mutiple items - Change some item - Save ] - To verify that system can change item status from Return Pending to Return Received when operation status = Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02635    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    11
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${item_id[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    return_received    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02636 [COD - Mutiple items - Change some item - Save all] - To verify that system can change item status from Return Pending to Return Received when operation status = Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02636    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    12
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${item_id[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    return_received    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02637 [CCW - Mutiple items - Change all items - Save] - To verify that system can change item status from Return Pending to Return Received when operation status = Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02637    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    13
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    14
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[1][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    return_received    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    return_received    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02638 [CCW - Mutiple items - Change all items - Save all] - To verify that system can change item status from Return Pending to Return Received when operation status = Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02638    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    13
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    14
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[1][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    return_received    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    return_received    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02639 [CS - Mutiple items - Change all items - Save] - To verify that system can change item status from Return Pending to Return Received when operation status = Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02639    WLS_High
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    13
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    14
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[1][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    return_received    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    return_received    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02640 [CS - Mutiple items - Change all items - Save all] - To verify that system can change item status from Return Pending to Return Received when operation status = Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02640    WLS_High
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    13
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    14
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[1][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    return_received    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    return_received    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02641 [COD - Mutiple items - Change all items - Save] - To verify that system can change item status from Return Pending to Return Received when operation status = Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02641    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    15
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    16
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${item_id[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    return_received    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    return_received    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02642 [COD - Mutiple items - Change all items - Save all] - To verify that system can change item status from Return Pending to Return Received when operation status = Return Refund Request.
    [Tags]    regression     ready    TC_ITMWM_02642    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    17
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    18
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${item_id[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    return_received    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    return_received    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02679 COD - Save - To verify that system doesn't change item status from Return Recieved to another status if user change item status of another item from Order Pending to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02679    WLS_High
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
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02680 COD - Save all - To verify that system doesn't change item status from Return Recieved to another status if user change item status of another item from Order Pending to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02680    WLS_High
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
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02681 COD - Save - To verify that system doesn't change item status from Return Recieved to another status if user change item status of another item from Shipped to Cancel Pending.
    [Tags]    regression     ready    TC_ITMWM_02681    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[2][0]}    5
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
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02682 COD - Save all - To verify that system doesn't change item status from Return Recieved to another status and change item status of another item correctly if user change item status of another item from Shipped to Cancel Pending.
    [Tags]    regression     ready    TC_ITMWM_02682    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[2][0]}    2
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
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02683 COD - Save - To verify that system doesn't change item status from Return Recieved to another status if user change item status of another item from Delivered to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02683    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}
    ${order_id}=    Guest Buy Product Success with COD by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # set 1st item status Order Pending
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    # set 2nd item status until Pending Shipment
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    # set 3rd item status until Shipped
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    # set 4th item to Delivered
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    none
    # set 5th item to Return Received
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[4][0]}    1
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[4][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[4][0]}    ${ui_item_status}
    # customer cancelled 4th item
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[3][0]}    1
    TrackOrder - Set Operation Status    ${item_id[3][0]}    ${operation_db_refund_request}
    TrackOrder - Click save    ${item_id[3][0]}
    # 1st
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    Verify item status on FMS is not cancel    ${item_id[0][0]}
    # 2nd
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    # 3rd
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    Verify item status on FMS is not cancel    ${item_id[2][0]}
    # 4th
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_refund_request}
    Verify item status on FMS    ${item_id[3][0]}    cancelled
    # 5th
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[4][0]}    return pending
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02684 COD - Save all - To verify that system doesn't change item status from Return Recieved to another status if user change item status of another item from Delivered to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02684    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}
    ${order_id}=    Guest Buy Product Success with COD by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # set 1st item status Order Pending
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    # set 2nd item status until Pending Shipment
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    # set 3rd item status until Shipped
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    # set 4th item to Delivered
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    none
    # set 5th item to Return Received
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[4][0]}    1
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[4][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[4][0]}    ${ui_item_status}
    # customer cancelled 4th item
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[3][0]}    1
    TrackOrder - Set Operation Status    ${item_id[3][0]}    ${operation_db_refund_request}
    TrackOrder - Click save all
    # 1st
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    # 2nd
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    # 3rd
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    Verify item status on FMS is not cancel    ${item_id[2][0]}
    # 4th
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_refund_request}
    Verify item status on FMS    ${item_id[3][0]}    cancelled
    # 5th
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[4][0]}    return pending
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02685 CS - Save - To verify that system doesn't change item status from Return Recieved to another status if user change item status of another item from Order Pending to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02685    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cs}    ${default_inventoryID_cs}    ${default_inventoryID_cs}    ${default_inventoryID_cs}    ${default_inventoryID_cs}
    ${order_id}=    Guest Buy Product Success with CS by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # set 1st item status Order Pending
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    # set 2nd item status until Pending Shipment
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    # set 3rd item status until Shipped
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    # set 4th item to Delivered
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    none
    # set 5th item to Return Received
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[4][0]}    1
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[4][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[4][0]}    ${ui_item_status}
    # customer cancelled 1st item
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Click save    ${item_id[0][0]}
    # 1st
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    cancelled
    # 2nd
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    # 3rd
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    Verify item status on FMS is not cancel    ${item_id[2][0]}
    # 4th
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    none
    Verify item status on FMS is not cancel    ${item_id[3][0]}
    # 5th
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[4][0]}    return pending
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02686 CS - Save all - To verify that system doesn't change item status from Return Recieved to another status if user change item status of another item from Shipped to Cancel Pending.
    [Tags]    regression     ready    TC_ITMWM_02686    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cs}    ${default_inventoryID_cs}    ${default_inventoryID_cs}    ${default_inventoryID_cs}    ${default_inventoryID_cs}
    ${order_id}=    Guest Buy Product Success with CS by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # set 1st item status Order Pending
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    # set 2nd item status until Pending Shipment
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    # set 3rd item status until Shipped
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    # set 4th item to Delivered
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    none
    # set 5th item to Return Received
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[4][0]}    1
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[4][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[4][0]}    ${ui_item_status}
    # customer cancelled 3rd item
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Click save all
    # 1st
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    # 2nd
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    # 3rd
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_refund_request}
    Verify item status on FMS    ${item_id[2][0]}    cancelled
    # 4th
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    # 5th
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[4][0]}    return pending
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02687 CCW - Save - To verify that system doesn't change item status from Return Recieved to another status if user change item status of another item from Shipped to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02687    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}
    ${order_id}=    Guest Buy Product Success with CCW by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # set 1st item status Order Pending
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    # set 2nd item status until Pending Shipment
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    # set 3rd item status until Shipped
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    # set 4th item to Delivered
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    none
    # set 5th item to Return Received
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[4][0]}    1
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[4][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[4][0]}    ${ui_item_status}
    # customer cancelled 3rd item
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Click save    ${item_id[2][0]}
    # 1st
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    # 2nd
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    # 3rd
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_refund_request}
    Verify item status on FMS    ${item_id[2][0]}    cancelled
    # 4th
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    # 5th
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[4][0]}    return pending
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02688 CCW - Save all - To verify that system doesn't change item status from Return Recieved to another status if user change item status of another item from Delivered to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02688    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}
    ${order_id}=    Guest Buy Product Success with CCW by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # set 1st item status Order Pending
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    # set 2nd item status until Pending Shipment
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    # set 3rd item status until Shipped
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    # set 4th item to Delivered
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    none
    # set 5th item to Return Received
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[4][0]}    1
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[4][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[4][0]}    ${ui_item_status}
    # customer cancelled 4th item
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[3][0]}    1
    TrackOrder - Set Operation Status    ${item_id[3][0]}    ${operation_db_refund_request}
    TrackOrder - Click save all
    # 1st
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    Verify item status on FMS is not cancel    ${item_id[0][0]}
    # 2nd
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    # 3rd
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    Verify item status on FMS is not cancel    ${item_id[2][0]}
    # 4th
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_refund_request}
    Verify item status on FMS    ${item_id[3][0]}    cancelled
    # 5th
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[4][0]}    return pending
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02653 [Single item - CCW]To verify that status item has been changed from "Return Pending" when FMS set item status "Return Received"
    [Tags]    regression     ready    TC_ITMWM_02653    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02654 [Single item - CCW]To verify that status item will not change if item status is not "Return Pending" when FMS set item status "Return Received"
    [Tags]    regression     ready    TC_ITMWM_02654    WLS_High
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
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status fail    ${body}    401
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02655 [Single item - CCW - FMS send incorrect status] To verify item status will not change when FMS sent incorrect status item status
    [Tags]    regression     ready    TC_ITMWM_02655    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    ${body}=    Set Json Value    ${body}    /0/item_status    "return_received2"
    Send Api update status fail    ${body}    400
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02656 [Single item - CCW - FMS send dup status] To verify item status will not change when item status in PCMS is Return Received
    [Tags]    regression     ready    TC_ITMWM_02656    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02657 [Single item - COD]To verify that status item has been changed from "Return Pending" when FMS set item status "Return Received"
    [Tags]    regression     ready    TC_ITMWM_02657    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02658 [Single item - COD]To verify that status item will not change if item status is not "Return Pending" when FMS set item status "Return Received"
    [Tags]    regression     ready    TC_ITMWM_02658    WLS_High
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
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status fail    ${body}    401
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02659 [Single item - COD - FMS send incorrect status] To verify item status will not change when FMS sent incorrect status item status
    [Tags]    regression     ready    TC_ITMWM_02659    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    ${body}=    Set Json Value    ${body}    /0/item_status    "return_received2"
    Send Api update status fail    ${body}    400
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02660 [Single item - COD - FMS send dup status] To verify item status will not change when item status in PCMS is Return Received
    [Tags]    regression     ready    TC_ITMWM_02660    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02661 [Single item - CS]To verify that status item has been changed from "Return Pending" when FMS set item status "Return Received"
    [Tags]    regression     ready    TC_ITMWM_02661    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02662 [Single item - CS]To verify that status item will not change if item status is not "Return Pending" when FMS set item status "Return Received"
    [Tags]    regression     ready    TC_ITMWM_02662    WLS_High
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
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status fail    ${body}    401
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02663 [Single item - CS - FMS send incorrect status] To verify item status will not change when FMS sent incorrect status item status
    [Tags]    regression     ready    TC_ITMWM_02663    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    ${body}=    Set Json Value    ${body}    /0/item_status    "return_received2"
    Send Api update status fail    ${body}    400
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02664 [Single item - CS - FMS send dup status] To verify item status will not change when item status in PCMS Return Received
    [Tags]    regression     ready    TC_ITMWM_02664    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02665 [Multiple item - CCW]To verify that status item has been changed from "Return Pending" when FMS set item status "Return Received"
    [Tags]    regression     ready    TC_ITMWM_02665    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[1][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    Sleep    5s
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02666 [Multiple item - CCW]To verify that status item will not change if item status is not "Return Pending" when FMS set item status "Return Received"
    [Tags]    regression     ready    TC_ITMWM_02666    WLS_High
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
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    Send Api update status fail    ${body}    401
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02667 [Multiple item - CCW - FMS send incorrect status] To verify item status will not change when FMS sent incorrect status item status
    [Tags]    regression     ready    TC_ITMWM_02667    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[1][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    ${body}=    Set Json Value    ${body}    /0/item_status    "return_received2"
    ${body}=    Set Json Value    ${body}    /1/item_status    "return_received2"
    Send Api update status fail    ${body}    400
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02668 [Multiple item - CCW - FMS send dup status] To verify item status will not change when item status in PCMS is Return Received
    [Tags]    regression     ready    TC_ITMWM_02668    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[1][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02669 [Multiple item - COD]To verify that status item has been changed from "Return Pending" when FMS set item status "Return Received"
    [Tags]    regression     ready    TC_ITMWM_02669    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[1][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    Sleep    5s
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02670 [Multiple item - COD]To verify that status item will not change if item status is not "Return Pending" when FMS set item status "Return Received"
    [Tags]    regression     ready    TC_ITMWM_02670    WLS_High
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
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    Send Api update status fail    ${body}    401
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02671 [Multiple item - COD - FMS send incorrect status] To verify item status will not change when FMS sent incorrect status item status
    [Tags]    regression     ready    TC_ITMWM_02671    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[1][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    ${body}=    Set Json Value    ${body}    /0/item_status    "return_received2"
    ${body}=    Set Json Value    ${body}    /1/item_status    "return_received2"
    Send Api update status fail    ${body}    400
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02672 [Multiple item - COD - FMS send dup status] To verify item status will not change when item status in PCMS is Return Received
    [Tags]    regression     ready    TC_ITMWM_02672    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[1][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02673 [Multiple item - CS]To verify that status item has been changed from "Return Pending" when FMS set item status "Return Received"
    [Tags]    regression     ready    TC_ITMWM_02673    WLS_High
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[1][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    Sleep    5s
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02674 [Multiple item - CS]To verify that status item will not change if item status is not "Return Pending" when FMS set item status "Return Received"
    [Tags]    regression     ready    TC_ITMWM_02674    WLS_High
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    Send Api update status fail    ${body}    401
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02675 [Multiple item - CS - FMS send incorrect status] To verify item status will not change when FMS sent incorrect status item status
    [Tags]    regression     ready    TC_ITMWM_02675    WLS_High
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[1][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    ${body}=    Set Json Value    ${body}    /0/item_status    "return_received2"
    ${body}=    Set Json Value    ${body}    /1/item_status    "return_received2"
    Send Api update status fail    ${body}    400
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02676 [Multiple item - CS - FMS send dup status] To verify item status will not change when item status in PCMS is Return Received
    [Tags]    regression     ready    TC_ITMWM_02676    WLS_High
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    6
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[1][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Received with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers
