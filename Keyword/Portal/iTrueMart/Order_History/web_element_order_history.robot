*** Variables ***
${header-user-menu}    //a[@id="user"]
${header-user-menu-history}    //a[@id="user"]/following-sibling::ul/li[2]
${header-user-menu-history-image}    //table/tbody/tr[1]/td[1]/img
${order_tracking_list_div}         jquery=.container-order-list

${delivery_text_th}    หากสั่งสินค้ามากกว่า 1 ชิ้น ระยะเวลาจัดส่งจะขึ้นกับระยะจัดส่งของสินค้าที่ระยะจัดส่งนานที่สุด หรือ อาจมีการแยกจัดส่ง โดยตัวแทนจำหน่ายหรือไปรษณีย์ไทย
${delivery_text_en}    If you order more than 1 item, estimate delivery time will up to the item which has the longest delivery time or it will ship separately by supplier or Thai post.

${customer_ref_id}    27145880
${customer_email}     robotautomate@gmail.com


# Wemall
${wm-header-user-menu}    //span[@class="icon-user"]
${wm-header-user-menu-history}    //ul[@class="list-menu-login"]/li[2]/a
