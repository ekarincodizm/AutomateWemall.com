*** Settings ***
Force Tags        WLS_ACL
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/User_Role/Keywords_User_Role.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track_order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Item_status/update_item_status.robot
Library           ${CURDIR}/../../Python_Library/common.py
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Orders/Keywords_upload_operation_status.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Orders/web_element_upload_operation_status.robot

*** Variable ***
${email-guest}    testMassUpload_operation@domain.com
${pcms_email}     admin@domain.com
${pcms_pass}      12345
${pcms_email_operation}    Robot_Mass_Upload_Status@test.com
${pcms_user_operation}    Test Mass Upload Status
${pcms_pass_operation}    12345
${user_role_group}    Robot Mass Upload Status
${user_id}        35
${track-order_view}    track-order_view
${upload_operation_manage}    upload-operation-status_view-and-manage
${view_operation_status}    track-order_view-operation-status-to

*** Test Cases ***
TC_ITMWM_07478 To verify that ACL work correctly when apply user role with Upload operation status = view&manage and apply permission in user level = Inherit
    [Tags]    TC_1759_1    WLS_Low
    Login Pcms    ${pcms_email}    ${pcms_pass}
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${upload_operation_manage}    ${view_operation_status}
    PCMS Set Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_operation}    ${pcms_user_operation}    ${pcms_pass_operation}    ${user_role_group}
    @{content}=    Refund Request To Pending TMN - Append Header To List
    ${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
    Log To Console    order id=${order_id}
    Close All Browsers
    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item id=${items_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_request}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Log To Console    content=${content}
    Verify Upload Operation Status Menu Is Shown
    Click Upload Operation Status Menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    Upload Operation Status - verify success only    1
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_pending_tmn}
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_operation}
    ...    AND    Clear User Role By Name    ${user_role_group}

TC_ITMWM_07479 To verify that ACL work correctly when apply user role with Upload operation status = view&manage but apply permission in user level = Allow
    [Tags]    TC_1759_2    WLS_Low
    Login Pcms    ${pcms_email}    ${pcms_pass}
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${upload_operation_manage}    ${view_operation_status}
    PCMS Set Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_operation}    ${pcms_user_operation}    ${pcms_pass_operation}    ${user_role_group}
    @{permission_list_unset}=    Create List    ${upload_operation_manage}
    PCMS Set Permission For User    ${pcms_email_operation}    @{permission_list_unset}
    @{content}=    Refund Request To Pending TMN - Append Header To List
    ${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
    Log To Console    order id=${order_id}
    Close All Browsers
    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item id=${items_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_request}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Log To Console    content=${content}
    Verify Upload Operation Status Menu Is Shown
    Click Upload Operation Status Menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    Upload Operation Status - verify success only    1
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_pending_tmn}
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_operation}
    ...    AND    Clear User Role By Name    ${user_role_group}

TC_ITMWM_07480 To verify that ACL work correctly when apply user role with Upload operation status = view&manage but apply permission in user level = Not allow
    [Tags]    TC_1759_3    regression    ready    WLS_High
    Login Pcms    ${pcms_email}    ${pcms_pass}
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${upload_operation_manage}    ${view_operation_status}
    PCMS Set Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_operation}    ${pcms_user_operation}    ${pcms_pass_operation}    ${user_role_group}
    @{permission_list_unset}=    Create List    ${upload_operation_manage}
    PCMS Unset Permission For User    ${pcms_email_operation}    @{permission_list_unset}
    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    Verify Upload Operation Status Menu Is Not Shown
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_operation}
    ...    AND    Clear User Role By Name    ${user_role_group}

TC_ITMWM_07481 To verify that ACL work correctly when apply user role with Upload operation status = Not allow to view&manage
    [Tags]    TC_1759_4    WLS_Low
    Login Pcms    ${pcms_email}    ${pcms_pass}
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${view_operation_status}
    PCMS Set Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_operation}    ${pcms_user_operation}    ${pcms_pass_operation}    ${user_role_group}
    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    Verify Upload Operation Status Menu Is Not Shown
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_operation}
    ...    AND    Clear User Role By Name    ${user_role_group}

TC_ITMWM_07482 To verify that ACL work correctly when apply user role with Upload operation status = Not allow to view&manage but apply permission in user level = Allow
    [Tags]    TC_1759_5    WLS_Low
    Login Pcms    ${pcms_email}    ${pcms_pass}
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${view_operation_status}
    PCMS Set Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_operation}    ${pcms_user_operation}    ${pcms_pass_operation}    ${user_role_group}
    @{permission_list_unset}=    Create List    ${upload_operation_manage}
    PCMS Set Permission For User    ${pcms_email_operation}    @{permission_list_unset}
    @{content}=    Refund Request To Pending TMN - Append Header To List
    ${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
    Log To Console    order id=${order_id}
    Close All Browsers
    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item id=${items_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_request}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Log To Console    content=${content}
    Verify Upload Operation Status Menu Is Shown
    Click Upload Operation Status Menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    Upload Operation Status - verify success only    1
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_pending_tmn}
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_operation}
    ...    AND    Clear User Role By Name    ${user_role_group}

TC_ITMWM_07483 To verify that ACL work correctly when apply user role with Upload operation status = Not allow to view&manage and apply permission in user level = Not allow
    [Tags]    TC_1759_6    WLS_Low
    Login Pcms    ${pcms_email}    ${pcms_pass}
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${view_operation_status}
    PCMS Set Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_operation}    ${pcms_user_operation}    ${pcms_pass_operation}    ${user_role_group}
    @{permission_list_unset}=    Create List    ${upload_operation_manage}
    PCMS Unset Permission For User    ${pcms_email_operation}    @{permission_list_unset}
    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    Verify Upload Operation Status Menu Is Not Shown
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_operation}
    ...    AND    Clear User Role By Name    ${user_role_group}

*** Keywords ***
Verify Upload Operation Status Menu Is Shown
    Page Should Contain Element    //*[@id="mws-navigation"]/ul/li/ul/li[3]/a

Click Upload Operation Status Menu
    Wait Until Element Is Visible    //*[@id="mws-navigation"]/ul/li/ul/li[3]/a
    Click Element    //*[@id="mws-navigation"]/ul/li/ul/li[3]/a

Verify Upload Operation Status Menu Is Not Shown
    Page Should Not Contain Element    //*[@id="mws-navigation"]/ul/li/ul/li[3]/a
