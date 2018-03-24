*** Settings ***
Force Tags    WLS_PCMS_Order
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track_order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Item_status/update_item_status.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot

*** Variables ***
${email-guest}    test_SLA@domain.com
${inventory_id}    LOAAB1111111
#เมาส์พร้อมคีย์บอร์ด Logitech Wireless mouse MK240 (Black)

*** Test Cases ***
TC_ITMWM_01901 To verify that system display SLA in green on UI when SLA is 0-10.
    [Tags]    regression    ready    TC_ITMWM_01901    WLS_Medium
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order_id = ${order_id}
    #
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check SLA time on UI is Null    ${item_id[0][0]}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    TrackOrder - Check SLA on DB    ${item_id[0][0]}    null
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    Refund Request
    TrackOrder - Check SLA timestamp on UI    ${item_id[0][0]}
    TrackOrder - Check SLA time on UI    ${item_id[0][0]}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    refund_request
    TrackOrder - Check SLA on DB    ${item_id[0][0]}    notnull
    [Teardown]    Close All Browsers

TC_ITMWM_01902 To verify that system display SLA in yellow on UI when SLA is 11-20.
    [Tags]    regression    ready    TC_ITMWM_01902    WLS_Medium
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    #    ${order_id}    Set Variable    3000492
    Log To Console    order_id = ${order_id}
    #
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check SLA time on UI is Null    ${item_id[0][0]}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    TrackOrder - Check SLA on DB    ${item_id[0][0]}    null
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    Refund Request
    TrackOrder - Change Time Back Date SLA    ${item_id[0][0]}    15
    Close All Browsers
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check SLA timestamp on UI    ${item_id[0][0]}
    TrackOrder - Check SLA time on UI    ${item_id[0][0]}    15
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    refund_request
    TrackOrder - Check SLA on DB    ${item_id[0][0]}    notnull
    [Teardown]    Close All Browsers

TC_ITMWM_01903 To verify that system display SLA in red on UI when SLA is more than 20.
    [Tags]    regression    ready    TC_ITMWM_01903    WLS_Medium
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    #    ${order_id}    Set Variable    3000492
    Log To Console    order_id = ${order_id}
    #
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Check SLA time on UI is Null    ${item_id[0][0]}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    none
    TrackOrder - Check SLA on DB    ${item_id[0][0]}    null
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    Refund Request
    TrackOrder - Change Time Back Date SLA    ${item_id[0][0]}    25
    Close All Browsers
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check SLA timestamp on UI    ${item_id[0][0]}
    TrackOrder - Check SLA time on UI    ${item_id[0][0]}    25
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    refund_request
    TrackOrder - Check SLA on DB    ${item_id[0][0]}    notnull
    [Teardown]    Close All Browsers
