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
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track Order/keywords_ApiTrackOrder.robot
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot

*** Variable ***
${pcms_email}     admin@domain.com
${pcms_password}    12345
${guest_email}    guest@email.com

*** Test Cases ***
TC_ITMWM_02430 To verify that system display error message if user select item status = customer cancelled but did not select cancel reason. (Click save)
    [Tags]     regression    ready    TC_ITMWM_02430    WLS_High
    #${order_id}=    Guest Buy Product Success with CCW    ${guest_email}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save not confirm action    ${item_id[0][0]}
    TrackOrder - Verify Cancel Reason No Select
    [Teardown]    Close All Browsers

TC_ITMWM_02431 To verify that system display error message if user select item status = cancel pending but did not select cancel reason. (Click save)
    [Tags]     regression    ready    TC_ITMWM_02431    WLS_High
    #${order_id}=    Guest Buy Product Success with CCW    ${guest_email}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    cancel_pending
    TrackOrder - Click save not confirm action    ${item_id[0][0]}
    TrackOrder - Verify Cancel Reason No Select
    [Teardown]    Close All Browsers

TC_ITMWM_02432 To verify that system display error message if user select item status = customer cancelled but did not select cancel reason. (Click save all)
    [Tags]     regression    ready    TC_ITMWM_02432    WLS_High
    #${order_id}=    Guest Buy Product Success with CCW    ${guest_email}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save all not confirm action
    TrackOrder - Verify Cancel Reason No Select
    [Teardown]    Close All Browsers

TC_ITMWM_02433 To verify that system display error message if user select item status = cancel pending but did not select cancel reason. (Click save all)
    [Tags]     regression    ready    TC_ITMWM_02433    WLS_High
    #${order_id}=    Guest Buy Product Success with CCW    ${guest_email}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    cancel_pending
    TrackOrder - Click save all not confirm action
    TrackOrder - Verify Cancel Reason No Select
    [Teardown]    Close All Browsers

TC_ITMWM_02434 [Single item - Click save] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from order pending to customer cancelled. (via CCW)
    [Tags]     regression    ready    TC_ITMWM_02434    WLS_High
    #${order_id}=    Guest Buy Product Success with CCW    ${guest_email}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02435 [Single item - Click save] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from pending shipment to customer cancelled. (via CS)
    [Tags]     regression    ready    TC_ITMWM_02435    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Pending Shipment
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02436 [Single item - Click save] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from shipped to customer cancelled. (via COD)
    [Tags]     regression    ready    TC_ITMWM_02436    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02437 [Single item - Click save] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from delivered to customer cancelled. (via CCW)
    [Tags]     regression    ready    TC_ITMWM_02437    WLS_High
    #${order_id}=    Guest Buy Product Success with CCW    ${guest_email}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    delivered
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Delivered
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02438 [Single item - Click save] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from shipped to cancel pending. (via CS)
    [Tags]     regression    ready    TC_ITMWM_02438    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    cancel_pending
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Cancel Pending
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02439 [Single item - Click save all] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from order pending to customer cancelled. (via COD)
    [Tags]     regression    ready    TC_ITMWM_02439    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02440 [Single item - Click save all] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from pending shipment to customer cancelled. (via CCW)
    [Tags]     regression    ready    TC_ITMWM_02440    WLS_High
    #${order_id}=    Guest Buy Product Success with CCW    ${guest_email}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Pending Shipment
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02441 [Single item - Click save all] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from shipped to customer cancelled. (via CS)
    [Tags]     regression    ready    TC_ITMWM_02441    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02442 [Single item - Click save all] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from delivered to customer cancelled. (via COD)
    [Tags]     regression    ready    TC_ITMWM_02442    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    delivered
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Delivered
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02443 [Single item - Click save all] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from shipped to cancel pending. (via CCW)
    [Tags]     regression    ready    TC_ITMWM_02443    WLS_High
    #${order_id}=    Guest Buy Product Success with CCW    ${guest_email}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    cancel_pending
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Cancel Pending
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02444 [Multiple items - cancel some item - Click save] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from order pending to customer cancelled. (via CCW)
    [Tags]     regression    ready    TC_ITMWM_02444    WLS_High
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${guest_email}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log to console    ${item_id[0][0]}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB is Empty    ${item_id[1][0]}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02445 [[Multiple items - cancel some item - Click save] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from pending shipment to customer cancelled. (via CS)
    [Tags]     regression    ready    TC_ITMWM_02445    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Pending Shipment
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB is Empty    ${item_id[1][0]}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02446 [Multiple items - cancel some item - Click save] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from shipped to customer cancelled. (via CCW)
    [Tags]     regression    ready    TC_ITMWM_02446    WLS_High
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${guest_email}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB is Empty    ${item_id[1][0]}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02447 [Multiple items - cancel some item - Click save] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from delivered to customer cancelled. (via CS)
    [Tags]     regression    ready    TC_ITMWM_02447    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    delivered
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Delivered
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB is Empty    ${item_id[1][0]}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02448 [Multiple items - cancel some item - Click save] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from shipped to cancel pending. (via CCW)
    [Tags]     regression    ready    TC_ITMWM_02448    WLS_High
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${guest_email}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    cancel_pending
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Cancel Pending
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB is Empty    ${item_id[1][0]}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02449 [Multiple items - cancel some item - Click save all] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from order pending to customer cancelled. (via CS)
    [Tags]     regression    ready    TC_ITMWM_02449    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB is Empty    ${item_id[1][0]}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02450 [Multiple items - cancel some item - Click save all] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from pending shipment to customer cancelled. (via CCW)
    [Tags]     regression    ready    TC_ITMWM_02450    WLS_High
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${guest_email}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Pending Shipment
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB is Empty    ${item_id[1][0]}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02451 [Multiple items - cancel some item - Click save all] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from shipped to customer cancelled. (via CS)
    [Tags]     regression    ready    TC_ITMWM_02451    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save all
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB is Empty    ${item_id[1][0]}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02452 [Multiple items - cancel some item - Click save all] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from delivered to customer cancelled. (via CCW)
    [Tags]     regression    ready    TC_ITMWM_02452    WLS_High
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${guest_email}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save all
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save all
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    delivered
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Delivered
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB is Empty    ${item_id[1][0]}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02453 [Multiple items - cancel some item - Click save all] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from shipped to cancel pending. (via CS)
    [Tags]     regression    ready    TC_ITMWM_02453    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save all
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    cancel_pending
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Cancel Pending
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB is Empty    ${item_id[1][0]}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02454 [Multiple items - cancel all items - same reason] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from order pending to customer cancelled. (via CCW)
    [Tags]     regression    ready    TC_ITMWM_02454    WLS_High
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${guest_email}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Order Pending
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Order Pending
    TrackOrder - Set Item status for cancel reason    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${items_id[0][0]}    ${cancel_reason_ui_customer_change_payment_type}
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${items_id[1][0]}    ${cancel_reason_ui_customer_change_payment_type}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${items_id[0][0]}    ${cancel_reason_db_customer_change_payment_type}
    TrackOrder - Check Cancel Reason on DB    ${items_id[1][0]}    ${cancel_reason_db_customer_change_payment_type}
    TrackOrder - Check Cancel Reason on UI    ${items_id[0][0]}    ${cancel_reason_ui_customer_change_payment_type}
    TrackOrder - Check Cancel Reason on UI    ${items_id[1][0]}    ${cancel_reason_ui_customer_change_payment_type}
    [Teardown]    Close All Browsers

TC_ITMWM_02455 [Multiple items - cancel all items - same reason] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from order pending to customer cancelled. (via CS)
    [Tags]     regression    ready    TC_ITMWM_02455    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Order Pending
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Order Pending
    TrackOrder - Set Item status for cancel reason    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${items_id[0][0]}    ${cancel_reason_ui_customer_fraud_order}
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${items_id[1][0]}    ${cancel_reason_ui_operation_missing_item}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${items_id[0][0]}    ${cancel_reason_db_customer_fraud_order}
    TrackOrder - Check Cancel Reason on DB    ${items_id[1][0]}    ${cancel_reason_db_operation_missing_item}
    TrackOrder - Check Cancel Reason on UI    ${items_id[0][0]}    ${cancel_reason_ui_customer_fraud_order}
    TrackOrder - Check Cancel Reason on UI    ${items_id[1][0]}    ${cancel_reason_ui_operation_missing_item}
    [Teardown]    Close All Browsers

TC_ITMWM_02456 [Multiple items - cancel all items - same reason] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from shipped to customer cancelled. (via CCW)
    [Tags]     regression    ready    TC_ITMWM_02456    WLS_High
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${guest_email}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${items_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[1][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[0][0]}    shipped
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    shipped
    TrackOrder - Click save    ${items_id[1][0]}
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Shipped
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Shipped
    TrackOrder - Set Item status for cancel reason    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${items_id[0][0]}    ${cancel_reason_ui_system_can_not_use_coupon}
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${items_id[1][0]}    ${cancel_reason_ui_customer_change_of_mind}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${items_id[0][0]}    ${cancel_reason_db_system_can_not_use_coupon}
    TrackOrder - Check Cancel Reason on DB    ${items_id[1][0]}    ${cancel_reason_db_customer_change_of_mind}
    TrackOrder - Check Cancel Reason on UI    ${items_id[0][0]}    ${cancel_reason_ui_system_can_not_use_coupon}
    TrackOrder - Check Cancel Reason on UI    ${items_id[1][0]}    ${cancel_reason_ui_customer_change_of_mind}
    [Teardown]    Close All Browsers

TC_ITMWM_02457 [Multiple items - cancel all items - difference reason] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from delivered to customer cancelled. (via CS)
    [Tags]     regression    ready    TC_ITMWM_02457    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save all
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    shipped
    TrackOrder - Click save all
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    delivered
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    delivered
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Delivered
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Delivered
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    ${cancel_reason_ui_system_can_not_use_coupon}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${item_id[1][0]}    ${cancel_reason_db_system_can_not_use_coupon}
    TrackOrder - Check Cancel Reason on UI    ${item_id[1][0]}    ${cancel_reason_ui_system_can_not_use_coupon}
    [Teardown]    Close All Browsers

TC_ITMWM_02458 [Multiple items - cancel all items - same reason] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from shipped to cancel pending. (via CCW)
    [Tags]     regression    ready    TC_ITMWM_02458    WLS_High
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${guest_email}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save all
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    shipped
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Shipped
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    cancel_pending
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    cancel_pending
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Cancel Pending
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${item_id[1][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02459 [Multiple items - cancel all items - difference reason] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from shipped to cancel pending. (via CS)
    [Tags]     regression    ready    TC_ITMWM_02459    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save all
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    shipped
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Shipped
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    cancel_pending
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    cancel_pending
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    ${cancel_reason_ui_system_can_not_use_coupon}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Cancel Pending
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${item_id[1][0]}    ${cancel_reason_db_system_can_not_use_coupon}
    TrackOrder - Check Cancel Reason on UI    ${item_id[1][0]}    ${cancel_reason_ui_system_can_not_use_coupon}
    [Teardown]    Close All Browsers

TC_ITMWM_02460 [Multiple items - cancel some item - Click save] For COD multiple items, To verify that if user update some item to customer cancelled and select cancel reason system will use that reason to apply for all items.
    [Tags]     regression    ready    TC_ITMWM_02460    WLS_High
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${guest_email}    ${default_inventoryID}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Order Pending
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${item_id[1][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02461 [Multiple items - cancel some item - Click save all] For COD multiple items, To verify that if user update some item to customer cancelled and select cancel reason system will use that reason to apply for all items.
    [Tags]     regression    ready    TC_ITMWM_02461    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Order Pending
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${item_id[1][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02462 [Multiple items - cancel some item - Click save] For COD multiple items, To verify that if user update some item to cancel pending and select cancel reason system will use that reason to apply for all items.
    [Tags]     regression    ready    TC_ITMWM_02462    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Order Pending
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    cancel_pending
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${item_id[1][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02463 [Multiple items - cancel some item - Click save all] For COD multiple items, To verify that if user update some item to cancel pending and select cancel reason system will use that reason to apply for all items.
    [Tags]     regression    ready    TC_ITMWM_02463    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Shipped
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Order Pending
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    cancel_pending
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${item_id[1][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02464 [Multiple items - cancel all items - same reason] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from order pending to customer cancelled. (via COD)
    [Tags]     regression    ready    TC_ITMWM_02464    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Order Pending
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${item_id[1][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02465 [Multiple items - cancel all items - difference reason] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from order pending to customer cancelled. (via COD)
    [Tags]     regression    ready    TC_ITMWM_02465    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Order Pending
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    ${cancel_reason_ui_customer_change_of_mind}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${item_id[1][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02466 [Multiple items - cancel all items - same reason] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from pending shipment to customer cancelled. (via COD)
    [Tags]     regression    ready    TC_ITMWM_02466    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Pending Shipment
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Pending Shipment
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${item_id[1][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02467 [Multiple items - cancel all items - difference reason] To verify that user can select cancel reason and system insert cancel reason to DB successfully when user change item status from pending shipment to customer cancelled. (via COD)
    [Tags]     regression    ready    TC_ITMWM_02467    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Pending Shipment
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Pending Shipment
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[1][0]}    ${cancel_reason_ui_customer_change_of_mind}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${item_id[1][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02468 [Multiple items - cancel some item - Click save] For COD multiple items (after shipped),To verify that if all items status is delivered then user update some item to customer cancelled and select cancel reason system will update only item that user selected.
    [Tags]     regression    ready    TC_ITMWM_02468    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    delivered
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    shipped
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    delivered
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Delivered
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Delivered
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Delivered
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB is Empty    ${item_id[1][0]}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[1][0]}    -
    [Teardown]    Close All Browsers

TC_ITMWM_02469 [Multiple items - cancel some item - Click save all] For COD multiple items (after shipped),To verify that if all items status is delivered then user update some item to customer cancelled and select cancel reason system will update only item that user selected.
    [Tags]     regression    ready    TC_ITMWM_02469    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    delivered
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    shipped
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[1][0]}    delivered
    TrackOrder - Click save    ${item_id[1][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Delivered
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Delivered
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${item_id[1][0]}    Delivered
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB is Empty    ${item_id[1][0]}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[1][0]}    -
    [Teardown]    Close All Browsers

TC_ITMWM_02470 [Multiple items - cancel some item - Click save all] For COD multiple items (after shipped),To verify that system update item status and cancel reason correctly if user change item A to customer cancelled if item A = order pending, item B = pending shipment and item C = delivered.
    [Tags]     regression    ready    TC_ITMWM_02470    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD     ${default_inventoryID_cod}    ${default_inventoryID_cod}    2
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[1][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[2][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[2][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[2][0]}    shipped
    TrackOrder - Click save    ${items_id[2][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[2][0]}    delivered
    TrackOrder - Click save    ${items_id[2][0]}
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Order Pending
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Pending Shipment
    TrackOrder - Check Item Status on UI    ${items_id[2][0]}    Delivered
    TrackOrder - Set Item status for cancel reason    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${items_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    sleep    3s
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${items_id[2][0]}    Delivered
    TrackOrder - Check Cancel Reason on DB    ${items_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${items_id[1][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB is Empty    ${items_id[2][0]}
    TrackOrder - Check Cancel Reason on UI    ${items_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${items_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02471 [[Multiple items - cancel some item - Click save all] For COD multiple items (after shipped),To verify that system update item status and cancel reason correctly if user change item B to customer cancelled if item A = order pending, item B = shipped and item C = delivered.
    [Tags]     regression    ready    TC_ITMWM_02471    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD     ${default_inventoryID_cod}    ${default_inventoryID_cod}    2
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[1][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    shipped
    TrackOrder - Click save    ${items_id[1][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[2][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[2][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[2][0]}    shipped
    TrackOrder - Click save    ${items_id[2][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[2][0]}    delivered
    TrackOrder - Click save    ${items_id[2][0]}
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Order Pending
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Shipped
    TrackOrder - Check Item Status on UI    ${items_id[2][0]}    Delivered
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${items_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${items_id[2][0]}    Delivered
    TrackOrder - Check Cancel Reason on DB    ${items_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${items_id[1][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB is Empty    ${items_id[2][0]}
    TrackOrder - Check Cancel Reason on UI    ${items_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${items_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02472 [Multiple items - cancel some item - Click save all] For COD multiple items (after shipped),To verify that system update item status and cancel reason correctly if user change item C to customer cancelled if item A = order pending, item B = pending shipment and item C = delivered.
    [Tags]     regression    ready    TC_ITMWM_02472    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD     ${default_inventoryID_cod}    ${default_inventoryID_cod}    2
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[1][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[2][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[2][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[2][0]}    shipped
    TrackOrder - Click save    ${items_id[2][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[2][0]}    delivered
    TrackOrder - Click save    ${items_id[2][0]}
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Order Pending
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Pending Shipment
    TrackOrder - Check Item Status on UI    ${items_id[2][0]}    Delivered
    TrackOrder - Set Item status for cancel reason    ${items_id[2][0]}    customer_cancelled
    TrackOrder - Set Cancel Reason    ${items_id[2][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Order Pending
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Pending Shipment
    TrackOrder - Check Item Status on UI    ${items_id[2][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB is Empty    ${items_id[0][0]}
    TrackOrder - Check Cancel Reason on DB is Empty    ${items_id[1][0]}
    TrackOrder - Check Cancel Reason on DB    ${items_id[2][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${items_id[2][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02473 [Multiple items - cancel some item - Click save all] For COD multiple items (after shipped),To verify that system update item status and cancel reason correctly if user change item B to cancel pending if item A = order pending, item B = shipped and item C = delivered.
    [Tags]     regression    ready    TC_ITMWM_02473    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD     ${default_inventoryID_cod}    ${default_inventoryID_cod}    2
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[1][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    shipped
    TrackOrder - Click save    ${items_id[1][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[2][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[2][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[2][0]}    shipped
    TrackOrder - Click save    ${items_id[2][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[2][0]}    delivered
    TrackOrder - Click save    ${items_id[2][0]}
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Order Pending
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Shipped
    TrackOrder - Check Item Status on UI    ${items_id[2][0]}    Delivered
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    cancel_pending
    TrackOrder - Set Cancel Reason    ${items_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Cancel Pending
    TrackOrder - Check Item Status on UI    ${items_id[2][0]}    Delivered
    TrackOrder - Check Cancel Reason on DB    ${items_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${items_id[1][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB is Empty    ${items_id[2][0]}
    TrackOrder - Check Cancel Reason on UI    ${items_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${items_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02474 [Single item] To verify that system use cancel reason that user selected when change item status to cancel pending to apply for item that update fail delivery from FMS. (via CCW)
    [Tags]     regression    ready    TC_ITMWM_02474    WLS_High
    #${order_id}=    Guest Buy Product Success with CCW    ${guest_email}    ${default_inventoryID}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Log To Console    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    shipped
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${item_id[0][0]}    cancel_pending
    TrackOrder - Set Cancel Reason    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Cancel Pending
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    ${body}=    Create Request Api update item status Failed Delivery with for Multi-item    ${order_id}    ${item_id}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${item_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${item_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02475 [Multiple items - cancel some item] To verify that system use cancel reason that user selected when change item status to cancel pending to apply for item that update fail delivery from FMS. (via CS)
    [Tags]     regression    ready    TC_ITMWM_02475    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${items_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[0][0]}    shipped
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[0][0]}    cancel_pending
    TrackOrder - Set Cancel Reason    ${items_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Order Pending
    TrackOrder - Check Cancel Reason on DB    ${items_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${items_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB is Empty    ${items_id[1][0]}
    ${body}=    Create Request Api update item status Failed Delivery with for Multi-item    ${order_id}    ${items_id}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Order Pending
    TrackOrder - Check Cancel Reason on DB    ${items_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${items_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB is Empty    ${items_id[1][0]}
    [Teardown]    Close All Browsers

TC_ITMWM_02476 [Multiple items - cancel some item] To verify that system use cancel reason that user selected when change item status to cancel pending to apply for item that update fail delivery from FMS. (via COD)
    [Tags]     regression    ready    TC_ITMWM_02476    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${items_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[0][0]}    shipped
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[0][0]}    cancel_pending
    TrackOrder - Set Cancel Reason    ${items_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${items_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${items_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${items_id[1][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${items_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    ${body}=    Create Request Api update item status Failed Delivery with for Multi-item    ${order_id}    ${items_id}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${items_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${items_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${items_id[1][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${items_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers

TC_ITMWM_02477 [Multiple items - cancel all items - difference reason] To verify that system use cancel reason that user selected when change item status to cancel pending to apply for item that update fail delivery from FMS. (via CCW)
    [Tags]     regression    ready    TC_ITMWM_02477    WLS_High
    ${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${items_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[0][0]}    shipped
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[1][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    shipped
    TrackOrder - Click save    ${items_id[1][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[0][0]}    cancel_pending
    TrackOrder - Set Cancel Reason    ${items_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    cancel_pending
    TrackOrder - Set Cancel Reason    ${items_id[1][0]}    ${cancel_reason_ui_customer_wrong_order}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Cancel Pending
    TrackOrder - Check Cancel Reason on DB    ${items_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${items_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${items_id[1][0]}    ${cancel_reason_db_customer_wrong_order}
    TrackOrder - Check Cancel Reason on UI    ${items_id[1][0]}    ${cancel_reason_ui_customer_wrong_order}
    ${body}=    Create Request Api update item status Failed Delivery with for Multi-item    ${order_id}    ${items_id}    12345    2
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${items_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${items_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${items_id[1][0]}    ${cancel_reason_db_customer_wrong_order}
    TrackOrder - Check Cancel Reason on UI    ${items_id[1][0]}    ${cancel_reason_ui_customer_wrong_order}
    [Teardown]    Close All Browsers

TC_ITMWM_02478 [Multiple items - cancel all items - same reason] To verify that system use cancel reason that user selected when change item status to cancel pending to apply for item that update fail delivery from FMS. (via CCW)
    [Tags]     regression    ready    TC_ITMWM_02478    WLS_High
    ${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status for cancel reason    ${items_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[0][0]}    shipped
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[1][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    shipped
    TrackOrder - Click save    ${items_id[1][0]}
    TrackOrder - Set Item status for cancel reason    ${items_id[0][0]}    cancel_pending
    TrackOrder - Set Cancel Reason    ${items_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Set Item status for cancel reason    ${items_id[1][0]}    cancel_pending
    TrackOrder - Set Cancel Reason    ${items_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Cancel Pending
    TrackOrder - Check Cancel Reason on DB    ${items_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${items_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${items_id[1][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${items_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    ${body}=    Create Request Api update item status Failed Delivery with for Multi-item    ${order_id}    ${items_id}    12345    2
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${items_id[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on UI    ${items_id[1][0]}    Customer Cancelled
    TrackOrder - Check Cancel Reason on DB    ${items_id[0][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${items_id[0][0]}    ${cancel_reason_ui_content_mismatch_content}
    TrackOrder - Check Cancel Reason on DB    ${items_id[1][0]}    ${cancel_reason_db_content_mismatch_content}
    TrackOrder - Check Cancel Reason on UI    ${items_id[1][0]}    ${cancel_reason_ui_content_mismatch_content}
    [Teardown]    Close All Browsers
