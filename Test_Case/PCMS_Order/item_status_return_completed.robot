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
TC_ITMWM_02713 [CCW - Single item - Save] - To verify that system can change item status from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02713    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02714 [CCW - Single item - Save all] - To verify that system can change item status from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02714    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02715 [CS - Single item - Save] - To verify that system can change item status from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02715    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02716 [CS - Single item - Save all] - To verify that system can change item status from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02716    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02717 [COD - Single item - Save] - To verify that system can change item status from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02717    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02718 [COD - Single item - Save all] - To verify that system can change item status from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02718    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02719 [CCW - Mutiple items - Change some item - Save] - To verify that system can change item status from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02719    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02720 [CCW - Mutiple items - Change some item - Save all] - To verify that system can change item status from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02720    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02721 [CS - Mutiple items - Change some item - Save] - To verify that system can change item status from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02721    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02722 [CS - Mutiple items - Change some item - Save all] - To verify that system can change item status from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02722    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02723 [COD - Mutiple items - Change some item - Save ] - To verify that system can change item status from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02723    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02724 [COD - Mutiple items - Change some item - Save all] - To verify that system can change item status from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02724    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02725 [CCW - Mutiple items - Change all items - Save] - To verify that system can change item status from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02725    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02726 [CCW - Mutiple items - Change all items - Save all] - To verify that system can change item status from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02726    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02727 [CS - Mutiple items - Change all items - Save] - To verify that system can change item status from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02727    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02728 [CS - Mutiple items - Change all items - Save all] - To verify that system can change item status from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02728    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02729 [COD - Mutiple items - Change all items - Save] - To verify that system can change item status from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02729    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02730 [COD - Mutiple items - Change all items - Save all] - To verify that system can change item status from Return Received to Return Completed and automatically change operation status from "Return Refund Request" to "Refund Request"
    [Tags]    regression     ready    TC_ITMWM_02730    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_return_completed}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    ###### m #####
    [Teardown]    Close All Browsers

TC_ITMWM_02771 COD - Save - To verify that system doesn't change item status from Return Completed to another status if user change item status of another item from Order Pending to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02771    WLS_High
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
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_refund_request}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    ${item_status_db_delivered}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[4][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02772 COD - Save all - To verify that system doesn't change item status from Return Completed to another status if user change item status of another item from Order Pending to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02772    WLS_High
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
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_refund_request}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    ${item_status_db_delivered}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[4][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02773 COD - Save - To verify that system doesn't change item status from Return Completed to another status if user change item status of another item from Shipped to Cancel Pending.
    [Tags]    regression     ready    TC_ITMWM_02773    WLS_High
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
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_refund_request}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_cancel_pending}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    ${item_status_db_cancel_pending}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    ${item_status_db_delivered}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[4][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02774 COD - Save all - To verify that system doesn't change item status from Return Completed to another status if user change item status of another item from Shipped to Cancel Pending.
    [Tags]    regression     ready    TC_ITMWM_02774    WLS_High
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
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_refund_request}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_cancel_pending}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    ${item_status_db_cancel_pending}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    ${item_status_db_delivered}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[4][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02775 COD - Save - To verify that system doesn't change item status from Return Completed to another status if user change item status of another item from Delivered to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02775    WLS_High
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
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_refund_request}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_pending_shipment}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    ${item_status_db_shipped}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[4][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02776 COD - Save all - To verify that system doesn't change item status from Return Completed to another status if user change item status of another item from Delivered to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02776    WLS_High
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
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_refund_request}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_pending_shipment}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    ${item_status_db_shipped}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[4][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02777 CS - Save - To verify that system doesn't change item status from Return Completed to another status if user change item status of another item from Order Pending to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02777    WLS_High
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
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_refund_request}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_pending_shipment}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    ${item_status_db_shipped}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    ${item_status_db_delivered}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[4][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02778 CS - Save all - To verify that system doesn't change item status from Return Completed to another status if user change item status of another item from Shipped to Cancel Pending.
    [Tags]    regression     ready    TC_ITMWM_02778    WLS_High
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
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_refund_request}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_cancel_pending}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_order_pending}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_pending_shipment}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    ${item_status_db_cancel_pending}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    ${item_status_db_delivered}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[4][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02779 - CCW - Save - To verify that system doesn't change item status from Return Completed to another status if user change item status of another item from Shipped to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02779    WLS_High
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
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_refund_request}
    TrackOrder - Set Item status    ${item_id[2][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_pending_shipment}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    ${item_status_db_delivered}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[4][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02780 CCW - Save all - To verify that system doesn't change item status from Return Completed to another status if user change item status of another item from Delivered to Customer Cancelled.
    [Tags]    regression     ready    TC_ITMWM_02780    WLS_High
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
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_refund_request}
    TrackOrder - Set Item status    ${item_id[3][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    ${item_status_db_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_return_completed}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_order_pending}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_pending_shipment}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    ${item_status_db_shipped}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[4][0]}    ${item_status_db_return_completed}    ${pcms_email}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    ##########FMS #######################
    [Teardown]    Close All Browsers

TC_ITMWM_02741 [Single item - CCW]To verify that status item has been changed from "Return Received" when FMS set item status "Return Completed"
    [Tags]    regression     ready    TC_ITMWM_02741    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status    ${body}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02742 [Single item - CCW]To verify that status item will not change if item status is not "Return Received" when FMS set item status "Return Completed"
    [Tags]    regression     ready    TC_ITMWM_02742    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status fail    ${body}    401
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02743 [Single item - CCW - FMS send incorrect status] To verify item status will not change when FMS sent incorrect status item status
    [Tags]    regression     ready    TC_ITMWM_02743    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    ${body}=    Set Json Value    ${body}    /0/item_status    "return_eiei"
    Send Api update status fail    ${body}    400
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02744 [Single item - CCW - FMS send dup status] To verify item status will not change when item status in PCMS is Return Completed
    [Tags]    regression     ready    TC_ITMWM_02744    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status    ${body}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02745 [Single item - COD]To verify that status item has been changed from "Return Received" when FMS set item status "Return Completed"
    [Tags]    regression     ready    TC_ITMWM_02745    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status    ${body}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02746 [Single item - COD]To verify that status item will not change if item status is not "Return Received" when FMS set item status "Return Completed"
    [Tags]    regression     ready    TC_ITMWM_02746    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Click save all
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
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    ${body}=    Set Json Value    ${body}    /0/item_status    "return_eiei"
    Send Api update status fail    ${body}    400
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02660 [Single item - COD - FMS send dup status] To verify item status will not change when item status in PCMS is Return Completed
    [Tags]    regression     ready    TC_ITMWM_02660    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status    ${body}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02661 [Single item - CS]To verify that status item has been changed from "Return Received" when FMS set item status "Return Completed"
    [Tags]    regression     ready    TC_ITMWM_02661    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status    ${body}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02662 [Single item - CS]To verify that status item will not change if item status is not "Return Received" when FMS set item status "Return Completed"
    [Tags]    regression     ready    TC_ITMWM_02662    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02663 [Single item - CS - FMS send incorrect status] To verify item status will not change when FMS sent incorrect status item status
    [Tags]    regression     ready    TC_ITMWM_02663    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    ${body}=    Set Json Value    ${body}    /0/item_status    "return_eiei"
    Send Api update status fail    ${body}    400
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02752 [Single item - CS - FMS send dup status] To verify item status will not change when item status in PCMS Return Completed
    [Tags]    regression     ready    TC_ITMWM_02752    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status    ${body}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02753 [Multiple item - CCW]To verify that status item has been changed from "Return Received" when FMS set item status "Return Completed"
    [Tags]    regression     ready    TC_ITMWM_02753    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    Send Api update status    ${body}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02754 [Multiple item - CCW]To verify that status item will not change if item status is not "Return Received" when FMS set item status "Return Completed"
    [Tags]    regression     ready    TC_ITMWM_02754    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    Send Api update status fail    ${body}    401
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02755 [Multiple item - CCW - FMS send incorrect status] To verify item status will not change when FMS sent incorrect status item status
    [Tags]    regression     ready    TC_ITMWM_02755    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    ${body}=    Set Json Value    ${body}    /0/item_status    "return_received2"
    ${body}=    Set Json Value    ${body}    /1/item_status    "return_received2"
    Send Api update status fail    ${body}    400
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02756 [Multiple item - CCW - FMS send dup status] To verify item status will not change when item status in PCMS is Return Completed
    [Tags]    regression     ready    TC_ITMWM_02756    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    Send Api update status    ${body}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02757 [Multiple item - COD]To verify that status item has been changed from "Return Received" when FMS set item status "Return Completed"
    [Tags]    regression     ready    TC_ITMWM_02757    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    Send Api update status    ${body}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02758 [Multiple item - COD]To verify that status item will not change if item status is not "Return Received" when FMS set item status "Return Completed"
    [Tags]    regression     ready    TC_ITMWM_02758    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    Send Api update status fail    ${body}    401
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02759 [Multiple item - COD - FMS send incorrect status] To verify item status will not change when FMS sent incorrect status item status
    [Tags]    regression     ready    TC_ITMWM_02759    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    ${body}=    Set Json Value    ${body}    /0/item_status    "return_received2"
    ${body}=    Set Json Value    ${body}    /1/item_status    "return_received2"
    Send Api update status fail    ${body}    400
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02760 [Multiple item - COD - FMS send dup status] To verify item status will not change when item status in PCMS is Return Completed
    [Tags]    regression     ready    TC_ITMWM_02760    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    Send Api update status    ${body}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02761 [Multiple item - CS]To verify that status item has been changed from "Return Received" when FMS set item status "Return Completed"
    [Tags]    regression     ready    TC_ITMWM_02761    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    Send Api update status    ${body}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02762 [Multiple item - CS]To verify that status item will not change if item status is not "Return Received" when FMS set item status "Return Completed"
    [Tags]    regression     ready    TC_ITMWM_02762    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    Send Api update status fail    ${body}    401
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02763 [Multiple item - CS - FMS send incorrect status] To verify item status will not change when FMS sent incorrect status item status
    [Tags]    regression     ready    TC_ITMWM_02763    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    ${body}=    Set Json Value    ${body}    /0/item_status    "return_received2"
    ${body}=    Set Json Value    ${body}    /1/item_status    "return_received2"
    Send Api update status fail    ${body}    400
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02764 [Multiple item - CS - FMS send dup status] To verify item status will not change when item status in PCMS is Return Completed
    [Tags]    regression     ready    TC_ITMWM_02764    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    Log To Console    order_id = ${order_id}
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save all
    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${order_id}    ${item_id}    SN12345    2
    Send Api update status    ${body}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_completed}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_completed}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_completed}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers
