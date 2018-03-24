*** Variables ***
${product_menu}                            //div[@id="mws-navigation"]/ul/li/a[contains(text(),'Product')]
${mass_upload_product_collection_menu}          //a[contains(text(),'Mass Upload Product Collection')]
${breadcrumb_mass_upload_product_collection}    //*[@class="breadcrumb"]/*[contains(text(),'Mass Upload Products Collections')]

#acl
${text_body}      //*[@class="mws-panel-body"]
${text_header}    //*[@class="mws-panel-header"]

${text_result}                        //*[@class="mws-panel-toolbar"]/label
${browse_file}                        //*[@name="file_upload"]
${xpath_count_row_td}                 //table[@class="mws-table"]/tbody/tr
${xpath_hd_td}                        //table[@class="mws-table"]/thead/tr/th
${xptah_td}                           //table[@class="mws-table"]/tbody/tr/td
${message_success_element}                    //*[@name="result_alert"]
${btn_back}                           //*[@name="back_btn"]

#### table history ####
${table_filename}           /../td[1]
${table_username}           /../td[2]
${table_status}             /../td[3]
${table_reason}             /../td[4]
${table_date_time}          /../td[5]

${upload_histories_table_tr_elements}    //tbody//tr
${upload_histories_table_filename_elements}    //tbody//tr/td[1]
${upload_histories_table_username_elements}    //tbody//tr/td[2]

${link_back}                //a[@name="back_btn"]
${btn_next}                 //*[@id="DataTables_Table_0_next"]
${link_templete}            //a[contains(@href,'/products/mass-upload-products-collections/example-csv-file')]

#user name
${text_display_name}       //*[@id="mws-username"]

