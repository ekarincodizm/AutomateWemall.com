*** Variables ***
${SS_OrderTracking_Container}             //*[@id="SScontainerFoot"]//div[@id="div_order_tracking"]


&{SS_OrderTracking}   not_found_order_image=//*[@data-id="ss_not_found_order_img"]
 ...   not_found_order_txt=//*[@data-id="ss_not_found_order_txt"]
 ...   order_id=//*[@data-id="ssot_order_id"]
 ...   order_date=//*[@data-id="ssot_order_date"]
 ...   sub_total=//*[@data-id="ssot_sub_total"]
 ...   total_item=//*[@data-id="ssot_total_item"]
 ...   item_product_name=//tr[@data-item-id="REPLACE_ITEM_ID"]/td/div[@data-id='ssot_product_name']
 ...   item_product_image=//tr[@data-item-id="REPLACE_ITEM_ID"]/td/img[@data-id='ssot_product_image' and @src!=""]
 ...   item_product_price=//tr[@data-item-id="REPLACE_ITEM_ID"]/td/div/div[@data-id='ssot_product_price']
 ...   item_product_quantity=//tr[@data-item-id="REPLACE_ITEM_ID"]/td/div/div[@data-id='ssot_product_quantity']
 ...   item_payment_status_customer=//tr[@data-item-id="REPLACE_ITEM_ID"]/td/div[@data-id='ssot_payment_status_customer']
 ...   item_status_customer=//tr[@data-item-id="REPLACE_ITEM_ID"]/td/div/span[@data-id='ssot_item_status_customer']
 ...   item_tracking_details=//tr[@data-item-id="REPLACE_ITEM_ID"]/td/div/span[@data-id='ssot_item_tracking_detail']
 ...   item_tracking_details_link=//tr[@data-item-id="REPLACE_ITEM_ID"]/td/div/span[@data-id='ssot_item_tracking_detail']/a
 ...   item_txt_tracking_no=//tr[@data-item-id="REPLACE_ITEM_ID"]/td/div/span/a[@data-id='ssot_txt_tracking_no']
 ...   item_btn_tracking_no=//tr[@data-item-id="REPLACE_ITEM_ID"]/td/a[@data-id='ssot_btn_tracking_no']
 ...   item_tracking_estimated_time_shipping=//tr[@data-item-id="REPLACE_ITEM_ID"]/td/div/span[@data-id='ssot_tracking_estimated_time_shipping']
 ...   item_shipping_date=//tr[@data-item-id="REPLACE_ITEM_ID"]/td/div/span[@data-id='ssot_shipping_date']
 ...   camp_short_description=//*[@data-id="camp_short_description"]
 ...   delivery_text=//*[@id="delivery_text"]/span

