*** Settings ***
Force Tags    WLS_Return_Refund_Replacement
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track_order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Item_status/update_item_status.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/WebElement_order.robot
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot

*** Variable ***
${email}          test_operation@gmail.com
${inventory_id}    INAAC1112611
${bank_ref_tmn}    bank-ref-robot-123

*** Test Cases ***
TC_ITMWM_01884 [UI] To verify that operation status field is added on 'order track >> view shipment itm' menu.
    [Tags]    regression    ready    TC_ITMWM_01884
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID}
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    Wait Until Element Is Visible    ${operation_element}
    [Teardown]    Close All Browsers

TC_ITMWM_01885 To verify that operation status is set as none(item level) after order is created.
    [Tags]    regression    ready    TC_ITMWM_01885
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID}
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${item_id}
    ${operation_element}=    Set Variable    //select[@id="status_operation${item_id[0][0]}"]/option
    Wait Until Element Is Not Visible    ${operation_element}
    [Teardown]    Close All Browsers

TC_ITMWM_01886 To verify that operation status can change from none to Unable to refund if payment is payment pending.
    [Tags]    regression    ready    TC_ITMWM_01886
    ${order_id}    Create Order API - Guest buy single product success with COD
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${item_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_unable_to_refund}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_unable_to_refund}
    [Teardown]    Close All Browsers

TC_ITMWM_01887 To verify that operation status can change from none to Refund request if payment status is success.
    [Tags]    regression    ready    TC_ITMWM_01887
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID}
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${item_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_01888 To verify that operation status can change from refund request to Pending TMN if payment channel = CCW.
    [Tags]    regression    ready    TC_ITMWM_01888
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID}
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${item_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_pending_tmn}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_01889 To verify that operation status can change from refund request to Pending TMN if payment channel = installment.
    [Tags]    regression    ready    TC_ITMWM_01889
    ${order_id}=    Guest Buy Product Success With Installment Payment    ${email}    กสิกรไทย    2    ${default_inventoryID}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${item_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_pending_tmn}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_01890 To verify that operation status can change from Pending TMN to SCM Require Doc. (CCW)
    [Tags]    regression    ready    TC_ITMWM_01890
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID}
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${item_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_pending_tmn}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_pending_tmn}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_scm_require_doc}    ${operation_ui_refund_complete}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_scm_require_doc}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_scm_require_doc}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_scm_require_doc}
    [Teardown]    Close All Browsers

TC_ITMWM_01891 To verify that operation status can change from Pending TMN to Refund Complete. (CCW)
    [Tags]    regression    ready    TC_ITMWM_01891
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID}
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${item_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_pending_tmn}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_pending_tmn}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_scm_require_doc}    ${operation_ui_refund_complete}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${item_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_complete}
    [Teardown]    Close All Browsers

TC_ITMWM_01892 To verify that operation status can change from refund request to CLT Doc Upload if payment channel is not CCW/installment.
    [Tags]    regression    ready    TC_ITMWM_01892
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${item_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_clt_doc_uploaded}
    [Teardown]    Close All Browsers

TC_ITMWM_01893 To verify that operation status can change from CLT Doc uploaded to SCM Verified. (if payment channel is not CCW/installment)
    [Tags]    regression    ready    TC_ITMWM_01893
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${item_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_clt_doc_uploaded}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_scm_verified}    ${operation_ui_scm_require_doc}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_scm_verified}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_scm_verified}
    [Teardown]    Close All Browsers

TC_ITMWM_01894 To verify that operation status can change from CLT Doc uploaded to SCM Require Doc. (if payment channel is not CCW/installment)
    [Tags]    regression    ready    TC_ITMWM_01894
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${item_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_clt_doc_uploaded}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_scm_verified}    ${operation_ui_scm_require_doc}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_scm_require_doc}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_scm_require_doc}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_scm_require_doc}
    [Teardown]    Close All Browsers

TC_ITMWM_01895 To verify that operation status can change from SCM Required Doc to CLT Doc Upload. (if payment channel is not CCW/installment)
    [Tags]    regression    ready    TC_ITMWM_01895
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${item_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_clt_doc_uploaded}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_scm_verified}    ${operation_ui_scm_require_doc}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_scm_require_doc}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_scm_require_doc}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_scm_require_doc}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_clt_doc_uploaded}
    [Teardown]    Close All Browsers

TC_ITMWM_01896 To verify that operation status can change from SCM Verified to Pending TMN. (if payment channel is not CCW/installment)
    [Tags]    regression    ready    TC_ITMWM_01896
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${item_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_clt_doc_uploaded}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_scm_verified}    ${operation_ui_scm_require_doc}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_scm_verified}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_scm_verified}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_pending_tmn}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_01897 To verify that operation status can change from Pending TMN to SCM Require Doc. (Counter service)
    [Tags]    regression    ready    TC_ITMWM_01897
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${item_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_clt_doc_uploaded}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_scm_verified}    ${operation_ui_scm_require_doc}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_scm_verified}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_scm_verified}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_pending_tmn}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_pending_tmn}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_scm_require_doc}    ${operation_ui_refund_complete}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_scm_require_doc}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_scm_require_doc}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_scm_require_doc}
    [Teardown]    Close All Browsers

TC_ITMWM_01898 To verify that operation status can change from SCM Require Doc to Refund Complete. (Counter service)
    [Tags]    regression    ready    TC_ITMWM_01898
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    ${item_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_request}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_clt_doc_uploaded}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_scm_verified}    ${operation_ui_scm_require_doc}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_scm_verified}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_scm_verified}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_pending_tmn}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_pending_tmn}
    ${operation_ui_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_scm_require_doc}    ${operation_ui_refund_complete}
    TrackOrder - Check Available Operation Status on UI    ${item_id[0][0]}    ${operation_ui_status}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${item_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    success
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_refund_complete}
    [Teardown]    Close All Browsers
