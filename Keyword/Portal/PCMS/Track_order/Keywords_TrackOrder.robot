*** Settings ***
Library           Selenium2Library
Library           String
Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py
Library           ${CURDIR}/../../../../Python_Library/order_shipment_items_library.py
Library           ${CURDIR}/../../../../Python_Library/excel.py
Resource          WebElement_TrackOrder.robot
Resource          ${CURDIR}/../../../../Keyword/Portal/PCMS/User_role/Keywords_User_Role.robot
Resource          ${CURDIR}/../../../../Keyword/Features/Freebie/keywords_discount_calculation.robot
Resource          ../../../Common/Keywords_Common.robot

*** Variables ***
${id_file_name}    1_id_card
${book_bank_file_name}    2_personal_book_bank
${slip_file_name}    3_payment_slip
${company_book_bank_file_name}    4_company_book_bank
${company_certificate_file_name}    5_company_certificate
${marriage_certificate_file_name}    6_marriage_certificate
${other_file_name}    7_other_document
${item_status}    pending_shipment
${order_detail_url}    http://alpha-pcms.itruemart-dev.com/orders/detail/3003216
${order_receipt_url}    http://alpha-pcms.itruemart-dev.com/order-receipt

*** Keywords ***
TrackOrder - Get Sale order ID
    [Arguments]    ${order_id}
    Go To    ${PCMS_URL}/orders/detail/${order_id}
    Wait Until Element Is Visible    ${Get_SeleOrderID_InTable}    20s
    ${Sale_order_id}=    Get Text    ${Get_SeleOrderID_InTable}
    [Return]    ${Sale_order_id}

TrackOrder - Go To Order Detail Page
    [Arguments]    ${order_id}
    Go To    ${PCMS_URL}/orders/detail/${order_id}
    Wait Until Element Is Visible    id=mws-container    20s

TrackOrder - Go To Upload Operation Status Page
    Go To    ${PCMS_URL}/orders/upload-operation-status

TrackOrder - Set Item status No Auto Set Other
    [Arguments]    ${item_id}    ${item_status}
    Select From List By Value    //*[@id="status_item${item_id}"]    ${item_status}

TrackOrder - Set Item status
    [Arguments]    ${item_id}    ${item_status}
    Select From List By Value    //*[@id="status_item${item_id}"]    ${item_status}
    ${present}=    Run Keyword And Return Status    Element Should Be Visible    //select[@id="dropdown_cancel_reason_${item_id}"]
    ${present_1}=    Run Keyword And Return Status    Element Should Be Visible    ${operation_status_option}${item_id}
    Run Keyword If    ${present}    TrackOrder - Set Cancel Reason    ${item_id}    Content: Mismatch content
    Run Keyword If    ${present_1}    TrackOrder - Set Operation Status    ${item_id}    ${operation_db_refund_request}

TrackOrder - Set Item status for cancel reason
    [Arguments]    ${item_id}    ${item_status}
    Select From List By Value    //*[@id="status_item${item_id}"]    ${item_status}
    ${present}=    Run Keyword And Return Status    Element Should Be Visible    ${operation_status_option}${item_id}
    Run Keyword If    ${present}    TrackOrder - Set Operation Status    ${item_id}    ${operation_db_refund_request}

TrackOrder - Set Items status
    [Arguments]    ${items_id}    ${item_status}
    : FOR    ${item_id}    IN    @{items_id}
    \    TrackOrder - Set Item status    ${item_id[0]}    ${item_status}
    \    ${present}=    Run Keyword And Return Status    Element Should Be Visible    ${cancel_reason_option}${item_id[0]}
    \    Run Keyword If    ${present}    TrackOrder - Set Cancel Reason    ${item_id[0]}    Content: Mismatch content
    \    TrackOrder - Click save    ${item_id[0]}

TrackOrder - Set Cancel Reason
    [Arguments]    ${item_id}    ${cancel_reason}
    Select From List    ${cancel_reason_option}${item_id}    ${cancel_reason}

TrackOrder - Set Item status(pending_shipment)
    [Arguments]    ${item_id}    ${item_status}
    FOR:    ${item_id}
    \    Select From List By Value

TrackOrder - Click save
    [Arguments]    ${item_id}
    Click Element    //button[@value="${item_id}"]
    Sleep    2s
    Confirm Action
    Sleep    2s

TrackOrder - Click save not confirm action
    [Arguments]    ${item_id}
    Click Element    //button[@value="${item_id}"]
    Sleep    3s

TrackOrder - Click save all
    ${present}=    Run Keyword And Return Status    Element Should Be Visible    ${cancel_reason_option_class}
    Run Keyword If    ${present}    Select From List By Value    //select[@class="dropdown_cancel_reason"]    1
    ${present_1}=    Run Keyword And Return Status    Element Should Be Visible    ${operation_status_option_class}
    Run Keyword If    ${present_1}    Select From List By Value    //select[@class="status_operation_select_operation_status"]    refund_request
    Click Element    //*[@id="update_shipment_items"]/div[3]/div/button
    Sleep    3s
    ${status1}=    Run Keyword And Ignore Error    Confirm Action
    Sleep    1.5s
    ${status2}=    Run Keyword And Ignore Error    Confirm Action
    # Log To Console    status1=${status1}
    # Log To Console    status2=${status2}
    Sleep    2s

TrackOrder - Click save all not confirm action
    Click Element    //*[@id="update_shipment_items"]/div[3]/div/button
    Sleep    3s

TrackOrder - Click enter
    Click Element    //button[@id="btn-save-doc-remark"]
    Wait Until Element Is Visible    //*[@id="document-remark-container"]
    Click Element    //button[@id="btn-confirm-doc-remark"]
    Dismiss Alert
    Sleep    1s

TrackOrder - Get Order Shipment id
    [Arguments]    ${order_id}
    ${item_id}=    Get Order Shipment Ids    ${order_id}
    Should Not Be Empty    ${item_id}
    [Return]    ${item_id}

TrackOrder - Check Item Status on DB
    [Arguments]    ${item_id}    ${status}
    ${item_status}=    Get Order Shipment Item Status    ${item_id}
    # Log to console    id=${item_id} / item_status_db=${item_status} / item_status_exped=${status}
    Should Not Be Empty    ${item_status}
    Should Be Equal As Strings    ${item_status[0]}    ${status}

TrackOrder - Check Payment Status on DB
    [Arguments]    ${item_id}    ${status}
    ${payment_status}=    Get Order Shipment Payment Status    ${item_id}
    Should Not Be Empty    ${payment_status}
    Should Be Equal As Strings    ${payment_status[0]}    ${status}

TrackOrder - Check Operation Status on DB
    [Arguments]    ${item_id}    ${status}
    ${Operation_status}=    Get Order Shipment Operation Status    ${item_id}
    Should Not Be Empty    ${Operation_status}
    Should Be Equal As Strings    ${Operation_status[0]}    ${status}

TrackOrder - Check Multiple items Operation Status on DB
    [Arguments]    ${items_id}    ${operation_status}
    : FOR    ${item_id}    IN    @{items_id}
    \    TrackOrder - Check Operation Status on DB    ${item_id[0]}    ${operation_status}

TrackOrder - Check Cancel Reason on DB
    [Arguments]    ${item_id}    ${id}
    ${cancel_reason_id}=    Get Order shipment Cancel Reason    ${item_id}
    Should Be Equal As Strings    ${cancel_reason_id[0]}    ${id}

TrackOrder - Check Multiple Cancel Reason on DB
    [Arguments]    ${items_id}    ${id}
    : FOR    ${item_id}    IN    @{items_id}
    \    TrackOrder - Check Cancel Reason on DB    ${item_id[0]}    ${id}

TrackOrder - Check Cancel Reason on DB is Empty
    [Arguments]    ${item_id}
    ${cancel_reason_id}=    Get Order shipment Cancel Reason    ${item_id}
    Should Be Equal As Strings    ${cancel_reason_id[0]}    None

TrackOrder - Verify Cancel Reason No Select
    Element Should Be Visible    id=cancel_reason-dialog
    ${display_error}=    Get Text    id=cancel_reason-dialog
    Should Be Equal As Strings    ${display_error}    Cancel Reason is required.

TrackOrder - Check Cancel Reason on UI
    [Arguments]    ${item_id}    ${cancel_reason}
    Element Should Contain    id=display_cancel_reason${item_id}    ${cancel_reason}

TrackOrder - Check Bank Ref on DB
    [Arguments]    ${item_id}    ${status}
    ${bank_ref}=    Get Order shipment Bank Ref    ${item_id}
    Should Not Be Empty    ${bank_ref}
    Should Be Equal As Strings    ${bank_ref[0]}    ${status}

TrackOrder - Check Multiple Bank Ref on DB
    [Arguments]    ${items_id}    ${status}
    : FOR    ${item_id}    IN    @{items_id}
    \    TrackOrder - Check Bank Ref on DB    ${item_id[0]}    ${status}

TrackOrder - Check Bank Ref on DB is Empty
    [Arguments]    ${item_id}
    ${bank_ref}=    Get Order shipment Bank Ref    ${item_id}
    Should Be Equal As Strings    ${bank_ref[0]}    None

TrackOrder - Verify Log Bank Ref TMN
    [Arguments]    ${item_id}    ${status}
    ${user_id}=    Get Id User by Email    ${PCMS_USERNAME}
    ${log_bank_ref_data}=    Get Log Bank Ref    ${item_id}
    Should Not Be Empty    ${log_bank_ref_data}
    Should Be Equal As Strings    ${log_bank_ref_data[0]}    ${user_id}
    Should Be Equal As Strings    ${log_bank_ref_data[1]}    ${status}

TrackOrder - Verify Log Multiple Bank Ref TMN
    [Arguments]    ${items_id}    ${status}
    : FOR    ${item_id}    IN    @{items_id}
    \    TrackOrder - Verify Log Bank Ref TMN    ${item_id[0]}    ${status}

TrackOrder - Verify No Log Bank Ref TMN
    [Arguments]    ${item_id}
    ${user_id}=    Get Id User by Email    ${PCMS_USERNAME}
    ${log_bank_ref_data}=    Get Log Bank Ref    ${item_id}
    Should Be Equal As Strings    ${log_bank_ref_data}    None

TrackOrder - Check Item Status on UI
    [Arguments]    ${item_id}    ${status}
    Wait Until Element Is Visible    //*[@id="current_item_status${item_id}"]    60s
    ${item_status_on_ui}=    Get Text    //*[@id="current_item_status${item_id}"]
    Should Not Be Empty    ${item_status_on_ui}
    Should Be Equal As Strings    ${item_status_on_ui}    ${status}

TrackOrder - Check Payment Status on UI
    [Arguments]    ${item_id}    ${status}
    Wait Until Element Is Visible    jquery=td.payment_status_${item_id}
    ${payment_status_on_ui}=    Get Text    jquery=td.payment_status_${item_id}
    Should Not Be Empty    ${payment_status_on_ui}
    Should Be Equal As Strings    ${payment_status_on_ui}    ${status}

TrackOrder - Check Operation Status on UI
    [Arguments]    ${item_id}    ${opetation_status}
    Wait Until Element Is Visible    //p[@id="current_operation_status_${item_id}"]    10s
    ${current_operation_status_on_ui}=    Get Text    //p[@id="current_operation_status_${item_id}"]
    Should Not Be Empty    ${current_operation_status_on_ui}
    Should Be Equal As Strings    ${current_operation_status_on_ui}    ${opetation_status}

TrackOrder - Check Multiple Operation Status on UI
    [Arguments]    ${items_id}    ${opetation_status}
    : FOR    ${item_id}    IN    @{items_id}
    \    TrackOrder - Check Operation Status on UI    ${item_id[0]}    ${opetation_status}

TrackOrder - Check Available Operation Status on UI
    [Arguments]    ${item_id}    ${opetation_display_status_list}
    ${operation_element}=    Set Variable    //select[@id="status_operation_${item_id}"]/option
    ${count_status_list}=    Get Length    ${opetation_display_status_list}
    Wait Until Element Is Visible    ${operation_element}    10s
    ${count_status}=    Get Matching Xpath Count    ${operation_element}
    ${count_status}=    Convert To Integer    ${count_status}
    Should Be Equal    ${count_status_list}    ${count_status}
    : FOR    ${INDEX}    IN RANGE    1    ${count_status_list+1}
    \    ${avaliable_operation_status}=    Get Text    ${operation_element}[${INDEX}]
    \    ${matches}=    Get Match Count    ${opetation_display_status_list}    ${avaliable_operation_status}
    \    Should Be Equal As Integers    ${matches}    1

TrackOrder - Verify Operation Status No Select
    Element Should Be Visible    id=operation_status_dialog
    ${display_error}=    Get Text    id=operation_status_dialog
    Should Be Equal As Strings    ${display_error}    Operation Status is required.

TrackOrder - Set Operation Status
    [Arguments]    ${item_id}    ${operation_status}
    Select From List By Value    //select[@id="status_operation_${item_id}"]    ${operation_status}

TrackOrder - Check SLA on DB
    [Arguments]    ${item_id}    ${verify_sla}=null
    ${SLA}=    Get SLA    ${item_id}
    Run Keyword If    'null' == '${verify_sla}'    Should Be Equal    ${SLA[0]}    ${none}
    ...    ELSE    Should Not Be Equal    ${SLA}    ${none}

TrackOrder - Change Time Back Date SLA
    [Arguments]    ${item_id}    ${day}
    ${SLA}=    Get SLA    ${item_id}
    Should Not Be Equal    ${SLA[0]}    ${none}
    ${date}=    Convert Date    ${SLA[0]}    date_format=%Y-%m-%d %H:%M:%s
    ${date}=    Subtract Time From Date    ${date}    ${day} days
    ${date}=    Convert Date    ${date}    result_format=timestamp
    Log To Console    ${date}
    ${SLA}=    Set SLA    ${item_id}    ${date}
    Log To Console    ${SLA}

TrackOrder - Get SLA on DB
    [Arguments]    ${item_id}
    ${SLA}=    Get SLA    ${item_id}
    Should Not Be Equal    ${SLA[0]}    ${none}
    [Return]    ${SLA[0]}

TrackOrder - Check SLA timestamp on UI
    [Arguments]    ${shipment_id}
    ${dateFromUI}=    Get Text    //div[@class="operation_date_${shipment_id}"]
    ${dateDatabase}=    get sla time    ${shipment_id}
    ${datetime} =    Convert Date    ${dateFromUI}    datetime    date_format=%d %b %Y %H:%M:%S
    Should Be Equal As Strings    ${datetime}    ${dateDatabase}

TrackOrder - Check SLA time on UI
    [Arguments]    ${shipment_id}    ${days}=0
    ${color}=    Set Variable    label-important
    ${color}=    Run Keyword If    '${days}' >= '0' and '${days}' <= '10'    Set Variable    label-success
    ...    ELSE    Set Variable    ${color}
    ${color}=    Run Keyword If    '${days}' > '10' and '${days}' <= '20'    Set Variable    label-warning
    ...    ELSE    Set Variable    ${color}
    Log to console    ${color}
    ${daysUI}=    Get Text    //div[@class="operation_diff_date_${shipment_id} label ${color}"]
    Should Be Equal As Strings    ${daysUI}    ${days}

TrackOrder - Check SLA time on UI is Null
    [Arguments]    ${shipment_id}
    ${daysUI}=    Get Text    jquery=.operation_start_time_${shipment_id}
    Should Be Equal As Strings    ${daysUI}    -

TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    Wait Until Element Is Visible    ${clt_doc_upload_section}    10s

TrackOrder - CLT doc upload - Upload file
    [Arguments]    ${file_name}    ${doc_id}
    Wait Until Element Is Visible    id=document-upload-file-${doc_id}    10s
    ${path_to_file}    common.get_canonical_path    ${file_name}
    Wait Until Element Is Visible    //div[@id="document-upload-file-${doc_id}"]/div/input    10s
    Choose File    jquery=#document-upload-file-${doc_id} #document-browse-upload-${doc_id}    ${path_to_file}

TrackOrder - CLT doc upload - Click upload button
    Wait Until Element Is Visible    ${clt_doc_upload_button}    10s
    Click Element    ${clt_doc_upload_button}

TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    Page Should Contain    Upload file success!

TrackOrder - CLT doc upload - Verify file path in DB
    [Arguments]    ${order_id}    ${doc_id}    ${user_id}
    ${file_name}=    Run Keyword If    ${doc_id} == 1    Set Variable    ${id_file_name}
    ...    ELSE IF    ${doc_id} == 2    Set Variable    ${book_bank_file_name}
    ...    ELSE IF    ${doc_id} == 3    Set Variable    ${slip_file_name}
    ...    ELSE IF    ${doc_id} == 4    Set Variable    ${company_book_bank_file_name}
    ...    ELSE IF    ${doc_id} == 5    Set Variable    ${company_certificate_file_name}
    ...    ELSE IF    ${doc_id} == 6    Set Variable    ${marriage_certificate_file_name}
    ...    ELSE IF    ${doc_id} == 7    Set Variable    ${other_file_name}
    ...    ELSE    Set Variable    Get invalid Doc ID
    ${doc_path}=    get clt document path    ${order_id}    ${doc_id}
    ${file_path}=    Set Variable    return_refund/${order_id}/${file_name}
    Should Not Be Empty    ${doc_path}
    Should Start With    ${doc_path[0][0]}    ${file_path}
    Should Be Equal As Strings    ${doc_path[0][1]}    ${user_id}

TrackOrder - CLT doc upload - Verify file name on UI
    [Arguments]    ${doc_id}
    ${file_name}=    Run Keyword If    ${doc_id} == 1    Set Variable    ${id_file_name}
    ...    ELSE IF    ${doc_id} == 2    Set Variable    ${book_bank_file_name}
    ...    ELSE IF    ${doc_id} == 3    Set Variable    ${slip_file_name}
    ...    ELSE IF    ${doc_id} == 4    Set Variable    ${company_book_bank_file_name}
    ...    ELSE IF    ${doc_id} == 5    Set Variable    ${company_certificate_file_name}
    ...    ELSE IF    ${doc_id} == 6    Set Variable    ${marriage_certificate_file_name}
    ...    ELSE IF    ${doc_id} == 7    Set Variable    ${other_file_name}
    ...    ELSE    Set Variable    Get invalid Doc ID
    Wait Until Element Is Visible    document-${doc_id}    10s
    ${name}=    Get Text    document-${doc_id}
    Should Start With    ${name}    ${file_name}

TrackOrder - CLT doc upload - Click to preview file
    [Arguments]    ${order_id}    ${doc_id}
    ${url}=    Set Variable    ${PCMS_URL}/orders/view-uploaded-document/${order_id}/${doc_id}
    Wait Until Element Is Visible    document-${doc_id}    10s
    Click Element    document-${doc_id}
    Select Window    url=${url}
    #Wait Until Element Is Visible    xpath=/html/body/img    20s
    #Element should contain    jquery=[src]    ${PCMS_URL}/orders/view-uploaded-document/${order_id}/${doc_id}

TrackOrder - CLT doc upload - Click to delete file
    [Arguments]    ${doc_id}
    Wait Until Element Is Visible    delete-document-${doc_id}    10s
    Click Element    delete-document-${doc_id}

TrackOrder - CLT doc upload - Confirm delete
    Wait Until Element Is Visible    confirm-delete-ok    10s
    Click Element    confirm-delete-ok
    Wait Until Element Is Visible    response-delete    10s
    Click Element    response-delete

TrackOrder - CLT doc upload - Cancel delete
    Wait Until Element Is Visible    confirm-delete-cancel    10s
    Click Element    confirm-delete-cancel

TrackOrder - CLT doc upload - Verify file name is not shown on UI
    [Arguments]    ${doc_id}
    Wait Until Element Is Visible    //div[@id="document-upload-file-${doc_id}"]/div/input    10s

TrackOrder - CLT doc upload - Verify file is not exist in DB
    [Arguments]    ${order_id}    ${doc_id}
    ${doc_path}=    get clt document path    ${order_id}    ${doc_id}
    Should Be Equal As Strings    ${doc_path}    ()

TrackOrder - CLT doc upload - Verify error message if upload invalid file
    Sleep    2S
    ${message}=    Get Alert Message
    Should Be Equal As Strings    ${message}    Only jpg, png and pdf are allowed.
    #Confirm Action

TrackOrder - CLT doc upload - Verify error message if upload big file
    Sleep    2S
    ${message}=    Get Alert Message
    Should Be Equal As Strings    ${message}    File size exceed limit. Max file size = 5 MB.
    #Confirm Action

TrackOrder - Doc remark - Verify Doc remark section is shown
    Wait Until Element Is Visible    ${doc_remark_section}    10s

TrackOrder - Doc remark - Check remark on UI
    [Arguments]    ${text}
    ${first_line_text_show}=    Get Text    ${remark_first_line}
    Log to console    ${first_line_text_show}
    Should Be Equal As Strings    ${first_line_text_show}    ${text}

TrackOrder - Doc remark - Check displayname on UI
    [Arguments]    ${displayname}    ${length}=20
    ${first_line_displayname_show}=    Get Text    ${user_first_line}
    Log to console    ${first_line_displayname_show}
    ${length_display_name} =    Get Length    ${displayname}
    ${length_display_name}=    Convert To Integer    ${length_display_name}
    ${display_name_sub_string} =    Get Substring    ${displayname}    0    ${length}
    ${display_name} =    Run Keyword IF    ${length} <= ${length_display_name}    Set Variable    ${display_name_sub_string}...
    ...    ELSE    Set Variable    ${display_name_sub_string}
    Should Be Equal    ${first_line_displayname_show}    ${display_name}

TrackOrder - Doc remark - Check remark datetime on UI
    ${dateFromUI}=    Get Text    ${date_first_line}
    ${today}=    Get Current Date
    Log to console    todayUI: ${dateFromUI}
    ${today_datetime} =    Convert Date    ${today}    result_format=%d-%b-%Y
    ${ui_datetime} =    Convert Date    ${dateFromUI}    datetime    date_format=%d %b %Y %H:%M
    ${ui_datetime} =    Convert Date    ${ui_datetime}    result_format=%d-%b-%Y
    Log to console    todayUI: ${ui_datetime}
    Should Be Equal As Strings    ${today_datetime}    ${ui_datetime}

TrackOrder - doc remark - Check error message on UI
    [Arguments]    ${error_mesage}    ${element_error_dialog}
    Wait Until Element Is Visible    ${element_error_dialog}    10
    ${error_message_ui}=    Get Text    ${element_error_dialog}
    Should Be Equal As Strings    ${error_mesage}    ${error_message_ui}

TrackOrder - Doc remark - Check Remark In DB
    [Arguments]    ${order_id}    ${remark_text}    ${user_id}
    ${doc_remark}=    Get Latest Doc Remark    ${order_id}
    Should Be Equal As Strings    ${doc_remark[1]}    ${order_id}
    Should Be Equal As Strings    ${doc_remark[2]}    ${remark_text}
    Should Be Equal As Strings    ${doc_remark[3]}    ${user_id}

TrackOrder - Check Available Item Status on UI
    [Arguments]    ${item_id}    ${display_item_status_list}
    ${item_status_element}=    Set Variable    //select[@id="status_item${item_id}"]/option
    ${count_status_list}=    Get Length    ${display_item_status_list}
    Wait Until Element Is Visible    ${item_status_element}    10s
    ${count_status}=    Get Matching Xpath Count    ${item_status_element}
    ${count_status}=    Convert To Integer    ${count_status}
    Should Be Equal    ${count_status_list}    ${count_status}
    : FOR    ${INDEX}    IN RANGE    1    ${count_status_list+1}
    \    ${avaliable_item_status}=    Get Text    ${item_status_element}[${INDEX}]
    \    ${matches}=    Get Match Count    ${display_item_status_list}    ${avaliable_item_status}
    \    Should Be Equal As Integers    ${matches}    1

TrackerOrder - Get Available Operation Status List
    [Arguments]    ${order_shipment_id}    ${payment_method}=CCW    ${payment_status}=success    ${item_status}=delivered
    Wait Until Element Is Visible    id=current_operation_status_${order_shipment_id}
    ${operation_status_on_ui}=    Get Text    id=current_operation_status_${order_shipment_id}
    ${operation_status_list}=    Run Keyword If    '${operation_status_on_ui}' == 'None' and '${payment_status}' == 'success' and '${item_status}' == 'delivered'    TrackerOrder - Get None Success Status Pending Item Status Delivered Available Operation Status List
    ...    ELSE IF    '${operation_status_on_ui}' == 'Refund Request' and ('${payment_method}' == 'CCW' or '${payment_method}' == 'installment')    TrackerOrder - Get Refund Request Payment Method CCW Available Operation Status List
    ...    ELSE IF    '${operation_status_on_ui}' == 'Refund Request' and '${payment_method}' != 'CCW' and '${payment_method}' != 'installment'    TrackerOrder - Get Refund Request Payment Method not CCW Available Operation Status List
    ...    ELSE IF    '${operation_status_on_ui}' == 'CLT Doc Uploaded'    TrackerOrder - Get CLT Doc Uploaded Available Operation Status List
    ...    ELSE IF    '${operation_status_on_ui}' == 'SCM Verified'    TrackerOrder - Get SCM Verified Available Operation Status List
    ...    ELSE IF    '${operation_status_on_ui}' == 'SCM Require Doc'    TrackerOrder - Get SCM Require Doc Available Operation Status List
    ...    ELSE IF    '${operation_status_on_ui}' == 'Pending TMN' and ('${payment_method}' == 'CCW' or '${payment_method}' == 'installment')    TrackerOrder - Get Pending TMN Payment Method CCW Available Operation Status List
    ...    ELSE IF    '${operation_status_on_ui}' == 'Pending TMN' and ''${payment_method}' != 'CCW' and '${payment_method}' != 'installment'    TrackerOrder - Get Pending TMN Payment Method not CCW Available Operation Status List
    ...    ELSE    FAIL    Error!! Can not expect current status
    [Return]    ${operation_status_list}

TrackerOrder - Get None Success Status Pending Item Status Delivered Available Operation Status List
    ${operation_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_refund_request}    ${operation_ui_return_refund_request}    ${operation_ui_not_in_system}
    [Return]    ${operation_status}

TrackerOrder - Get Refund Request Payment Method CCW Available Operation Status List
    ${operation_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_pending_tmn}
    [Return]    ${operation_status}

TrackerOrder - Get Refund Request Payment Method not CCW Available Operation Status List
    ${operation_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_clt_doc_uploaded}
    [Return]    ${operation_status}

TrackerOrder - Get CLT Doc Uploaded Available Operation Status List
    ${operation_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_scm_verified}    ${operation_ui_scm_require_doc}
    [Return]    ${operation_status}

TrackerOrder - Get SCM Verified Available Operation Status List
    ${operation_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_pending_tmn}
    [Return]    ${operation_status}

TrackerOrder - Get SCM Require Doc Available Operation Status List
    ${operation_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_clt_doc_uploaded}
    [Return]    ${operation_status}

TrackerOrder - Get Pending TMN Payment Method CCW Available Operation Status List
    ${operation_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_refund_complete}
    [Return]    ${operation_status}

TrackerOrder - Get Pending TMN Payment Method not CCW Available Operation Status List
    ${operation_status}=    Create List    ${operation_ui_please_select}    ${operation_ui_refund_complete}    ${operation_ui_scm_require_doc}
    [Return]    ${operation_status}

TrackerOrder - Get Available Item Status List
    [Arguments]    ${order_shipment_id}    ${option}=None
    Wait Until Element Is Visible    id=current_item_status${order_shipment_id}
    ${item_status_on_ui}=    Get Text    id=current_item_status${order_shipment_id}
    ${item_status_list}=    Run Keyword If    '${item_status_on_ui}' == 'Shipped' and '${option}' == 'COD'    TrackerOrder - Get Shipped COD Available Item Status List
    ...    ELSE IF    '${item_status_on_ui}' == 'Shipped'    TrackerOrder - Get Shipped Available Item Status List
    ...    ELSE IF    '${item_status_on_ui}' == 'Cancel Pending'    TrackerOrder - Get Cancel Pending Available Item Status List
    ...    ELSE IF    '${item_status_on_ui}' == 'Order Pending'    TrackerOrder - Get Order Pending Available Item Status List
    ...    ELSE IF    '${item_status_on_ui}' == 'Pending Shipment'    TrackerOrder - Get Pending Shipment Available Item Status List
    ...    ELSE IF    '${item_status_on_ui}' == 'Delivered'    TrackerOrder - Get Delivered Available Item Status List
    ...    ELSE IF    '${item_status_on_ui}' == 'Return Pending'    TrackerOrder - Get Return Pending Available Item Status List
    ...    ELSE IF    '${item_status_on_ui}' == 'Return Received'    TrackerOrder - Get Return Received Available Item Status List
    ...    ELSE    FAIL    Error!! Can not expect current status
    [Return]    ${item_status_list}

TrackerOrder - Get Shipped Available Item Status List
    ${item_status}=    Create List    ${item_status_ui_please_select}    ${item_status_ui_cancel_pending}    ${item_status_ui_customer_cancelled}    ${item_status_ui_failed_delivery}    ${item_status_ui_delivered}
    [Return]    ${item_status}

TrackerOrder - Get Shipped COD Available Item Status List
    ${item_status}=    Create List    ${item_status_ui_please_select}    ${item_status_ui_cancel_pending}    ${item_status_ui_customer_cancelled}    ${item_status_ui_delivered}
    [Return]    ${item_status}

TrackerOrder - Get Cancel Pending Available Item Status List
    ${item_status}=    Create List    ${item_status_ui_please_select}    ${item_status_ui_customer_cancelled}    ${item_status_ui_delivered}
    [Return]    ${item_status}

TrackerOrder - Get Order Pending Available Item Status List
    ${item_status}=    Create List    ${item_status_ui_please_select}    ${item_status_ui_pending_shipment}    ${item_status_ui_customer_cancelled}
    [Return]    ${item_status}

TrackerOrder - Get Pending Shipment Available Item Status List
    ${item_status}=    Create List    ${item_status_ui_please_select}    ${item_status_ui_shipped}    ${item_status_ui_customer_cancelled}
    [Return]    ${item_status}

TrackerOrder - Get Delivered Available Item Status List
    ${item_status}=    Create List    ${item_status_ui_please_select}    ${item_status_ui_customer_cancelled}    ${item_status_ui_replacement_pending}
    [Return]    ${item_status}

TrackerOrder - Get Return Pending Available Item Status List
    ${item_status}=    Create List    ${item_status_ui_please_select}    ${item_status_ui_return_failed}    ${item_status_ui_return_received}
    [Return]    ${item_status}

TrackerOrder - Get Return Received Available Item Status List
    ${item_status}=    Create List    ${item_status_ui_please_select}    ${item_status_ui_return_completed}
    [Return]    ${item_status}

Change All Items Status To Pending Shipment
    [Arguments]    ${order_id}
    Wait Until Element Is Visible    ${icon_truck}    10s
    ${webElement}=    Get Webelements    jquery=table.dataTable td.table-center:first-child
    : FOR    ${element}    IN    @{webElement}
    \    Select From List By Value    css=#status_item${element.text}    pending_shipment
    Click Element    ${button_orders_detail_save_all}
    Confirm Action

Change All Items Status To Shipped
    [Arguments]    ${order_id}
    Wait Until Element Is Visible    ${icon_truck}    10s
    ${webElement}=    Get Webelements    jquery=table.dataTable td.table-center:first-child
    : FOR    ${element}    IN    @{webElement}
    \    Select From List By Value    css=#status_item${element.text}    shipped
    \    Select From List By Value    css=#third_pl${element.text}    1
    Click Element    ${button_orders_detail_save_all}
    Confirm Action

Change Shipment Status By Order Id List
    ${order_counts}=    Get Length    ${ORDER_IDS}
    : FOR    ${index}    IN RANGE    0    ${order_counts}
    \    ${order_id}=    Get Data From List By Index    ${ORDER_IDS}    ${index}
    \    Change Shipment Status By Order Id    ${order_id}

TrackOrder - Customer Cancel order
    [Arguments]    ${SKU_id}
    ${element_cancel_order}=    Set Variable    //table[@id="orderShipmentTable"]//../td[2][contains(text(),"${SKU_id}")]/../td[9]/select
    Wait Until Element Is Visible    ${element_cancel_order}    60s
    Click Element    ${element_cancel_order}/option[contains(text(),"Customer Cancelled")]

TrackOrder - Customer Cancel order reason
    [Arguments]    ${SKU_id}
    ${cancel_reason}=    Set Variable    //table[@id="orderShipmentTable"]//../td[2][contains(text(),"${SKU_id}")]/../td[10]/select
    Wait Until Element Is Visible    ${cancel_reason}    60s
    Click Element    ${cancel_reason}/option[contains(text(),"Mismatch content")]

Get inventory ids from tracking page
    ${elements}=    Get Web Elements    ${material_id_and_inventory_id}
    ${inventory_ids}=    Create List
    : FOR    ${element}    IN    @{elements}
    \    Log to console    text1::${element.text}
    \    ${split_list}=    Split String    ${element.text}    /
    \    ${inventory_id}=    Get from list    ${split_list}    1
    \    Append To List    ${inventory_ids}    ${inventory_id}
    Log to console    inventory_ids::${inventory_ids}
    [Return]    ${inventory_ids}

Go to order together
    Go to    ${order_receipt_url}

TrackOrder - Export Order as Excel and Get Order Shipment Ids
    [Arguments]    ${order_id}    ${disount}
    Login Pcms    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    Go To    ${PCMS_URL}/orders/
    Input Text    //*[@id="order_id"]    ${order_id}
    Click Element    //*[@id='btn-search']
    Wait Until Element Is Visible    //table[@id='DataTables_Table_0']/tbody/tr/td[2]
    ${order_id}=    Get Text From Table    DataTables_Table_0    2    1
    Log    ${order_id}
    Remove All Export Order    ${DOWNLOAD-PATH}
    TrackOrder - Export Order Tracker as Excel
    @{files}=    Wait Until File is Downloaded Completely    ${DOWNLOAD-PATH}    export_order*.xlsx
    # @{files}=    List Files In Directory    ${DOWNLOAD-PATH}    export_order*.xlsx
    Discount Should Be Distributed correctly while last product is freebie    ${disount}    ${DOWNLOAD-PATH}/@{files}[0]
    ${order_shipment_id}=    get order shipment ids    ${order_id}
    ${order_shipment_id_list}=    Convert Tuple To List    ${order_shipment_id}
    Return From Keyword    ${order_shipment_id_list}

TrackOrder - Export Order Tracker as Excel
    Click Element    //*[@id='export-excel']

Remove All Export Order
    [Arguments]    ${DOWNLOAD-PATH}
    Remove File    ${DOWNLOAD-PATH}/export_order*.xlsx

Wait Until File is Downloaded Completely
    [Arguments]    ${absolute_path}    ${file_name}    ${repeat}=2
    : FOR    ${index}    IN RANGE    0    ${repeat}
    \    @{files}=    List Files In Directory    ${absolute_path}    ${file_name}
    \    ${is_downloaded}=    Get Length    ${files}
    \    ${result}=    Set Variable If    ${is_downloaded} > 0    ${True}    ${False}
    \    Sleep    2s
    Should Be True    ${result}
    Return From Keyword    ${files}

TrackOrder - Verify Log Api Send Item Status by Item Id
    [Arguments]    ${order_shipment_id}    ${item_status}
    ${log_order_db}=    get log api send item status    ${order_shipment_id}
    Should Be Equal As Strings    ${log_order_db[0][4]}    ${item_status}

TrackOrder - Verify Log OrderShipment by User
    [Arguments]    ${order_shipment_id}    ${item_status}    ${pcms_email}
    ${log_order_db}=    get log order shipment item    ${order_shipment_id}
    ${user_id}=    Get Id User by Email    ${pcms_email}
    Should Be Equal As Strings    ${log_order_db[0][1]}    ${item_status}
    Should Be Equal As Strings    ${log_order_db[0][2]}    ${user_id}

TrackOrder - Verify Log OrderShipment Two Status by User
    [Arguments]    ${order_shipment_id}    ${item_status}    ${item_status2}    ${pcms_email}
    ${log_order_db}=    get all log order shipment item    ${order_shipment_id}
    ${user_id}=    Get Id User by Email    ${pcms_email}
    Should Be Equal As Strings    ${log_order_db[0][1]}    ${item_status}
    Should Be Equal As Strings    ${log_order_db[1][1]}    ${item_status2}
    Should Be Equal As Strings    ${log_order_db[0][2]}    ${user_id}

TrackOrder - Verify Log OrderShipment by Api
    [Arguments]    ${order_shipment_id}    ${item_status}
    ${log_order_db}=    get log order shipment item    ${order_shipment_id}
    ${user_id}=    Get Id User by Email    ${pcms_email}
    Should Be Equal As Strings    ${log_order_db[0][1]}    ${item_status}
    Should Be Equal As Strings    ${log_order_db[0][2]}    api

TrackOrder - Verify Log OperationStatus by User
    [Arguments]    ${order_shipment_id}    ${operation_status}    ${pcms_email}
    ${log_operation_status_db}=    get log operation status    ${order_shipment_id}
    ${user_id}=    Get Id User by Email    ${pcms_email}
    Should Be Equal As Strings    ${log_operation_status_db[0][1]}    ${operation_status}
    Should Be Equal As Strings    ${log_operation_status_db[0][2]}    ${user_id}

TrackOrder - Verify Log OperationStatus by Api
    [Arguments]    ${order_shipment_id}    ${operation_status}
    ${log_operation_status_db}=    get log operation status    ${order_shipment_id}
    ${user_id}=    Get Id User by Email    ${pcms_email}
    Should Be Equal As Strings    ${log_operation_status_db[0][1]}    ${operation_status}
    Should Be Equal As Strings    ${log_operation_status_db[0][2]}    api

TrackerOrder - Verify Item Status - Operation Status - Payment Status - Log - Stock Hold - FMS - Order Together After Customer Cancelled for CCW and CS
    [Arguments]    ${order_id}    ${order_shipment_id}    ${pcms_email}
    TrackOrder - Check Item Status on UI    ${order_shipment_id}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_id}    customer_cancelled
    TrackOrder - Check Operation Status on UI    ${order_shipment_id}    Refund Request
    TrackOrder - Check Payment Status on UI    ${order_shipment_id}    Success
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_id}    customer_cancelled    ${pcms_email}
    Verify status in stock hold table    ${order_shipment_id}    cancel
    Verify item status on FMS    ${order_shipment_id}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_id}    4
    Order - Together Check Order Status In DB    ${order_id}    1

TrackedOrder - Verify 3pl on UI
    [Arguments]    ${order_id}    ${item_id}    ${3pl}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${3pl_dropdown_list}    Set Variable    jquery=#third_pl${item_id} option:selected
    Log To Console    ${3pl_dropdown_list}
    Wait Until Element Is Visible    ${3pl_dropdown_list}
    ${3pl_on_ui}=    Get Text    ${3pl_dropdown_list}
    Log To Console    ${3pl_on_ui}
    Should Not Be Empty    ${3pl_on_ui}
    Should Be Equal As Strings    ${3pl_on_ui}    ${3pl}

TrackOrder - Verify View Last Update Status Button is not Visible
    [Arguments]    ${item_id}
    Element Should Not Be Visible    id=last-update-operation-status-${item_id}

TrackOrder - Verify View Last Update Button for Operation Status is Visible
    [Arguments]    ${item_id}
    Element Should Be Visible    id=last-update-operation-status-${item_id}
    Element Should Contain    id=last-update-operation-status-${item_id}    View Last Update

TrackOrder - Verify Last Update for Operation Status is Shown Correctly
    [Arguments]    ${item_id}
    Click Element    id=last-update-operation-status-${item_id}
    ${data}=    Get Operation Status Latest Update    ${item_id}
    ${date_update}=    Convert Date    ${data[6]}    result_format=%d-%m-%Y %H:%M:%S
    Wait Until Element Does Not Contain    id=last-update-operation-status-${item_id}    waiting
    Element Should Contain    id=last-update-operation-status-${item_id}    ${date_update}
    Run Keyword IF    'None' == '${data[8]}'    Element Should Contain    id=last-update-operation-status-${item_id}    ${data[3]}
    ...    ELSE    Element Should Contain    id=last-update-operation-status-${item_id}    ${data[8]}

TrackOrder - Generate Excel File For Refund Completed
    [Arguments]    ${order_id}    ${inv_id}
    ${data}=    Get Item Id    ${order_id}    ${inv_id}
    ${tmn_ref_id}=    Set Variable    bankref-xxxx
    #Choose File    id=browse-pending-tmn    ${CU}
    create_and_write_to_excel_file    ${write_data}

Track Order - Get List item Query by Cron
    [Arguments]    ${item_id}
    ${list}=    get_item_used_by_Cron    ${item_id}
    [Return]    ${list}

Track Order - Run Cron Update item Status
    Open Browser    ${PCMS_URL}/command/update-item-status-return-pending-to-return-fail    chrome
    # Open Browser    file:///C:/Users/natthawat.cha/Desktop/update-item-status-return-pending-to-return-fail.html    chrome

Track Order - Get Order Shipment Items
    [Arguments]    ${order_id}
    ${data}=    get_all_item    ${order_id}
    [Return]    ${data}

Track Order - Get Order ID by Item ID
    [Arguments]    ${item_id}
    ${data}=    get_order_id_by_item_id    ${item_id}
    [Return]    ${data[0]}

Track Order - Check Point Redemption Log
    [Arguments]    ${show}
    Run Keyword IF    '1' == '${show}'    Element Should Be Visible    //*[@id="table-point-redemption-log"]
    ...    ELSE    Element Should Not Be Visible    //*[@id="table-point-redemption-log"]

Track Order - Verify Point Redemption Log
    [Arguments]    ${partner}    ${used_point}    ${normal_discount}    ${additional_discount}    ${total_discount}
    ${partner_ui}=    Get Text    //*[@id="table-point-redemption-log"]/div[2]/table/tbody/tr/td[1]
    ${used_point_ui}=    Get Text    //*[@id="table-point-redemption-log"]/div[2]/table/tbody/tr/td[2]
    ${normal_discount_ui}=    Get Text    //*[@id="table-point-redemption-log"]/div[2]/table/tbody/tr/td[3]
    ${additional_discount_ui}=    Get Text    //*[@id="table-point-redemption-log"]/div[2]/table/tbody/tr/td[4]
    ${total_discount_ui}=    Get Text    //*[@id="table-point-redemption-log"]/div[2]/table/tbody/tr/td[5]
    Should Be Equal    ${partner}    ${partner_ui}
    Should Be Equal as Numbers    ${used_point}    ${used_point_ui}
    Should Be Equal as Numbers    ${normal_discount}    ${normal_discount_ui}
    Should Be Equal as Numbers    ${additional_discount}    ${additional_discount_ui}
    Should Be Equal as Numbers    ${total_discount}    ${total_discount_ui}
