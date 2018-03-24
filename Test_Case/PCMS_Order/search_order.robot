*** Settings ***
Force Tags    WLS_PCMS_Order
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Orders/web_element_track_orders.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Orders/Keywords_Orders.robot
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
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track Order/keywords_ApiTrackOrder.robot
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot

*** Variable ***
${pcms_email}     admin@domain.com
${pcms_password}    12345
${email}          guest@email.com
${default_inventoryID}    INAAC1112611
${bank_ref_tmn}    bank-ref-robot-123

*** Test Cases ***
TC_ITMWM_02838 To verify search operation status order by using criteria : Operation Status - Return Refund Request
    [Tags]    Regression    Ready    TC_ITMWM_02838    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    pending_shipment
    TrackOrder - Set Item status    ${items_id[1][0]}    pending_shipment
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${items_id[0][0]}    shipped
    TrackOrder - Set Item status    ${items_id[1][0]}    shipped
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${items_id[0][0]}    delivered
    TrackOrder - Set Item status    ${items_id[1][0]}    delivered
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${items_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${items_id[0][0]}    1
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_return_refund_request}
    TrackOrder - Set Item status    ${items_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${items_id[1][0]}    1
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_refund_request}
    Order - Search - Click Search
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${items_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${items_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02839 To verify search operation status order by using criteria : Operation Status - Not in system
    [Tags]    Regression    Ready    TC_ITMWM_02839    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    pending_shipment
    TrackOrder - Set Item status    ${items_id[1][0]}    pending_shipment
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${items_id[0][0]}    shipped
    TrackOrder - Set Item status    ${items_id[1][0]}    shipped
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${items_id[0][0]}    delivered
    TrackOrder - Set Item status    ${items_id[1][0]}    delivered
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${items_id[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${items_id[0][0]}    1
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_not_in_system}
    TrackOrder - Set Item status    ${items_id[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${items_id[1][0]}    1
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_not_in_system}
    TrackOrder - Click save all
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_refund_request}
    Order - Search - Click Search
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${items_id[0][0]}    None
    Order - Together Check Item Status In DB    ${order_id}    ${items_id[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02326 To verify search order by using criteria = Operation Status - Refund Request : Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02326    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    #${order_id}=    Set Variable    3003051
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_refund_request}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    #Order - Verify Search Not Found by Order Id    1111
    [Teardown]    Close All Browsers

TC_ITMWM_02327 To verify search order by using criteria = Operation Status Date from : Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02327    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02328 To verify search order by using criteria = SLA - 11-20 Level 2 สีเหลือง : Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02328    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    15
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set SLA Operation Status    1
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02329 To verify search order by using criteria = Stock type - RX : Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02329    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RX
    Send Api update status    ${body}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Stock Type    RX
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02330 To verify search order by using criteria = Operation Status - Refund Request : Operation Status Date from : App : Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02330    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_refund_request}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set App    iTruemart
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02331 To verify search order by using criteria = Operation Status - SCM Verified : SLA - 1-10 Level 1 สีเขียว = Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02331    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_scm_verified}
    Order - Search - Set SLA Operation Status    0
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02332 To verify search order by using criteria = Operation Status - SCM Require doc : SLA - 11-20 Level 2 สีเหลือง : Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02332    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_require_doc}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    15
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_scm_require_doc}
    Order - Search - Set SLA Operation Status    1
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02333 To verify search order by using criteria = Operation Status - CLT Doc Uploaded : SLA - 21-30 Level 3 สีแดง : Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02333    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    25
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_clt_doc_uploaded}
    Order - Search - Set SLA Operation Status    2
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02334 To verify search order by using criteria = Operation Status - Refund Complete : Stock type - RT : Order ID
    [Tags]    Regression    Ready    TC_ITMWM_02334    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RT
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Operation Status    ${operation_ui_refund_request}
    Order - Search - Set Stock Type    RT
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02335 To verify search order by using criteria = Operation Status - Unable to Refund : Operation Status Date from : Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02335    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_unable_to_refund}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02336 To verify search order by using criteria = Operation Status Date from : Stock type - MX : Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02336    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MX
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Stock Type    MX
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02337 To verify search order by using criteria = Operation Status - Pending TMN : Stock type - RD : Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02337    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RD
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_pending_tmn}
    Order - Search - Set Stock Type    RD
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02338 To verify search order by using criteria = Operation Status Date from : Stock type - MD : Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02338    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MD
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Stock Type    MD
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02339 To verify search order by using criteria = SLA - 1-10 Level 1 สีเขียว : Stock type - RT : Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02339    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RT
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set SLA Operation Status    0
    Order - Search - Set Stock Type    RT
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02340 To verify search order by using criteria = SLA - 1-10 Level 1 สีเขียว : Stock type - RX : Search by expire date from
    [Tags]    Regression    Ready    TC_ITMWM_02340    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RX
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    ${current_date}=    Get Current Date
    Set Expired Date    ${order_id}    ${current_date}
    Order - Go to Order Page
    Order - Search - Set Expired Date From    ${current_date}
    Order - Search - Set SLA Operation Status    0
    Order - Search - Set Stock Type    RX
    #Order - Search - Click Label Search By Order ID
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02341 To verify search order by using criteria = SLA - 11-20 Level 2 สีเหลือง : Stock type - CT : Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02341    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    CT
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    15
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set SLA Operation Status    1
    Order - Search - Set Stock Type    CT
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02342 To verify search order by using criteria SLA - > 20 สีแดง : Stock type - MF : Search by payment date from
    [Tags]    Regression    Ready    TC_ITMWM_02342    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MF
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    25
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Payment Date From    ${current_date}
    Order - Search - Set SLA Operation Status    2
    Order - Search - Set Stock Type    MF
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02343 To verify search order by using criteria = Operation Status - Refund Request : Operation Status Date from : Operation Status Date to : Payment Status : Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02343    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${from_date}=    Get Current Date    UTC    - 1 Days
    ${to_date}=    Get Current Date
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Operation Status    ${operation_ui_refund_request}
    Order - Search - Set Order Date From    ${from_date}
    Order - Search - Set Order Date To    ${to_date}
    Order - Search - Set Payment Status    Success
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02344 To verify search order by using criteria = Operation Status - Refund Request : Operation Status Date from : SLA - 11-20 Level 2 สีเหลือง : Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02344    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    15
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Operation Status    ${operation_ui_refund_request}
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set SLA Operation Status    1
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02345 To verify search order by using criteria = Operation Status - Refund Request : Operation Status Date from : Stock type - RT : Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02345    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RT
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    15
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Operation Status    ${operation_ui_refund_request}
    Order - Search - Set Stock Type    RT
    Order - Search - Set SLA Operation Status    1
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02346 To verify search order by using criteria = Operation Status - Refund Request : SLA - 1-10 Level 1 สีเขียว : Stock type - RT : Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02346    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RT
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Operation Status    ${operation_ui_refund_request}
    Order - Search - Set Stock Type    RT
    Order - Search - Set SLA Operation Status    0
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02347 To verify search order by using criteria = 1. Operation Status - Pending TMN :2. Operation Status Date from :3. Operation Status Date to :4. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02347    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${from_date}=    Get Current Date    UTC    - 1 Days
    ${to_date}=    Get Current Date
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Operation Status    ${operation_ui_pending_tmn}
    Order - Search - Set Order Date From    ${from_date}
    Order - Search - Set Order Date To    ${to_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02348 To verify search order by using criteria = 1. Operation Status - Pending TMN : 2. Operation Status Date from : 3. SLA - > 20 สีแดง : 4. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02348    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    25
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Operation Status    ${operation_ui_pending_tmn}
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set SLA Operation Status    2
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02349 To verify search order by using criteria = 1. Operation Status - Pending TMN : 2. Operation Status Date from : 3. Stock type - RD : 4. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02349    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RD
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Operation Status    ${operation_db_pending_tmn}
    Order - Search - Set Stock Type    RD
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02350 To verify search order by using criteria = 1. Operation Status - Pending TMN : 2. SLA - 1-10 Level 1 สีเขียว : 3. Stock type - RX : 4. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02350    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RX
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Operation Status    ${operation_ui_pending_tmn}
    Order - Search - Set Stock Type    RX
    Order - Search - Set SLA Operation Status    0
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02351 To verify search order by using criteria = 1. Operation Status - SCM Verified : 2. Operation Status Date from : 3. Operation Status Date to : 4. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02351    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${from_date}=    Get Current Date    UTC    - 1 Days
    ${to_date}=    Get Current Date
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Operation Status    ${operation_ui_scm_verified}
    Order - Search - Set Order Date From    ${from_date}
    Order - Search - Set Order Date To    ${to_date}
    Order - Search - Click Search
    [Teardown]    Close All Browsers

TC_ITMWM_02352 To verify search order by using criteria = 1. Operation Status - SCM Verified : 2. Operation Status Date from : 3. SLA - 1-10 Level 1 สีเขียว : 4. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02352    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Operation Status    ${operation_ui_scm_verified}
    Order - Search - Set SLA Operation Status    0
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02353 To verify search order by using criteria = 1. Operation Status - SCM Verified : 2. Operation Status Date from : 3. Stock type - RX : 4. Item Status : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02353    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RX
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Operation Status    ${operation_ui_scm_verified}
    Order - Search - Set Stock Type    RX
    Order - Search - Set Item Status    Customer Cancelled
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02354 To verify search order by using criteria = 1. Operation Status - SCM Verified : 2. SLA - 1-10 Level 1 สีเขียว : 3. Stock type - CT : 4. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02354    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    CT
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Operation Status    ${operation_ui_scm_verified}
    Order - Search - Set Stock Type    CT
    Order - Search - Set SLA Operation Status    0
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02355 To verify search order by using criteria = 1. Operation Status - SCM Require doc : 2. Operation Status Date from : 3. SLA - 11-20 Level 2 สีเหลือง : 4. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02355    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    13
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Operation Status    ${operation_ui_scm_verified}
    Order - Search - Set SLA Operation Status    1
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02356 To verify search order by using criteria = 1. Operation Status - SCM Require doc : 2. Operation Status Date from : 3. Stock type - MF : 4. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02356    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MF
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Operation Status    ${operation_ui_scm_verified}
    Order - Search - Set Stock Type    MF
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02357 To verify search order by using criteria = 1. Operation Status - CLT Doc Uploaded : 2. Operation Status Date from : 3. SLA - 11-20 Level 2 สีเหลือง : 4. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02357    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    13
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Operation Status    ${operation_ui_clt_doc_uploaded}
    Order - Search - Set SLA Operation Status    1
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02358 To verify search order by using criteria = 1. Operation Status - CLT Doc Uploaded : 2. Operation Status Date from : 3. Stock type - MX : 4. Payment Method : 5. Payment Status : 6. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02358    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MX
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    13
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Operation Status    ${operation_ui_clt_doc_uploaded}
    Order - Search - Set SLA Operation Status    1
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Stock Type    MX
    Order - Search - Set Payment Method    Counter service
    Order - Search - Set Payment Status    Success
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02359 To verify search order by using criteria = 1. Operation Status - CLT Doc Uploaded : 2. SLA - 1-10 Level 1 สีเขียว : 3. Stock type - MD : 4. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02359    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MD
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Operation Status    ${operation_ui_clt_doc_uploaded}
    Order - Search - Set SLA Operation Status    0
    Order - Search - Set Stock Type    MD
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02360 To verify search order by using criteria = 1. Operation Status - Refund Complete : 2. Operation Status Date from : 3. SLA - > 20 สีแดง : 4. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02360    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${items_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save all
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    25
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set SLA Operation Status    2
    Order - Search - Set Operation Status    ${operation_db_refund_complete}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02361 To verify search order by using criteria = 1. Operation Status - Refund Complete : 2. SLA - 1-10 Level 1 สีเขียว : 3. Stock type - RT : 4. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02361    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RT
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${items_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save all
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    5
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Stock Type    RT
    Order - Search - Set SLA Operation Status    0
    Order - Search - Set Operation Status    ${operation_ui_refund_complete}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02362 To verify search order by using criteria = 1. Operation Status - Unable to Refund : 2. Operation Status Date from : 3. Stock type - RX : 4. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02362    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RX
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Stock Type    RX
    Order - Search - Set Operation Status    ${operation_db_unable_to_refund}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02363 To verify search order by using criteria = 1. Operation Status Date from : 2. Operation Status Date to : 3. SLA - 1-10 Level 1 สีเขียว : 4. Search by Order ID
    [Tags]    Regression    Ready    TC_ITMWM_02363    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${current_date}
    Order - Search - Set SLA Operation Status    0
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Click Search
    Order - Verify Search Not Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02364 To verify search order by using criteria = 1. Operation Status Date from : 2. Operation Status Date to : 3. Stock type - RT : 4. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02364    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RT
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Stock Type    RT
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02365 To verify search order by using criteria = 1. Operation Status Date from : 2. SLA - 1-10 Level 1 สีเขียว : 3. Stock type - CT : 4. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02365    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    CT
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    10
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Stock Type    CT
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set SLA Operation Status    0
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02366 To verify search order by using criteria = 1. Operation Status Date from : 2. SLA - > 20 สีแดง : 3. Stock type - MD : 4. Payment Method : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02366    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MD
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    21
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Stock Type    MD
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Payment Method    บัตรเครดิต
    Order - Search - Set SLA Operation Status    2
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02367 To verify search order by using criteria = 1. Operation Status - Refund Request : 2. Operation Status Date from : 3. SLA - 1-10 Level 1 สีเขียว : 4. Stock type - RT : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02367    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RT
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    10
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Stock Type    RT
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_refund_request}
    Order - Search - Set SLA Operation Status    0
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02368 To verify search order by using criteria = 1. Operation Status - Refund Request : 2. Operation Status Date from : 3. SLA - 11-20 Level 2 สีเหลือง : 4. Stock type - RT : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02368    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RT
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    20
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Stock Type    RT
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_refund_request}
    Order - Search - Set SLA Operation Status    1
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02369 To verify search order by using criteria = 1. Operation Status - Refund Request : 2. Operation Status Date from : 3. SLA - > 20 สีแดง : 4. Stock type - RD : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02369    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RD
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    50
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Stock Type    RD
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_refund_request}
    Order - Search - Set SLA Operation Status    2
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02370 To verify search order by using criteria = 1. Operation Status - Refund Request : 2. Operation Status Date from : 3. Operation Status Date to : 4. SLA - 11-20 Level 2 สีเหลือง : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02370    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    11
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_refund_request}
    Order - Search - Set SLA Operation Status    1
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02371 To verify search order by using criteria = 1. Operation Status - Refund Request : 2. Operation Status Date from : 3. Operation Status Date to : 4. Stock type - RT : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02371    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RT
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_refund_request}
    Order - Search - Set Stock Type    RT
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02372 To verify search order by using criteria = 1. Operation Status - Pending TMN : 2. Operation Status Date from : 3. SLA - 1-10 Level 1 สีเขียว : 4. Stock type - RD : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02372    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RD
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_pending_tmn}
    Order - Search - Set Stock Type    RD
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02373 To verify search order by using criteria = 1. Operation Status - Pending TMN : 2. Operation Status Date from : 3. SLA - > 20 สีแดง : 4. Stock type - RX : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02373    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RX
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    21
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_pending_tmn}
    Order - Search - Set Stock Type    RX
    Order - Search - Set SLA Operation Status    2
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02374 To verify search order by using criteria = 1. Operation Status - Pending TMN : 2. Operation Status Date from : 3. Operation Status Date to : 4. Stock type - RX : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02374    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RX
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_pending_tmn}
    Order - Search - Set Stock Type    RX
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02375 To verify search order by using criteria = 1. Operation Status - SCM Verified : 2. Operation Status Date from : 3. SLA - 1-10 Level 1 สีเขียว : 4. Stock type - CT : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02375    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    CT
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Operation Status    ${operation_ui_scm_verified}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set SLA Operation Status    0
    Order - Search - Set Stock Type    CT
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02376 To verify search order by using criteria = 1. Operation Status - SCM Verified : 2. Operation Status Date from : 3. SLA - 11-20 Level 2 สีเหลือง : 4. Stock type - CT : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02376    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    CT
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    15
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Operation Status    ${operation_ui_scm_verified}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set SLA Operation Status    1
    Order - Search - Set Stock Type    CT
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02377 To verify search order by using criteria = 1. Operation Status - SCM Verified : 2. Operation Status Date from : 3. SLA - > 20 สีแดง : 4. Stock type - CT : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02377    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    CT
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    25
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Operation Status    ${operation_ui_scm_verified}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set SLA Operation Status    2
    Order - Search - Set Stock Type    CT
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02378 To verify search order by using criteria = 1. Operation Status - SCM Verified : 2. Operation Status Date from : 3. Operation Status Date to : 4. SLA - 1-10 Level 1 สีเขียว : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02378    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Operation Status    ${operation_ui_scm_verified}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${current_date}
    Order - Search - Set SLA Operation Status    0
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02379 To verify search order by using criteria = 1. Operation Status - SCM Verified : 2. Operation Status Date from : 3. Operation Status Date to : 4. Stock type - MF : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02379    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MF
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Operation Status    ${operation_ui_scm_verified}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${current_date}
    Order - Search - Set Stock Type    MF
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02380 To verify search order by using criteria = 1. Operation Status - SCM Require doc : 2. Operation Status Date from : 3. SLA - 1-10 Level 1 สีเขียว : 4. Stock type - MX : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02380    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MX
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_require_doc}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Operation Status    ${operation_ui_scm_require_doc}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set SLA Operation Status    0
    Order - Search - Set Stock Type    MX
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02381 To verify search order by using criteria = 1. Operation Status - SCM Require doc : 2. Operation Status Date from : 3. SLA - 11-20 Level 2 สีเหลือง : 4. Stock type - MX: 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02381    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MX
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_require_doc}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    15
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Operation Status    ${operation_ui_scm_require_doc}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set SLA Operation Status    1
    Order - Search - Set Stock Type    MX
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02382 To verify search order by using criteria = 1. Operation Status - SCM Require doc : 2. Operation Status Date from : 3. SLA - > 20 สีแดง : 4. Stock type - MX : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02382    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MX
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_require_doc}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    25
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Operation Status    ${operation_ui_scm_require_doc}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set SLA Operation Status    2
    Order - Search - Set Stock Type    MX
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02383 To verify search order by using criteria = 1. Operation Status - SCM Require doc : 2. Operation Status Date from : 3. Operation Status Date to : 4. Stock type - MF : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02383    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MF
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_require_doc}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    25
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    ${to_date}=    Get Current Date    UTC    + 1 hours
    Order - Search - Set Operation Status    ${operation_ui_scm_require_doc}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${to_date}
    Order - Search - Set Stock Type    MF
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02384 To verify search order by using criteria = 1. Operation Status - CLT Doc Uploaded : 2. Operation Status Date from : 3. SLA - 1-10 Level 1 สีเขียว : 4. Stock type - MD : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02384    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MD
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    1
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Operation Status    ${operation_ui_clt_doc_uploaded}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set SLA Operation Status    0
    Order - Search - Set Stock Type    MD
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02385 To verify search order by using criteria = 1. Operation Status - CLT Doc Uploaded : 2. Operation Status Date from : 3. SLA - 11-20 Level 2 สีเหลือง : 4. Stock type - MD : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02385    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MD
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    15
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Operation Status    ${operation_ui_clt_doc_uploaded}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set SLA Operation Status    1
    Order - Search - Set Stock Type    MD
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02386 To verify search order by using criteria = 1. Operation Status - CLT Doc Uploaded : 2. Operation Status Date from : 3. SLA - > 20 สีแดง : 4. Stock type - MD : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02386    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MD
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    25
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Operation Status    ${operation_ui_clt_doc_uploaded}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set SLA Operation Status    2
    Order - Search - Set Stock Type    MD
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02387 To verify search order by using criteria = 1. Operation Status - CLT Doc Uploaded : 2. Operation Status Date from : 3. Operation Status Date to : 4. SLA - 1-10 Level 1 สีเขียว : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02387    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MD
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    1
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    ${to_date}=    Get Current Date    UTC    + 1 hours
    Order - Search - Set Operation Status    ${operation_ui_clt_doc_uploaded}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${to_date}
    Order - Search - Set SLA Operation Status    0
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02388 To verify search order by using criteria = 1. Operation Status - CLT Doc Uploaded : 2. Operation Status Date from : 3. Operation Status Date to : 4. Stock type - MD : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02388    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MD
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    ${to_date}=    Get Current Date    UTC    + 1 hours
    Order - Search - Set Operation Status    ${operation_ui_clt_doc_uploaded}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${to_date}
    Order - Search - Set Stock Type    MD
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02389 To verify search order by using criteria = 1. Operation Status - Refund Complete : 2. Operation Status Date from : 3. SLA - 1-10 Level 1 สีเขียว : 4. Stock type - RT : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02389    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RT
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${items_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    1
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Operation Status    ${operation_ui_refund_complete}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set SLA Operation Status    0
    Order - Search - Set Stock Type    RT
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02390 To verify search order by using criteria = 1. Operation Status - Refund Complete : 2. Operation Status Date from : 3. SLA - 11-20 Level 2 สีเหลือง : 4. Stock type - RT : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02390    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RT
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${items_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    15
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Operation Status    ${operation_ui_refund_complete}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set SLA Operation Status    1
    Order - Search - Set Stock Type    RT
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02391 To verify search order by using criteria = 1. Operation Status - Refund Complete : 2. Operation Status Date from : 3. SLA - > 20 สีแดง : 4. Stock type - RT : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02391    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RT
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${items_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    25
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Operation Status    ${operation_ui_refund_complete}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set SLA Operation Status    2
    Order - Search - Set Stock Type    RT
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02392 To verify search order by using criteria = 1. Operation Status - Refund Complete : 2. Operation Status Date from : 3. Operation Status Date to : 4. SLA - 1-10 Level 1 สีเขียว : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02392    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RT
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${items_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    1
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    ${to_date}=    Get Current Date    UTC    + 1 hours
    Order - Search - Set Operation Status    ${operation_ui_refund_complete}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${to_date}
    Order - Search - Set SLA Operation Status    0
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02393 To verify search order by using criteria = 1. Operation Status - Refund Complete : 2. Operation Status Date from : 3. Operation Status Date to : 4. Stock type - RT : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02393    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RT
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${items_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    ${to_date}=    Get Current Date    UTC    + 1 hours
    Order - Search - Set Operation Status    ${operation_ui_refund_complete}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${to_date}
    Order - Search - Set Stock Type    RT
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02394 To verify search order by using criteria = 1. Operation Status - Unable to Refund : 2. Operation Status Date from : 3. stock type - RD : 4. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02394    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RD
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Operation Status    ${operation_ui_unable_to_refund}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Stock Type    RD
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02395 To verify search order by using criteria = 1. Operation Status - Unable to Refund : 2. Operation Status Date from : 3. stock type - MF : 4. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02395    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MF
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Operation Status    ${operation_ui_unable_to_refund}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Stock Type    MF
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02396 To verify search order by using criteria = 1. Operation Status - Unable to Refund : 2. Operation Status Date from : 3. Operation Status Date to : 4. Stock type - MX : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02396    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MX
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    ${to_date}=    Get Current Date    UTC    + 1 hours
    Order - Search - Set Operation Status    ${operation_ui_unable_to_refund}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${to_date}
    Order - Search - Set Stock Type    MX
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02397 To verify search order by using criteria = 1. Operation Status - Unable to Refund : 2. Operation Status Date from : 3. Operation Status Date to : 4. Stock type - RT : 5. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02397    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RT
    Send Api update status    ${body}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    ${to_date}=    Get Current Date    UTC    + 1 hours
    Order - Search - Set Operation Status    ${operation_ui_unable_to_refund}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${to_date}
    Order - Search - Set Stock Type    RT
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02398 To verify search order by using criteria = 1. Operation Status - Refund Request : 2. Operation Status Date from : 3. Operation Status Date to : 4. SLA - 11-20 Level 2 สีเหลือง : 5. Stock type - RT : 6. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02398    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RT
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    15
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_refund_request}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${current_date}
    Order - Search - Set SLA Operation Status    1
    Order - Search - Set Stock Type    RT
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02399 To verify search order by using criteria = 1. Operation Status - SCM Require doc : 2. Operation Status Date from : 3. Operation Status Date to : 4. SLA - 1-10 Level 1 สีเขียว : 5. Stock type - RX : 6. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02399    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RX
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_require_doc}
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_scm_require_doc}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${current_date}
    Order - Search - Set SLA Operation Status    0
    Order - Search - Set Stock Type    RX
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02400 To verify search order by using criteria = 1. Operation Status - Refund Complete : 2. Operation Status Date from : 3. Operation Status Date to : 4. SLA - > 20 สีแดง : 5. Stock type - MX : 6. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02400    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MX
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${items_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save all
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    25
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_refund_complete}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${current_date}
    Order - Search - Set SLA Operation Status    2
    Order - Search - Set Stock Type    MX
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02401 "To verify search order by using criteria = 1. Operation Status - Pending TMN : 2. Operation Status Date from : 3. Operation Status Date to : 4. SLA - > 20 สีแดง : 5. Stock type - RX : 6. Order date from
    [Tags]    Regression    Ready    TC_ITMWM_02401    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RX
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Change Time Back Date SLA    ${items_id[0][0]}    25
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Operation Status    ${operation_ui_pending_tmn}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${current_date}
    Order - Search - Set SLA Operation Status    2
    Order - Search - Set Stock Type    RX
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02402 To verify search order status by using criteria = 1. Order ID
    [Tags]    Regression    Ready    TC_ITMWM_02402    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Order - Go to Order Page
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02404 To verify search order status by using criteria = 1. Order date from : 2. Order date to
    [Tags]    Regression    Ready    TC_ITMWM_02404    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Order Date From    ${current_date}
    Order - Search - Set Order Date To    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02405 To verify search order status by using criteria = 1. Search by expire date from : 2. Search by expire date to
    [Tags]    Regression    Ready    TC_ITMWM_02405    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Set Expired Date    ${order_id}    ${current_date}
    Order - Search - Set Expired Date From    ${current_date}
    Order - Search - Set Expired Date To    ${current_date}
    #Order - Search - Click Label Search By Order ID
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02406 To verify search order status by using criteria = 1. Search by payment date from : 2. Search by payment date to
    [Tags]    Regression    Ready    TC_ITMWM_02406    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Payment Date From    ${current_date}
    Order - Search - Set Payment Date To    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02407 To verify search order status by using criteria = 1. Search by payment date from : 2. Search by payment date to : 3. Operation Status Date from : 4 Operation Status Date to
    [Tags]    Regression    Ready    TC_ITMWM_02407    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Order - Go to Order Page
    ${current_date}=    Get Current Date
    Order - Search - Set Payment Date From    ${current_date}
    Order - Search - Set Payment Date To    ${current_date}
    Order - Search - Set Operation Status Date From    ${current_date}
    Order - Search - Set Operation Status Date To    ${current_date}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02550 To verify search order when using criteria item status = Return Pending
    [Tags]    Regression    Ready    TC_ITMWM_02550    WLS_Medium
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
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_pending}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_pending}
    Order - Go to Order Page
    Order - Go to Order Page
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Item Status    ${item_status_ui_return_pending}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02678 To verify search order when using criteria item status = Return Received
    [Tags]    Regression    Ready    TC_ITMWM_02678    WLS_High
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
    Order - Go to Order Page
    Order - Go to Order Page
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Item Status    ${item_status_ui_return_received}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02593 To verify search order when using criteria item status = return failed > delivered
    [Tags]    Regression    Ready    TC_ITMWM_02593    WLS_High
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_failed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_delivered}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_delivered}
    Order - Go to Order Page
    Order - Go to Order Page
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Item Status    ${item_status_ui_delivered}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02781 To verify search order when using criteria item status = Return Completed
    [Tags]    Regression    Ready    TC_ITMWM_02781    WLS_High
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
    TrackOrder - Set Item status    ${item_id[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_completed}
    Order - Go to Order Page
    Order - Go to Order Page
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Item Status    ${item_status_ui_return_completed}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_02624 To verify search order when using criteria item status = Return Rejected
    [Tags]    Regression    Ready    TC_ITMWM_02624    WLS_High
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
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${item_id}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    ${item_status_db_return_rejected}
    Order - Go to Order Page
    Order - Go to Order Page
    Order - Search - Set Order Id    ${order_id}
    Order - Search - Set Item Status    ${item_status_ui_return_rejected}
    Order - Search - Click Search
    Order - Verify Search Found by Order Id    ${order_id}
    [Teardown]    Close All Browsers
