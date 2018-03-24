*** Variables ***
${Thankyou_OrderID}         //*[@id="thank_order_id"]
${Thankyou_ClosePopup}      //*[@id="popup-regis"]/div/div/div[1]/div[2]/img
${Thankyou_DeliveryText}    //*[@id="remark-text-delivery"]

${deliverydate1}    //*[@id="contener"]/div/div[1]/div[1]/div[3]/div[1]/div[4]/div[2]/div[2]/div[1]/span
${deliverydate2}    //*[@id="contener"]/div/div[1]/div[1]/div[3]/div[1]/div[4]/div[2]/div[3]/div[1]/span
${get_email_Thankyou}    id=thank_email
${get_address_Thankyou}    id=thank_shipping_address
${deliverydate1}            //*[@id="contener"]/div/div[1]/div[1]/div[3]/div[1]/div[4]/div[2]/div[2]/div[1]/span
${deliverydate2}            //*[@id="contener"]/div/div[1]/div[1]/div[3]/div[1]/div[4]/div[2]/div[3]/div[1]/span
${total-discount-thankyou}    //*[@id='contener']/div/div[1]/div[1]/div[3]/div[1]/div[4]/div[3]/div[2]/div[5]/div[2]

&{XPATH_THANKYOU}   lbl_payment_status=//div[@class="p-row"]/div[contains(@class, "p-title-p")]
 ...  lbl_order_status=//div[@class="p-row"]/div[contains(@class, "p-title-p")][1]
 ...  lbl_tracking_number=//div[@class="p-row"]/div[contains(@class, "p-title-p")][1]
 ...  lbl_estimated_date_of_delivery=//div[@class="p-row"]/div[contains(@class, "p-title-p")][1]
 ...  lbl_first_normal_price=//div[@class="p-row"]/div[contains(@class, "p-title-c")][1]/span
 ...  lbl_first_quantity=//div[@class="p-row"]/div[contains(@class, "p-title-n")][1]
 ...  lbl_first_total_price=//div[@class="p-row"]/div[contains(@class, "p-title-n-s")][1]
 ...  lbl_summary_total_price=//div[@class="p-row-sum"][1]/div[contains(@class, "p-title-n-s")]
 ...  lbl_summary_shipping_price=//div[@class="p-row-sum"][2]/div[contains(@class, "p-title-n-s")]
 ...  lbl_summary_discount_price=//div[@class="p-row-sum"][3]/div[contains(@class, "p-title-n-s")]
 ...  lbl_summary_sub_total_price=//span[@id="thank_total_pay"]
 ...  lbl_order_id=//span[@id="thank_order_id"]
 ...  row_normal_item=//div[@class="p-row" and @data-type="normal"]
 ...  row_freebie_item=//div[@class="p-row" and @data-type="freebie"]
 ...  row_all_item=//div[@class="p-row" and @data-type]
 ...  normal_item_total_price_row_x=//div[@class="p-row"][@data-type="normal"][^^position^^]/div[contains(@class, "p-title-n-s")]
 ...  normal_item_price_row_x=//div[@class="p-row"][@data-type="normal"][^^position^^]/div[contains(@class, "p-title-c")]/span[1]
 ...  normal_item_qty_row_x= //div[@class="p-row"][@data-type="normal"][^^position^^]/div[contains(@class, "p-title-n")][1]
 ...  freebie_item_total_price_row_x=//div[@class="p-row"][@data-type="freebie"][^^position^^]/div[contains(@class, "p-title-n-s")]
 ...  freebie_item_price_row_x=//div[@class="p-row"][@data-type="freebie"][^^position^^]/div[contains(@class, "p-title-c")]/span[1]
 ...  freebie_item_qty_row_x=//div[@class="p-row"][@data-type="freebie"][^^position^^]/div[contains(@class, "p-title-n")][1]
 ...  camp_short_description=//span[@data-id="camp_short_description"]
 ...  lbl_order_status_head=//div[contains(@class, "thank-icon")]/h1


&{MSG_THANKYOU}  payment_status_success=ชำระเงินเรียบร้อยแล้ว
 ...  payment_status_failed=
 ...  payment_status_waiting=
 ...  order_status_verify_pending=รอการตรวจสอบจากเจ้าหน้าที่
 ...  no_tracking_number=ยังไม่มีเลขที่พัสดุ
 ...  email_subject=ยืนยันรายการสั่งซื้อและชำระเงินสำเร็จแล้ว
 ...  email_mnp_subject=คุณได้ทำการลงทะเบียนย้ายค่ายเบอร์เดิมเป็นทรูมูฟ เอช
 ...  sms_subject1=รายการสั่งซื้อ
 ...  sms_subject2=ชำระเงินผ่านบัตรเครดิตเรียบร้อยแล้ว
 ...  order_payment_status_waiting=รายการสั่งซื้อรอการชำระเงิน
 ...  order_payment_status_success=รายการสั่งซื้อของคุณชำระเงินเรียบร้อยแล้ว

&{MSG_THANKYOU_EN}  payment_status_success=
 ...  payment_status_failed=
 ...  payment_status_waiting=
 ...  order_payment_status_success=Your order has been paid successfully.
