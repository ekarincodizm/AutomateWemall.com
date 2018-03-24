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

*** Variable ***
${email-guest}    test_display_remark@domain.com
${pcms_email}     test_display_remark@gmail.com
${pcms_pass}      12345
${inventory_id}    INAAC1112611
${display_name}    thortestlimitdisplayname
${remark_text}    Hello, This is Remark @#$%^++
${user_role_group}    Test_Document_Remark
${element_btn_save_doc_remark}    //button[@id="btn-save-doc-remark"]
${element_error_dialog}    //div[@id="error-dialog"]
${error_message_1}    Please input Document remark!!
${remark_text_1}    ทดสอบ document remark ครั้งที่ 1
${remark_text_2}    ทดสอบ document remark ครั้งที่ 2
${track-order_view-operation-status}    track-order_view-operation-status-to
${track-order_manage-operation-status}    track-order_manage-operation-status-to

*** Test Cases ***
TC_ITMWM_02026 Verify Document Remark Section is Shown
    [Tags]    TC_ITMWM_02026    regression    ready
    #${order_id}=    Guest Buy Product Success with CCW    ${email-guest}    ${inventory_id}
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${display_name}    Set Variable    remarker
    ${pcms_email}    Set Variable    remarker@email.com
    LOGIN PCMS
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${order-doc_view}    ${order-doc_manage}
    PCMS Set Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email}    ${display_name}    ${pcms_pass}    ${user_role_group}
    ${user_id}=    Get Id User by Email    ${pcms_email}
    Login Pcms    ${pcms_email}    ${pcms_pass}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Doc remark - Verify Doc remark section is shown
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email}
    ...    AND    Clear User Role By Name    ${user_role_group}

TC_ITMWM_02027 Verify User Can Update Document Remark
    [Tags]    TC_ITMWM_02027    regression    ready
    #${order_id}=    Guest Buy Product Success with CCW    ${email-guest}    ${inventory_id}
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${display_name}    Set Variable    remarker
    ${pcms_email}    Set Variable    remarker@email.com
    LOGIN PCMS
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${order-doc_view}    ${order-doc_manage}    ${track-order_view-operation-status}    ${track-order_manage-operation-status}
    PCMS Set Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email}    ${display_name}    ${pcms_pass}    ${user_role_group}
    ${user_id}=    Get Id User by Email    ${pcms_email}
    Login Pcms    ${pcms_email}    ${pcms_pass}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Doc remark - Verify Doc remark section is shown
    Input Text    id=text-box-doc-remark    ${remark_text_1}
    TrackOrder - Click enter
    TrackOrder - Doc remark - Check remark on UI    ${remark_text_1}
    TrackOrder - Doc remark - Check displayname on UI    ${display_name}
    TrackOrder - Doc remark - Check remark datetime on UI
    Input Text    id=text-box-doc-remark    ${remark_text_2}
    TrackOrder - Click enter
    TrackOrder - Doc remark - Check remark on UI    ${remark_text_2}
    TrackOrder - Doc remark - Check displayname on UI    ${display_name}
    TrackOrder - Doc remark - Check remark datetime on UI
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email}
    ...    AND    Clear User Role By Name    ${user_role_group}

TC_ITMWM_02028 Verify User Can Update Document Remark Latest First Line
    [Tags]    TC_ITMWM_02028    regression    ready
    #${order_id}=    Guest Buy Product Success with CCW    ${email-guest}    ${inventory_id}
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${display_name}    Set Variable    remarker
    ${pcms_email}    Set Variable    remarker@email.com
    LOGIN PCMS
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${order-doc_view}    ${order-doc_manage}    ${track-order_view-operation-status}    ${track-order_manage-operation-status}
    PCMS Set Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email}    ${display_name}    ${pcms_pass}    ${user_role_group}
    ${user_id}=    Get Id User by Email    ${pcms_email}
    Login Pcms    ${pcms_email}    ${pcms_pass}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Doc remark - Verify Doc remark section is shown
    Input Text    id=text-box-doc-remark    ${remark_text}
    TrackOrder - Click enter
    TrackOrder - Doc remark - Check remark on UI    ${remark_text}
    TrackOrder - Doc remark - Check displayname on UI    ${display_name}
    TrackOrder - Doc remark - Check remark datetime on UI
    TrackOrder - Doc remark - Check Remark In DB    ${order_id}    ${remark_text}    ${user_id}
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email}
    ...    AND    Clear User Role By Name    ${user_role_group}

TC_ITMWM_02029 To verify that system will display displayname only first 20 characters and ... if displayname is more than 20 characters
    [Tags]    TC_ITMWM_02029    regression    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    #    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${order-doc_view}    ${order-doc_manage}    ${track-order_view-operation-status}    ${track-order_manage-operation-status}
    PCMS Set Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email}    ${display_name}    ${pcms_pass}    ${user_role_group}
    ${user_id}=    Get Id User by Email    ${pcms_email}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    Login Pcms    ${pcms_email}    ${pcms_pass}
    TrackOrder - Go To Order Detail Page    ${order_id}
    Input Text    id=text-box-doc-remark    ${remark_text}
    TrackOrder - Click enter
    TrackOrder - Doc remark - Check remark on UI    ${remark_text}
    TrackOrder - Doc remark - Check displayname on UI    ${display_name}
    TrackOrder - Doc remark - Check remark datetime on UI
    TrackOrder - Doc remark - Check Remark In DB    ${order_id}    ${remark_text}    ${user_id}
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email}
    ...    AND    Clear User Role By Name    ${user_role_group}

TC_ITMWM_02030 To verify that system display error message when user didn't input document remark and click enter
    [Tags]    TC_ITMWM_02030    regression    ready
    #    ${order_id}=    Guest Buy Product Success with COD    ${email-guest}    ${inventory_id}
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    #    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${order-doc_view}    ${order-doc_manage}    ${track-order_view-operation-status}    ${track-order_manage-operation-status}
    PCMS Set Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email}    ${display_name}    ${pcms_pass}    ${user_role_group}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    Login Pcms    ${pcms_email}    ${pcms_pass}
    TrackOrder - Go To Order Detail Page    ${order_id}
    Wait Until Element is ready and click    ${element_btn_save_doc_remark}    10
    TrackOrder - doc remark - Check error message on UI    ${error_message_1}    ${element_error_dialog}
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email}
    ...    AND    Clear User Role By Name    ${user_role_group}
