*** Variables ***
${text_display_name}       //*[@id="mws-username"]
${collection_menu}         //a[text() = ' Collection']
${mass_upload_menu}        //a[text() = ' Collection']/..//a[text() = 'Mass Upload']

${text_menu}               //ul[@class="breadcrumb"]/li[2][@class="active"]
${browse_file}             //*[@name="file_upload"]
${btn_back}                //a[@href="/collections-products"]
${choose_product_has_alias}        //td[.='9922654321123']/../td/a[.='Products']
${choose_product_has_not_alias}        //td[.='9966654321246']/../td/a[.='Products']
${verify_upload_btn}       //*[@name="upload_btn"]
${result_back_btn}         //*[@name="back_btn"]

${text_error_found}         //*[@class="mws-panel-toolbar"]/label
${text_result_upload}       //*[@name="result_alert"]
${text_all_history}         //*[@id="DataTables_Table_0_info"]

#### table verify ####
${table}          //*[@class="mws-table"]/tbody
${table_row}      ${table}/tr/td[1]
${table_collection_key}    ${table}/tr/td[2]
${table_product_key}    ${table}/tr/td[3]
${table_status_ver}    ${table}/tr/td[4]
${table_row2}     ${table}/tr[2]/td[1]
${table_collection_key2}    ${table}/tr[2]/td[2]
${table_product_key2}    ${table}/tr[2]/td[3]
${table_status_ver2}    ${table}/tr[2]/td[4]
${xpath_count_row_td}    //table[@class="mws-table"]/tbody/tr
${xpath_hd_td}    //table[@class="mws-table"]/thead/tr/th
${xptah_td}       //table[@class="mws-table"]/tbody/tr/td
${message_success_element}    //*[@name="result_alert"]
# ${btn_back}     //*[@name="back_btn"]
#### table history ####
${table_username}    /../td[2]
${table_status}    /../td[3]
${table_reason}    /../td[4]
${table_date_time}    /../td[5]
${link_back}      //a[@name="back_btn"]
${btn_next}       //*[@id="DataTables_Table_0_next"]
${link_templete}    //a[contains(@href,'/collections-products/example-csv-file')]
#### export products form collection
${menu_manage_collection}    //a[contains(text(),'Manage Collection')]
${choose_sub_collection1}    //td[.='9991234567897']/../td/a[contains(text(),'Sub-collections')]
${choose_sub_collection2}    //td[.='9991234567898']/../td/a[contains(text(),'Sub-collections')]
${choose_product}    //td[.='9991234567899']/../td/a[.='Products']
${choose_product_category}    //td[.='9991234567896']/../td/a[.='Products']
${choose_select_all}    //input[@name="tick_all"]
${choose_select_one}    //td[.='2752364291283']/../td/input[@type='checkbox']
${export_button}    //*[@id='btn_export']
${get_collection_id}    //input[@name='old_collection_id']
${get_product_ids}    //input[@name='product_ids']
${level_c_thumbnail_count}    //*[@id='wrapper_content']/div/div[6]/div[3]/div
${manage_collection_url_path}    collections
${table_collections}    jquery=table.mws-datatable-fn
${create_button}    jquery=div.btn-group.btn-collection-nav a.btn
${translation_button}    jquery=div button.btn.btn-small.add
${save_button}    jquery=div.mws-button-row input.btn.btn-primary
${name_field}     jquery=div.mws-form-item input#name
${combo_box_translation}    jquery=div select#select-locale_name
${lang_field}     jquery=div.input-prepend.large input.small
${radio_box_pds_collection}    pds_collection
${radio_box_app_collection}    app
${input_is_category}    jquery=div.mws-form-item input[name='is_category']
${button_add_collection}    jquery=.btn-toolbar a.btn i.icol-add
${table_collections_xpath}    //table[@class='mws-datatable-fn mws-table']/tbody/tr
#acl
${text_body}      //*[@class="mws-panel-body"]
${text_header}    //*[@class="mws-panel-header"]
${PRODUCT-IN-COLLECTION-TABLE}    xpath=//*[@id="productsInCollectionTable"]
