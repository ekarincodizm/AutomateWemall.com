*** Variable ***
${email}    guest@email.com
${pcms_email}     admin@domain.com
${pcms_password}    12345
@{product}    2727186360913
${inventory_id}    ASAAA1119111
${upload_file}    wemall.png
${path_excel_file}    ${CURDIR}/../../../../Resource/TestData/update_operation_status
${excel_file}    update_operation_status/update_operation_status_refundrequest_to_pendingtmn.xlsx
${excel_file_no_order_id}	 update_operation_status/update_operation_status_refundrequest_to_pendingtmn_no_order_id.xlsx
${excel_file_multiple_no_order_id}	 update_operation_status/update_operation_status_refundrequest_to_pendingtmn_multiple_no_order_id.xlsx
${excel_file_multiple_some_no_order_id}	 update_operation_status/update_operation_status_refundrequest_to_pendingtmn_multiple_some_no_order_id.xlsx
${excel_file_no_item_id}	 update_operation_status/update_operation_status_refundrequest_to_pendingtmn_multiple_no_item_id.xlsx
${error_incorrect_file_type}    Only xlsx is allowed.
${error_no_file_upload}    No xlsx files were uploaded.
${error_no_order_id}    No Order id.
${refund_request_to_pending_tmn_excel_file_name}    Refund_Request_To_Pending_TMN.xlsx
${pending_tmn_to_refund_complete_excel_file_name}    Pending_TMN_To_Refund_Complete.xlsx

${operation_db_customer_cancel}    customer_cancelled
${operation_db_refund_request}     refund_request
${operation_db_pending_tmn}        pending_tmn
${operation_ui_pending_tmn}        Pending TMN
${operation_ui_refund_complete}    Refund Complete
${operation_db_refund_complete}    refund_complete
${operation_db_clt_doc_uploaded}    clt_doc_uploaded
${operation_db_scm_verified}    scm_verified
${operation_db_scm_require_doc}    scm_require_doc


# **ID**
${frame_refund_request_to_pending_tmn}    frm-upload-refund-request
${frame_pending_tmn_to_refund_complete}    frm-upload-pending-tmn
${button_submit_upload_refund_request}    btn-submit-upload-refund-request
${button_submit_upload_pending_tmn}    btn-submit-upload-pending-tmn
${browse_refund_request}    browse-refund-request
${browse_pending_tmn}    browse-pending-tmn

# ${browse_pending_tmn}        //input[@id="browse-pending-tmn"]
# ${btn_upload_pending_tmn}    //*[@id="btn-submit-upload-pending-tmn"]
# ${section_pending_tmn}       //*[@id="frm-upload-pending-tmn"]


${dialog_result}                    jquery=#dialog-result

${error_message_order_not_found}      jquery=#error_order_id_not_found b
${error_line_order_not_found}         jquery=#error_order_id_not_found span
${error_message_item_not_found}       jquery=#error_item_id_not_found b
${error_line_item_not_found}          jquery=#error_item_id_not_found span
${error_message_item_id_not_match}    jquery=#error_item_id_not_match b
${error_line_item_id_not_match}       jquery=#error_item_id_not_match span
${error_message_incorrect_payment_channel}     jquery=#error_incorrect_payment_channel b
${error_line_incorrect_payment_channel}        jquery=#error_incorrect_payment_channel span
${error_message_incorrect_operation_status}    jquery=#error_incorrect_operation_status b
${error_line_incorrect_operation_status}       jquery=#error_incorrect_operation_status span
${error_message_order_not_match}               jquery=#error_order_id_not_match b
${error_line_order_not_match}                  jquery=#error_order_id_not_match span
${error_message_cannot_change_operation_status}    jquery=#error_cannot_change_operation_status b
${error_line_cannot_change_operation_status}       jquery=#error_cannot_change_operation_status span
${error_message_required_TMN_payment_ref}          jquery=#error_tmn_payment_ref_required b
${error_line_required_TMN_payment_ref}             jquery=#error_tmn_payment_ref_required span
${error_message_duplicate_records}					jquery=#error_duplicate_data b
${error_line_required_duplicate_records}            jquery=#error_duplicate_data span

## error message ##
${text_error_message_required_TMN_payment_ref}      Required TMN payment ref.
${text_error_message_order_not_found}               Order id not found
${text_error_message_item_not_found}                Item id not found
${text_error_message_order_not_match}               Item not match with order id
${text_error_message_item_id_not_match}             Item not match with order id
${text_error_message_incorrect_payment_channel}     Incorrect payment channel
${text_error_message_incorrect_operation_status}    Incorrect operation status
${text_error_message_cannot_change_operation_status}    Cannot change operation status
${text_error_message_duplicate_records}    			Duplicate data


${popup_error_message}
${message_required_TMN_payment_ref}
${error_empty_file}    Column "order id" is not found.
${common_upload_file_error_msg}    Failed to update operation status. Please check error below.
${success_message}    jquery=#total_success
${duplicate_message}    jquery=#total_duplicate
${error_msg_required_field_upload_file_refund_request_to_pending_tmn}    Order id, Item id is required.
${error_msg_required_field_upload_file_pending_tmn_to_refund_complete}    Order id, Item id, TMN Payment Ref. is required.
${error_no_file_upload}    No xlsx files were uploaded.

${bank_ref_tmn}    123456789