*** Settings ***
Library           Selenium2Library
Library           HttpLibrary
Library           Collections
Library           String
Resource          ${CURDIR}/../../../Resource/init.robot
Library           ${CURDIR}/../../../Python_Library/DatabaseData.py
Library           ${CURDIR}/../../../Python_Library/order_shipment_items_library.py
Library           ${CURDIR}/../../../Python_Library/order_tracking.py
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Stock/keywords_stock.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Product/keywords_product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Track_order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../../Keyword/API/FMS/FMS_ORDER.robot

*** Keywords ***
Prepare Order Shipment Items and set item status Return Pending
    ${order_id}    Create Order API - Guest buy single product success with COD     ${default_inventoryID_retail}    10
    log to console     order==${order_id}
    LOGIN PCMS
    # ${order_id}=   Set Variable   20001288
    ${row}=    Track Order - Get Order Shipment Items    ${order_id}
    TrackOrder - Go To Order Detail Page    ${order_id}
    :FOR    ${item}    IN    @{row}
    \    TrackOrder - Set Item status    ${item[0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    :FOR    ${item}    IN    @{row}
    \    TrackOrder - Set Item status    ${item[0]}    ${item_status_db_shipped}
    TrackOrder - Click save all
    :FOR    ${item}    IN    @{row}
    \    TrackOrder - Set Item status    ${item[0]}    ${item_status_db_delivered}
    TrackOrder - Click save all
    :FOR    ${item}    IN    @{row}
    \    TrackOrder - Set Item status    ${item[0]}    ${item_status_db_customer_cancelled}
    \    TrackOrder - Set Cancel Reason    ${item[0]}    21
    \    TrackOrder - Set Operation Status    ${item[0]}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    :FOR    ${item}    IN    @{row}
    \   TrackOrder - Check Item Status on UI    ${item[0]}    ${item_status_ui_return_pending}
    \   TrackOrder - Check Item Status on DB    ${item[0]}    ${item_status_db_return_pending}
    [return]    ${order_id}

Set item status Return Pending less than current date
    [Arguments]    ${order_id}
    ${row}=    Track Order - Get Order Shipment Items    ${order_id}
    :FOR    ${item}    IN    @{row}
    \    ${id}=     get_transaction_order_item_statuses_return_pending   ${item[0]}
    \    update_return_pending_less_than_current_date    ${id}

*** Test Cases ***
TC_ITMWM_02853
    [tags]  TC_ITMWM_02853   itm-a-sprint 2016s15     itma-3222    ready
    ${order_id}=    Prepare Order Shipment Items and set item status Return Pending
    Set item status Return Pending less than current date    ${order_id}
    Track Order - Run Cron Update item Status
     ${body}=   Get Text   //body
     ${data}=    Parse Json    ${body}
     Log to console    Variable_Data = ${data}
     # ${data}=    Parse Json   [{"success":[10002289,10002290,10002291,10002292,10002293,10002294,10002295,10002296,10002297,10002298],"failed":[]}]
     ${len}=   Get Length    ${data[0]['success']}
     ${len}=   Evaluate    ${len} - 1
     Login Pcms Browser Existing
    :FOR   ${index}  IN range     0   ${len}
    \   ${order_id}=    Track Order - Get Order ID by Item ID    ${data[0]['success'][${index}]}
    \   Log to console    - ${index}.... order_id===${order_id}, ====item_ID==${data[0]['success'][${index}]}
    \   TrackOrder - Go To Order Detail Page    ${order_id}
    \   TrackOrder - Check Item Status on UI    ${data[0]['success'][${index}]}    ${item_status_ui_delivered}
    \   TrackOrder - Check Item Status on DB    ${data[0]['success'][${index}]}    ${item_status_db_delivered}
    \   Verify Item Status Create Date Is Less Than    ${data[0]['success'][${index}]}    14
    \   Verify item status on FMS    ${data[0]['success'][${index}]}    ${item_status_fms_delivered}
    \   TrackOrder - Check Operation Status on UI    ${data[0]['success'][${index}]}    ${operation_ui_none}
    \   TrackOrder - Check Operation Status on DB    ${data[0]['success'][${index}]}    ${operation_db_none}
    \   TrackOrder - Set Item status    ${data[0]['success'][${index}]}    ${item_status_db_customer_cancelled}
    \   TrackOrder - Set Cancel Reason    ${data[0]['success'][${index}]}    21
    \   TrackOrder - Set Operation Status    ${data[0]['success'][${index}]}    ${operation_db_return_refund_request}
    \   TrackOrder - Click save     ${data[0]['success'][${index}]}
    \   TrackOrder - Check Item Status on UI    ${data[0]['success'][${index}]}    ${item_status_ui_return_pending}
    \   TrackOrder - Check Item Status on DB    ${data[0]['success'][${index}]}    ${item_status_db_return_pending}
    \   TrackOrder - Check Operation Status on UI    ${data[0]['success'][${index}]}    ${operation_ui_return_refund_request}
    \   TrackOrder - Check Operation Status on DB    ${data[0]['success'][${index}]}    ${operation_db_return_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02854
    [tags]  TC_ITMWM_02854   itm-a-sprint 2016s15     itma-3222    ready
    ${order_id}=    Prepare Order Shipment Items and set item status Return Pending
    Set item status Return Pending less than current date    ${order_id}
    Track Order - Run Cron Update item Status
     ${body}=   Get Text   //body
     ${data}=    Parse Json    ${body}
     # ${data}=    Parse Json   [{"success":[10002289,10002290,10002291,10002292,10002293,10002294,10002295,10002296,10002297,10002298],"failed":[]}]
     ${len}=   Get Length    ${data[0]['success']}
     ${len}=   Evaluate    ${len} - 1
     Login Pcms Browser Existing
    :FOR   ${index}  IN range     0   ${len}
    \   ${order_id}=    Track Order - Get Order ID by Item ID    ${data[0]['success'][${index}]}
    \   Log to console    - ${index}.... order_id===${order_id}, ====item_ID==${data[0]['success'][${index}]}
    \   TrackOrder - Go To Order Detail Page    ${order_id}
    \   TrackOrder - Check Item Status on UI    ${data[0]['success'][${index}]}    ${item_status_ui_delivered}
    \   TrackOrder - Check Item Status on DB    ${data[0]['success'][${index}]}    ${item_status_db_delivered}
    \   TrackOrder - Check Operation Status on UI    ${data[0]['success'][${index}]}    ${operation_ui_none}
    \   TrackOrder - Check Operation Status on DB    ${data[0]['success'][${index}]}    ${operation_db_none}
    \   Verify Item Status Create Date Is Less Than    ${data[0]['success'][${index}]}    14
    \   Verify item status on FMS    ${data[0]['success'][${index}]}    ${item_status_fms_delivered}
    \   TrackOrder - Set Item status    ${data[0]['success'][${index}]}    ${item_status_db_replacement_pending}
    \   TrackOrder - Click save     ${data[0]['success'][${index}]}
    \   TrackOrder - Check Item Status on UI    ${data[0]['success'][${index}]}    ${item_status_ui_replacement_pending}
    \   TrackOrder - Check Item Status on DB    ${data[0]['success'][${index}]}    ${item_status_db_replacement_pending}
    \   TrackOrder - Check Operation Status on UI    ${data[0]['success'][${index}]}    ${operation_ui_none}
    \   TrackOrder - Check Operation Status on DB    ${data[0]['success'][${index}]}    ${operation_db_none}
    [Teardown]    Close All Browsers
