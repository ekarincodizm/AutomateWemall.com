*** Keywords ***
Booking Payment Page - Open Page
    Open Browser     ${BOOKING_URL}/iphone-se/pre-order/payment

Booking Payment Page - Go To Page
    Go To     ${BOOKING_URL}/iphone-se/pre-order/payment

Booking Payment Page - Display Page
    Location Should Contain    /iphone-se/pre-order/payment

Booking Payment Page - Display EN Page
    Location Should Contain    /en/iphone-se/pre-order/payment

Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Display All CCW Information
    Booking Payment Page - User Enter Valid Card Holder Name
    Booking Payment Page - User Enter Valid Credit Card Number
    Booking Payment Page - User Enter Valid CVC
    Booking Payment Page - User Select Valid Card Expired

Booking Payment Page - Enter Invalid CCW Information
    Booking Payment Page - Display All CCW Information
    Booking Payment Page - User Enter Valid Card Holder Name
    Booking Payment Page - User Enter Invalid Credit Card Number
    Booking Payment Page - User Enter Valid CVC
    Booking Payment Page - User Select Valid Card Expired

Booking Payment Page - Display All CCW Information
    Booking Payment Page - Display Card Holder Name
    Booking Payment Page - Display Credit Card Number
    Booking Payment Page - Display CVC
    Booking Payment Page - Display Card Expired Date

Booking Payment Page - Display Error All CCW Information
    Booking Payment Page - Display Error Card Holder Name
    Booking Payment Page - Display Error Credit Card Number
    Booking Payment Page - Display Error CVC
    Booking Payment Page - Display Error Card Expired Date

Booking Payment Page - Display Customer Data
    Booking Payment Page - Display Person ID As Value To Random ID Card
    Booking Payment Page - Display Firstname As Test Data Value
    Booking Payment Page - Display Lastname As Test Data Value
    Booking Payment Page - Display Customer Tel As Test Data Value
    Booking Payment Page - Display Customer Email As Test Data Value

Booking Payment Page - Display Billing Data
    Booking Payment Page - Display Bill Address As Test Data Value
    Booking Payment Page - Display Bill District As Value in PCMS
    Booking Payment Page - Display Bill City As Value in PCMS
    Booking Payment Page - Display Bill Province As Value in PCMS
    Booking Payment Page - Display Bill Postcode As Test Data Value

Booking Payment Page - Display Billing Data EN
    Booking Payment Page - Display Bill Address As Test Data Value
    Booking Payment Page - Display Bill District As Value in PCMS EN
    Booking Payment Page - Display Bill City As Value in PCMS EN
    Booking Payment Page - Display Bill Province As Value in PCMS EN
    Booking Payment Page - Display Bill Postcode As Test Data Value

Booking Payment Page - Display Booking Data
    Booking Payment Page - Display Date of Booking As Value To Date Now
    Booking Payment Page - Display Deposit

Booking Payment Page - Display Booking Data EN
    Booking Payment Page - Display Date of Booking As Value To Date Now EN
    Booking Payment Page - Display Deposit EN

Booking Payment Page - Display Device Data
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_product_name}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_product_name}          ${var_booking_product_name}
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_confirm_product_name}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_confirm_product_name}          ${var_booking_product_name}

Booking Payment Page - Display Device Bundle Data
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_product_name}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_product_name}          ${var_booking_product_name} ${BOOKING_TRANS_TH.number_type}
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_confirm_product_name}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_confirm_product_name}          ${var_booking_product_name} ${BOOKING_TRANS_TH.number_type}

Booking Payment Page - Display Device Bundle Data EN
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_product_name}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_product_name}          ${var_booking_product_name} ${BOOKING_TRANS_EN.number_type}
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_confirm_product_name}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_confirm_product_name}          ${var_booking_product_name} ${BOOKING_TRANS_EN.number_type}

Booking Payment Page - Display Person ID As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_person_id}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_person_id}          ${BOOKING_PREORDER_VALID.person_id}

Booking Payment Page - Display Person ID As Value To Random ID Card
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_person_id}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_person_id}          ${var_random_id_card}

Booking Payment Page - Display Date of Booking As Value To Date Now
    Get Date Now Format Thai
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_created_at}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_created_at}          ${var_booking_thai_month}

Booking Payment Page - Display Date of Booking As Value To Date Now EN
    Get Date Now Format English
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_created_at}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_created_at}          ${var_booking_english_month}

Booking Payment Page - Display Deposit
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_deposit}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_deposit}          ${BOOKING_DATA_TH.deposit} ${BOOKING_TRANS_TH.bath}

Booking Payment Page - Display Deposit EN
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_deposit}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_deposit}          ${BOOKING_DATA_EN.deposit} ${BOOKING_TRANS_EN.bath}

Booking Payment Page - Display Firstname As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_firstname}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_firstname}          ${BOOKING_PREORDER_VALID.firstname}

Booking Payment Page - Display Lastname As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_lastname}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_lastname}          ${BOOKING_PREORDER_VALID.lastname}

Booking Payment Page - Display Customer Tel As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_customer_tel}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_customer_tel}          ${BOOKING_PREORDER_VALID.customer_tel}

Booking Payment Page - Display Customer Email As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_customer_email}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_customer_email}          ${BOOKING_PREORDER_VALID.customer_email}

Booking Payment Page - Display Bill Address As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_bill_address}   10s
    ${bill_address}=   Convert To String     ${BOOKING_PREORDER_VALID.customer_billing_no} ${BOOKING_PREORDER_VALID.customer_billing_moo} ${BOOKING_PREORDER_VALID.customer_billing_village} ${BOOKING_PREORDER_VALID.customer_billing_floor} ${BOOKING_PREORDER_VALID.customer_billing_soi} ${BOOKING_PREORDER_VALID.customer_billing_road}
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_bill_address}          ${bill_address}

Booking Payment Page - Display Bill District As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_bill_district}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_bill_district}          ${var_booking_bill_district}

Booking Payment Page - Display Bill City As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_bill_city}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_bill_city}          ${var_booking_bill_city}

Booking Payment Page - Display Bill Province As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_bill_province}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_bill_province}          ${var_booking_bill_province}

Booking Payment Page - Display Bill Postcode As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_bill_postcode}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_bill_postcode}          ${BOOKING_PREORDER_VALID.billing_postcode}

Booking Payment Page - Display Bill District As Value in PCMS
    Booking Py - Get Billing District Name From PCMS
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_bill_district}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_bill_district}          ${var_booking_bill_district_th}

Booking Payment Page - Display Bill City As Value in PCMS
    Booking Py - Get Billing City Name From PCMS
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_bill_city}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_bill_city}          ${var_booking_bill_city_th}

Booking Payment Page - Display Bill Province As Value in PCMS
    Booking Py - Get Billing Province Name From PCMS
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_bill_province}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_bill_province}          ${var_booking_bill_province_th}

Booking Payment Page - Display Bill District As Value in PCMS EN
    Booking Py - Get Billing District Name From PCMS
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_bill_district}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_bill_district}          ${var_booking_bill_district_en}

Booking Payment Page - Display Bill City As Value in PCMS EN
    Booking Py - Get Billing City Name From PCMS
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_bill_city}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_bill_city}          ${var_booking_bill_city_en}

Booking Payment Page - Display Bill Province As Value in PCMS EN
    Booking Py - Get Billing Province Name From PCMS
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_bill_province}   10s
    Element Should Contain   ${XPATH_BOOKING_PAYMENT.lbl_bill_province}          ${var_booking_bill_province_en}

Booking Payment Page - Display Card Holder Name
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.card_holder_name}   60s
    Element Should Be Visible   ${XPATH_BOOKING_PAYMENT.card_holder_name}

Booking Payment Page - Display Credit Card Number
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.card_number}  60s
    Element Should Be Visible   ${XPATH_BOOKING_PAYMENT.card_number}

Booking Payment Page - Display CVC
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.cvc_number}  60s
    Element Should Be Visible   ${XPATH_BOOKING_PAYMENT.cvc_number}

Booking Payment Page - Display Card Expired Date
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.expiry_month}  60s
    Element Should Be Visible   ${XPATH_BOOKING_PAYMENT.expiry_month}

    Wait Until Element Is Visible  ${XPATH_BOOKING_PAYMENT.expiry_year}   60s
    Element Should Be Visible   ${XPATH_BOOKING_PAYMENT.expiry_year}

Booking Payment Page - Display Error Card Holder Name
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_error_card_holder_name}   3s
    Element Should Be Visible   ${XPATH_BOOKING_PAYMENT.lbl_error_card_holder_name}

Booking Payment Page - Display Error Credit Card Number
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_error_card_number}  3s
    Element Should Be Visible   ${XPATH_BOOKING_PAYMENT.lbl_error_card_number}

Booking Payment Page - Display Error CVC
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_error_cvc_number}  3s
    Element Should Be Visible   ${XPATH_BOOKING_PAYMENT.lbl_error_cvc_number}

Booking Payment Page - Display Error Card Expired Date
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.lbl_error_expiry_date}  3s
    Element Should Be Visible   ${XPATH_BOOKING_PAYMENT.lbl_error_expiry_date}

Booking Payment Page - Not Display Error Card Holder Name
    Wait Until Element Is Not Visible   ${XPATH_BOOKING_PAYMENT.lbl_error_card_holder_name}   3s
    Element Should Not Be Visible   ${XPATH_BOOKING_PAYMENT.lbl_error_card_holder_name}

Booking Payment Page - Not Display Error Credit Card Number
    Wait Until Element Is Not Visible   ${XPATH_BOOKING_PAYMENT.lbl_error_card_number}  3s
    Element Should Not Be Visible   ${XPATH_BOOKING_PAYMENT.lbl_error_card_number}

Booking Payment Page - Not Display Error CVC
    Wait Until Element Is Not Visible   ${XPATH_BOOKING_PAYMENT.lbl_error_cvc_number}  3s
    Element Should Not Be Visible   ${XPATH_BOOKING_PAYMENT.lbl_error_cvc_number}

Booking Payment Page - Not Display Error Card Expired Date
    Wait Until Element Is Not Visible   ${XPATH_BOOKING_PAYMENT.lbl_error_expiry_date}  3s
    Element Should Not Be Visible   ${XPATH_BOOKING_PAYMENT.lbl_error_expiry_date}

Booking Payment Page - Display Image Product
    Wait Until Element Is Visible      //img[@src="${BOOKING_URL}/${BOOKING_IMAGE_PRODUCT_URL}/${var_booking_photo}"]      10s
    Element Should Be Visible  //img[@src="${BOOKING_URL}/${BOOKING_IMAGE_PRODUCT_URL}/${var_booking_photo}"]

Booking Payment Page - User Enter Valid Card Holder Name
    Input Text   ${XPATH_BOOKING_PAYMENT.card_holder_name}   ${BOOKING_PAYMENT_CCW.valid_card_holder_name}

Booking Payment Page - User Enter Valid Credit Card Number
    Input Text   ${XPATH_BOOKING_PAYMENT.card_number}   ${BOOKING_PAYMENT_CCW.valid_credit_card_number}
    Click Element    //body

Booking Payment Page - User Enter Invalid Credit Card Number
    Input Text   ${XPATH_BOOKING_PAYMENT.card_number}   ${BOOKING_PAYMENT_CCW.invalid_credit_card_number}
    Click Element    //body

Booking Payment Page - User Enter Valid CVC
    Input Text   ${XPATH_BOOKING_PAYMENT.cvc_number}  ${BOOKING_PAYMENT_CCW.valid_cvc}

Booking Payment Page - User Select Valid Card Expired
    Booking Payment Page - User Select Valid Month Card Expired
    Booking Payment Page - User Select Valid Year Card Expired

Booking Payment Page - User Select Valid Month Card Expired
    ${valid-month}=   Get Card Expired Valid Month
    Click Element   ${XPATH_BOOKING_PAYMENT.expiry_month}/option[@value="${valid-month}"]

Booking Payment Page - User Select Valid Year Card Expired
    ${valid-year}=     Get Card Expired Valid Year
    Click Element   ${XPATH_BOOKING_PAYMENT.expiry_year}/option[@value="${valid-year}"]

Booking Payment Page - Click Pay
    Wait Until Element Is Visible   ${XPATH_BOOKING_PAYMENT.btn_pay}   60s
    Click Element   ${XPATH_BOOKING_PAYMENT.btn_pay}

Get Card Expired Valid Year
    ${date}=   Get Current Date
    ${date}=  Convert Date   ${date}   datetime
    Return From Keyword   ${date.year}

Get Card Expired Valid Month
    ${date}=   Get Current Date
    ${date}=  Convert Date  ${date}  datetime
    ${valid-month}=  Convert Month Add Zero Prefix   ${date.month}
    Return From Keyword   ${valid-month}

Convert Month Add Zero Prefix
    [Arguments]   ${number}
    ${number}=   Convert To String  ${number}
    ${length_month}=   Get Length  ${number}
    ${return}=  Run Keyword If   '${length_month}' == '1'  Set Variable  0${number}
    ...   ELSE  Set Variable   ${number}
    Return From Keyword   ${return}
