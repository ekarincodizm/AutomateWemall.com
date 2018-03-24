*** Variables ***
${Get_SeleOrderID_InTable}    //*[contains(@id,'update_shipment_items')]//tbody//tr/td[1]

${operation_db_none}    none
${operation_db_refund_request}    refund_request
${operation_db_clt_doc_uploaded}    clt_doc_uploaded
${operation_db_scm_verified}    scm_verified
${operation_db_scm_require_doc}    scm_require_doc
${operation_db_pending_tmn}    pending_tmn
${operation_db_refund_complete}    refund_complete
${operation_db_unable_to_refund}    unable_to_refund
${operation_db_return_refund_request}    return_refund_request
${operation_db_not_in_system}    not_in_system

${operation_ui_please_select}    - Please select -
${operation_ui_none}    None
${operation_ui_refund_request}    Refund Request
${operation_ui_clt_doc_uploaded}    CLT Doc Uploaded
${operation_ui_scm_verified}    SCM Verified
${operation_ui_scm_require_doc}    SCM Require Doc
${operation_ui_pending_tmn}    Pending TMN
${operation_ui_refund_complete}    Refund Complete
${operation_ui_unable_to_refund}    Unable to Refund
${operation_ui_return_refund_request}    Return Refund Request
${operation_ui_not_in_system}    Not in System

${clt_doc_upload_section}     id=order_uplaod_document
${clt_doc_upload_button}     id=upload-document

${doc_remark_section}           id=document-remark-container
${remark_first_line}            //div[@id="document-remark-container"]/table[@class="mws-datatable-fn mws-table upload-document-list"]/tbody/tr/td
${date_first_line}              //div[@id="document-remark-container"]/table[@class="mws-datatable-fn mws-table upload-document-list"]/tbody/tr/td[3]/span
${user_first_line}              //div[@id="document-remark-container"]/table[@class="mws-datatable-fn mws-table upload-document-list"]/tbody/tr/td[2]/span

${save_all}                  jquery=button#save_all_item_status    #//*[@id="update_shipment_items"]/div[3]/div/button

${track-order_view}    track-order_view
${order-doc_view}     track-order_view-document-upload-section-to
${order-doc_manage}   track-order_manage-document-upload-section-to

${item_status_ui_please_select}    - Please select -
${item_status_ui_order_pending}    Order Pending
${item_status_ui_cancel_pending}    Cancel Pending
${item_status_ui_customer_cancelled}    Customer Cancelled
${item_status_ui_failed_delivery}    Failed Delivery
${item_status_ui_delivered}    Delivered
${item_status_ui_pending_shipment}    Pending Shipment
${item_status_ui_shipped}    Shipped
${item_status_ui_return_pending}    Return Pending
${item_status_ui_replacement_pending}    Replacement Pending
${item_status_ui_return_received}    Return Received
${item_status_ui_return_failed}    Return Failed
${item_status_ui_return_rejected}    Return Rejected
${item_status_ui_return_completed}    Return Completed

${item_status_db_order_pending}    order_pending
${item_status_db_cancel_pending}    cancel_pending
${item_status_db_customer_cancelled}    customer_cancelled
${item_status_db_failed_delivery}    failed_delivery
${item_status_db_delivered}    delivered
${item_status_db_pending_shipment}    pending_shipment
${item_status_db_shipped}    shipped
${item_status_db_return_pending}    return_pending
${item_status_db_replacement_pending}    replacement_pending
${item_status_db_return_received}    return_received
${item_status_db_return_failed}    return_failed
${item_status_db_return_rejected}    return_rejected
${item_status_db_return_completed}    return_completed

${item_status_fms_customer_cancelled}    cancelled
${item_status_fms_return_pending}    return pending
${item_status_fms_return_received}    return received
${item_status_fms_return_failed}    return failed
${item_status_fms_delivered}    delivered
${item_status_fms_return_rejected}    return rejected
${item_status_fms_return_completed}    return completed


## hulk team ####
${textbox_search_by_order}    jquery=input[id="order_id"]
${button_search}    jquery=button[id="btn-search"]
${icon_truck}                               css=.icon-truck
${button_orders_detail_save_all}            jquery=button.btn.btn-primary:contains('Save All')
${order_together_bar}       jquery=li a i.icon-coffee:eq(0)
${order_together_bar_receipt}       jquery=li ul li a[href="${PCMS_URL}/order-receipt"]:eq(0)
${order_together_input_pcms_order_id}       jquery=input[name="f_pcms_order_id_1"]:eq(0)
${order_together_search_button}             jquery=.btn.btn-primary
${order_together_export_billing_button}     jquery=.btn.btn-warning.btn-small:eq(0)
${download_button}                          jquery=.btn.btn-warning.btn-small:eq(1)
${order_together_textarea}                  css=p>textarea
${order_together_confirm}                   css=.btn.btn-primary
${file_original}                            ${CURDIR}/../../../Resources/Template/test.pdf
${file_robot_download}                      ${CURDIR}/../../../Resources/Template/3000111-1511000143.pdf
${order_together_textarea}                  jquery=textarea

${text_box_search_by_order_date_from}    id=created_at_start
${text_box_search_by_order_date_to}    id=created_at_end
${button_export_excel}    id=export-excel
${order_promotion_name}    jquery=table.mws-datatable-fn.mws-table:eq(3) tbody tr td:eq(2)
${order_promotion_type}    jquery=table.mws-datatable-fn.mws-table:eq(3) tbody tr td:eq(3)
${order_promotion_discount}    jquery=table.mws-datatable-fn.mws-table:eq(3) tbody tr td:eq(5)
${order_promotion_code}    jquery=table.mws-datatable-fn.mws-table:eq(3) tbody tr td:eq(6)
${export_excel_link}    jquery=.mws-button-row a.hide

${material_id_and_inventory_id}    //table[@class='mws-datatable-fn mws-table dataTable']/tbody/tr/td[@class='table-center'][2]

${operation_status_option}                     id=status_operation_

${cancel_reason_option_class}                     class=dropdown_cancel_reason
${operation_status_option_class}                     class=status_operation_select_operation_status

${cancel_reason_option}                     id=dropdown_cancel_reason_
${cancel_reason_ui_content_mismatch_content}    Content: Mismatch content
${cancel_reason_db_content_mismatch_content}    1
${cancel_reason_ui_system_can_not_use_coupon}    System: Can not use coupon
${cancel_reason_db_system_can_not_use_coupon}    2
${cancel_reason_ui_customer_change_of_mind}    Customer: Change of mind
${cancel_reason_db_customer_change_of_mind}    3
${cancel_reason_ui_product_quality_poor_quality}    Product Quality : Poor Quality
${cancel_reason_db_product_quality_poor_quality}    4
${cancel_reason_ui_customer_wrong_order}    Customer: Wrong Order
${cancel_reason_db_customer_wrong_order}    5
${cancel_reason_ui_customer_fraud_order}    Customer: Fraud Order
${cancel_reason_db_customer_fraud_order}    6
${cancel_reason_ui_operation_late_delivery}    Operation: Late delivery
${cancel_reason_db_operation_late_delivery}    7
${cancel_reason_ui_operation_missing_item}    Operation: Missing Item
${cancel_reason_db_operation_missing_item}    8
${cancel_reason_ui_operation_out_of_stock}    Operation: Out of Stock
${cancel_reason_db_operation_out_of_stock}    9
${cancel_reason_ui_operation_package_damaged}    Operation: Package Damaged
${cancel_reason_db_operation_package_damaged}    10
${cancel_reason_ui_operation_product_missing}    Operation: Product Missing
${cancel_reason_db_operation_product_missing}    11
${cancel_reason_ui_operation_supplier_issue}    Operation: Supplier Issue
${cancel_reason_db_operation_supplier_issue}    12
${cancel_reason_ui_operation_wrong_item}    Operation: Wrong Item
${cancel_reason_db_operation_wrong_item}    13
${cancel_reason_ui_other}    Other
${cancel_reason_db_other}    14
${cancel_reason_ui_customer_change_payment_type}    Customer: Change Payment Type
${cancel_reason_db_customer_change_payment_type}    15
${cancel_reason_ui_customer_need_to_use_discount}    Customer: Need to use discount
${cancel_reason_db_customer_need_to_use_discount}    16
${cancel_reason_ui_payment_offline_expired}    Payment: Offline Expired
${cancel_reason_db_payment_offline_expired}    17
${cancel_reason_ui_test}    Test
${cancel_reason_db_test}    18
${cancel_reason_ui_test}    Customer: Use coupon wrong Term & Condition
${cancel_reason_db_test}    19
${cancel_reason_ui_test}    Operation: Failed Delivery
${cancel_reason_db_test}    20
${cancel_reason_ui_test}    Payment: Payment Expired
${cancel_reason_db_test}    21
