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
TC_ITMWM_02594 [CCW - Single item] To verify that system change item status from Return Received to Return Rejected correctly when FMS send request for update item status to Return Rejected to PCMS.
    [Tags]    regression    TC_ITMWM_02594    WLS_High
    # 1
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    # FMS return rejected
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_return_rejected}
    # verify order together
    Close All Browsers
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02595 [CS - Single item] To verify that system change item status from Return Received to Return Rejected correctly when FMS send request for update item status to Return Rejected to PCMS.
    [Tags]    regression    TC_ITMWM_02595    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    # FMS return rejected
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_return_rejected}

    # verify order together
    Close All Browsers
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02596 [COD - Single item] To verify that system change item status from Return Received to Return Rejected correctly when FMS send request for update item status to Return Rejected to PCMS.
    [Tags]    regression    TC_ITMWM_02596    WLS_High
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    # FMS return rejected
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_return_rejected}
    # verify order together
    Close All Browsers
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02597 [CCW - Mutiple items - Change some item] To verify that system change item status from Return Received to Return Rejected correctly when FMS send request for update item status to Return Rejected to PCMS.
    [Tags]    regression    TC_ITMWM_02597    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID}    ${default_inventoryID}
    ${order_id}=    Guest Buy Product Success with CCW by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # set 1st item to Return Received
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    # 2nd item status Order Pending
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    # FMS return rejected
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # 1st
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_return_rejected}
    # 2nd
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[1][0]}    ${item_status_db_order_pending}
    # verify order together
    Close All Browsers
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02598 [CS - Mutiple items - Change some item] To verify that system change item status from Return Received to Return Rejected correctly when FMS send request for update item status to Return Rejected to PCMS.
    [Tags]    regression    TC_ITMWM_02598    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # set 1st item to Return Received
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    # 2nd item status Order Pending
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    # FMS return rejected
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # 1st
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_return_rejected}
    # 2nd
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    ${item_status_db_order_pending}    ${pcms_email}
    # verify order together
    Close All Browsers
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02599 [COD - Mutiple items - Change some item] To verify that system change item status from Return Received to Return Rejected correctly when FMS send request for update item status to Return Rejected to PCMS.
    [Tags]    regression    TC_ITMWM_02599    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cod}    ${default_inventoryID_cod}
    ${order_id}=    Guest Buy Product Success with COD by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # set 1st item to Return Received
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    # 2nd item status Order Pending
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    # FMS return rejected
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}    SN12345    1
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # 1st
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_return_rejected}
    # 2nd
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[1][0]}    ${item_status_db_order_pending}
    # verify order together
    Close All Browsers
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02600 [CCW - Mutiple items - Change all items] To verify that system change item status from Return Received to Return Rejected correctly when FMS send request for update item status to Return Rejected to PCMS.
    [Tags]    regression    TC_ITMWM_02600    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID}    ${default_inventoryID}
    ${order_id}=    Guest Buy Product Success with CCW by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # set all item to Return Received
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
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    1
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    # FMS return rejected
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}    SR111    2
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # 1st
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_return_rejected}
    # 2nd
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[1][0]}    ${item_status_db_return_rejected}
    # verify order together
    Close All Browsers
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02601 [CS - Mutiple items - Change all items] To verify that system change item status from Return Received to Return Rejected correctly when FMS send request for update item status to Return Rejected to PCMS.
    [Tags]    regression    TC_ITMWM_02601    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # set all item to Return Received
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
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    1
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    # FMS return rejected
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}    SR111    2
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # 1st
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_return_rejected}
    # 2nd
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[1][0]}    ${item_status_db_return_rejected}
    # verify order together
    Close All Browsers
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02602 [COD - Mutiple items - Change all items] To verify that system change item status from Return Received to Return Rejected correctly when FMS send request for update item status to Return Rejected to PCMS.
    [Tags]    regression    TC_ITMWM_02602    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # set all item to Return Received
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
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    1
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    # FMS return rejected
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}    SR111    2
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # 1st
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_return_rejected}
    # 2nd
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[1][0]}    ${item_status_db_return_rejected}
    # verify order together
    Close All Browsers
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02606 To verify that system return error to FMS when FMS send request for update item status to Return Rejected but current status on PCMS is not Return Received.
    [Tags]    regression    TC_ITMWM_02606    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}
    Send Api update status fail    ${body}    401
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_order_pending}
    # 2
    [Teardown]    Close All Browsers

TC_ITMWM_02607 COD - Save - To verify that system doesn't change item status from Return Rejected to another status if user change item status of another item from Order Pending to Customer Cancelled.
    [Tags]    regression    TC_ITMWM_02607    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}
    ${order_id}=    Guest Buy Product Success with COD by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    delivered
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    sleep    3s
    # FMS return rejected
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    shipped
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    shipped
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    delivered
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[4][0]}
    #item 5
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    unable_to_refund
    Verify item status on FMS    ${item_id[4][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[4][0]}    customer_cancelled    ${pcms_email}
    #item 2
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    unable_to_refund
    Verify item status on FMS    ${item_id[1][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    customer_cancelled    ${pcms_email}
    #item 3
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    unable_to_refund
    Verify item status on FMS    ${item_id[2][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    customer_cancelled    ${pcms_email}
    #item 4
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${item_id[3][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    None
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${item_id[3][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    delivered    ${pcms_email}
    Verify item status on FMS is not cancel    ${item_id[3][0]}
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by api    ${item_id[0][0]}    ${item_status_db_return_rejected}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    4
    [Teardown]    Close All Browsers

TC_ITMWM_02608 COD - Save all - To verify that system doesn't change item status from Return Rejected to another status if user change item status of another item from Order Pending to Customer Cancelled.
    [Tags]    regression    TC_ITMWM_02608    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}
    ${order_id}=    Guest Buy Product Success with COD by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    delivered
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    sleep    3s
    # FMS return rejected
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    shipped
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    shipped
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    delivered
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    customer_cancelled
    TrackOrder - Click save all
    #item 5
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    unable_to_refund
    Verify item status on FMS    ${item_id[4][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[4][0]}    customer_cancelled    ${pcms_email}
    #item 2
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    unable_to_refund
    Verify item status on FMS    ${item_id[1][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    customer_cancelled    ${pcms_email}
    #item 3
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    unable_to_refund
    Verify item status on FMS    ${item_id[2][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    customer_cancelled    ${pcms_email}
    #item 4
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${item_id[3][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    None
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${item_id[3][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    delivered    ${pcms_email}
    Verify item status on FMS is not cancel    ${item_id[3][0]}
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by api    ${item_id[0][0]}    ${item_status_db_return_rejected}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    4
    [Teardown]    Close All Browsers

TC_ITMWM_02609 COD - Save - To verify that system doesn't change item status from Return Rejected to another status if user change item status of another item from Shipped to Cancel Pending.
    [Tags]    regression    TC_ITMWM_02609    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}
    ${order_id}=    Guest Buy Product Success with COD by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    delivered
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    sleep    3s
    # FMS return rejected
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    shipped
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    shipped
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    delivered
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    cancel_pending
    TrackOrder - Click save    ${item_id[2][0]}
    #item 5
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    unable_to_refund
    Verify item status on FMS    ${item_id[4][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[4][0]}    customer_cancelled    ${pcms_email}
    #item 2
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    unable_to_refund
    Verify item status on FMS    ${item_id[1][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    customer_cancelled    ${pcms_email}
    #item 3
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    cancel_pending
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    Verify item status on FMS is not cancel    ${item_id[2][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    cancel_pending    ${pcms_email}
    #item 4
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${item_id[3][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    None
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${item_id[3][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    delivered    ${pcms_email}
    Verify item status on FMS is not cancel    ${item_id[3][0]}
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by api    ${item_id[0][0]}    ${item_status_db_return_rejected}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    4
    # 3
    [Teardown]    Close All Browsers

TC_ITMWM_02610 COD - Save all - To verify that system doesn't change item status from Return Rejected to another status if user change item status of another item from Shipped to Cancel Pending.
    [Tags]    regression    TC_ITMWM_02610    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}
    ${order_id}=    Guest Buy Product Success with COD by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    shipped
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    shipped
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    delivered
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    delivered
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}

    # FMS return rejected
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[2][0]}    cancel_pending
    TrackOrder - Click save all
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    unable_to_refund
    Verify item status on FMS    ${item_id[4][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[4][0]}    customer_cancelled    ${pcms_email}
    #item 2
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    unable_to_refund
    Verify item status on FMS    ${item_id[1][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    customer_cancelled    ${pcms_email}
    #item 3
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    cancel_pending
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    Verify item status on FMS is not cancel    ${item_id[2][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    cancel_pending    ${pcms_email}
    #item 4
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${item_id[3][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    None
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${item_id[3][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    delivered    ${pcms_email}
    Verify item status on FMS is not cancel    ${item_id[3][0]}
    #item 5
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_return_rejected}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    4
    [Teardown]    Close All Browsers

TC_ITMWM_02611 COD - Save - To verify that system doesn't change item status from Return Rejected to another status if user change item status of another item from Delivered to Customer Cancelled.
    [Tags]    regression    TC_ITMWM_02611    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}
    ${order_id}=    Guest Buy Product Success with COD by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    shipped
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    shipped
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    delivered
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    delivered
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}

    # FMS return rejected
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[3][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[3][0]}
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    Order Pending
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    None
    TrackOrder - Check Payment Status on UI    ${item_id[4][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[4][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    none
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[4][0]}    order_pending
    Verify item status on FMS is not cancel    ${item_id[4][0]}
    #item 2
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Pending Shipment
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    pending_shipment
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    pending_shipment    ${pcms_email}
    #item 3
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    shipped
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    Verify item status on FMS is not cancel    ${item_id[2][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    shipped    ${pcms_email}
    #item 4
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    customer_cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[3][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[3][0]}    success
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    customer_cancelled    ${pcms_email}
    Verify item status on FMS    ${item_id[3][0]}    cancelled
    #item 5
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_return_rejected}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02612 COD - Save all - To verify that system doesn't change item status from Return Rejected to another status if user change item status of another item from Delivered to Customer Cancelled.
    [Tags]    regression    TC_ITMWM_02612    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}    ${default_inventoryID_cod}
    ${order_id}=    Guest Buy Product Success with COD by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    shipped
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    shipped
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    delivered
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    delivered
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}

    # FMS return rejected
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[3][0]}    customer_cancelled
    TrackOrder - Click save all
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    Order Pending
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    None
    TrackOrder - Check Payment Status on UI    ${item_id[4][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[4][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    none
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[4][0]}    order_pending
    Verify item status on FMS is not cancel    ${item_id[4][0]}
    #item 2
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Pending Shipment
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    pending_shipment
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    pending_shipment    ${pcms_email}
    #item 3
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    shipped
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    Verify item status on FMS is not cancel    ${item_id[2][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    shipped    ${pcms_email}
    #item 4
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    customer_cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[3][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[3][0]}    success
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    customer_cancelled    ${pcms_email}
    Verify item status on FMS    ${item_id[3][0]}    cancelled
    #item 5
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_return_rejected}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02613 CS - Save - To verify that system doesn't change item status from Return Rejected to another status if user change item status of another item from Order Pending to Customer Cancelled.
    [Tags]    regression    TC_ITMWM_02613    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}
    ${order_id}=    Guest Buy Product Success with CS by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    shipped
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    shipped
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    delivered
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    delivered
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}

    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${item_id[4][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[4][0]}
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    customer_cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[4][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[4][0]}    success
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${item_id[4][0]}    customer_cancelled    ${pcms_email}
    Verify item status on FMS    ${item_id[4][0]}    cancelled
    #item 2
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Pending Shipment
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    pending_shipment
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    pending_shipment    ${pcms_email}
    #item 3
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    shipped
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    Verify item status on FMS is not cancel    ${item_id[2][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    shipped    ${pcms_email}
    #item 4
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${item_id[3][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    None
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${item_id[3][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    delivered    ${pcms_email}
    Verify item status on FMS is not cancel    ${item_id[3][0]}
    #item 5
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_return_rejected}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02614 CS - Save all - To verify that system doesn't change item status from Return Rejected to another status if user change item status of another item from Shipped to Cancel Pending.
    [Tags]    regression    TC_ITMWM_02614    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}
    ${order_id}=    Guest Buy Product Success with CS by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    shipped
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    shipped
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    delivered
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    delivered
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}

    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${item_id[2][0]}    cancel_pending
    TrackOrder - Click save all
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    Order Pending
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    None
    TrackOrder - Check Payment Status on UI    ${item_id[4][0]}    Success
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[4][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    none
    Verify item status on FMS is not cancel    ${item_id[4][0]}
    #item 2
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Pending Shipment
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    pending_shipment
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    pending_shipment    ${pcms_email}
    #item 3
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    cancel_pending
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    Verify item status on FMS is not cancel    ${item_id[2][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    cancel_pending    ${pcms_email}
    #item 4
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${item_id[3][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    None
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${item_id[3][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    delivered    ${pcms_email}
    Verify item status on FMS is not cancel    ${item_id[3][0]}
    #item 5
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_return_rejected}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02615 CCW - Save - To verify that system doesn't change item status from Return Rejected to another status if user change item status of another item from Shipped to Customer Cancelled.
    [Tags]    regression    TC_ITMWM_02615    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}
    ${order_id}=    Guest Buy Product Success with CCW by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    shipped
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    shipped
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    delivered
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    delivered
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}

    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${item_id[2][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[2][0]}
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    Order Pending
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    None
    TrackOrder - Check Payment Status on UI    ${item_id[4][0]}    Success
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[4][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    none
    Verify item status on FMS is not cancel    ${item_id[4][0]}
    #item 2
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Pending Shipment
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    pending_shipment
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    pending_shipment    ${pcms_email}
    #item 3
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    customer_cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[2][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[2][0]}    success
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    customer_cancelled    ${pcms_email}
    Verify item status on FMS    ${item_id[2][0]}    cancelled
    #item 4
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${item_id[3][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    None
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${item_id[3][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    delivered    ${pcms_email}
    Verify item status on FMS is not cancel    ${item_id[3][0]}
    #item 5
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_return_rejected}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02616 CCW - Save - To verify that system doesn't change item status from Return Rejected to another status if user change item status of another item from Shipped to Customer Cancelled.
    [Tags]    regression    TC_ITMWM_02616    WLS_High
    ${inv_ids}=    Create List    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}
    ${order_id}=    Guest Buy Product Success with CCW by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    shipped
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    shipped
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    delivered
    TrackOrder - Click save    ${item_id[3][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    delivered
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}

    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${item_id[3][0]}    customer_cancelled
    TrackOrder - Click save all
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    Order Pending
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    None
    TrackOrder - Check Payment Status on UI    ${item_id[4][0]}    Success
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[4][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    none
    Verify item status on FMS is not cancel    ${item_id[4][0]}
    #item 2
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Pending Shipment
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    pending_shipment
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    pending_shipment    ${pcms_email}
    #item 3
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    shipped
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    Verify item status on FMS is not cancel    ${item_id[2][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    shipped    ${pcms_email}
    #item 4
    TrackOrder - Check Item Status on UI    ${item_id[3][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[3][0]}    customer_cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[3][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[3][0]}    success
    TrackOrder - Check Operation Status on UI    ${item_id[3][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${item_id[3][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${item_id[3][0]}    customer_cancelled    ${pcms_email}
    Verify item status on FMS    ${item_id[3][0]}    cancelled
    #item 5
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    ${item_status_db_return_rejected}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

ITMB_1924_038 CS - Mutiple items - Change some item - Verify Dropdown Item Status
    [Tags]    ITMB_1924    ITMB_1924_038
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # set all item to Return Received
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
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    1
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_received}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    # FMS return rejected
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}    SR111    1
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # 1st
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Element Should Not Be Visible    id=status_item${item_id[0][0]}
    # 2nd
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    Element Should Be Visible    id=status_item${item_id[1][0]}
    [Teardown]    Close All Browsers
