*** Settings ***
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Track_Order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Item_status/update_item_status.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Order/WebElement_order.robot
Resource          ${CURDIR}/../../../Keyword/API/FMS/FMS_ORDER.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Order_together/keywords_order_together.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot

*** Variable ***
${email}          guest@email.com
${material_id}    robot_material_id_123
${serial_number}    123456
${pcms_email}     admin@domain.com
${pcms_password}    12345

*** Test Cases ***
ITMB_1922_015 CCW - Single item - Save To verify that user can change item status from Return Pending to Return Failed successfully.
    [Tags]    ITMB_1922_015    ready
    #####FEEL######
    ${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID}
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    Sleep    3s
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

ITMB_1922_016 CCW - Single item - Save - To verify that user can change item status from Return Pending to Return Failed successfully.
    [Tags]    ITMB_1922_016    ready
    ${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID}
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

ITMB_1922_017 CS - Single item - Save - To verify that user can change item status from Return Pending to Return Failed successfully.
    [Tags]    ITMB_1922_017    ready
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

ITMB_1922_018 CS - Single item - Save all - To verify that user can change item status from Return Pending to Return Failed successfully.
    [Tags]    ITMB_1922_018    ready
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

ITMB_1922_019 COD - Single item - Save - To verify that user can change item status from Return Pending to Return Failed successfully.
    [Tags]    ITMB_1922_019    ready
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    21
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

ITMB_1922_020 COD - Single item - Save - To verify that user can change item status from Return Pending to Return Failed successfully.
    [Tags]    ITMB_1922_020    ready
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

ITMB_1922_021 CCW - Mutiple items - Change some item - Save - To verify that user can change item status from Return Pending to Return Failed successfully.
    [Tags]    ITMB_1922_021    ready
    ${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID}
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

ITMB_1922_022 CCW - Mutiple items - Change some item - Save all - To verify that user can change item status from Return Pending to Return Failed successfully.
    [Tags]    ITMB_1922_022    ready
    ${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID}
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

ITMB_1922_023 CS - Mutiple items - Change some item - Save - To verify that user can change item status from Return Pending to Return Failed successfully.
    [Tags]    ITMB_1922_023    ready
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

ITMB_1922_024 CS - Mutiple items - Change some item - Save all - To verify that user can change item status from Return Pending to Return Failed successfully.
    [Tags]    ITMB_1922_024    ready
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

ITMB_1922_025 COD - Mutiple items - Change some item - Save] - To verify that user can change item status from Return Pending to Return Failed successfully.
    [Tags]    ITMB_1922_025    ready
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    21
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

ITMB_1922_026 CS - Mutiple items - Change some item - Save all] - To verify that user can change item status from Return Pending to Return Failed successfully.
    [Tags]    ITMB_1922_026    ready
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

ITMB_1922_027 CCW - Mutiple items - Change all items - Save] - To verify that user can change item status from Return Pending to Return Failed successfully.
    [Tags]    ITMB_1922_027    ready
    ${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID}
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    21
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    21
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

ITMB_1922_028 CCW - Mutiple items - Change all items - Save all] - To verify that user can change item status from Return Pending to Return Failed successfully.
    [Tags]    ITMB_1922_028    ready
    ${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID}
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    21
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    21
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

ITMB_1922_029 CS - Mutiple items - Change all items - Save] - To verify that user can change item status from Return Pending to Return Failed successfully.
    [Tags]    ITMB_1922_029    ready
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    21
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    21
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

ITMB_1922_030 CS - Mutiple items - Change all items - Save all] - To verify that user can change item status from Return Pending to Return Failed successfully.
    [Tags]    ITMB_1922_030    ready
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    21
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    21
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

ITMB_1922_031 COD - Mutiple items - Change all items - Save] - To verify that user can change item status from Return Pending to Return Failed successfully.
    [Tags]    ITMB_1922_031    ready
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    21
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    21
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

ITMB_1922_032 COD - Mutiple items - Change all items - Save all] - To verify that user can change item status from Return Pending to Return Failed successfully.
    [Tags]    ITMB_1922_032    ready
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    21
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    21
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_delivered}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    ######################################
    ##############TONY####################
    [Teardown]    Close All Browsers

ITMB_1922_034 COD - Save - To verify that system doesn't change item status from Return Failed to another status if user change item status of another item from Order Pending to Customer Cancelled.
    [Tags]    ITMB_1922_034    ready
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
    TrackOrder - Set Item status    ${item_id[4][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    shipped
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    delivered
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    unable_to_refund
    Verify item status on FMS    ${item_id[0][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    customer_cancelled    ${pcms_email}
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
    #item 5
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_delivered}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

ITMB_1922_035 COD - Save all - To verify that system doesn't change item status from Return Failed to another status if user change item status of another item from Order Pending to Customer Cancelled.
    [Tags]    ITMB_1922_035    ready
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
    TrackOrder - Set Item status    ${item_id[4][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    shipped
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    delivered
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save all
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    unable_to_refund
    Verify item status on FMS    ${item_id[0][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    customer_cancelled    ${pcms_email}
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
    #item 5
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_delivered}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

ITMB_1922_036 COD - Save - To verify that system doesn't change item status from Return Failed to another status if user change item status of another item from Shipped to Cancel Pending.
    [Tags]    ITMB_1922_036    ready
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
    TrackOrder - Set Item status    ${item_id[4][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    shipped
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    delivered
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    cancel_pending
    TrackOrder - Click save    ${item_id[2][0]}
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    unable_to_refund
    Verify item status on FMS    ${item_id[0][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    customer_cancelled    ${pcms_email}
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
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_delivered}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

ITMB_1922_037 COD - Save all - To verify that system doesn't change item status from Return Failed to another status if user change item status of another item from Shipped to Cancel Pending.
    [Tags]    ITMB_1922_037    ready
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
    TrackOrder - Set Item status    ${item_id[4][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    shipped
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    delivered
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    cancel_pending
    TrackOrder - Click save all
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    unable_to_refund
    Verify item status on FMS    ${item_id[0][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    customer_cancelled    ${pcms_email}
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
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_delivered}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

ITMB_1922_038 COD - Save - To verify that system doesn't change item status from Return Failed to another status if user change item status of another item from Delivered to Customer Cancelled.
    [Tags]    ITMB_1922_038    ready
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
    TrackOrder - Set Item status    ${item_id[4][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    shipped
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    delivered
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[3][0]}
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    order_pending
    Verify item status on FMS is not cancel    ${item_id[0][0]}
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
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_delivered}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

ITMB_1922_039 COD - Save all - To verify that system doesn't change item status from Return Failed to another status if user change item status of another item from Delivered to Customer Cancelled.
    [Tags]    ITMB_1922_039    ready
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
    TrackOrder - Set Item status    ${item_id[4][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    shipped
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    delivered
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    customer_cancelled
    TrackOrder - Click save all
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[0][0]}    order_pending
    Verify item status on FMS is not cancel    ${item_id[0][0]}
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
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_delivered}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

ITMB_1922_040 CS - Save - To verify that system doesn't change item status from Return Failed to another status if user change item status of another item from Order Pending to Customer Cancelled.
    [Tags]    ITMB_1922_040    ready
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
    TrackOrder - Set Item status    ${item_id[4][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    shipped
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    delivered
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    customer_cancelled    ${pcms_email}
    Verify item status on FMS    ${item_id[0][0]}    cancelled
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
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_delivered}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

ITMB_1922_041 CS - Save all - To verify that system doesn't change item status from Return Failed to another status if user change item status of another item from Shipped to Cancel Pending.
    [Tags]    ITMB_1922_041    ready
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
    TrackOrder - Set Item status    ${item_id[4][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    shipped
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    delivered
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    cancel_pending
    TrackOrder - Click save all
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    Verify item status on FMS is not cancel    ${item_id[0][0]}
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
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_delivered}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

ITMB_1922_042 CCW - Save - To verify that system doesn't change item status from Return Failed to another status if user change item status of another item from Shipped to Customer Cancelled.
    [Tags]    ITMB_1922_042    ready
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
    TrackOrder - Set Item status    ${item_id[4][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    shipped
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    delivered
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[2][0]}
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    Verify item status on FMS is not cancel    ${item_id[0][0]}
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
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_delivered}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    [Teardown]    Close All Browsers

ITMB_1922_043 CCW - Save - To verify that system doesn't change item status from Return Failed to another status if user change item status of another item from Shipped to Customer Cancelled.
    [Tags]    ITMB_1922_043    ready
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
    TrackOrder - Set Item status    ${item_id[4][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    shipped
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    delivered
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    customer_cancelled
    TrackOrder - Set Operation Status    ${item_id[4][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[4][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[4][0]}
    TrackOrder - Set Item status    ${item_id[3][0]}    customer_cancelled
    TrackOrder - Click save all
    #item 1
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    Verify item status on FMS is not cancel    ${item_id[0][0]}
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
    TrackOrder - Check Item Status on UI    ${item_id[4][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[4][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[4][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[4][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[4][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[4][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[4][0]}    ${item_status_fms_delivered}
    # verify order together
    Open PCMS And Sync Order Together
    Sleep    5s
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[3][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[4][0]}    None
    ############################
    [Teardown]    Close All Browsers

ITMWM_02851 COD - Single item - Save all] - To verify that user can change item status from Return Pending to Return Failed successfully and can continue cancellation process from Delivered to Customer Cancelled.
    [Tags]    ITMWM_02851    itma-3222    itm-a-sprint 2016S15    regression    ready
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    21
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}

    # cancel order again
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}

    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

ITMWM_02852 COD - Single item - Save] - To verify that user can change item status from Return Pending to Return Failed successfully and can continue replacement pending process from Delivered to Replacement Pending.
    [Tags]    ITMWM_02852    itma-3222    itm-a-sprint 2016S15    regression    ready
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    21
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_delivered}    ${item_status_db_return_failed}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}

    # continue replacement pending
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_replacement_pending}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_replacement_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_replacement_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_replacement_pending}    ${item_status_db_delivered}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_failed}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_delivered}

    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers
