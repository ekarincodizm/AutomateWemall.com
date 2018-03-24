*** Settings ***
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
Resource          ${CURDIR}/../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot

*** Variable ***
${email}            guest@email.com
${material_id}      robot_material_id_123
${serial_number}    123456
${pcms_email}       admin@domain.com
${pcms_password}    12345
${default_inventoryID_cs}       LOAAB1111111

*** Test Cases ***
TC_1 in PCMS, item status= Return Rejected + Op status = RRR -> FMS sends 'Shipped' with new data
    [Tags]    TC_1    ITMA-3223    2016S15

    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID}
    ${order_id}=    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_item}=       TrackOrder - Get Order Shipment id      ${order_id}
    ${order_shipment_item_id}=    Set Variable    ${order_shipment_item[0][0]}
    Close All Browsers

    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}

    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_item}    1
    Send Api update status    ${body}

    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_item}    ${serial_number}    1
    Send Api update status    ${body}

    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status        ${order_shipment_item_id}    ${item_status_db_delivered}
    TrackOrder - Click save             ${order_shipment_item_id}
    TrackOrder - Set Item status        ${order_shipment_item_id}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason      ${order_shipment_item_id}    1
    TrackOrder - Set Operation Status   ${order_shipment_item_id}    ${operation_db_return_refund_request}
    TrackOrder - Click save             ${order_shipment_item_id}
    TrackOrder - Set Item status        ${order_shipment_item_id}    ${item_status_db_return_received}
    TrackOrder - Click save             ${order_shipment_item_id}

    TrackOrder - Check Item Status on UI            ${order_shipment_item_id}    ${item_status_ui_return_received}
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${order_shipment_item}
    Send Api update status    ${body}

    TrackOrder - Go To Order Detail Page            ${order_id}
    TrackOrder - Check Item Status on UI            ${order_shipment_item_id}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB            ${order_shipment_item_id}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI       ${order_shipment_item_id}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB       ${order_shipment_item_id}    ${operation_db_return_refund_request}

    # FMS shipped
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_item}    ${serial_number}    1
    Send Api update status    ${body}

    TrackOrder - Go To Order Detail Page            ${order_id}
    TrackOrder - Check Item Status on UI            ${order_shipment_item_id}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on DB            ${order_shipment_item_id}    ${item_status_db_shipped}
    TrackOrder - Check Operation Status on UI       ${order_shipment_item_id}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB       ${order_shipment_item_id}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_item_id}    ${item_status_db_shipped}
    TrackOrder - Verify Log OperationStatus by Api  ${order_shipment_item_id}    ${operation_db_none}

    [Teardown]    Close All Browsers

TC_2 in PCMS, item status= Return Rejected -> FMS sends 'Pick/Pack' with new data (match order id and order shipment item)
    [Tags]    TC_2    ITMA-3223    2016S15

    # ${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID}
    ${order_id}=    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_item}=       TrackOrder - Get Order Shipment id      ${order_id}
    ${order_shipment_item_id}=    Set Variable    ${order_shipment_item[0][0]}
    Close All Browsers

    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}

    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_item}    1
    Send Api update status    ${body}

    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_item}    ${serial_number}    1
    Send Api update status    ${body}

    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status        ${order_shipment_item_id}    ${item_status_db_delivered}
    TrackOrder - Click save             ${order_shipment_item_id}
    TrackOrder - Set Item status        ${order_shipment_item_id}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason      ${order_shipment_item_id}    1
    TrackOrder - Set Operation Status   ${order_shipment_item_id}    ${operation_db_return_refund_request}
    TrackOrder - Click save             ${order_shipment_item_id}
    TrackOrder - Set Item status        ${order_shipment_item_id}    ${item_status_db_return_received}
    TrackOrder - Click save             ${order_shipment_item_id}

    TrackOrder - Check Item Status on UI            ${order_shipment_item_id}    ${item_status_ui_return_received}
    ${body}=    Create Request Api update item status Return Rejected with for Multi-item    ${order_id}    ${order_shipment_item}
    Send Api update status    ${body}

    TrackOrder - Go To Order Detail Page            ${order_id}
    TrackOrder - Check Item Status on UI            ${order_shipment_item_id}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB            ${order_shipment_item_id}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI       ${order_shipment_item_id}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB       ${order_shipment_item_id}    ${operation_db_return_refund_request}

    # FMS shipped
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_item}    1
    Send Api update status fail    ${body}    401

    TrackOrder - Go To Order Detail Page            ${order_id}
    TrackOrder - Check Item Status on UI            ${order_shipment_item_id}    ${item_status_ui_return_rejected}
    TrackOrder - Check Item Status on DB            ${order_shipment_item_id}    ${item_status_db_return_rejected}
    TrackOrder - Check Operation Status on UI       ${order_shipment_item_id}    ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB       ${order_shipment_item_id}    ${operation_db_return_refund_request}
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_item_id}    ${item_status_db_return_rejected}
    TrackOrder - Verify Log OperationStatus by User  ${order_shipment_item_id}    ${operation_db_return_refund_request}    ${pcms_email}

    [Teardown]    Close All Browsers

TC_3 in PCMS, item status= Pending Shipment-> FMS sends 'Shipped' with data
    [Tags]    TC_3    ITMA-3223    2016S15

    # ${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID}
    ${order_id}=    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_item}=       TrackOrder - Get Order Shipment id      ${order_id}
    ${order_shipment_item_id}=    Set Variable    ${order_shipment_item[0][0]}
    Close All Browsers

    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}

    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_item}    1
    Send Api update status    ${body}

    TrackOrder - Go To Order Detail Page            ${order_id}

    TrackOrder - Check Item Status on UI            ${order_shipment_item_id}    ${item_status_ui_pending_shipment}
    TrackOrder - Check Item Status on DB            ${order_shipment_item_id}    ${item_status_db_pending_shipment}
    TrackOrder - Check Operation Status on UI       ${order_shipment_item_id}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB       ${order_shipment_item_id}    ${operation_db_none}

    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_item}    ${serial_number}    1
    Send Api update status    ${body}

    TrackOrder - Go To Order Detail Page            ${order_id}

    TrackOrder - Check Item Status on UI            ${order_shipment_item_id}    ${item_status_ui_shipped}
    TrackOrder - Check Item Status on DB            ${order_shipment_item_id}    ${item_status_db_shipped}
    TrackOrder - Check Operation Status on UI       ${order_shipment_item_id}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB       ${order_shipment_item_id}    ${operation_db_none}
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_item_id}    ${item_status_db_shipped}
    TrackOrder - Verify Log OperationStatus by Api  ${order_shipment_item_id}    ${operation_db_none}

    [Teardown]    Close All Browsers
