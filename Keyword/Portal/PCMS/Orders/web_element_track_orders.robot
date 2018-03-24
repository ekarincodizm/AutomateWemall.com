*** Variables ***
${textbox_search_by_order}    jquery=input[id="order_id"]
${button_search}              jquery=button[id="btn-search"]
${order_together_bar}                       jquery=li a i.icon-coffee:eq(0)
${order_together_bar_receipt}               jquery=li ul li a[href="${PCMS_URL}/order-receipt"]:eq(0)
${order_together_input_pcms_order_id}       jquery=input[name="f_pcms_order_id_1"]:eq(0)
${order_together_search_button}             jquery=.btn.btn-primary
${order_together_export_billing_button}     jquery=.btn.btn-warning.btn-small:eq(0)
${download_button}                          jquery=.btn.btn-warning.btn-small:eq(1)
${order_together_textarea}                  css=p>textarea
${order_together_confirm}                   css=.btn.btn-primary
${file_original}                            ${CURDIR}/../../../Resources/Template/test.pdf
${file_robot_download}                      ${CURDIR}/../../../Resources/Template/3000111-1511000143.pdf
${order_together_textarea}                  jquery=textarea

${button_export_excel}         id=export-excel
${order_promotion_name}        jquery=table.mws-datatable-fn.mws-table:eq(3) tbody tr td:eq(2)
${order_promotion_type}        jquery=table.mws-datatable-fn.mws-table:eq(3) tbody tr td:eq(3)
${order_promotion_discount}    jquery=table.mws-datatable-fn.mws-table:eq(3) tbody tr td:eq(5)
${order_promotion_code}        jquery=table.mws-datatable-fn.mws-table:eq(3) tbody tr td:eq(6)
${export_excel_link}           jquery=.mws-button-row a.hide

# Search Form
${text_box_search_by_order_id}      id=order_id
${text_box_search_by_booking_id}    id=booking_id
${select_box_app}                   //select[@name="app_id"]
${select_box_payment_status}        //select[@name="payment_status"]
${select_box_item_status}           //select[@name="item_status"]
${select_box_payment_method}        //select[@name="payment_method"]

${text_box_search_by_order_date_from}       id=created_at_start
${text_box_search_by_order_date_to}         id=created_at_end
${text_box_search_by_payment_date_from}     id=transaction_time_start
${text_box_search_by_payment_date_to}       id=transaction_time_end
${text_box_search_by_expired_date_from}     id=expired_at_start
${text_box_search_by_expired_date_to}       id=expired_at_end

${select_box_operation_status}          id=operation_status_option
${select_box_search_by_operation_status_date_from}      id=operation_status_date_from
${select_box_search_by_operation_status_date_to}        id=operation_status_date_to
${select_box_sla_operation_status}      id=operation_status_sla_option
${select_box_stock_type}                id=stock_type_option

${button_reset}     id=btn-reset

${operation_db_customer_cancel}    customer_cancelled
${operation_db_refund_request}     refund_request
${operation_ui_refund_request}     Refund Request
${operation_db_pending_tmn}        pending_tmn
${operation_ui_pending_tmn}        Pending TMN
${operation_ui_refund_complete}    Refund Complete
${operation_db_refund_complete}    refund_complete
${operation_db_clt_doc_uploaded}    clt_doc_uploaded
${operation_ui_clt_doc_uploaded}    CLT Doc Uploaded
${operation_db_scm_verified}    scm_verified
${operation_ui_scm_verified}    SCM Verified
${operation_db_scm_require_doc}    scm_require_doc
${operation_ui_scm_require_doc}    SCM Require Doc
${operation_db_unable_to_refund}    unable_to_refund
${operation_ui_unable_to_refund}    Unable to Refund