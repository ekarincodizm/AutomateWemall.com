*** Variables ***

&{XPATH_HANDSET}   txt_mobile=//input[@id="mobile"]
 ...  txt_idcard=//input@id="idcard"]
 ...  txt_fname=//input[@id="fname"]
 ...  txt_lname=//input[@id="lname"]

&{XPATH_REGISTER}  cbo_mobile_number=//input[@id="mobile"]

# Step 2
 ...  cbo_operator=//select[@id="operator"]
 ...  txt_operator_other=//input[@name="operatorOther"]
 ...  err_operator_is_required=//label[@for="operator"]

 ...  txt_idcard=//input[@id="idcard"]
 ...  txt_idcard_expired=//input[@id="idcard_expire_display"]
 ...  cld_idcard_expired=//div[@class="pika-lendar"]
 ...  cld_select_idcard_expired_day=//table[@class="pika-table"]//tbody//tr[3]/
 ...  cld_idcard_expired_day=//table[@class="pika-table"]//tbody//tr[3]/
 ...  err_idcard_expired_is_required=//label[@for="idcard_expire_display"]

 ...  cbo_title=//select[@name="title"]
 ...  txt_title_other=//input[@name="titleOther"]
 ...  err_title_is_required=//label[@for="title"]

 ...  txt_fname=//input[@id="fname"]
 ...  err_fname_is_required=//label[@for="fname"]

 ...  txt_lname=//input[@id="lname"]
 ...  err_lname_is_required=//label[@for="lname"]

 ...  cbo_gender=//select[@id="gender"]
 ...  err_gender_is_required=//label[@for="gender"]

 ...  cbo_marital_status=//select[@id="marital_status"]
 ...  err_marital_status_is_required=//label[@for="marital_status"]
 ...  txt_birth_date=//input[@name="birth_date_display"]
 ...  cbo_idcard_expire_year=//div[2][@class="pika-label"]/select[@class="pika-select pika-select-year"]
 ...  cbo_idcard_expire_month=//div[1][@class="pika-label"]/select[@class="pika-select pika-select-month"]
 ...  cld_birth_date=//div[@class="pika-lendar"]
 ...  cld_select_birth_year=//div[2][@class="pika-label"]/select[@class="pika-select pika-select-year"]
 ...  cld_select_birth_month=//div[1][@class="pika-label"]/select[@class="pika-select pika-select-month"]
 ...  cld_select_birth_day=//table[@class="pika-table"]//tbody//tr

 ...  cbo_dob_year=//select[@id="dob_year"]
 ...  cbo_dob_month=//input[@id="dob_month"]
 ...  cbo_dob_day=//input[@id="dob_day"]
 ...  txt_customer_tel=//input[@id="customer_tel"]
 ...  err_customer_tel_is_required=//label[@for="customer_tel"]

 ...  btn_browser_idcard_image=//button[@class="btn mnp-btn-m"]
 ...  btn_idcard_image=//input[@type="file"][@name="file"]
 ...  err_idcard_image_is_required=//label[@for="file"]

 ...  cbo_customer_province=//select[@name="customer_province"]
 ...  cbo_customer_city=//select[@name="customer_city"]
 ...  div_customer_city_loading=//select[@name="customer_city"]/following-sibling::span[@class="waiting"]
 ...  cbo_customer_district=//select[@name="customer_district"]
 ...  div_customer_district_loading=//select[@name="customer_district"]/following-sibling::span[@class="waiting"]
 ...  cbo_customer_zipcode=//select[@name="customer_zipcode"]
 ...  div_customer_zipcode_loading=//select[@name="customer_zipcode"]/following-sibling::span[@class="waiting"]
 ...  txt_customer_address=//textarea[@name="customer_address"]
 ...  chk_billing_same_shipping=//input[@name="billing-address"]
 ...  cbo_billing_province=//select[@name="billing_province"]
 ...  cbo_billing_city=//select[@name="billing_city"]
 ...  div_billing_city_loading=//select[@name="billing_city"]/following-sibling::span[@class="waiting"]
 ...  cbo_billing_district=//select[@name="billing_district"]
 ...  div_billing_district_loading=//select[@name="billing_district"]/following-sibling::span[@class="waiting"]
 ...  cbo_billing_zipcode=//select[@name="billing_zipcode"]
 ...  div_billing_zipcode_loading=//select[@name="billinb_zipcode"]/following-sibling::span[@class="waiting"]
 ...  txt_billing_address=//textarea[@name="billing_address"]
 ...  terms_and_conditions_container=//div[@id="mnp-modal-conditions"]//div[@class="modal-content"]
 ...  verify_term=//div[@id="mnp-modal-conditions"]//div[@class="modal-content"]//p[1]

 ...  err_customer_province_is_required=//label[@for="customer_province"]
 ...  err_customer_city_is_required=//label[@for="customer_city"]
 ...  err_customer_district_is_required=//label[@for="customer_district"]
 ...  err_customer_zipcode_is_required=//label[@for="customer_zipcode"]
 ...  err_customer_address_is_required=//label[@for="customer_address"]
 ...  err_billing_province_is_required=//label[@for="billing_province"]
 ...  err_billing_district_is_required=//label[@for="billing_district"]
 ...  err_billing_city_is_required=//label[@for="billing_city"]
 ...  err_billing_zipcode_is_required=//label[@for="billing_zipcode"]
 ...  err_billing_address_is_required=//label[@for="billing_address"]

 ...  btn_billing_checkbox=//input[@name="billing-address"]

 ...  btn_next_step1=//button[@data-goto="2"]
 ...  btn_next_step2=//button[@data-goto="3"]
 ...  btn_next_step3=//button[@data-goto="4"]
 ...  btn_next_step4=//button[@id="confirm-form"]
 ...  btn_back_step1=//a[@class="cancel"]
 ...  btn_back_step2=//a[@data-goto="1"]
 ...  btn_back_step3=//a[@data-goto="2"]
 ...  btn_back_step4=//a[@data-goto="3"]
 ...  step_highlight1=//div[contains(@class, "mnh-step-wrapper gp-step-1")]
 ...  step_highlight2=//div[contains(@class, "mnh-step-wrapper gp-step-2")]
 ...  step_highlight3=//div[contains(@class, "mnh-step-wrapper gp-step-3")]
 ...  step_highlight4=//div[contains(@class, "mnh-step-wrapper gp-step-4")]

 ...  btn_back_device_step1=//div[@class="section-footer"]//a[@class="left"]

 ...  dia_err_image_file_popup=//div[@class='modal-content'][contains(.,'เกิดข้อผิดผลาด!')]
 ...  dia_err_image_file_message=//div[@class='modal-body']

 ...  ads_banner=//area[@id="area-2"]

# Step 3

 ...  cbo_device=//select[@name="mobile_id"]
 ...  err_device=//label[@for="mobile_id"]
 ...  btn_checkbox=//*[@id="icon-itruemart-check"]
 ...  price_plan_items=//*[@class="owl-item"]
 ...  recommended_item=//*[@class="mnp-icon-package"]
 ...  cbo_sim=//select[@name="inventory_id"]
 ...  err_sim=//label[@for="inventory_id"]
 ...  cnt_package=//div[@class="owl-item"]//label
 ...  cnt_package_line=//*[@class="owl-item"][1]//div[@class="package-info"]/p
#...  btn_price_plan_id=//span[1][@class="btn mnp-btn-m-b"]
 ...  btn_price_plan_id=//div[@class="owl-item"][1]/div/div[2]/div[2]/label/span[1]
 ...  chk_price_plan_id=//div[1][@class="owl-item"]/div[@class="mnp-package item selected-package"]
 ...  txt_price_plan_name=//div[1][@class="owl-item"]//div[@class="mnp-package item selected-package"]/div[@class="package-name"]/span
#if change btn_price_plan_id=//span[1]            to //span[2]
#   chk_price_plan_id=//div[1]     must be change to //div[2]
#   txt_price_plan_name=//div[1]   must be change to //div[2]
#   txt_price_plan_info=//div[1]   must be change to //div[2]
 ...  txt_price_plan_info1=//div[1][@class="owl-item"]//div[@class="package-info"]/p[1]
 ...  txt_price_plan_info2=//div[1][@class="owl-item"]//div[@class="package-info"]/p[2]
 ...  txt_price_plan_info3=//div[1][@class="owl-item"]//div[@class="package-info"]/p[3]
 ...  txt_price_plan_info4=//div[1][@class="owl-item"]//div[@class="package-info"]/p[4]
 ...  txt_price_plan_info5=//div[1][@class="owl-item"]//div[@class="package-info"]/p[5]
 ...  txt_price_plan_info6=//div[1][@class="owl-item"]//div[@class="package-info"]/p[6]
 ...  txt_price_plan_info7=//div[1][@class="owl-item"]//div[@class="package-info"]/p[7]

 ...  cnt_itm_checked_icon=//div[@class="owl-item"]//span[@class="icon-itruemart-check"]
 ...  btn_itm_should_be_checked=//div[1][@class="owl-item"]//span[@class="icon-itruemart-check"]

 ...  err_price_plan_id=//label[@for="price_plan_id"]

# Step 4

 ...  number_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[1]/td
 ...  operator_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[2]/td
 ...  idcard_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[3]/td
 ...  idcard_expired_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[4]/td
 ...  title_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[5]/td
 ...  fname_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[6]/td
 ...  lname_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[7]/td
 ...  gender_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[8]/td
 ...  marital_status_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[9]/td
 ...  birth_date_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[10]/td
 ...  tel_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[11]/td
 ...  idcard_image_line1_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[12]/td
# ...  idcard_image_line2_step4=//table[1][@class="table table-striped mnp-recheck"]

 ...  customer_province_step4=//table[2][@class="table table-striped mnp-recheck"]//tr[1]/td
 ...  customer_city_step4=//table[2][@class="table table-striped mnp-recheck"]//tr[2]/td
 ...  customer_district_step4=//table[2][@class="table table-striped mnp-recheck"]//tr[3]/td
 ...  customer_zipcode_step4=//table[2][@class="table table-striped mnp-recheck"]//tr[4]/td
 ...  customer_address_step4=//table[2][@class="table table-striped mnp-recheck"]//tr[5]/td

 ...  billing_province_step4=//table[3][@class="table table-striped mnp-recheck"]//tr[1]/td
 ...  billing_city_step4=//table[3][@class="table table-striped mnp-recheck"]//tr[2]/td
 ...  billing_district_step4=//table[3][@class="table table-striped mnp-recheck"]//tr[3]/td
 ...  billing_zipcode_step4=//table[3][@class="table table-striped mnp-recheck"]//tr[4]/td
 ...  billing_address_step4=//table[3][@class="table table-striped mnp-recheck"]//tr[5]/td

 ...  device_step4=//table[4][@class="table table-striped mnp-recheck"]//tr[1]/td
 ...  sim_step4=//table[4][@class="table table-striped mnp-recheck"]//tr[2]/td
 ...  dia_sim_out_of_stock=//h4[@class="modal-title"]




 ...  data_number_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[1]/td[2]
 ...  data_operator_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[2]/td[2]
 ...  data_idcard_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[3]/td[2]
 ...  data_idcard_expired_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[4]/td[2]
 ...  data_title_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[5]/td[2]
 ...  data_fname_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[6]/td[2]
 ...  data_lname_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[7]/td[2]
 ...  data_gender_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[8]/td[2]
 ...  data_marital_status_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[9]/td[2]
 ...  data_birth_date_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[10]/td[2]
 ...  data_tel_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[11]/td[2]
 ...  data_idcard_image_line1_step4=//table[1][@class="table table-striped mnp-recheck"]//tr[12]/td[2]

 ...  data_customer_province_step4=//table[2][@class="table table-striped mnp-recheck"]//tr[1]/td[2]
 ...  data_customer_city_step4=//table[2][@class="table table-striped mnp-recheck"]//tr[2]/td[2]
 ...  data_customer_district_step4=//table[2][@class="table table-striped mnp-recheck"]//tr[3]/td[2]
 ...  data_customer_zipcode_step4=//table[2][@class="table table-striped mnp-recheck"]//tr[4]/td[2]
 ...  data_customer_address_step4=//table[2][@class="table table-striped mnp-recheck"]//tr[5]/td[2]

 ...  data_billing_province_step4=//table[3][@class="table table-striped mnp-recheck"]//tr[1]/td[2]
 ...  data_billing_city_step4=//table[3][@class="table table-striped mnp-recheck"]//tr[2]/td[2]
 ...  data_billing_district_step4=//table[3][@class="table table-striped mnp-recheck"]//tr[3]/td[2]
 ...  data_billing_zipcode_step4=//table[3][@class="table table-striped mnp-recheck"]//tr[4]/td[2]
 ...  data_billing_address_step4=//table[3][@class="table table-striped mnp-recheck"]//tr[5]/td[2]

 ...  data_device_step4=//table[4][@class="table table-striped mnp-recheck"]//tr[1]/td[2]
 ...  data_sim_step4=//table[4][@class="table table-striped mnp-recheck"]//tr[2]/td[2]


 ...  txt_price_plan_name_step4=//*[@id="preview_package"]/div/div[1]/span
 ...  txt_price_plan_info1_step4=//*[@id="preview_package"]/div/div[2]/div/p[1]
 ...  txt_price_plan_info2_step4=//*[@id="preview_package"]/div/div[2]/div/p[2]
 ...  txt_price_plan_info3_step4=//*[@id="preview_package"]/div/div[2]/div/p[3]
 ...  txt_price_plan_info4_step4=//*[@id="preview_package"]/div/div[2]/div/p[4]
 ...  txt_price_plan_info5_step4=//*[@id="preview_package"]/div/div[2]/div/p[5]
 ...  txt_price_plan_info6_step4=//*[@id="preview_package"]/div/div[2]/div/p[6]
 ...  txt_price_plan_info7_step4=//*[@id="preview_package"]/div/div[2]/div/p[7]
 ...  txt_price_plan_info_step4=//*[@id="preview_package"]/div/div[2]/div/p

 ...  btn_term_condition=//input[@name="accept-conditions"]
 ...  btn_accept_term=//button[@class="btn mnp-btn-m accept-terms"]
 ...  btn_ok_confirm_tos=//button[contains(@class, "accept-terms")]
 ...  live_chat_title=//map[@id="ads-banner"]
 ...  btn_live_chat_close=//map[@id="ads-banner"]/area[2]


&{XPATH_REGISTER_STEP1}   btn_next=//input[@id="next-step-01"]

${msisdn_input_box}    //input[@name="msisdn"]
${idcard_input_box}    //input[@name="idcard"]
${chatbar_box}    //*[@id="chatbar"]
${price_plan_id_hidden}    //*[@name="price_plan_id"]