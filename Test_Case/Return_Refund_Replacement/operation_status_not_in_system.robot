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
TC_ITMWM_02842 shipped, delivered : delivered => customer cancelled : operation status = Not in system : payment channel = CCW
    [Tags]    Regression    Ready    TC_ITMWM_02842    TC_iTM_1754_107
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID}
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[1][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    not_in_system
    TrackOrder - Click save    ${item_id[1][0]}
    # verify 1st item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    shipped
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    Verify item status on FMS is not cancel    ${item_id[0][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    shipped    ${pcms_email}
    # verify 2nd items should be Delivered
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    Not in System
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    not_in_system
    Verify item status on FMS    ${item_id[1][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    customer_cancelled    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02846 shipped, order pending, delivered : delivered => customer cancelled : : operation status = Not in system : payment channel = CS
    [Tags]    Regression    Ready    TC_ITMWM_02846    TC_iTM_1754_111
    ${inv_ids}=    Create List    ${default_inventoryID_cs}    ${default_inventoryID_cs}    ${default_inventoryID_cs}
    ${order_id}=    Guest Buy Product Success with CS by Inventory Id List    ${email}    ${inv_ids}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # set 1st item status until Shipped
    TrackOrder - Set Item status    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    shipped
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    # 2nd item is Order Pending
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    order_pending
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    # set 3rd item to Delivered
    TrackOrder - Set Item status    ${item_id[2][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    shipped
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Set Item status    ${item_id[2][0]}    delivered
    TrackOrder - Click save    ${item_id[2][0]}
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    delivered
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    # customer cancelled 3nd item
    TrackOrder - Set Item status    ${item_id[2][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[2][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[2][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[2][0]}    not_in_system
    TrackOrder - Click save    ${item_id[2][0]}
    # verify 1st items should be Shipped
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    shipped
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    Verify item status on FMS is not cancel    ${item_id[0][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    shipped    ${pcms_email}
    # verify 2nd items should be Delivered
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    order_pending
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    Verify item status on FMS is not cancel    ${item_id[1][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    order_pending    ${pcms_email}
    # verify 3rd item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    Not in System
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    not_in_system
    Verify item status on FMS    ${item_id[2][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    customer_cancelled    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    None
    # ------------------ Toey ------------------
    [Teardown]    Close All Browsers

TC_ITMWM_02817 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item B status to Customer Cancelled and Operation Status = Not in system if payment channel = COD and current item A = Order Pending and B status = Delivered.
    [Tags]    Regression    Ready    TC_ITMWM_02817
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
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[1][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    order_pending
    Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02818 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to Customer Cancelled and Operation Status = Not in system if payment channel = COD and current item A = Delivered and B status = Pending Shipment.
    [Tags]    Regression    Ready    TC_ITMWM_02818
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
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02819 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to Customer Cancelled and Operation Status = Not in system if payment channel = COD and current item A = Delivered and B status = Shipped.
    [Tags]    Regression    Ready    TC_ITMWM_02819
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
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02820 Multiple items - Change item status some item - Save button - To verify that system can change item status correctly when change item A status to Customer Cancelled and Operation Status = Not in system if payment channel = COD and current item A = Delivered and B status = Cancel Pending.
    [Tags]    Regression    Ready    TC_ITMWM_02820
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
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02821 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item B status to Customer Cancelled and Operation Status = Not in system if payment channel = COD and current item A = Order Pending and B status = Delivered.
    [Tags]    Regression    Ready    TC_ITMWM_02821
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
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[1][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save all
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    order_pending
    Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02822 Multiple items - Change item status some item - Save All button - Change item A status to Customer Cancelled and Operation Status = Not in system if payment channel = COD and current item A = Delivered and B status = Pending Shipment.
    [Tags]    Regression    Ready    TC_ITMWM_02822
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
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save all
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Pending Shipment
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02823 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item A status to Customer Cancelled and Operation Status = Not in system if payment channel = COD and current item A = Delivered and B status = Shipped.
    [Tags]    Regression    Ready    TC_ITMWM_02823
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
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save all
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Shipped
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02824 Multiple items - Change item status some item - Save All button - To verify that system can change item status correctly when change item A status to Customer Cancelled and Operation Status = Not in system if payment channel = COD and current item A = Delivered and B status = Cancel Pending.
    [Tags]    Regression    Ready    TC_ITMWM_02824
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
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save all
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    #    ITEM 1
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    #    ITEM 2
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02825 Multiple items - Change item status all item - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Not in system if payment channel = CCW.
    [Tags]    Regression    Ready    TC_ITMWM_02825
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID}
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[0][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[1][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02826 Multiple items - Change item status all item - Save all button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Not in system if payment channel = CCW.
    [Tags]    Regression    Ready    TC_ITMWM_02826
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID}
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[0][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[1][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save all
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02827 Multiple items - Change item status all item - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Not in system if payment channel = CS.
    [Tags]    Regression    Ready    TC_ITMWM_02827
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${order_id}
    Log To Console    ${order_shipment_data}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[0][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[1][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02828 Multiple items - Change item status all item - Save all button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Not in system if payment channel = CS.
    [Tags]    Regression    Ready    TC_ITMWM_02828
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${order_id}
    Log To Console    ${order_shipment_data}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Click save all
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[0][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[1][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save all
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02829 Multiple items - Change item status all item - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Not in system if payment channel = COD.
    [Tags]    Regression    Ready    TC_ITMWM_02829
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
    Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[1][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02830 Multiple items - Change item status all item - Save all button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Not in system if payment channel = COD.
    [Tags]    Regression    Ready    TC_ITMWM_02830
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
    Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[0][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[1][0]}    COD    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save all
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02831 Multiple items - Change item status all item - To verify that item status can change from Cancel Pending to Delivered and to Customer Cancelled if payment channel = CS.
    [Tags]    Regression    Ready    TC_ITMWM_02831
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${order_id}
    Log To Console    ${order_shipment_data}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[0][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${order_shipment_data[1][0]}    CS    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${order_shipment_data[1][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${order_shipment_data[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    # ------------------ Cing ------------------
    [Teardown]    Close All Browsers

TC_ITMWM_02807 Single item - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Not in system if payment channel = CCW.
    [Tags]    Regression    Ready    TC_ITMWM_02807
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
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_not_in_system}
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02808 Single item - Save all button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Not in system if payment channel = CCW.
    [Tags]    Regression    Ready    TC_ITMWM_02808
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
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02809 Single item - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Not in system if payment channel = CS.
    [Tags]    Regression    Ready    TC_ITMWM_02809
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
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02810 Single item - Save all button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Not in system if payment channel = CS.
    [Tags]    Regression    Ready    TC_ITMWM_02810
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
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02811 Single item - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Not in system if payment channel = COD.
    [Tags]    Regression    Ready    TC_ITMWM_02811
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
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02812 Single item - Save all button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Not in system if payment channel = COD.
    [Tags]    Regression    Ready    TC_ITMWM_02812
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
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02813 Multiple items - Change item status some item - Save button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Not in system if payment channel = CCW.
    [Tags]    Regression    Ready    TC_ITMWM_02813
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
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02814 Multiple items - Change item status some item - Save All button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Not in system if payment channel = CCW.
    [Tags]    Regression    Ready    TC_ITMWM_02814
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
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02815 Multiple items - Change item status some item - Save button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Not in system if payment channel = CS.
    [Tags]    Regression    Ready    TC_ITMWM_02815
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
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02816 Multiple items - Change item status some item - Save All button - To verify that item status can change from Delivered to Customer Cancelled and Operation Status = Not in system if payment channel = CS.
    [Tags]    Regression    Ready    TC_ITMWM_02816
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
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_not_in_system}
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers
