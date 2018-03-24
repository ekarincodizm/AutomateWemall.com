*** Variables ***
${Input_OrderID}        //*[@name="f_pcms_order_id_1"]
${Input_PCMSOrderID}    //*[@name="f_pcms_order_id_2"]
${Search_Order}         //*[@class='mws-button-row']/input[@class='btn btn-primary']
${Selected_Order}       //*[contains(@class,'activity mws-datatable-fn')]//tbody//tr[1]/td[5]/b[contains(text(),'REPLACE_ME')]/../../td[2]/input
${View_Receipt_Order}    //*[@id='footbox']/div[1]/input[@class='btn btn-warning'][1]
${expand_plus}           //*[@class='expand-plus']
${order_detail}          //*[@id="standard-tb"]

${Selected_Order_receipt}       //*[contains(@class,'activity mws-datatable-fn')]//tbody//tr[1]/td[5]/b[contains(text(),'REPLACE_ME')]

${receipt_inventory_id_elements}    //table[@id='standard-tb']/tbody/tr/td[1]
${receipt_merchant_elements}    //table[@id='standard-tb']/tbody/tr/td[8]


&{XPATH_PCMS}   link_order_together=//ul/li/a[contains(.,'Order Together')]
 ...   link_receipt=//ul/li/a[contains(.,'Receipt')]
 ...   txt_order_id=//input[@name='f_pcms_order_id_1']
 ...   btn_search=//input[@value='Search']
 ...   btn_expand_plus=//div[@class='expand-plus']
 ...   order_id_first_record=//table[@id='tb-order']/tbody/tr[@class='accordion'][1]
 ...   checkbox_first_record//table[@id='tb-order']/tbody/tr[@class='accordion highlight'][1]/td[2]
 ...   cnt_inv_number=//table[@id='standard-tb']//tbody/tr
 ...   inv_id_first_record=//table[@id='standard-tb']//tbody/tr[1]
 ...   btn_receipt=//table[@id='tb-order']/tbody/tr[@class='accordion highlight'][1]/td[@style='float:left;']/a[2]
 ...   btn_copy_receipt=//table[@id='tb-order']/tbody/tr[@class='accordion highlight'][1]/td[@style='float:left;']/a[3]
