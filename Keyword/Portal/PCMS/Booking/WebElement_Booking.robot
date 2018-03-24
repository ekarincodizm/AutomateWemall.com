*** Variables ***
&{XPATH_PCMS_BOOKING}   input_booking_code=//*[@id="booking_code"]
 ...   btn_search=//*[@type="submit" and @value="Search"]
 ...   lbl_payment_status_bk_id=//*[@id="booking-payment-status-^^booking_id^^"]
 ...   td_no_data=//td[contains(text(), 'No data available in table')]

&{XPATH_PCMS_BOOKING_TMVH_BOOKING}   td_no_data=//td[contains(text(), 'ไม่พบข้อมูลที่ท่านค้นหา')]
 ...   cbo_billing_city_id=//select[@name="bill_city_id"]

&{XPATH_PCMS_BOOKING_TMVH_TRACKING}   td_no_data=//td[contains(text(), 'ไม่พบข้อมูลที่ท่านค้นหา')]
 ...   cbo_billing_city_id=//select[@name="bill_city_id"]
