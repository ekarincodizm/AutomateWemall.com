*** Variables ***
${BkPre-person_id}    name=person_id
${BkPre-firstname}    name=firstname
${BkPre-lastname}    name=lastname
${BkPre-customer_tel}    name=customer_tel
${BkPre-customer_email}    name=customer_email
${BkPre-customer_address_no}    name=customer_address_no
${BkPre-customer_address_moo}    name=customer_address_moo
${BkPre-customer_address_village}    name=customer_address_village
${BkPre-customer_address_floor}    name=customer_address_floor
${BkPre-customer_address_soi}    name=customer_address_soi
${BkPre-customer_address_road}    name=customer_address_road
${BkPre-customer_province_id}    name=customer_province_id
${BkPre-customer_city_id}    name=customer_city_id
${BkPre-customer_district_id}    name=customer_district_id
${BkPre-customer_province}    name=customer_province
${BkPre-customer_city}    name=customer_city
${BkPre-customer_district}    name=customer_district
${BkPre-customer_postcode}    name=customer_postcode
${BkPre-customer_billing_no}    name=customer_billing_no
${BkPre-customer_billing_moo}    name=customer_billing_moo
${BkPre-customer_billing_village}    name=customer_billing_village
${BkPre-customer_billing_floor}    name=customer_billing_floor
${BkPre-customer_billing_soi}    name=customer_billing_soi
${BkPre-customer_billing_road}    name=customer_billing_road
${BkPre-billing_province_id}    name=bill_province_id
${BkPre-billing_city_id}    name=bill_city_id
${BkPre-billing_district_id}    name=bill_district_id
${BkPre-billing_province}    name=bill_province
${BkPre-billing_city}    name=bill_city
${BkPre-billing_district}    name=bill_district
${BkPre-billing_postcode}    name=bill_postcode
${BkPre-capacity}    name=capacity
${BkPre-color}    name=color
${BkPre-customer_billing_no}    name=customer_billing_no
${BkPre-next}    name=Next
${BkPre-back}    name=Back
${billing-checkbox}    jquery=[data-id="lbl_billing_address"]

${div_product_data}=    //div[@class="product_data_select"]
${product_color_element}=    //select[@class="product-option form-control inline-inputl product-color"]
${product_size_element}=    //select[@class="product-option form-control inline-inputl product-size"]

&{XPATH_BOOKING_PREORDER}   lbl_billing_address=//label[@data-id="lbl_billing_address"]
 ...   i_waiting=//i[contains(@class, 'waiting')]
 ...   lbl_bundle=//label[@data-id="lbl_bundle"]
 ...   lbl_handset=//label[@data-id="lbl_handset"]
 ...   cbo_customer_province_id=//select[@name="customer_province_id"]
 ...   cbo_customer_city_id=//select[@name="customer_city_id"]
 ...   cbo_customer_district_id=//select[@name="customer_district_id"]
 ...   cbo_customer_postcode_id=//select[@name="customer_postcode"]
 ...   cbo_billing_province_id=//select[@name="bill_province_id"]
 ...   cbo_billing_city_id=//select[@name="bill_city_id"]
 ...   cbo_billing_district_id=//select[@name="bill_district_id"]
 ...   cbo_billing_postcode_id=//select[@name="bill_postcode"]
 ...   alert_error=//div[@id="alert_error"]

