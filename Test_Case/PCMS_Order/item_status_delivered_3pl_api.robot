*** Settings ***
Force Tags    WLS_PCMS_Order
Resource          ${CURDIR}/../../Resource/init.robot
Library           ${CURDIR}/../../Python_Library/DatabaseData.py
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/WebElement_order.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track_Order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Order_together/keywords_order_together.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track Order/keywords_ApiTrackOrder.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Item_status/update_item_status.robot
Resource          ${CURDIR}/../../Keyword/API/FMS/FMS_ORDER.robot
Resource          ${CURDIR}/../../Keyword/Features/Order/Keywords_Order_Tracking.robot
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot

*** Variable ***
${email}          guest@email.com
${material_id}    robot_material_id_123
${serial_number}    123456
${pcms_email}     admin@domain.com
${pcms_password}    12345

*** Test Cases ***
TC_ITMWM_02228 [CCW] To verify that system can update status (and log to DB) from shipped to delivered when send delivered status from 3PL deliver api
    [Tags]    regression    TC_ITMWM_02228    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    ${logistic_code}    set variable    Alpha
    ${tracking_number}    set variable    ITM${order_id}
    ${body}=    Create Request Api update item status Shipped with tracking and 3PL for Multi-item    ${order_id}    ${order_shipment_data}    ${logistic_code}    ${tracking_number}    1
    Send Api update status    ${body}
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    ${Variable_Token}=    get_3pl_access_token    ${logistic_code}
    API Receive Status    ${tracking_number}    ${Variable_Token}
    Tracking - Expected Response From Api    "success"    "200"    "Update tracking status is successfully."
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    delivered
    ${result}=    Tracking - Get Retry Queues Tracking Number In DB    ${tracking_number}
    Should Be Equal As Strings    ${result}    None
    ${count_retry}=    Tracking - Count Tracking Receive Queues    ${tracking_number}
    ${count_log}=    Tracking - Count Tracking Receive Log    ${tracking_number}
    Should Be Equal As Integers    ${count_retry}    0
    Should Be Equal As Integers    ${count_log}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02229 [CCW] To verify that system can update status (and log to DB) from cancel pending to delivered when send delivered status from 3PL deliver api
    [Tags]    regression    TC_ITMWM_02229    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    ${logistic_code}    set variable    Alpha
    ${tracking_number}    set variable    ITM${order_id}
    ${body}=    Create Request Api update item status Shipped with tracking and 3PL for Multi-item    ${order_id}    ${order_shipment_data}    ${logistic_code}    ${tracking_number}    1
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    Sleep    1s
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    ${Variable_Token}=    get_3pl_access_token    ${logistic_code}
    API Receive Status    ${tracking_number}    ${Variable_Token}
    Tracking - Expected Response From Api    "success"    "200"    "Update tracking status is successfully."
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    delivered
    ${result}=    Tracking - Get Retry Queues Tracking Number In DB    ${tracking_number}
    Should Be Equal As Strings    ${result}    None
    ${count_retry}=    Tracking - Count Tracking Receive Queues    ${tracking_number}
    ${count_log}=    Tracking - Count Tracking Receive Log    ${tracking_number}
    Should Be Equal As Integers    ${count_retry}    0
    Should Be Equal As Integers    ${count_log}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02230 [CS] To verify that system can update status (and log to DB) from shipped to delivered when send delivered status from 3PL deliver api
    [Tags]    regression    TC_ITMWM_02230    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    ${logistic_code}    set variable    Alpha
    ${tracking_number}    set variable    ITM${order_id}
    ${body}=    Create Request Api update item status Shipped with tracking and 3PL for Multi-item    ${order_id}    ${order_shipment_data}    ${logistic_code}    ${tracking_number}    1
    Send Api update status    ${body}
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    ${Variable_Token}=    get_3pl_access_token    ${logistic_code}
    API Receive Status    ${tracking_number}    ${Variable_Token}
    Tracking - Expected Response From Api    "success"    "200"    "Update tracking status is successfully."
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    delivered
    ${result}=    Tracking - Get Retry Queues Tracking Number In DB    ${tracking_number}
    Should Be Equal As Strings    ${result}    None
    ${count_retry}=    Tracking - Count Tracking Receive Queues    ${tracking_number}
    ${count_log}=    Tracking - Count Tracking Receive Log    ${tracking_number}
    Should Be Equal As Integers    ${count_retry}    0
    Should Be Equal As Integers    ${count_log}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02231 [CS] To verify that system can update status (and log to DB) from cancel pending to delivered when send delivered status from 3PL deliver api
    [Tags]    regression    TC_ITMWM_02231    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    ${logistic_code}    set variable    Alpha
    ${tracking_number}    set variable    ITM${order_id}
    ${body}=    Create Request Api update item status Shipped with tracking and 3PL for Multi-item    ${order_id}    ${order_shipment_data}    ${logistic_code}    ${tracking_number}    1
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    Sleep    1s
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    ${Variable_Token}=    get_3pl_access_token    ${logistic_code}
    API Receive Status    ${tracking_number}    ${Variable_Token}
    Tracking - Expected Response From Api    "success"    "200"    "Update tracking status is successfully."
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    delivered
    ${result}=    Tracking - Get Retry Queues Tracking Number In DB    ${tracking_number}
    Should Be Equal As Strings    ${result}    None
    ${count_retry}=    Tracking - Count Tracking Receive Queues    ${tracking_number}
    ${count_log}=    Tracking - Count Tracking Receive Log    ${tracking_number}
    Should Be Equal As Integers    ${count_retry}    0
    Should Be Equal As Integers    ${count_log}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02232 [COD] To verify that system can update status (and log to DB) from shipped to delivered when send delivered status from 3PL deliver api
    [Tags]    regression    TC_ITMWM_02232    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    ${logistic_code}    set variable    Alpha
    ${tracking_number}    set variable    ITM${order_id}
    ${body}=    Create Request Api update item status Shipped with tracking and 3PL for Multi-item    ${order_id}    ${order_shipment_data}    ${logistic_code}    ${tracking_number}    1
    Send Api update status    ${body}
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    ${Variable_Token}=    get_3pl_access_token    ${logistic_code}
    API Receive Status    ${tracking_number}    ${Variable_Token}
    Tracking - Expected Response From Api    "success"    "200"    "Update tracking status is successfully."
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    delivered
    ${result}=    Tracking - Get Retry Queues Tracking Number In DB    ${tracking_number}
    Should Be Equal As Strings    ${result}    None
    ${count_retry}=    Tracking - Count Tracking Receive Queues    ${tracking_number}
    ${count_log}=    Tracking - Count Tracking Receive Log    ${tracking_number}
    Should Be Equal As Integers    ${count_retry}    0
    Should Be Equal As Integers    ${count_log}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02233 [COD] To verify that system can update status (and log to DB) from cancel pending to delivered when send delivered status from 3PL deliver api
    [Tags]    regression    TC_ITMWM_02233    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    ${logistic_code}    set variable    Alpha
    ${tracking_number}    set variable    ITM${order_id}
    ${body}=    Create Request Api update item status Shipped with tracking and 3PL for Multi-item    ${order_id}    ${order_shipment_data}    ${logistic_code}    ${tracking_number}    1
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    Sleep    1s
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    ${Variable_Token}=    get_3pl_access_token    ${logistic_code}
    API Receive Status    ${tracking_number}    ${Variable_Token}
    Tracking - Expected Response From Api    "success"    "200"    "Update tracking status is successfully."
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    delivered
    ${result}=    Tracking - Get Retry Queues Tracking Number In DB    ${tracking_number}
    Should Be Equal As Strings    ${result}    None
    ${count_retry}=    Tracking - Count Tracking Receive Queues    ${tracking_number}
    ${count_log}=    Tracking - Count Tracking Receive Log    ${tracking_number}
    Should Be Equal As Integers    ${count_retry}    0
    Should Be Equal As Integers    ${count_log}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02234 To verify that system does not insert data to retry-queue if send delivered status from 3PL deliver api but current status is "delivered"
    [Tags]    regression    TC_ITMWM_02234    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    ${logistic_code}    set variable    Alpha
    ${tracking_number}    set variable    ITM${order_id}
    ${body}=    Create Request Api update item status Shipped with tracking and 3PL for Multi-item    ${order_id}    ${order_shipment_data}    ${logistic_code}    ${tracking_number}    1
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    Sleep    1s
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    ${Variable_Token}=    get_3pl_access_token    ${logistic_code}
    API Receive Status    ${tracking_number}    ${Variable_Token}
    Tracking - Expected Response From Api    "success"    "200"    "Update tracking status is successfully."
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    delivered    ${pcms_email}
    ${result}=    Tracking - Get Retry Queues Tracking Number In DB    ${tracking_number}
    Should Be Equal As Strings    ${result}    None
    ${count_retry}=    Tracking - Count Tracking Receive Queues    ${tracking_number}
    ${count_log}=    Tracking - Count Tracking Receive Log    ${tracking_number}
    Should Be Equal As Integers    ${count_retry}    0
    Should Be Equal As Integers    ${count_log}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02235 If send delivered status from 3PL deliver api but current status is order pending, system will insert log to DB and insert data to retry-queue.
    [Tags]    regression    TC_ITMWM_02235    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    # ${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    ${logistic_code}    set variable    Alpha
    ${tracking_number}    set variable    ITM${order_id}
    ${third_pl_id}=    get_3pl_id_by_name    ${logistic_code}
    ${Variable_Token}=    get_3pl_access_token    ${logistic_code}
    API Receive Status    ${tracking_number}    ${Variable_Token}
    Tracking - Expected Response From Api    "success"    "200"    "Update tracking status is successfully."
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    # TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    order_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    order_pending    ${pcms_email}
    ${result}=    Tracking - Get Retry Queues Tracking Number In DB    ${tracking_number}
    Should Not Be Equal As Strings    ${result}    None
    Tracking - Verify Retry Queues Tracking Number In DB    ${result}    ${third_pl_id}    ${tracking_number}    0    2    N
    ${count_retry}=    Tracking - Count Tracking Receive Queues    ${tracking_number}
    ${count_log}=    Tracking - Count Tracking Receive Log    ${tracking_number}
    Should Be Equal As Integers    ${count_retry}    1
    Should Be Equal As Integers    ${count_log}    1
    [Teardown]    Close All Browsers


TC_ITMWM_02236 If send delivered status from 3PL deliver api but current status is pending shipment, system will insert log to DB and insert data to retry-queue.
    [Tags]    regression    TC_ITMWM_02236    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    Sleep    1s
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    pending_shipment
    ${logistic_code}    set variable    Alpha
    ${tracking_number}    set variable    ITM${order_id}
    ${third_pl_id}=    get_3pl_id_by_name    ${logistic_code}
    ${Variable_Token}=    get_3pl_access_token    ${logistic_code}
    API Receive Status    ${tracking_number}    ${Variable_Token}
    Tracking - Expected Response From Api    "success"    "200"    "Update tracking status is successfully."
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Pending Shipment
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    pending_shipment    ${pcms_email}
    ${result}=    Tracking - Get Retry Queues Tracking Number In DB    ${tracking_number}
    Should Not Be Equal As Strings    ${result}    None
    Tracking - Verify Retry Queues Tracking Number In DB    ${result}    ${third_pl_id}    ${tracking_number}    0    2    N
    ${count_retry}=    Tracking - Count Tracking Receive Queues    ${tracking_number}
    ${count_log}=    Tracking - Count Tracking Receive Log    ${tracking_number}
    Should Be Equal As Integers    ${count_retry}    1
    Should Be Equal As Integers    ${count_log}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02237 If the same data is send for the second time and data is already inserted to retry-queue at the first time, system will not insert duplicate data to retry-queue but system still log to DB.
    [Tags]    regression    TC_ITMWM_02237    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    ${logistic_code}    set variable    Alpha
    ${tracking_number}    set variable    ITM${order_id}
    ${body}=    Create Request Api update item status Shipped with tracking and 3PL for Multi-item    ${order_id}    ${order_shipment_data}    ${logistic_code}    ${tracking_number}    1
    Send Api update status    ${body}
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    ${Variable_Token}=    get_3pl_access_token    ${logistic_code}
    API Receive Status    ${tracking_number}    ${Variable_Token}
    Tracking - Expected Response From Api    "success"    "200"    "Update tracking status is successfully."
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    delivered
    ${result}=    Tracking - Get Retry Queues Tracking Number In DB    ${tracking_number}
    Should Be Equal As Strings    ${result}    None
    #    Duplicate API Sending #2
    ${Variable_Token}=    get_3pl_access_token    ${logistic_code}
    API Receive Status    ${tracking_number}    ${Variable_Token}
    Tracking - Expected Response From Api    "success"    "200"    "Update tracking status is successfully."
    ${count_retry}=    Tracking - Count Tracking Receive Queues    ${tracking_number}
    ${count_log}=    Tracking - Count Tracking Receive Log    ${tracking_number}
    Should Be Equal As Integers    ${count_retry}    0
    Should Be Equal As Integers    ${count_log}    2
    [Teardown]    Close All Browsers

TC_ITMWM_02238 If send delivered status from 3PL deliver api but using invalid token, system will return error message "401: access denied"
    [Tags]    regression    TC_ITMWM_02238    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    ${logistic_code}    set variable    Alpha
    ${tracking_number}    set variable    ITM${order_id}
    ${wrong_Token}    set variable    wrong_token
    ${body}=    Create Request Api update item status Shipped with tracking and 3PL for Multi-item    ${order_id}    ${order_shipment_data}    ${logistic_code}    ${tracking_number}    1
    Send Api update status    ${body}
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    API Receive Status    ${tracking_number}    ${wrong_Token}
    Tracking - Expected Response From Api    "error"    "101"    "Access Denied."
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    shipped
    ${result}=    Tracking - Get Retry Queues Tracking Number In DB    ${tracking_number}
    Should Be Equal As Strings    ${result}    None
    ${count_retry}=    Tracking - Count Tracking Receive Queues    ${tracking_number}
    ${count_log}=    Tracking - Count Tracking Receive Log    ${tracking_number}
    Should Be Equal As Integers    ${count_retry}    0
    Should Be Equal As Integers    ${count_log}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02239 To verify that system keep correct 3PL name(match with token) when send delivered status from 3PL deliver api.
    [Tags]    regression    TC_ITMWM_02239    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    ${logistic_code}    set variable    Alpha
    ${tracking_number}    set variable    ITM${order_id}
    ${body}=    Create Request Api update item status Shipped with tracking and 3PL for Multi-item    ${order_id}    ${order_shipment_data}    ${logistic_code}    ${tracking_number}    1
    Send Api update status    ${body}
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    ${Variable_Token}=    get_3pl_access_token    ${logistic_code}
    API Receive Status    ${tracking_number}    ${Variable_Token}
    Tracking - Expected Response From Api    "success"    "200"    "Update tracking status is successfully."
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    delivered
    ${result}=    Tracking - Get Retry Queues Tracking Number In DB    ${tracking_number}
    Should Be Equal As Strings    ${result}    None
    TrackedOrder - Verify 3pl on UI    ${order_id}    ${order_shipment_data[0][0]}    ${logistic_code}
    ${count_retry}=    Tracking - Count Tracking Receive Queues    ${tracking_number}
    ${count_log}=    Tracking - Count Tracking Receive Log    ${tracking_number}
    Should Be Equal As Integers    ${count_retry}    0
    Should Be Equal As Integers    ${count_log}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02240 To verify that system can not receive tracking that does not start with configured prefix and does not change status to delivered. (Insert into log but not insert into queue)
    [Tags]    regression    TC_ITMWM_02240    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    ${logistic_code}    set variable    Alpha
    ${tracking_number}    set variable    AAA${order_id}
    ${body}=    Create Request Api update item status Shipped with tracking and 3PL for Multi-item    ${order_id}    ${order_shipment_data}    ${logistic_code}    ${tracking_number}    1
    Send Api update status    ${body}
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    ${Variable_Token}=    get_3pl_access_token    ${logistic_code}
    API Receive Status    ${tracking_number}    ${Variable_Token}
    Tracking - Expected Response From Api    "success"    "200"    "Update tracking status is successfully."
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    shipped
    ${result}=    Tracking - Get Retry Queues Tracking Number In DB    ${tracking_number}
    Should Be Equal As Strings    ${result}    None
    ${count_retry}=    Tracking - Count Tracking Receive Queues    ${tracking_number}
    ${count_log}=    Tracking - Count Tracking Receive Log    ${tracking_number}
    Should Be Equal As Integers    ${count_retry}    0
    Should Be Equal As Integers    ${count_log}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02241 To verify that system can update status (and log to DB) from shipped to delivered when send delivered status from 3PL deliver api
    [Tags]    regression    TC_ITMWM_02241    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    ${third_pl_name}    set variable    ThorRobotTest3plDelivery
    ${third_pl_fullname}    set variable    ThorRobotTest3plDeliveryFullName
    ${third_pl_access_token}    set variable    ThorRobotTest3plDeliveryAccessToken
    Tracking - Add New Third PL    ${third_pl_name}    ${third_pl_fullname}    ${third_pl_access_token}
    ${tracking_number}    set variable    ITM${order_id}
    ${body}=    Create Request Api update item status Shipped with tracking and 3PL for Multi-item    ${order_id}    ${order_shipment_data}    ${third_pl_name}    ${tracking_number}    1
    Send Api update status    ${body}
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    ${Variable_Token}=    get_3pl_access_token    ${third_pl_name}
    Log To Console    ${Variable_Token}
    API Receive Status    ${tracking_number}    ${Variable_Token}
    Tracking - Expected Response From Api    "success"    "200"    "Update tracking status is successfully."
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Delivered
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    delivered
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    delivered
    ${result}=    Tracking - Get Retry Queues Tracking Number In DB    ${tracking_number}
    Should Be Equal As Strings    ${result}    None
    ${count_retry}=    Tracking - Count Tracking Receive Queues    ${tracking_number}
    ${count_log}=    Tracking - Count Tracking Receive Log    ${tracking_number}
    Should Be Equal As Integers    ${count_retry}    0
    Should Be Equal As Integers    ${count_log}    1
    [Teardown]    Run Keywords    Close All Browsers
