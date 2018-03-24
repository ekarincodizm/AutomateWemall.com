*** Variables ***
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

${text_all_history}         //*[@id="DataTables_Table_0_info"]