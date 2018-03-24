*** Variables ***

${promotion_menu}             xpath=//div[@id="mws-navigation"]/ul/li/a[contains(text(),'Promotion')]
${mass_price_product_menu}    //*[@id="mws-navigation"]//a[contains(text(),'Mass Price & Product')]
${text_menu}                  xpath=//ul[@class="breadcrumb"]/li[2][@class="active"]
${btn_back}                   xpath=//a[@name="back_btn"]
${browse_file}                xpath=//*[@name="file_upload"]
## error ##
${text_result}                xpath=//*[@class="mws-panel-toolbar"]/label

## table ##
${xpath_count_row_td}         xpath=//table[@class="mws-table"]/tbody/tr
${xpath_hd_td}                xpath=//table[@class="mws-table"]/thead/tr/th
${xpath_td}                   xpath=//table[@class="mws-table"]/tbody/tr/td
${text_message}               xpath=//*[@name="result_alert"]
${text_message_fail}          xpath=//*[@id="mws-container"]/div[1]/div/div[2]/label

# "fail_result_table" cannot use "xpath=..." format
${fail_result_table}          //table[@class="mws-table"]

${link_example_file}          xpath=//a[contains(text(),'(Example File)')]
${link_back}                  xpath=//a[@href="/campaigns/mass-upload"]

${text_header}                xpath=//*[@class="mws-panel-header"]
${text_can_not_access}        xpath=//*[@class="mws-panel-body"]


##### error message #####
${text_invalid_inventory_id}                   Invalid Inventory Id.
${text_sku_overlapped_campaign}                SKU exist under overlapped Campaign Id : ??campID??
${text_special_price_greater_than_discount}    Special Price must be greater than or equal to Discount Price.
${text_discount_price_less_than_zero}          Discount Price must be greater than 0.
${history_camp_price_prod_db}                  camp_prc_pro