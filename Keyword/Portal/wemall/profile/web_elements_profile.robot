*** Variables ***
&{XPATH_PROFILE}   cbo_address_list=//select[@id="shipping_address_list"]
 ...   txt_full_name=//input[@id="shipping_fullname"]
 ...   cbo_province=//select[@id="shipping_province_code"]
 ...   cbo_district=//select[@id="shipping_city_code"]
 ...   cbo_sub_district=//select[@id="shipping_district_code"]
 ...   txt_address=//input[@id="shipping_address"]
 ...   txt_zipcode=//input[@id="shipping_postcode"]
 ...   txt_mobile_no=//input[@id="shipping_phone"]
 ...   txt_email=//input[@id="shipping_email"]
 ...   btn_save=//button[@id="submit_addr"]
 ...   lbl_header=//*[@class="profile_header"]
 ...   div_modal_content=//div[@id="alert-error"]
 ...   div_modal_body=//div[@class="modal-content"]/div[@class="modal-body"]
 ...   btn_modal_ok=//button[@class="modal-button form-bot"]

&{MSG_PROFILE}   full_name_is_required=กรุณากรอกชื่อ
 ...   province_is_required=กรุณาเลือกจังหวัด
 ...   address_is_required=กรุณากรอกที่อยู่
 ...   zipcode_is_required=กรุณากรอกรหัสไปรษณีย์
 ...   zipcode_is_invalid=รหัสไปรษณีย์ ไม่ถูกต้อง
 ...   mobile_is_required=กรุณากรอกเบอร์ติดต่อ
 ...   mobile_is_invalid=เบอร์ติดต่อ ไม่ถูกต้อง
 ...   email_is_required=กรุณากรอกอีเมล์
 ...   email_is_invalid=Email ไม่ถูกต้อง