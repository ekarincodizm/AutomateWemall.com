*** Variables ***
${alias_merchant_id_element}     //input[@name="alias_merchant_id"]@value
${btn_mass_upload}          //a[@id="button-mass-upload"]
${browse_file}              //*[@name="file_upload"]
${header_mass_upload}       //div[@class="mws-panel-header"]

${verify_upload_btn}        //*[@name="upload_btn"]
${result_back_btn}          //*[@name="back_btn"]

${link_back}                //a[@name="back_btn"]

${text_error_found}         //*[@class="mws-panel-toolbar"]/label
${text_result_upload}       //*[@name="result_alert"]
${text_all_history}         //*[@id="DataTables_Table_0_info"]

${link_example_file}        //a[contains(text(),'(Example File)')]
${text_result}              //*[@class="mws-panel-toolbar"]/label
${xpath_count_row_td}       //table[@class="mws-table"]/tbody/tr
${xpath_hd_td}              //table[@class="mws-table"]/thead/tr/th
${xpath_td}                 //table[@class="mws-table"]/tbody/tr/td
${link_back_upload}    //div[@class='mws-panel-toolbar']/a
#### table history ####
${table_filename}           /../td[1]
${table_username}           /../td[2]
${table_status}             /../td[3]
${table_reason}             /../td[4]
${table_date_time}          /../td[5]
${upload_histories_table_tr_elements}    //tbody//tr
${upload_histories_table_filename_elements}    //tbody//tr/td[1]
${upload_histories_table_username_elements}    //tbody//tr/td[2]
${text_all_history}         //*[@id="DataTables_Table_0_info"]
${btn_next}                 //*[@id="DataTables_Table_0_next"]

