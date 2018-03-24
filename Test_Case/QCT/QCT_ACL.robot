*** Settings ***
Resource          ${CURDIR}/../../Resource/init.robot 
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/User_Role/Keywords_User_Role.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track_order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Item_status/update_item_status.robot
Library           ${CURDIR}/../../Python_Library/common.py

*** Variable ***
${email-guest}    testACL_docUpload@domain.com
${pcms_email}     admin@domain.com
${pcms_pass}      12345
${pcms_email_clt_doc_upload}    clt_doc_upload@test.com
${pcms_user_clt_doc_upload}    clt_doc_upload
${pcms_pass_clt_doc_upload}    12345
${user_role_group}    CLT doc upload ACL
${track-order_view}    track-order_view
${order-doc_view}    track-order_view-document-upload-section-to
${order-doc_manage}    track-order_manage-document-upload-section-to
${user_id}        35
${ID_file}        ${CURDIR}/../../Resource/PIC/pds.pdf
${book_bank_file}    ${CURDIR}/../../Resource/PIC/600w.png
${slip_file}      ${CURDIR}/../../Resource/PIC/400p.jpg
${company_book_bank_file}    ${CURDIR}/../../Resource/PIC/pds.pdf
${company_certificate_file}    ${CURDIR}/../../Resource/PIC/600w.png
${marriage_certificate_file}    ${CURDIR}/../../Resource/PIC/400p.jpg
${other_file}     ${CURDIR}/../../Resource/PIC/pds.pdf
${ID_id}          1
${book_bank_id}    2
${slip_id}        3
${company_book_bank_id}    4
${company_certificate_id}    5
${marriage_certificate_id}    6
${other_id}       7
${document_upload}    jquery=#order_uplaod_document
${element_browse_file_all_tab}    jquery=#order_uplaod_document .fileinput-btn input
${element_button_all_tab}    jquery=#order_uplaod_document button.btn
${inventory_id}    LOAAB1111111
#เมาส์พร้อมคีย์บอร์ด Logitech Wireless mouse MK240 (Black)

*** Test Cases ***
Create user and apply user role with operation status permission = view only
    [Tags]    QCT    tc1
    LOGIN PCMS    ${pcms_email}    ${pcms_pass}
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${order-doc_view}
    PCMS Set Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_clt_doc_upload}    ${pcms_user_clt_doc_upload}    ${pcms_pass_clt_doc_upload}    ${user_role_group}
    ${order_id}=    Guest Buy Product Success with CS    ${email-guest}    ${inventory_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_pass}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    Login Pcms    ${pcms_email_clt_doc_upload}    ${pcms_pass_clt_doc_upload}
    TrackOrder - Go To Order Detail Page    ${order_id}
    Wait Until Element Is Visible    ${document_upload}
    Wait Until Element Is Not Visible    ${element_browse_file_all_tab}
    Element Should Be Disabled    ${element_button_all_tab}
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_clt_doc_upload}
    ...    AND    Clear User Role By Name    ${user_role_group}

Create user and apply user role with CLT doc upload permission = manage only
    [Tags]    QCT
    Login Pcms    ${pcms_email}    ${pcms_pass}
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${order-doc_manage}
    PCMS Set Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_clt_doc_upload}    ${pcms_user_clt_doc_upload}    ${pcms_pass_clt_doc_upload}    ${user_role_group}
    ${order_id}=    Guest Buy Product Success with CS    ${email-guest}    ${inventory_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_pass}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    Login Pcms    ${pcms_email_clt_doc_upload}    ${pcms_pass_clt_doc_upload}
    TrackOrder - Go To Order Detail Page    ${order_id}
    Wait Until Element Is Visible    ${document_upload}
    Element Should Be Enabled    ${element_browse_file_all_tab}
    ${user_id}=    Get Id User by Email    ${pcms_email_clt_doc_upload}
    #
    TrackOrder - CLT doc upload - Upload file    ${ID_file}    ${ID_id}
    TrackOrder - CLT doc upload - Upload file    ${book_bank_file}    ${book_bank_id}
    TrackOrder - CLT doc upload - Upload file    ${slip_file}    ${slip_id}
    TrackOrder - CLT doc upload - Upload file    ${company_book_bank_file}    ${company_book_bank_id}
    TrackOrder - CLT doc upload - Upload file    ${company_certificate_file}    ${company_certificate_id}
    TrackOrder - CLT doc upload - Upload file    ${marriage_certificate_file}    ${marriage_certificate_id}
    TrackOrder - CLT doc upload - Upload file    ${other_file}    ${other_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file name on UI    ${ID_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${ID_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${book_bank_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${book_bank_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${slip_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${slip_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${company_book_bank_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${company_book_bank_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${company_certificate_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${company_certificate_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${marriage_certificate_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${marriage_certificate_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${other_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${other_id}    ${user_id}
    Element Should Be Enabled    ${element_button_all_tab}
    TrackOrder - CLT doc upload - Click to delete file    ${ID_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${ID_id}
    TrackOrder - CLT doc upload - Click to delete file    ${book_bank_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${book_bank_id}
    TrackOrder - CLT doc upload - Click to delete file    ${slip_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${slip_id}
    TrackOrder - CLT doc upload - Click to delete file    ${company_book_bank_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${company_book_bank_id}
    TrackOrder - CLT doc upload - Click to delete file    ${company_certificate_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${company_certificate_id}
    TrackOrder - CLT doc upload - Click to delete file    ${marriage_certificate_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${marriage_certificate_id}
    TrackOrder - CLT doc upload - Click to delete file    ${other_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${other_id}
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_clt_doc_upload}
    ...    AND    Clear User Role By Name    ${user_role_group}

Create user and apply user role with CLT doc upload permission = view&manage
    [Tags]    QCT
    Login Pcms    ${pcms_email}    ${pcms_pass}
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${track-order_view}    ${order-doc_view}    ${order-doc_manage}
    PCMS Set Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_clt_doc_upload}    ${pcms_user_clt_doc_upload}    ${pcms_pass_clt_doc_upload}    ${user_role_group}
    ${order_id}=    Guest Buy Product Success with CS    ${email-guest}    ${inventory_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_pass}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    Login Pcms    ${pcms_email_clt_doc_upload}    ${pcms_pass_clt_doc_upload}
    TrackOrder - Go To Order Detail Page    ${order_id}
    Wait Until Element Is Visible    ${document_upload}
    Element Should Be Enabled    ${element_browse_file_all_tab}
    ${user_id}=    Get Id User by Email    ${pcms_email_clt_doc_upload}
    TrackOrder - CLT doc upload - Upload file    ${ID_file}    ${ID_id}
    TrackOrder - CLT doc upload - Upload file    ${book_bank_file}    ${book_bank_id}
    TrackOrder - CLT doc upload - Upload file    ${slip_file}    ${slip_id}
    TrackOrder - CLT doc upload - Upload file    ${company_book_bank_file}    ${company_book_bank_id}
    TrackOrder - CLT doc upload - Upload file    ${company_certificate_file}    ${company_certificate_id}
    TrackOrder - CLT doc upload - Upload file    ${marriage_certificate_file}    ${marriage_certificate_id}
    TrackOrder - CLT doc upload - Upload file    ${other_file}    ${other_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file name on UI    ${ID_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${ID_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${book_bank_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${book_bank_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${slip_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${slip_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${company_book_bank_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${company_book_bank_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${company_certificate_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${company_certificate_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${marriage_certificate_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${marriage_certificate_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${other_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${other_id}    ${user_id}
    Element Should Be Enabled    ${element_button_all_tab}
    TrackOrder - CLT doc upload - Click to delete file    ${ID_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${ID_id}
    TrackOrder - CLT doc upload - Click to delete file    ${book_bank_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${book_bank_id}
    TrackOrder - CLT doc upload - Click to delete file    ${slip_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${slip_id}
    TrackOrder - CLT doc upload - Click to delete file    ${company_book_bank_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${company_book_bank_id}
    TrackOrder - CLT doc upload - Click to delete file    ${company_certificate_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${company_certificate_id}
    TrackOrder - CLT doc upload - Click to delete file    ${marriage_certificate_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${marriage_certificate_id}
    TrackOrder - CLT doc upload - Click to delete file    ${other_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${other_id}
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_clt_doc_upload}
    ...    AND    Clear User Role By Name    ${user_role_group}
