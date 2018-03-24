*** Variables ***
&{XPATH_ALIAS}   txt_alias_name=//input[@id="alias_name"]
 ...   txt_alias_code=//input[@id="alias_code"]
 ...   btn_save=//input[@id="submit_data"]
 ...   dialog_error=//div[contains(@class, "alert-error")]
 ...   dialog_error_content=//div[contains(@class, "alert-error")]/p
 ...   dialog_success=//div[contains(@class, "alert-success")]
 ...   dialog_success_content=//div[contains(@class, "alert-success")]
 ...   search_input=//*[@id="DataTables_Table_0_filter"]/label/input
 ...   edit_button=//*[@id="button-edit-alias"]
 ...   alias_name_input=//*[@id="alias_name"]
 ...   delete_alias_button=//*[@id="button-delete-alias"]
 ...   th_col_id=//table[@id="DataTables_Table_0"]/thead/tr/th[1]
 ...   th_col_alias_name=//table[@id="DataTables_Table_0"]/thead/tr/th[2]
 ...   th_col_merchant_code=//table[@id="DataTables_Table_0"]/thead/tr/th[3]
 ...   th_col_updated_at=//table[@id="DataTables_Table_0"]/thead/tr/th[5]

 ...   th_col_id_desc=//table[@id="DataTables_Table_0"]/thead/tr/th[1][contains(@class, "sorting_desc")]
 ...   th_col_id_asc=//table[@id="DataTables_Table_0"]/thead/tr/th[1][contains(@class, "sorting_asc")]
 ...   th_col_alias_name_desc=//table[@id="DataTables_Table_0"]/thead/tr/th[2][contains(@class, "sorting_desc")]
 ...   th_col_alias_name_asc=//table[@id="DataTables_Table_0"]/thead/tr/th[2][contains(@class, "sorting_asc")]
 ...   th_col_merchant_code_desc=//table[@id="DataTables_Table_0"]/thead/tr/th[3][contains(@class, "sorting_desc")]
 ...   th_col_merchant_code_asc=//table[@id="DataTables_Table_0"]/thead/tr/th[3][contains(@class, "sorting_asc")]
 ...   th_col_updated_at_desc=//table[@id="DataTables_Table_0"]/thead/tr/th[5][contains(@class, "sorting_desc")]
 ...   th_col_updated_at_asc=//table[@id="DataTables_Table_0"]/thead/tr/th[5][contains(@class, "sorting_asc")]

 ...   row1_td_col_alias_name=//table[@id="DataTables_Table_0"]/tbody/tr[1]/td[2]
 ...   row2_td_col_alias_name=//table[@id="DataTables_Table_0"]/tbody/tr[2]/td[2]
 ...   row3_td_col_alias_name=//table[@id="DataTables_Table_0"]/tbody/tr[3]/td[2]
 ...   row4_td_col_alias_name=//table[@id="DataTables_Table_0"]/tbody/tr[4]/td[2]
 ...    row5_td_col_alias_name=//table[@id="DataTables_Table_0"]/tbody/tr[5]/td[2]
 ...   row6_td_col_alias_name=//table[@id="DataTables_Table_0"]/tbody/tr[6]/td[2]


 ...   search_input=//*[@id="DataTables_Table_0_filter"]/label/input
 ...   edit_button=//*[@id="button-edit-alias"]
 ...   delete_button=//*[@id="button-delete-product"]
 ...   alias_name_input=//*[@id="alias_name"]
 ...   delete_alias_button=//*[@id="button-delete-alias"]
 ...   display_100_elements_button=//*[@id="DataTables_Table_0_length"]/label/select/option[4]
 ...   btn_mass_upload=//a[@id="button-mass-upload"]
 ...   btn_mass_delete=//a[@id="button-mass-delete"]
 ...   txt_mass_upload_file=//input[@name="file_upload"]
 ...   btn_back=//a[@id="back_btn"]

&{MSG_ALIAS}   required_alias_name=Alias Name is required.

 ...   create_alias_success=Create Alias Merchant Successfully.
 ...   save_alias_success=Edit Alias Merchant Success.
 ...   delete_success=Delete Product in Alias Merchant Successfully.
 ...   empty_data=Empty data
 ...   update_success=Update Alias Merchant Successfully.
 ...   require_alias_merchant_name=Alias Merchant Name is required.
 ...   create_merchant_success=Create Alias Merchant Successfully.
 ...   delete_alias_success=Delete Alias Merchant Successfully.
 ...   display_100_elements=Showing 1 to 31 of 31 entries



${product_menu}               //div[@id="mws-navigation"]/ul/li/a[contains(text(),'Product')]
${set_alias_merchant_menu}    //a[contains(.,'Set Alias Merchant')]