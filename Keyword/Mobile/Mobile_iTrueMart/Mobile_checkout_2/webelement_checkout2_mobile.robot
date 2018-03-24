*** Variables ***
${Checkout2_LoadingImg}    //*[@class="ajaxloading-widget-background"]
${Checkout2_NextBtn}    //*[@id="btnSave"]
${Checkout2_NextBtn_Mobile}    //*[@id="submit-text"]
${Checkout2_NextBtn_Member}    //*[@class="form-bot-address-active"]
${Checkout2_InputName}    //*[@id="name"]
${Checkout2_InputPhone}    //*[@id="phone_number"]
${Checkout2_Province}    //*[@id="province-control"]
${Checkout2_District_Mobile}    //*[@id="city-control"]
${Checkout2_SubDistrict_Mobile}    //*[@id="district-control"]
${Checkout2_ZipCode}    //*[@id="zip-code-control"]
${Checkout2_InputAddress}    //*[@id="address"]




&{XPATH_CHECKOUT_STEP2_MOBILE}   address_list_container=//*[@id="member-address"]
 ...   btn_first_select_address=//*[@id="address-list-0"]
 ...   txt_name=//input[@id="name"]
 ...   txt_mobile=//input[@id="telephone"]
 ...   txt_email=//input[@id="email"]
 ...   cbo_province=//select[@id="province-control"]
 ...   cbo_city=//select[@id="district-control"]
 ...   cbo_district=//select[@id="sub-district-control"]
 ...   cbo_zipcode=//select[@id="zip-code-control"]
 ...   txt_address=//textarea[@id="address"]
 ...   btn_next=//input[@id="btnSave"]
 ...   btn_add_new_address=//div[@id="add-address-btn"]
 ...   active_address=//div[@class="address-box-active"]
 ...   alerttext_name=//div[@id="fill-address-form"]/form/div/div[1]/div/div
 ...   alert_province=//div[@id="fill-address-form"]/form/div/div[4]/div/div
 ...   alert_district=//div[@id="fill-address-form"]/form/div/div[6]/div/div
 ...   alert_sub_district=//div[@id="fill-address-form"]/form/div/div[8]/div/div
 ...   alert_postcode=//div[@id="fill-address-form"]/form/div/div[10]/div/div
 ...   alert_address=//div[@id="fill-address-form"]/form/div/div[12]/div/div
 ...   btn_edit_address=//div[@class="address-box-active"]/div/div/div[2]
 ...   btn_delete_address=//div[@class="address-box-active"]/div/div/div[1]
 ...   btn_confirm_delete=//button[@id="btnConfirmDelete"]
 ...   btn_ok_deletesuccess=//button[@id="btnOK"]
 ...   addressbox_notactive=//div[@class="address-box"]/div
 ...   btn_send_the_address=//input[@class="form-bot-address-active"]
 ...   name_in_active_textbox=//div[@class="address-box-active"]/div/h2
 ...   district_text=//span[@id="district-name"]
 ...   text_sub_district=//span[@id="sub-district-name"]
 ...   btn_ship_to_this_address=//*[@id="proceed_with_indicated_address"]
 ...   mini_cart_container=//div[@id="minicart-container"]

${Checkout2_AddShippingAddress}    //*[@id="add-address-btn"]
${Checkout2_ShippingFirstAddress}    //input[@class='form-bot-address-active']
${Checkout2_MiniCart}    //*[@id="minicart-container"]
