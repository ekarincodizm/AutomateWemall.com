*** Variables ***
${icon_truck}                               css=.icon-truck
${button_orders_detail_save_all}            jquery=button.btn.btn-primary:contains('Save All')
${lbl_payment}                              //div[@id="payment_status"]
${btn_confirm_cancel}                              //button[@id="cancel_reason-confirm"]
${lbl_payment_status}                       //div[@id="payment_status" and @data-payment-status="^^payment_status^^"]
${lbl_item_payment_status}                  //tr[@data-camp-type="^^camp_type^^"]/td[@data-column="payment-status"]/*[contains(text(), '^^payment_status^^')]
${lbl_item_camp_type}                       //tr[@data-camp-type="^^camp_type^^"]/td[@data-column="payment-status"]
${table_promotion_camp_logs}                //div[@id="table-promotion-camp-logs"]
${camp_log_camp_id}                         //tr[@data-camp-type="freebie"]/td[@data-column="camp_id" and contains(text(), '^^camp_id^^')]

${textarea_cusotmer_address}                //*[@name="order[REPLACE_ORDER_ID][customer_address]"]
${btn_save_customer_address}                //table[contains(@class, 'customer')]/tbody/tr/td/form/div/input[@type="submit"]

${ORDER-DETAIL-TABLE}       xpath=//*[@id="orderShipmentTable"]

&{MSG_ORDER_DETAIL}  payment_status_success=ชำระเงินสำเร็จ
 ...  payment_status_failed=
 ...  payment_status_waiting=รอการชำระเงิน
