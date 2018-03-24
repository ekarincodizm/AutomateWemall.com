*** Settings ***
Force Tags    WLS_Return_Refund_Replacement
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/API/FMS/FMS_ORDER.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Order_together/keywords_order_together.robot
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot

*** Variable ***
${email}          guest@email.com
${pcms_email}     admin@domain.com
${pcms_password}    12345
${inventory_id}    INAAC1112611

*** Test Cases ***
TC_ITMWM_02782 Single item - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Return Refund Request if payment channel = CCW.
    [Tags]    Regression    Ready    TC_ITMWM_02782    TC_iTM_1754_40
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
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
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02783 Single item - Save all button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Return Refund Request if payment channel = CCW.
    [Tags]    Regression    Ready    TC_ITMWM_02783    TC_iTM_1754_41
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
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
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02784 Single item - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Return Refund Request if payment channel = CS.
    [Tags]    Regression    Ready    TC_ITMWM_02784    TC_iTM_1754_42
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
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
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02785 Single item - Save all button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Return Refund Request if payment channel = CS.
    [Tags]    Regression    Ready    TC_ITMWM_02785    TC_iTM_1754_43
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
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
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02786 Single item - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Return Refund Request if payment channel = COD.
    [Tags]    Regression    Ready    TC_ITMWM_02786    TC_iTM_1754_44
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
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
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02787 Single item - Save all button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Return Refund Request if payment channel = COD.
    [Tags]    Regression    Ready    TC_ITMWM_02787    TC_iTM_1754_45
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
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
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02788 Multiple items - Change item status some item - Save button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Return Refund Request if payment channel = CCW.
    [Tags]    Regression    Ready    TC_ITMWM_02788    TC_iTM_1754_46
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02789 Multiple items - Change item status some item - Save All button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Return Refund Request if payment channel = CCW.
    [Tags]    Regression    Ready    TC_ITMWM_02789    TC_iTM_1754_47
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02790 Multiple items - Change item status some item - Save button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Return Refund Request if payment channel = CS.
    [Tags]    Regression    Ready    TC_ITMWM_02790    TC_iTM_1754_48
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02791 Multiple items - Change item status some item - Save All button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Return Refund Request if payment channel = CS.
    [Tags]    Regression    Ready    TC_ITMWM_02791    TC_iTM_1754_49
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02792 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item B status to Customer Cancelled and Operation Status = Return Refund Request if payment channel = COD and current item A = Order Pending and B status = Delivered.
    [Tags]    Regression    Ready    TC_ITMWM_02792    TC_iTM_1754_50
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02793 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to Customer Cancelled and Operation Status = Return Refund Request if payment channel = COD and current item A = Delivered and B status = Pending Shipment.
    [Tags]    Regression    Ready    TC_ITMWM_02793    TC_iTM_1754_51
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02794 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to Customer Cancelled and Operation Status = Return Refund Request if payment channel = COD and current item A = Delivered and B status = Shipped.
    [Tags]    Regression    Ready    TC_ITMWM_02794    TC_iTM_1754_52
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02795 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to Customer Cancelled and Operation Status = Return Refund Request if payment channel = COD and current item A = Delivered and B status = Cancel Pending.
    [Tags]    Regression    Ready    TC_ITMWM_02795    TC_iTM_1754_53
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    2
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_cancel_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02796 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item B status to Customer Cancelled and Operation Status = Return Refund Request if payment channel = COD and current item A = Order Pending and B status = Delivered.
    [Tags]    Regression    Ready    TC_ITMWM_02796    TC_iTM_1754_54
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02797 Multiple items - Change item status some item - Save All button - Change item A status to Customer Cancelled and Operation Status = Return Refund Request if payment channel = COD and current item A = Delivered and B status = Pending Shipment.
    [Tags]    Regression    Ready    TC_ITMWM_02797    TC_iTM_1754_55
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02798 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item A status to Customer Cancelled and Operation Status = Return Refund Request if payment channel = COD and current item A = Delivered and B status = Shipped.
    [Tags]    Regression    Ready    TC_ITMWM_02798    TC_iTM_1754_56
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_shipped}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02799 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item A status to Customer Cancelled and Operation Status = Return Refund Request if payment channel = COD and current item A = Delivered and B status = Cancel Pending.
    [Tags]    Regression    Ready    TC_ITMWM_02799    TC_iTM_1754_57
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    2
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_cancel_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_cancel_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    Verify item status on FMS should not be    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02800 Multiple items - Change item status all item - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Return Refund Request if payment channel = CCW.
    [Tags]    Regression    Ready    TC_ITMWM_02800    TC_iTM_1754_58
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    1
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[1][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02801 Multiple items - Change item status all item - Save all button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Return Refund Request if payment channel = CCW.
    [Tags]    Regression    Ready    TC_ITMWM_02801    TC_iTM_1754_59
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    1
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[1][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02802 Multiple items - Change item status all item - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Return Refund Request if payment channel = CS.
    [Tags]    Regression    Ready    TC_ITMWM_02802    TC_iTM_1754_60
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    1
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[1][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02803 Multiple items - Change item status all item - Save all button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Return Refund Request if payment channel = CS.
    [Tags]    Regression    Ready    TC_ITMWM_02803    TC_iTM_1754_61
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
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    1
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    1
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[1][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02804 Multiple items - Change item status all item - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Return Refund Request if payment channel = COD.
    [Tags]    Regression    Ready    TC_ITMWM_02804    TC_iTM_1754_62
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    1
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[1][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02805 Multiple items - Change item status all item - Save all button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Return Refund Request if payment channel = COD.
    [Tags]    Regression    Ready    TC_ITMWM_02805    TC_iTM_1754_63
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    1
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[1][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02806 Multiple items - Change item status all item - To verify that item status can change from Cancel Pending to Delivered and to Customer Cancelled if payment channel = CS.
    [Tags]    Regression    Ready    TC_ITMWM_02806    TC_iTM_1754_64
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[1][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[0][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[0][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[0][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    ${item_status_db_return_pending}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    ${operation_db_return_refund_request}
    Verify item status on FMS    ${item_id[1][0]}    ${item_status_fms_return_pending}
    TrackOrder - Verify Log OrderShipment Two Status by User    ${item_id[1][0]}    ${item_status_db_return_pending}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log Api Send Item Status by Item Id    ${item_id[1][0]}    ${item_status_db_return_pending}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02832 [Single item - Click save] To verify error message 'Operation status is required.' when user change item status from delivered to customer cancelled and operation status is null. (via CCW)
    [Tags]    Regression    Ready    TC_ITMWM_02832    TC_iTM_1754_90
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
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
    TrackOrder - Set Item status No Auto Set Other    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    System: Can not use coupon
    TrackOrder - Click save not confirm action    ${item_id[0][0]}
    TrackOrder - Verify Operation Status No Select
    [Teardown]    Close All Browsers

TC_ITMWM_02833 [Single item - Click save all] To verify error message 'Operation status is required.' when user change item status from delivered to customer cancelled and operation status is null. (via CCW)
    [Tags]    Regression    Ready    TC_ITMWM_02833    TC_iTM_1754_91
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
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
    TrackOrder - Set Item status No Auto Set Other    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    18
    TrackOrder - Click save all not confirm action
    TrackOrder - Verify Operation Status No Select
    [Teardown]    Close All Browsers

TC_ITMWM_02834 [Multiple item - cancel some item - Click save] To verify error message 'Operation status is required.' when user change item status from delivered to customer cancelled and operation status is null. (via CCW)
    [Tags]    Regression    Ready    TC_ITMWM_02834    TC_iTM_1754_92
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
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
    TrackOrder - Set Item status No Auto Set Other    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    18
    TrackOrder - Click save not confirm action    ${item_id[0][0]}
    TrackOrder - Verify Operation Status No Select
    [Teardown]    Close All Browsers

TC_ITMWM_02835 [Multiple item - cancel some item - Click save all] To verify error message 'Operation status is required.' when user change item status from delivered to customer cancelled and operation status is null. (via CCW)
    [Tags]    Regression    Ready    TC_ITMWM_02835    TC_iTM_1754_93
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
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
    TrackOrder - Set Item status No Auto Set Other    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    18
    TrackOrder - Click save all not confirm action
    TrackOrder - Verify Operation Status No Select
    [Teardown]    Close All Browsers

TC_ITMWM_02836 [Multiple item - cancel all item - Click save] To verify error message 'Operation status is required.' when user change item status from delivered to customer cancelled and operation status is null. (via CCW)
    [Tags]    Regression    Ready    TC_ITMWM_02836    TC_iTM_1754_94
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
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
    TrackOrder - Set Item status No Auto Set Other    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    18
    TrackOrder - Set Item status No Auto Set Other    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    17
    TrackOrder - Click save not confirm action    ${item_id[0][0]}
    TrackOrder - Verify Operation Status No Select
    [Teardown]    Close All Browsers

TC_ITMWM_02837 [Multiple item - cancel all item - Click save all] To verify error message 'Operation status is required.' when user change item status from delivered to customer cancelled and operation status is null. (via CCW)
    [Tags]    Regression    Ready    TC_ITMWM_02837    TC_iTM_1754_95
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
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
    TrackOrder - Set Item status No Auto Set Other    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    18
    TrackOrder - Set Item status No Auto Set Other    ${item_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    17
    TrackOrder - Click save all not confirm action
    TrackOrder - Verify Operation Status No Select
    [Teardown]    Close All Browsers

TC_ITMWM_02844 delivered, cancel pending : delivered => customer cancelled : operation status = Return Refund Request : payment channel = CCW
    [Tags]    Regression    Ready    TC_ITMWM_02844    TC_iTM_1754_109
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID}
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # set 1st item status until Shipped
    TrackOrder - Set Item status    ${item_id[0][0]}    pending_shipment
    TrackOrder - Set Item status    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    shipped
    TrackOrder - Set Item status    ${item_id[1][0]}    shipped
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    delivered
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    cancel_pending
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    delivered
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    # 2nd item is Order Pending
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    cancel_pending
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    # customer cancelled 1st item
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    return_refund_request
    TrackOrder - Click save    ${item_id[0][0]}
    # verify 1st items should be Return Pending
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Return Pending
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    return_pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    Return Refund Request
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    return_refund_request
    Verify item status on FMS    ${item_id[0][0]}    return pending
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    return_pending    ${pcms_email}
    # verify 2nd items should be Cancel Pending
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    cancel_pending
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    cancel_pending    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers
