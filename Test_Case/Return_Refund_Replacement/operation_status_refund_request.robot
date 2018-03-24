*** Settings ***
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
TC_iTM_1754_108 shipped, order pending, delivered : delivered => customer cancelled : operation status = Refund Request : payment channel = CCW
    [Tags]    TC_iTM_1754    TC_iTM_1754_108
    ${inv_ids}=    Create List    ${default_inventoryID}    ${default_inventoryID}    ${default_inventoryID}
    ${order_id}=    Guest Buy Product Success with CCW by Inventory Id List    ${email}    ${inv_ids}
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
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[2][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[2][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[2][0]}    refund_request
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
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[1][0]}    order_pending
    # verify 3rd item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    refund_request
    Verify item status on FMS    ${item_id[2][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    customer_cancelled    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[2][0]}    4
    [Teardown]    Close All Browsers

TC_iTM_1754_112 delivered, cancel pending : delivered => customer cancelled : operation status = Refund Request : payment channel = CS
    [Tags]    TC_iTM_1754    TC_iTM_1754_112
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    # set 1st item status until Delivered
    TrackOrder - Set Item status    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status    ${item_id[0][0]}    delivered
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    delivered
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    # set 1st item status until Cancel Pending
    TrackOrder - Set Item status    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    shipped
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status    ${item_id[1][0]}    cancel_pending
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    cancel_pending
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    # customer cancelled 1st item
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    ${ui_operation_status}=    TrackerOrder - Get Available Operation Status List    ${item_id[0][0]}    CCW    success    delivered
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${ui_operation_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    refund_request
    TrackOrder - Click save    ${item_id[0][0]}
    # verify 1st item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    refund_request
    Verify item status on FMS    ${item_id[0][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    customer_cancelled    ${pcms_email}
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
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers
