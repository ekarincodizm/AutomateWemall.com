*** Settings ***
Force Tags    WLS_Return_Refund_Replacement
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/WebElement_order.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track_Order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/User_Role/Keywords_User_Role.robot
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot

*** Variable ***
${email}          latest_update@email.com
${material_id}    robot_material_id_123
${serial_number}    123456
${pcms_email}     admin@domain.com
${pcms_password}    12345
${bank_ref_tmn}    bank-ref-robot-123
${pcms_email_user_a}    latest_update_A@test.com
${pass_user}      12345
${display_a}      A_User
${display_b}      B_User
${pcms_email_user_b}    latest_update_B@test.com
${role_user}      SuperAdmin
${inventory_id}    INAAC1112611

*** Test Cases ***
TC_ITMWM_02409 To verify that system display last update information for all operation status correctly.
    [Tags]    TC_ITMWM_02409    ready    regression
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    Refund Request
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${item_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[0][0]}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_clt_doc_uploaded}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${item_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[0][0]}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_scm_require_doc}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_scm_require_doc}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${item_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[0][0]}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_clt_doc_uploaded}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${item_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[0][0]}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_scm_verified}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${item_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[0][0]}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${item_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[0][0]}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${item_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${item_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[0][0]}
    [Teardown]    Close All Browsers

TC_ITMWM_02410 [Multiple items] To verify that system display last update information for operation status correctly if update each item in different time.
    [Tags]    TC_ITMWM_02410    ready    regression
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID}
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    PCMS Created User    ${pcms_email_user_a}    ${display_a}    ${pass_user}    ${role_user}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    PCMS Created User    ${pcms_email_user_b}    ${display_b}    ${pass_user}    ${role_user}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_user_a}    ${pass_user}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    #    item no.1
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    Refund Request
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${items_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${items_id[0][0]}
    #    item no.2
    TrackOrder - Check Operation Status on UI    ${items_id[1][0]}    ${operation_ui_none}
    TrackOrder - Verify View Last Update Status Button is not Visible    ${items_id[1][0]}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_user_b}    ${pass_user}
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    item no.2
    TrackOrder - Set Item status    ${items_id[1][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Operation Status on UI    ${items_id[1][0]}    Refund Request
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${items_id[1][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${items_id[1][0]}
    #    item no.1
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    Refund Request
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${items_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${items_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${items_id[0][0]}
    #    item no.2
    TrackOrder - Check Operation Status on UI    ${items_id[1][0]}    Refund Request
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${items_id[1][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${items_id[1][0]}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_user_a}    ${pass_user}
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    item no.2
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save all
    TrackOrder - Check Operation Status on UI    ${items_id[1][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${items_id[1][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${items_id[1][0]}
    #    item no.1
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${items_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${items_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${items_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${items_id[0][0]}
    #    item no.2
    TrackOrder - Check Operation Status on UI    ${items_id[1][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${items_id[1][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${items_id[1][0]}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_user_b}    ${pass_user}
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    item no.2
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${items_id[1][0]}    ${bank_ref_tmn}
    TrackOrder - Click save all
    TrackOrder - Check Operation Status on UI    ${items_id[1][0]}    ${operation_ui_refund_complete}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${items_id[1][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${items_id[1][0]}
    #    item no.1
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${items_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${items_id[0][0]}
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_user_a}
    ...    AND    Clear User By Email    ${pcms_email_user_b}

TC_ITMWM_02411 [Multiple items] To verify that system display last update information for operation status correctly if update each item the same time.
    [Tags]    TC_ITMWM_02411    ready    regression
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID}
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    PCMS Created User    ${pcms_email_user_a}    ${display_a}    ${pass_user}    ${role_user}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    PCMS Created User    ${pcms_email_user_b}    ${display_b}    ${pass_user}    ${role_user}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_user_a}    ${pass_user}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    #    item no.1
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Item status    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    Refund Request
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${item_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[0][0]}
    #    item no.2
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    Refund Request
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${item_id[1][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[1][0]}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_user_b}    ${pass_user}
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    item no.1,2 B
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[1][0]}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save all
    #verify 1,2 B
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${item_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${item_id[1][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[1][0]}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    TrackOrder - Set Operation Status    ${item_id[1][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${item_id[0][0]}    ${bank_ref_tmn}
    Input Text    id=bank_ref_tmn_${item_id[1][0]}    ${bank_ref_tmn}
    TrackOrder - Click save all
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${item_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_refund_complete}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${item_id[1][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[1][0]}
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_user_a}
    ...    AND    Clear User By Email    ${pcms_email_user_b}

TC_ITMWM_02412 [Multiple items] To verify that system display last update information for operation status correctly after get fail delivery from FMS.
    [Tags]    TC_ITMWM_02412    ready    regression
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID}
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    PCMS Created User    ${pcms_email_user_a}    ${display_a}    ${pass_user}    ${role_user}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    PCMS Created User    ${pcms_email_user_b}    ${display_b}    ${pass_user}    ${role_user}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_user_a}    ${pass_user}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    #    item no.1
    TrackOrder - Set Item status    ${item_id[0][0]}    pending_shipment
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    shipped
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${item_id[0][0]}    cancel_pending
    TrackOrder - Click save all
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Verify View Last Update Status Button is not Visible    ${item_id[0][0]}
    #    item no.2
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    ${operation_ui_none}
    TrackOrder - Verify View Last Update Status Button is not Visible    ${item_id[1][0]}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_user_b}    ${pass_user}
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    item no.2
    TrackOrder - Set Item status    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    Refund Request
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${item_id[1][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[1][0]}
    #    item no.1
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    None
    TrackOrder - Verify View Last Update Status Button is not Visible    ${item_id[0][0]}
    ${body}=    Create Request Api update item status Failed Delivery with for Multi-item    ${order_id}    ${item_id}
    Log To Console    ${body}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    #    item no.1
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    Refund Request
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${item_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[0][0]}
    #    item no.2
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    Refund Request
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${item_id[1][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[1][0]}
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_user_a}
    ...    AND    Clear User By Email    ${pcms_email_user_b}

TC_ITMWM_02413 For COD multiple items, To verify that system display last update information for operation status correctly if change some item status to customer cancelled.
    [Tags]    TC_ITMWM_02413    ready    regression
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Close All Browsers
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    PCMS Created User    ${pcms_email_user_a}    ${display_a}    ${pass_user}    ${role_user}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_user_a}    ${pass_user}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    Unable to Refund
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${item_id[0][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${item_id[1][0]}    Unable to Refund
    TrackOrder - Verify View Last Update Button for Operation Status is Visible    ${item_id[1][0]}
    TrackOrder - Verify Last Update for Operation Status is Shown Correctly    ${item_id[1][0]}
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_user_a}
