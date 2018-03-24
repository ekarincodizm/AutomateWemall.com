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
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/WebElement_order.robot


*** Variable ***
${pcms_email}    admin@domain.com
${pcms_pass}    12345
${pcms_email_operation}    operation@test.com
${pcms_user_operation}    Operation Test
${pcms_pass_operation}    12345
${user_role_group}    Robot Test Operation Acl
#${user_role_group}    Warehouse
${track-order_view}    track-order_view
${track-order_view-operation-status}    track-order_view-operation-status-to
${track-order_manage-operation-status}    track-order_manage-operation-status-to

${bank_ref_tmn}      bank-ref-robot-123
${bank_ref_tmn}    bank-ref-robot-123
${bank_ref_tmn_new}    bank-ref-robot-789
${email}          Test@hotmail.com
${inventory_id}   ASAAA1119111

*** Test Cases ***
TC_ITMWM_01945 Create user and apply user role with operation status permission = view only
    [Tags]    ready    regression    TC_ITMWM_01945    WLS_High
    [Teardown]    Run Keywords    Clear User By Email    ${pcms_email_operation}
    ...    AND    Clear User Role By Name    ${user_role_group}
    ...    AND    Close All Browsers


#   Step 1 : Set Permission
    Login Pcms    ${pcms_email}    ${pcms_pass}
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${track-order_view-operation-status}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_operation}    ${pcms_user_operation}    ${pcms_pass_operation}    ${user_role_group}

#   Step 2 : Create Order
   ${order_id}=    Guest Buy Product Success with CCW      ${email}    ${inventory_id}
    # ${order_id}=     Set Variable    3003183
    Log To Console       order_id = ${order_id}

#   Step 3 : Verify ACL work correctly : cannot edit operation status
    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Wait Until Element Is Visible           ${operation_element}
    TrackOrder - Set Item status            ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_request}
    Element Should Be Disabled    ${element_drop_down_operation}

#   Step 4 : Change operation status to refund complete with bank ref tmn
    Login Pcms    ${pcms_email}    ${pcms_pass}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${item_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_complete}

    Element Should Be Visible    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn}

#   Step 5 : Verify ACL work correctly : cannot edit Bank Ref TMN
    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Wait Until Element Is Visible           ${operation_element}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_complete}
    Element Should Not Be Visible    ${element_drop_down_operation}
    Element Should Be Visible    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn}
    Element Should Not Be Visible    id=bank_ref_tmn_${item_id[0][0]}
    Click Element    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Not Be Visible    id=text-box-bank-ref


TC_ITMWM_01946 Create user and apply user role with operation status permission = manage only
    [Tags]    ready    regression    TC_ITMWM_01946    WLS_High
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_operation}
    ...    AND    Clear User Role By Name    ${user_role_group}

#   Set Permission
    Login Pcms    ${pcms_email}    ${pcms_pass}
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${track-order_manage-operation-status}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_operation}    ${pcms_user_operation}    ${pcms_pass_operation}    ${user_role_group}

#   Create Order
    ${order_id}=    Guest Buy Product Success with CCW      testforthor@gmail.com
    Log To Console       order_id = ${order_id}
    # ${order_id}=    Set Variable    3000415

#   Verify ACL work correctly : can edit operation status
    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Wait Until Element Is Visible           ${operation_element}

    TrackOrder - Set Item status            ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_request}
    Element Should Be Enabled    ${element_drop_down_operation}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}

    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_pending_tmn}
    Element Should Be Enabled    ${element_drop_down_operation}

    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${item_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save                 ${item_id[0][0]}
    Element Should Be Visible    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn}

#   Verify ACL work correctly : can edit bank ref
    Click Element    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Be Visible    id=text-box-bank-ref
    Textfield Value Should Be    id=text-box-bank-ref    ${bank_ref_tmn}
    Input Text    id=text-box-bank-ref    ${bank_ref_tmn_new}
    Click element    id=btn-save-edit-bank-ref
    Wait Until Element Is Not Visible    id=dialog-edit-bank-ref
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn_new}


TC_ITMWM_01947 Create user and apply user role with operation status permission = view&manage
    [Tags]    ready    regressiony    TC_ITMWM_01947    WLS_Low
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_operation}
    ...    AND    Clear User Role By Name    ${user_role_group}

#   Set Permission
    Login Pcms    ${pcms_email}    ${pcms_pass}
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${track-order_view-operation-status}    ${track-order_manage-operation-status}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_operation}    ${pcms_user_operation}    ${pcms_pass_operation}    ${user_role_group}

#   Create Order
    ${order_id}=    Guest Buy Product Success with CCW      testforthor@gmail.com
    Log To Console       order_id = ${order_id}
    # ${order_id}=    Set Variable    3000412

#   Verify ACL work correctly : can edit operation status
    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Wait Until Element Is Visible           ${operation_element}

    TrackOrder - Set Item status            ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_request}
    Element Should Be Enabled    ${element_drop_down_operation}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}

    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_pending_tmn}
    Element Should Be Enabled    ${element_drop_down_operation}

    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${item_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save                 ${item_id[0][0]}
    Element Should Be Visible    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn}

#   Verify ACL work correctly : can edit bank ref
    Click Element    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Be Visible    id=text-box-bank-ref
    Textfield Value Should Be    id=text-box-bank-ref    ${bank_ref_tmn}
    Input Text    id=text-box-bank-ref    ${bank_ref_tmn_new}
    Click element    id=btn-save-edit-bank-ref
    Wait Until Element Is Not Visible    id=dialog-edit-bank-ref
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn_new}

TC_ITMWM_01948 Create user and apply user role with operation status permission = not allow
    [Tags]    TC_18    ready    TC_ITMWM_01948    WLS_Low
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_operation}
    ...    AND    Clear User Role By Name    ${user_role_group}

    Login Pcms    ${pcms_email}    ${pcms_pass}
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_operation}    ${pcms_user_operation}    ${pcms_pass_operation}    ${user_role_group}

    ${order_id}=    Guest Buy Product Success with CCW      testforthor@gmail.com
    Log To Console       order_id = ${order_id}
    # ${order_id}=    Set Variable    3000409

    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Element Should Not Be Visible    ${operation_element}
    Element Should Not Be Visible    ${element_drop_down_operation}


TC_ITMWM_01949 Create user and apply user role with operation status permission = view only and change permission = manage only in user level
    [Tags]    ready    regression    TC_ITMWM_01949    WLS_Medium
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_operation}
    ...    AND    Clear User Role By Name    ${user_role_group}

#   Set Permission
    Login Pcms    ${pcms_email}    ${pcms_pass}
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${track-order_view-operation-status}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}

    PCMS Created User    ${pcms_email_operation}    ${pcms_user_operation}    ${pcms_pass_operation}    ${user_role_group}

    @{permission_list_unset}=    Create List    ${track-order_view-operation-status}
    PCMS Unset Permission For User    ${pcms_email_operation}    @{permission_list_unset}

    @{permission_list_set}=    Create List    ${track-order_manage-operation-status}
    PCMS Set Permission For User    ${pcms_email_operation}    @{permission_list_set}

#   Create Order
    ${order_id}=    Guest Buy Product Success with CCW      testforthor@gmail.com
    Log To Console       order_id = ${order_id}
    # ${order_id}=    Set Variable    3000409

#   Verify ACL work correctly : can edit operation status
    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Wait Until Element Is Visible           ${operation_element}

    TrackOrder - Set Item status            ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_request}
    Element Should Be Enabled    ${element_drop_down_operation}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}

    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_pending_tmn}
    Element Should Be Enabled    ${element_drop_down_operation}

    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${item_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save                 ${item_id[0][0]}
    Element Should Be Visible    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn}

#   Verify ACL work correctly : can edit bank ref
    Click Element    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Be Visible    id=text-box-bank-ref
    Textfield Value Should Be    id=text-box-bank-ref    ${bank_ref_tmn}
    Input Text    id=text-box-bank-ref    ${bank_ref_tmn_new}
    Click element    id=btn-save-edit-bank-ref
    Wait Until Element Is Not Visible    id=dialog-edit-bank-ref
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn_new}

TC_ITMWM_01950 Create user and apply user role with operation status permission = view only and change permission = view&manage in user level
    [Tags]    ready    regression    TC_ITMWM_01950    WLS_Medium
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_operation}
    ...    AND    Clear User Role By Name    ${user_role_group}

#   Set Permission
    Login Pcms    ${pcms_email}    ${pcms_pass}
        PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${track-order_view-operation-status}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_operation}    ${pcms_user_operation}    ${pcms_pass_operation}    ${user_role_group}

    @{permission_list_set}=    Create List    ${track-order_view-operation-status}    ${track-order_manage-operation-status}
    PCMS Set Permission For User    ${pcms_email_operation}    @{permission_list_set}

#   Create Order
    ${order_id}=    Guest Buy Product Success with CCW      testforthor@gmail.com
    Log To Console       order_id = ${order_id}
    # ${order_id}=    Set Variable    3000407

#   Verify ACL work correctly : can edit operation status
    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Wait Until Element Is Visible           ${operation_element}

    TrackOrder - Set Item status            ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_request}
    Element Should Be Enabled    ${element_drop_down_operation}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}

    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_pending_tmn}
    Element Should Be Enabled    ${element_drop_down_operation}

    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${item_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save                 ${item_id[0][0]}
    Element Should Be Visible    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn}

#   Verify ACL work correctly : can edit bank ref
    Click Element    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Be Visible    id=text-box-bank-ref
    Textfield Value Should Be    id=text-box-bank-ref    ${bank_ref_tmn}
    Input Text    id=text-box-bank-ref    ${bank_ref_tmn_new}
    Click element    id=btn-save-edit-bank-ref
    Wait Until Element Is Not Visible    id=dialog-edit-bank-ref
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn_new}

TC_ITMWM_01951 Create user and apply user role with operation status permission = view only and change permission = view only in user level
    [Tags]    ready    regression    TC_ITMWM_01951    WLS_Medium
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_operation}
    ...    AND    Clear User Role By Name    ${user_role_group}

#   Set Permission
    Login Pcms    ${pcms_email}    ${pcms_pass}
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${track-order_view-operation-status}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_operation}    ${pcms_user_operation}    ${pcms_pass_operation}    ${user_role_group}

    @{permission_list_set}=    Create List    ${track-order_view-operation-status}
    PCMS Set Permission For User    ${pcms_email_operation}    @{permission_list_set}

#   Step 2 : Create Order
   ${order_id}=    Guest Buy Product Success with CCW      ${email}    ${inventory_id}
    # ${order_id}=     Set Variable    3000404
    Log To Console       order_id = ${order_id}

#   Step 3 : Verify ACL work correctly : cannot edit operation status
    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Wait Until Element Is Visible           ${operation_element}

    TrackOrder - Set Item status            ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_request}
    Element Should Be Disabled    ${element_drop_down_operation}

#   Step 4 : Change operation status to refund complete with bank ref tmn
    Login Pcms    ${pcms_email}    ${pcms_pass}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${item_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_complete}

    Element Should Be Visible    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn}

#   Step 5 : Verify ACL work correctly : cannot edit Bank Ref TMN
    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Wait Until Element Is Visible           ${operation_element}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_complete}
    Element Should Not Be Visible    ${element_drop_down_operation}
    Element Should Be Visible    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn}
    Element Should Not Be Visible    id=bank_ref_tmn_${item_id[0][0]}
    Click Element    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Not Be Visible    id=text-box-bank-ref

TC_ITMWM_01953 Create user and apply user role with operation status permission = view only and change permission = not allow in user level
    [Tags]    ready    regression    TC_ITMWM_01953    WLS_Medium
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_operation}
    ...    AND    Clear User Role By Name    ${user_role_group}

    Login Pcms    ${pcms_email}    ${pcms_pass}
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${track-order_view-operation-status}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_operation}    ${pcms_user_operation}    ${pcms_pass_operation}    ${user_role_group}

    @{permission_list_unset}=    Create List    ${track-order_view-operation-status}    ${track-order_manage-operation-status}
    PCMS Unset Permission For User    ${pcms_email_operation}    @{permission_list_unset}

    ${order_id}=    Guest Buy Product Success with CCW      testforthor@gmail.com
    Log To Console       order_id = ${order_id}
    # ${order_id}=    Set Variable    3000401

    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Element Should Not Be Visible    ${operation_element}
    Element Should Not Be Visible    ${element_drop_down_operation}


TC_iTM_02004 Create user and apply user role with operation status permission = manage only and change permission = not allow in user level
    [Tags]    TC_23    ready    TC_iTM_02004    WLS_Medium
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_operation}
    ...    AND    Clear User Role By Name    ${user_role_group}

    Login Pcms    ${pcms_email}    ${pcms_pass}
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${track-order_manage-operation-status}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_operation}    ${pcms_user_operation}    ${pcms_pass_operation}    ${user_role_group}

    @{permission_list_unset}=    Create List    ${track-order_view-operation-status}    ${track-order_manage-operation-status}
    PCMS Unset Permission For User    ${pcms_email_operation}    @{permission_list_unset}

    ${order_id}=    Guest Buy Product Success with CCW      testforthor@gmail.com
    Log To Console       order_id = ${order_id}
    # ${order_id}=    Set Variable    3000401

    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Element Should Not Be Visible    ${operation_element}
    Element Should Not Be Visible    ${element_drop_down_operation}

TC_ITMWM_01954 Create user and apply user role with operation status permission = manage only and change permission = view only in user level
    [Tags]    ready    regression    TC_ITMWM_01954    WLS_Medium
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_operation}
    ...    AND    Clear User Role By Name    ${user_role_group}

    Login Pcms    ${pcms_email}    ${pcms_pass}
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${track-order_manage-operation-status}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_operation}    ${pcms_user_operation}    ${pcms_pass_operation}    ${user_role_group}

    @{permission_list_unset}=    Create List    ${track-order_manage-operation-status}
    PCMS Unset Permission For User    ${pcms_email_operation}    @{permission_list_unset}

    @{permission_list_set}=    Create List    ${track-order_view-operation-status}
    PCMS Set Permission For User    ${pcms_email_operation}    @{permission_list_set}

#   Step 2 : Create Order
   ${order_id}=    Guest Buy Product Success with CCW      ${email}    ${inventory_id}
    # ${order_id}=     Set Variable    3000395
    Log To Console       order_id = ${order_id}

#   Step 3 : Verify ACL work correctly : cannot edit operation status
    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Wait Until Element Is Visible           ${operation_element}

    TrackOrder - Set Item status            ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_request}
    Element Should Be Disabled    ${element_drop_down_operation}

#   Step 4 : Change operation status to refund complete with bank ref tmn
    Login Pcms    ${pcms_email}    ${pcms_pass}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${item_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_complete}

    Element Should Be Visible    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn}

#   Step 5 : Verify ACL work correctly : cannot edit Bank Ref TMN
    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Wait Until Element Is Visible           ${operation_element}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_complete}
    Element Should Not Be Visible    ${element_drop_down_operation}
    Element Should Be Visible    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn}
    Element Should Not Be Visible    id=bank_ref_tmn_${item_id[0][0]}
    Click Element    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Not Be Visible    id=text-box-bank-ref

TC_ITMWM_01955 Create user and apply user role with operation status permission = manage only and change permission = manage only in user level
    [Tags]    ready    regression    TC_ITMWM_01955    WLS_Medium
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_operation}
    ...    AND    Clear User Role By Name    ${user_role_group}

#   Set Permission
    Login Pcms    ${pcms_email}    ${pcms_pass}
        PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${track-order_manage-operation-status}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_operation}    ${pcms_user_operation}    ${pcms_pass_operation}    ${user_role_group}

    @{permission_list_set}=    Create List    ${track-order_manage-operation-status}
    PCMS Set Permission For User    ${pcms_email_operation}    @{permission_list_set}

#   Create Order
    ${order_id}=    Guest Buy Product Success with CCW      testforthor@gmail.com
    Log To Console       order_id = ${order_id}
    # ${order_id}=    Set Variable    3000393

#   Verify ACL work correctly : can edit operation status
    Login Pcms    ${pcms_email_operation}    ${pcms_pass_operation}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Wait Until Element Is Visible           ${operation_element}

    TrackOrder - Set Item status            ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_request}
    Element Should Be Enabled    ${element_drop_down_operation}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}

    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_pending_tmn}
    Element Should Be Enabled    ${element_drop_down_operation}

    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${item_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save                 ${item_id[0][0]}
    Element Should Be Visible    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn}

#   Verify ACL work correctly : can edit bank ref
    Click Element    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Be Visible    id=text-box-bank-ref
    Textfield Value Should Be    id=text-box-bank-ref    ${bank_ref_tmn}
    Input Text    id=text-box-bank-ref    ${bank_ref_tmn_new}
    Click element    id=btn-save-edit-bank-ref
    Wait Until Element Is Not Visible    id=dialog-edit-bank-ref
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn_new}

TC_ITMWM_01956 To verify that ACL work correctly when apply user role with operation status permission = manage only but apply permission in user level = view and manage
    [Tags]    ready    regression    TC_ITMWM_01956    WLS_Medium
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${email}
    ...    AND    Clear User Role By Name    ${group_name}

    ${email}=    Set Variable    robot1839@mail.com
    ${display_name}=    Set Variable    robot1839
    ${password}=    Set Variable    123456
    ${group_name}=    Set Variable    RobotRole

    # Create new order and update status to Customer Cancelled
    ${order_id}=    Guest Buy Product Success with CCW      testforthor@gmail.com
    # ${order_id}=    Set Variable    3000391
    Close All Browsers
    Login Pcms
    TrackOrder - Go To Order Detail Page     ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Wait Until Element Is Visible           ${operation_element}

    TrackOrder - Set Item status            ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save                 ${item_id[0][0]}
    Close All Browsers

    # 1. - Create user and apply user role with operation status permission = manage only
    Login Pcms
    PCMS Created User Role    ${group_name}
    @{permission_list}=    Create List    ${track-order_view}    ${track-order_manage-operation-status}
    PCMS Set Permission In Role   ${group_name}    @{permission_list}
    PCMS Created User    ${email}    ${display_name}    ${password}    ${group_name}

    # 2. Modify operation status in user level to operation status permission = view & manage
    @{permission_list}=    Create List    ${track-order_view-operation-status}    ${track-order_manage-operation-status}
    PCMS Set Permission For User    ${email}    @{permission_list}
    Close All Browsers

    # 3. Verify that user can view and edit operation status
    Login Pcms    ${email}    ${password}
    TrackOrder - Go To Order Detail Page     ${order_id}
    Element Should Be Enabled    id=status_operation_${item_id[0][0]}
    Element Should Be Visible    id=current_operation_status_${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_request}
    Element Should Be Enabled    ${element_drop_down_operation}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}

    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_pending_tmn}
    Element Should Be Enabled    ${element_drop_down_operation}

    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${item_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save                 ${item_id[0][0]}
    Element Should Be Visible    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn}

#   Verify ACL work correctly : can edit bank ref
    Click Element    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Be Visible    id=text-box-bank-ref
    Textfield Value Should Be    id=text-box-bank-ref    ${bank_ref_tmn}
    Input Text    id=text-box-bank-ref    ${bank_ref_tmn_new}
    Click element    id=btn-save-edit-bank-ref
    Wait Until Element Is Not Visible    id=dialog-edit-bank-ref
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn_new}

TC_ITMWM_01957 To verify that ACL work correctly when apply user role with operation status permission = view and manage but apply permission in user level = view only
    [Tags]    ready    regression    TC_ITMWM_01957    WLS_Medium
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${email}
    ...    AND    Clear User Role By Name    ${group_name}

    ${email}=    Set Variable    robot1839@mail.com
    ${display_name}=    Set Variable    robot1839
    ${password}=    Set Variable    123456
    ${group_name}=    Set Variable    RobotRole

    # Create new order and update status to Customer Cancelled
    ${order_id}=    Guest Buy Product Success with CCW      testforthor@gmail.com
    # ${order_id}=    Set Variable    3000389
    Close All Browsers
    Login Pcms
    TrackOrder - Go To Order Detail Page     ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Wait Until Element Is Visible           ${operation_element}

    TrackOrder - Set Item status            ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save                 ${item_id[0][0]}
    Close All Browsers

    # 1. - Create user and apply user role with operation status permission = view & manage
    Login Pcms
    PCMS Created User Role    ${group_name}
    @{permission_list}=    Create List    ${track-order_view}    ${track-order_view-operation-status}    ${track-order_manage-operation-status}
    PCMS Set Permission In Role   ${group_name}    @{permission_list}
    PCMS Created User    ${email}    ${display_name}    ${password}    ${group_name}

    # 2. Modify operation status in user level to operation status permission = view only
    @{permission_list}=    Create List    ${track-order_manage-operation-status}
    PCMS Unset Permission For User    ${email}    @{permission_list}
    @{permission_list}=    Create List    ${track-order_view-operation-status}
    PCMS Set Permission For User    ${email}    @{permission_list}
    Close All Browsers

    # 3. Verify that user can view but cannot edit operation status
    Login Pcms    ${email}    ${password}
    TrackOrder - Go To Order Detail Page     ${order_id}
    Element Should Be Disabled    id=status_operation_${item_id[0][0]}
    Element Should Be Visible    id=current_operation_status_${item_id[0][0]}

#   Step 4 : Change operation status to refund complete with bank ref tmn
    Login Pcms    ${pcms_email}    ${pcms_pass}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${item_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_complete}

    Element Should Be Visible    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn}

#   Step 5 : Verify ACL work correctly : cannot edit Bank Ref TMN
    Login Pcms    ${email}    ${password}
    TrackOrder - Go To Order Detail Page       ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Wait Until Element Is Visible           ${operation_element}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_complete}
    Element Should Not Be Visible    ${element_drop_down_operation}
    Element Should Be Visible    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn}
    Element Should Not Be Visible    id=bank_ref_tmn_${item_id[0][0]}
    Click Element    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Not Be Visible    id=text-box-bank-ref

TC_ITMWM_01958 To verify that ACL work correctly when apply user role with operation status permission = view and manage but apply permission in user level = manage only
    [Tags]    ready    regression    TC_ITMWM_01958    WLS_Medium
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${email}
    ...    AND    Clear User Role By Name    ${group_name}

    ${email}=    Set Variable    robot1839@mail.com
    ${display_name}=    Set Variable    robot1839
    ${password}=    Set Variable    123456
    ${group_name}=    Set Variable    RobotRole

    # Create new order and update status to Customer Cancelled
    ${order_id}=    Guest Buy Product Success with CCW      testforthor@gmail.com
    # ${order_id}=    Set Variable    3000387
    Close All Browsers
    Login Pcms
    TrackOrder - Go To Order Detail Page     ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Wait Until Element Is Visible           ${operation_element}

    TrackOrder - Set Item status            ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save                 ${item_id[0][0]}
    Close All Browsers

    # 1. - Create user and apply user role with operation status permission = view&manage
    Login Pcms
    PCMS Created User Role    ${group_name}
    @{permission_list}=    Create List    ${track-order_view}    ${track-order_view-operation-status}    ${track-order_manage-operation-status}
    PCMS Set Permission In Role   ${group_name}    @{permission_list}
    PCMS Created User    ${email}    ${display_name}    ${password}    ${group_name}

    # 2. Modify operation status in user level to operation status permission = manage only
    @{permission_list}=    Create List    ${track-order_view-operation-status}
    PCMS Unset Permission For User    ${email}    @{permission_list}
    @{permission_list}=    Create List    ${track-order_manage-operation-status}
    PCMS Set Permission For User    ${email}    @{permission_list}
    Close All Browsers

    # 3. Verify that user can view and edit operation status
    Login Pcms    ${email}    ${password}
    TrackOrder - Go To Order Detail Page     ${order_id}
    Element Should Be Visible    jquery=select.status_operation
    Element Should Be Enabled    id=status_operation_${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_request}
    Element Should Be Enabled    ${element_drop_down_operation}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}

    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_pending_tmn}
    Element Should Be Enabled    ${element_drop_down_operation}

    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${item_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save                 ${item_id[0][0]}
    Element Should Be Visible    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn}

#   Verify ACL work correctly : can edit bank ref
    Click Element    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Be Visible    id=text-box-bank-ref
    Textfield Value Should Be    id=text-box-bank-ref    ${bank_ref_tmn}
    Input Text    id=text-box-bank-ref    ${bank_ref_tmn_new}
    Click element    id=btn-save-edit-bank-ref
    Wait Until Element Is Not Visible    id=dialog-edit-bank-ref
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn_new}

TC_ITMWM_01959 To verify that ACL work correctly when apply user role with operation status permission = view and manage but apply permission in user level = not allow
    [Tags]    ready    regression    TC_ITMWM_01959    WLS_Medium
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${email}
    ...    AND    Clear User Role By Name    ${group_name}

    ${email}=    Set Variable    robot1839@mail.com
    ${display_name}=    Set Variable    robot1839
    ${password}=    Set Variable    123456
    ${group_name}=    Set Variable    RobotRole

    # Create new order and update status to Customer Cancelled
    ${order_id}=    Guest Buy Product Success with CCW      testforthor@gmail.com
    # ${order_id}=    Set Variable    3000350
    Close All Browsers
    Login Pcms
    TrackOrder - Go To Order Detail Page     ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}
    TrackOrder - Set Item status            ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save                 ${item_id[0][0]}
    Close All Browsers

    # 1. - Create user and apply user role with operation status permission = view & manage
    Login Pcms
    PCMS Created User Role    ${group_name}
    @{permission_list}=    Create List    ${track-order_view}    ${track-order_view-operation-status}    ${track-order_manage-operation-status}
    PCMS Set Permission In Role   ${group_name}    @{permission_list}
    PCMS Created User    ${email}    ${display_name}    ${password}    ${group_name}

    # 2. Modify operation status in user level to operation status permission = not allow
    @{permission_list}=    Create List    ${track-order_view-operation-status}    ${track-order_manage-operation-status}
    PCMS Unset Permission For User    ${email}    @{permission_list}
    Close All Browsers

    # 3. Verify that user can not view and edit operation status
    Login Pcms    ${email}    ${password}
    TrackOrder - Go To Order Detail Page     ${order_id}
    Element Should Not Be Visible    jquery=select.status_operation


TC_ITMWM_01960 To verify that ACL work correctly when apply user role with operation status permission = view and manage but apply permission in user level = view and manage
    [Tags]    ready    regression    TC_ITMWM_01960    WLS_Medium
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${email}
    ...    AND    Clear User Role By Name    ${group_name}

    ${email}=    Set Variable    robot1839@mail.com
    ${display_name}=    Set Variable    robot1839
    ${password}=    Set Variable    123456
    ${group_name}=    Set Variable    RobotRole

    # Create new order and update status to Customer Cancelled
    ${order_id}=    Guest Buy Product Success with CCW      testforthor@gmail.com
    # ${order_id}=    Set Variable    3000349
    Close All Browsers
    Login Pcms
    TrackOrder - Go To Order Detail Page     ${order_id}
    ${item_id}=     TrackOrder - Get Order Shipment id        ${order_id}

    ${operation_element}=    Set Variable    //td[@class="table-center operation_status operation_status_${item_id[0][0]}"]
    ${element_drop_down_operation}=    Set Variable    //select[@id="status_operation_${item_id[0][0]}"]

    Wait Until Element Is Visible           ${operation_element}

    TrackOrder - Set Item status            ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save                 ${item_id[0][0]}
    Close All Browsers

    # 1. - Create user and apply user role with operation status permission = manage only
    Login Pcms
    PCMS Created User Role    ${group_name}
    @{permission_list}=    Create List    ${track-order_view}    ${track-order_view-operation-status}    ${track-order_manage-operation-status}
    PCMS Set Permission In Role   ${group_name}    @{permission_list}
    PCMS Created User    ${email}    ${display_name}    ${password}    ${group_name}

    # 2. Modify operation status in user level to operation status permission = view & manage
    @{permission_list}=    Create List    ${track-order_view-operation-status}    ${track-order_manage-operation-status}
    PCMS Set Permission For User    ${email}    @{permission_list}
    Close All Browsers

    # 3. Verify that user can view and edit operation status
    Login Pcms    ${email}    ${password}
    TrackOrder - Go To Order Detail Page     ${order_id}
    Element Should Be Enabled    id=status_operation_${item_id[0][0]}
    Element Should Be Visible    id=current_operation_status_${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_refund_request}
    Element Should Be Enabled    ${element_drop_down_operation}
    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_pending_tmn}

    TrackOrder - Click save                 ${item_id[0][0]}

    TrackOrder - Check Operation Status on UI     ${item_id[0][0]}    ${operation_ui_pending_tmn}
    Element Should Be Enabled    ${element_drop_down_operation}

    TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${item_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save                 ${item_id[0][0]}
    Element Should Be Visible    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn}

#   Verify ACL work correctly : can edit bank ref
    Click Element    id=current-bank-ref-tmn-${item_id[0][0]}
    Element Should Be Visible    id=text-box-bank-ref
    Textfield Value Should Be    id=text-box-bank-ref    ${bank_ref_tmn}
    Input Text    id=text-box-bank-ref    ${bank_ref_tmn_new}
    Click element    id=btn-save-edit-bank-ref
    Wait Until Element Is Not Visible    id=dialog-edit-bank-ref
    Element Should Contain    id=current-bank-ref-tmn-${item_id[0][0]}    ${bank_ref_tmn_new}