*** Variables ***
# ${Run_Order_Process}          //*[@id="run_job"]
# ${Order_Content}              //div[@id="status_cbox"][contains(.,'PCMS Order')]

${textbox_search_by_order}    jquery=input[id="order_id"]
${button_search}              jquery=button[id="btn-search"]
${icon_truck}                               css=.icon-truck
${button_orders_detail_save_all}            jquery=button.btn.btn-primary:contains('Save All')
${order_together_bar}                       jquery=li a i.icon-coffee:eq(0)
${order_together_bar_receipt}               jquery=li ul li a[href='${PCMS_URL}/order-receipt']:eq(0)
${order_together_input_pcms_order_id}       jquery=input[name="f_pcms_order_id_1"]:eq(0)
${order_together_search_button}             jquery=.btn.btn-primary
${order_together_export_billing_button}     jquery=.btn.btn-warning.btn-small:eq(0)
${download_button}                          jquery=.btn.btn-warning.btn-small:eq(1)
${order_together_textarea}                  css=p>textarea
${order_together_confirm}                   css=.btn.btn-primary
${file_original}                            ${CURDIR}/../../../Resources/Template/test.pdf
${file_robot_download}                      ${CURDIR}/../../../Resources/Template/3000111-1511000143.pdf
${order_together_textarea}                  jquery=textarea

${text_box_search_by_order_date_from}       id=created_at_start
${text_box_search_by_order_date_to}         id=created_at_end
${button_export_excel}                      id=export-excel
${order_promotion_name}                     jquery=table.mws-datatable-fn.mws-table:eq(3) tbody tr td:eq(2)
${order_promotion_type}                     jquery=table.mws-datatable-fn.mws-table:eq(3) tbody tr td:eq(3)
${order_promotion_discount}                 jquery=table.mws-datatable-fn.mws-table:eq(3) tbody tr td:eq(5)
${order_promotion_code}                     jquery=table.mws-datatable-fn.mws-table:eq(3) tbody tr td:eq(6)
${export_excel_link}                        jquery=.mws-button-row a.hide