*** Settings ***
Resource          ${CURDIR}/../../Resource/init.robot  
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track_order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Item_status/update_item_status.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/WebElement_order.robot

*** Variable ***
${bank_ref_tmn}    bank-ref-robot-123
${bank_ref_tmn}    bank-ref-robot-123
${bank_ref_tmn_new}    bank-ref-robot-789
${email}          Test@hotmail.com
${inventory_id}    ASAAA1119111

*** Test Cases ***
To verify that system display Bank Ref TMN textbox when user select operation status 'refund complete'.
    [Tags]    QCT
    ${order_id}=    Guest Buy Product Success with CCW    ${email}    ${inventory_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Success
    Element Should Be Visible    id=bank_ref_tmn_${item_id[0][0]}
    Element Should Be Enabled    id=bank_ref_tmn_${item_id[0][0]}
    [Teardown]    Close All Browsers

Single item - Update Error - no Bank Ref TMN.
    [Tags]    QCT
    ${order_id}=    Guest Buy Product Success with CCW    ${email}    ${inventory_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    # TrackOrder - Click save    ${item_id[0][0]}
    Click Element    //button[@value="${item_id[0][0]}"]
    # ${display_error}=    Get Text    //*[@class="alert alert-error"]/p
    # Should Be Equal As Strings    ${display_error}    Bank Ref TMN is required
    Element Should Be Visible    //*[@id="bank-ref-dialog"]
    ${display_error}=    Get Text    //*[@id="bank-ref-dialog"]
    Should Be Equal As Strings    ${display_error}    TMN Payment Ref is required.
    [Teardown]    Close All Browsers

Single item - Edit and Log success.
    [Tags]    QCT
    # 1 Create order
    ${order_id}=    Guest Buy Product Success with CCW    ${email}    ${inventory_id}
    # 2 Set operation status to Pending TMN
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${item_id[0][0]}
    # 3 Set operation status to refund complete and input bank ref
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${item_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save    ${item_id[0][0]}
    Element Should Be Visible    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn}
    # 4 Edit bank ref
    Click Element    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Be Visible    id=text-box-bank-ref
    Textfield Value Should Be    id=text-box-bank-ref    ${bank_ref_tmn}
    Input Text    id=text-box-bank-ref    ${bank_ref_tmn_new}
    Click element    id=btn-save-edit-bank-ref
    Wait Until Element Is Not Visible    id=dialog-edit-bank-ref
    # 5 Verify
    TrackOrder - Check Bank Ref on DB    ${item_id[0][0]}    ${bank_ref_tmn_new}
    TrackOrder - Verify Log Bank Ref TMN    ${item_id[0][0]}    ${bank_ref_tmn_new}
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn_new}
    [Teardown]    Close All Browsers
