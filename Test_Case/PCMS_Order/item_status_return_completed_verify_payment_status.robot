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
TC_ITMWM_02689 [CCW - Single item - Save] - To verify payment status = Payment success when item status has been changed from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02689    WLS_High
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02690 [CCW - Single item - Save all] - To verify payment status = Payment success when item status has been changed from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02690    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    5
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02691 [CS - Single item - Save] - To verify payment status = Payment success when item status has been changed from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02691    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    5
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02692 [CS - Single item - Save all] - To verify payment status = Payment success when item status has been changed from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02692    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    5
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02693 [COD - Single item - Save] - To verify payment status = Payment success when item status has been changed from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02693    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    5
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02694 [COD - Single item - Save all] - To verify payment status = Payment success when item status has been changed from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02694    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    5
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02695 [CCW - Mutiple items - Change some item - Save] - To verify payment status = Payment success when item status has been changed from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02695    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    5
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Payment Status on UI    ${item_id[1][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[1][0]}    success
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02696 [CCW - Mutiple items - Change some item - Save all] - To verify payment status = Payment success when item status has been changed from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02696    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    5
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Payment Status on UI    ${item_id[1][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[1][0]}    success
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02697 [CS - Mutiple items - Change some item - Save] - To verify payment status = Payment success when item status has been changed from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02697    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    5
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Payment Status on UI    ${item_id[1][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[1][0]}    success
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02698 [CS - Mutiple items - Change some item - Save all] - To verify payment status = Payment success when item status has been changed from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02698    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    5
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Payment Status on UI    ${item_id[1][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[1][0]}    success
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None

TC_ITMWM_02699 [COD - Mutiple items - Change some item - Save ] - To verify payment status = Payment success when item status has been changed from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02699    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Payment Status on UI    ${item_id[1][0]}    Payment Pending
    TrackOrder - Check Payment Status on DB    ${item_id[1][0]}    payment_pending
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02700 [COD - Mutiple items - Change some item - Save all] - To verify payment status = Payment success when item status has been changed from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02700    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    5
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Payment Status on UI    ${item_id[1][0]}    Payment Pending
    TrackOrder - Check Payment Status on DB    ${item_id[1][0]}    payment_pending
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02701 [CCW - Mutiple items - Change all items - Save] - To verify payment status = Payment success when item status has been changed from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02701    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    5
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    5
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[1][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Payment Status on UI    ${item_id[1][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[1][0]}    success
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02702 [CCW - Mutiple items - Change all items - Save all] - To verify payment status = Payment success when item status has been changed from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02702    WLS_High
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
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    5
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    5
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[1][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Payment Status on UI    ${item_id[1][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[1][0]}    success
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02703 [CS - Mutiple items - Change all items - Save] - To verify payment status = Payment success when item status has been changed from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02703    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    5
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    5
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[1][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Payment Status on UI    ${item_id[1][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[1][0]}    success
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02704 [CS - Mutiple items - Change all items - Save all] - To verify payment status = Payment success when item status has been changed from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02704    WLS_High
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
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    5
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    5
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[1][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Payment Status on UI    ${item_id[1][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[1][0]}    success
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02705 [COD - Mutiple items - Change all items - Save] - To verify payment status = Payment success when item status has been changed from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02705    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
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
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    5
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[1][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Payment Status on UI    ${item_id[1][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[1][0]}    success
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02706 [COD - Mutiple items - Change all items - Save all] - To verify payment status = Payment success when item status has been changed from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02706    WLS_High
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
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    5
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    5
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[0][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[0][0]}    ${ui_item_status}
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item_id[1][0]}
    TrackOrder - Check Available Item Status on UI    ${item_id[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Payment Status on UI    ${item_id[1][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[1][0]}    success
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers
