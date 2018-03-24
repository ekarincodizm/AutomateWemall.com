*** Settings ***
Force Tags    WLS_PCMS_Order
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

*** Test Cases ***
TC_ITMWM_02414 shipped, delivered : shipped => customer cancelled
    [Tags]     regression    ready    TC_ITMWM_02414    WLS_High
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
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    # verify 1st item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    unable_to_refund
    #C#Verify item status on FMS    ${item_id[0][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    customer_cancelled    ${pcms_email}
    # verify 2nd items should be Delivered
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    delivered
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    #C#Verify item status on FMS is not cancel    ${item_id[1][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    delivered    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02415 shipped, delivered : shipped => cancel pending
    [Tags]     regression    ready    TC_ITMWM_02415    WLS_High
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
    # Cancel Pending 1st item
    TrackOrder - Set Item status    ${item_id[0][0]}    cancel_pending
    TrackOrder - Click save    ${item_id[0][0]}
    # verify 1st item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    cancel_pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    #C#Verify item status on FMS is not cancel    ${item_id[0][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    cancel_pending    ${pcms_email}
    # verify 2nd items should be Delivered
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    delivered
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    #C#Verify item status on FMS is not cancel    ${item_id[1][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    delivered    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02416 shipped, delivered : delivered => customer cancelled
    [Tags]     regression    ready    TC_ITMWM_02416    WLS_High
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
    TrackOrder - Click save    ${item_id[1][0]}
    # verify 1st item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    shipped
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    #C#Verify item status on FMS is not cancel    ${item_id[0][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    shipped    ${pcms_email}
    # verify 2nd items should be Delivered
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    refund_request
    #C#Verify item status on FMS    ${item_id[0][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    customer_cancelled    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02417 shipped, order pending, delivered : order pending => customer cancelled
    [Tags]     regression    ready    TC_ITMWM_02417    WLS_High
    ${inv_1}=    Get One Inventory ID
    ${inv_2}=    Get One Inventory ID
    ${inv_3}=    Get One Inventory ID
    ${inv_ids}=    Create List    ${inv_1}    ${inv_2}    ${inv_3}
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
    # cancelled 2nd item
    TrackOrder - Set Item status    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[1][0]}
    # verify 1st item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    unable_to_refund
    #C#Verify item status on FMS    ${item_id[0][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    customer_cancelled    ${pcms_email}
    # verify 2nd item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    unable_to_refund
    #C#Verify item status on FMS    ${item_id[1][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    customer_cancelled    ${pcms_email}
    # verify 3rd item should be Delivered
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    delivered
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    #C#Verify item status on FMS is not cancel    ${item_id[2][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    delivered    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02419 shipped, order pending, delivered : shipped => customer cancelled
    [Tags]     regression    ready    TC_ITMWM_02419    WLS_High
    ${inv_1}=    Get One Inventory ID
    ${inv_2}=    Get One Inventory ID
    ${inv_3}=    Get One Inventory ID
    ${inv_ids}=    Create List    ${inv_1}    ${inv_2}    ${inv_3}
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
    # cancelled 1st item
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    # verify 1st item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    unable_to_refund
    #C#Verify item status on FMS    ${item_id[0][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    customer_cancelled    ${pcms_email}
    # verify 2nd item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    unable_to_refund
    #C#Verify item status on FMS    ${item_id[1][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    customer_cancelled    ${pcms_email}
    # verify 3rd item should be Delivered
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    delivered
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    #C#Verify item status on FMS is not cancel    ${item_id[2][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    delivered    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02420 shipped, order pending, delivered : delivered => customer cancelled
    [Tags]     regression    ready    TC_ITMWM_02420    WLS_High
    ${inv_1}=    Get One Inventory ID
    ${inv_2}=    Get One Inventory ID
    ${inv_3}=    Get One Inventory ID
    ${inv_ids}=    Create List    ${inv_1}    ${inv_2}    ${inv_3}
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
    TrackOrder - Click save    ${item_id[2][0]}
    # verify 1st item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    shipped
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    #C#Verify item status on FMS is not cancel    ${item_id[0][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    shipped    ${pcms_email}
    # verify 2nd item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    order_pending
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    none
    #C#Verify item status on FMS is not cancel    ${item_id[1][0]}
    TrackOrder - Verify Log OrderShipment by Api    ${item_id[1][0]}    order_pending
    # verify 3rd item should be Delivered
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    Refund Request
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    refund_request
    #C#Verify item status on FMS    ${item_id[2][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    customer_cancelled    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02418 shipped, order pending, delivered : shipped => cancel pending
    [Tags]     regression    ready    TC_ITMWM_02418    WLS_High
    ${inv_1}=    Get One Inventory ID
    ${inv_2}=    Get One Inventory ID
    ${inv_3}=    Get One Inventory ID
    ${inv_ids}=    Create List    ${inv_1}    ${inv_2}    ${inv_3}
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
    # Cancel Peninng 1st item
    TrackOrder - Set Item status    ${item_id[0][0]}    cancel_pending
    TrackOrder - Click save    ${item_id[0][0]}
    # verify 1st item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    cancel_pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    #C#Verify item status on FMS is not cancel    ${item_id[0][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[0][0]}    cancel_pending    ${pcms_email}
    # verify 2nd item should be Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    Unable to Refund
    TrackOrder - Check Operation Status on DB    ${item_id[1][0]}    unable_to_refund
    #C#Verify item status on FMS    ${item_id[1][0]}    cancelled
    TrackOrder - Verify Log OrderShipment by User    ${item_id[1][0]}    customer_cancelled    ${pcms_email}
    # verify 3rd item should be Delivered
    TrackOrder - Check Item Status on UI    ${item_id[2][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${item_id[2][0]}    delivered
    TrackOrder - Check Operation Status on UI    ${item_id[2][0]}    None
    TrackOrder - Check Operation Status on DB    ${item_id[2][0]}    none
    #C#Verify item status on FMS is not cancel    ${item_id[2][0]}
    TrackOrder - Verify Log OrderShipment by User    ${item_id[2][0]}    delivered    ${pcms_email}
    # verify order together
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[2][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02421 delivered, cancel pending : delivered => customer cancelled
    [Tags]     regression    ready    TC_ITMWM_02421    WLS_High
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
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    #    ITEM 1
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    Refund Request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    cancel_pending    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02422 order pending, delivered : delivered => customer cancelled
    [Tags]     regression    ready    TC_ITMWM_02422    WLS_High
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
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    order_pending
    #    Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Delivered
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    None
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    delivered
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    none
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    delivered    ${pcms_email}
    #    Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    #    ITEM 2
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[1][0]}    COD
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[1][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    #    ITEM 1
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[0][0]}    None
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Payment Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[0][0]}    none
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    order_pending
    #    Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    #    ITEM 2
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Customer Cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_data[1][0]}    Refund Request
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[1][0]}    Success
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    success
    TrackOrder - Check Operation Status on DB    ${order_shipment_data[1][0]}    refund_request
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[1][0]}    customer_cancelled    ${pcms_email}
    #    Verify item status on FMS    ${order_shipment_data[1][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers
