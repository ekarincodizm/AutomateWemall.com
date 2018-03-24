*** Variables ***
&{XPATH_VERIFY}  container=//div[contains(@class, "check-thai-id-modal")]
 ...  btn_go_to_register_step=//button[@id="verify_submit_verify_btn"]
 ...  btn_verify=//button[@id="verify_submit_verify_btn"]
 ...  btn_verify_register=//a[@id="verify_register_mnp_two"]
 ...  btn_cancel=//a[@id="verify_cancel_verify_btn"]
 ...  txt_mobile=//input[@name="msisdn"]
 ...  txt_thai_id=//input[@name="idcard"]
 ...  txt_dob=//input[@id="birthDate"]
 ...  cbo_dob_year=//select[@id="mnp-bdYear"]
 ...  cbo_dob_month=//select[@id="mnp-bdMonth"]
 ...  cbo_dob_day=//select[@id="mnp-bdDay"]
 ...  txt_birth_date=//input[@id="birthDate"]
 ...  cld_birth_date=//div[@class="pika-lendar"]
 ...  cld_select_birth_year=//div[2][@class="pika-label"]/select[@class="pika-select pika-select-year"]
 ...  cld_select_birth_month=//div[1][@class="pika-label"]/select[@class="pika-select pika-select-month"]
 ...  cld_select_birth_day=//table[@class="pika-table"]//tbody//tr
 ...  err_mobile_is_required=//input[@name="msisdn"]/following-sibling::div
 ...  err_mobile_length_not_enough=//input[@name="msisdn"]/following-sibling::div
 ...  err_thai_id_is_required=//input[@name="idcard"]/following-sibling::div
 ...  err_thai_id_special_character=//input[@name="idcard"]/following-sibling::div
 ...  err_thai_id_length_not_enough=//input[@name="idcard"]/following-sibling::div
 ...  err_thai_id_is_wrong_format=//input[@name="idcard"]/following-sibling::div
 ...  err_birthdate_is_required=//input[@id="birthDate"]/following-sibling::div
 ...  dialog_container=//div[@id="mnp-errorMessage"]
 ...  dialog_msg_wrong_format=//div[@id="mnp-errorMessage"]
 ...  dialog_transfer_is_processing=//div[@id="mnp-errorMessage"]
 ...  dialog_transfer_is_collection=//div[@id="mnp-errorMessage"]
 ...  dialog_thai_id_is_max_allow=//div[@id="mnp-errorMessage"]
 ...  dialog_thai_id_is_collection=//div[@id="mnp-errorMessage"]
 ...  dialog_thai_id_is_fraud=//div[@id="mnp-errorMessage"]
 ...  dialog_thai_id_is_blacklist=//div[@id="mnp-errorMessage"]